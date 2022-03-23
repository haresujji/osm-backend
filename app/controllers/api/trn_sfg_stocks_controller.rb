class Api::TrnSfgStocksController < Api::ApiController
  before_action :authenticate_user
  before_action :set_trn_sfg_stock, only: [ :update]


  def index
    begin
      requested_date = Date.yesterday
      plant = params['plant']
      str_loc = params['str_loc']
      @trn_sfg_stocks = TrnSfgStock.all
                                   .where('plant=? and str_loc=? and issue_status=?  and pallet_rfid_date >=?',plant,str_loc,'G',requested_date)
                                   .where('rfid_tag is not null')
        if @trn_sfg_stocks.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:@trn_sfg_stocks
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_workcenter
    begin
      plant = params["plant"]
      str_loc = params['str_loc']
      records = TrnSfgStock.select('distinct work_center').where('work_center is not null')
                           .where('plant=? and str_loc=?',plant,str_loc)
                            .where("rfid_tag is null or rfid_tag=?",'')
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_sap_batch
    begin
      plant = params['plant']
      str_loc = params['str_loc']
      mat_code = params['mat_code']
      records = TrnSfgStock.select('sap_batch,balance_qty').where('plant=? and str_loc=? and sfg_code=? and balance_qty > 0',plant,str_loc,mat_code)
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_work_center_list
    begin
      work_center = params["work_center"]
      records = TrnSfgStock.select('id,sfg_code,sap_batch,lot_no,sfg_desc,stock_qty as stock_qty_kg,batch_reference,balance_qty')
                           .where("work_center=? and issue_status=?",work_center,'N')
                           .where("rfid_tag is null or rfid_tag=?",'')
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

 

  def fetch_rfid_list
    begin
      rfid_tag = params["rfid_tag"]
      rfid = TrnSfgStock.all.where("rfid_tag=? and issue_status=?",rfid_tag,'G').first
        if rfid.blank?
          render json: {status:"error", "message": "No Matches Found for this rfid"}, status: :internal_server_error 
        else
          render json:rfid
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def fetch_all_rfid
    begin
      rfid = TrnSfgStock.all.where("issue_status=? and balance_qty > 0.0",'G').where('rfid_tag is not null or rfid_tag!=?','')
        if rfid.blank?   
        render json: {status:"error", "message": "No datas found"}, status: :internal_server_error
        else 
          render json:rfid
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def update
    begin
      event = params[:event]
      quantity = params[:quantity]
      rfid_tag = params[:rfid_tag]
      mat_code = params[:mat_code]
      sap_batch = params[:sap_batch]
      plant = params[:plant]
      tare_wt = params[:tare_wt]
      gross_wt = params[:gross_wt]
      batch_reference = params[:batch_reference]
      id = params[:id]
      params = trn_sfg_stock_params
      trn_sfg_stock = TrnSfgStock.find_by(rfid_tag:rfid_tag)
      if trn_sfg_stock
        render json: {status:"error", "message": 'Rfid already exists'}, status: :internal_server_error        
      else
        if event == 'Full'
          @trn_sfg_stock.update(params)
          gross_weight = @trn_sfg_stock.balance_qty.to_f + tare_wt.to_f
          @trn_sfg_stock.update(issue_status:'G',issue_qty:@trn_sfg_stock.stock_qty.to_f,balance_qty:0,gross_wt:gross_weight)
        end
        update_sfg(event,quantity,sap_batch,mat_code,plant,rfid_tag,tare_wt,gross_wt,batch_reference,id)
        render json: @trn_sfg_stock, status: :ok
      end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def update_sfg(ob_type,quantity,sap_batch,mat_code,plant,rfid_tag,tare_wt,gross_wt,batch_reference,id)
    if ob_type == 'Partial'
      sfg = TrnSfgStock.where('id=?',id).where("rfid_tag is null or rfid_tag=?",'').first
       if !sfg.blank?
        if !sfg.issue_qty.blank?
          issue_qty = sfg.issue_qty
        else
          issue_qty = 0
        end
        #  cons_qty = issue_qty.to_f + quantity.to_f
        #  bal_qty = sfg.stock_qty.to_f - cons_qty.to_f - tare_wt.to_f
        #  bal_par_qty = sfg.stock_qty.to_f - cons_qty.to_f
         gross_weight = quantity.to_f + tare_wt.to_f
         gross = gross_weight.to_f.round(3)
         bal_qty_exits_data = sfg.stock_qty.to_f -  quantity.to_f
         cons_qty = issue_qty.to_f + quantity.to_f
         sfg.update(issue_qty:cons_qty.to_f.round(3),balance_qty:bal_qty_exits_data.to_f.round(3),stock_qty:bal_qty_exits_data)
         
         
         TrnSfgStock.create!(plant:sfg.plant,work_center:sfg.work_center,issue_qty:0,stock_qty:quantity,balance_qty:quantity,batch_reference:batch_reference,str_loc:sfg.str_loc,sfg_group:sfg.sfg_group,sfg_code:sfg.sfg_code,sfg_desc:sfg.sfg_desc,sfg_uom:sfg.sfg_uom,lot_no:sfg.lot_no,sap_batch:sfg.sap_batch,expiry_dt:sfg.expiry_dt,rfid_tag:rfid_tag,stock_status:sfg.stock_status,sfg_group_name:sfg.sfg_group_name,gross_wt:gross,tare_wt:tare_wt,pallet_rfid_date:Time.now,issue_status:'G')
       end
    end
  end

  def fetch_sfg_list
    begin
    date = params['date']
    userplant = params['plant']
    userloc = params['strloc']
    offset = params['page']
    search = params["search"]
    offset_value = pagination(offset,date,userplant,userloc,search)
    query =  TrnSfgStock.all
    if(!date.blank?)
     query = query.where("to_char(trn_sfg_stocks.pallet_rfid_date,'yyyy-mm-dd')=?",date)
    end
    if userplant !='' || !userplant.blank?
     query = query.where("trn_sfg_stocks.plant=?",userplant)
    end
    if userloc !='' || userloc.blank?
      query = query.where("trn_sfg_stocks.str_loc=?",userloc)
    end
    if search == ''
      query = query
    end
    if !search.blank?
     query = query.where('work_center ILIKE :search or sfg_code ILIKE :search  
                       or sap_batch ILIKE :search  or lot_no ILIKE :search',{search: "%#{search}%"})                                    
    end

    query = query.limit(5).offset(offset_value) 
    fetch_page_length
    if query.blank?
      render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
    else
      render json: {sfg_lists: query, pagelength: fetch_page_length}, status: :ok
    end
      rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end 
  end

  def osm_count(date,userplant,userloc,search)
    if search.blank?
     return  count = TrnSfgStock.where("trn_sfg_stocks.plant=?",userplant)
                       .where("trn_sfg_stocks.str_loc=?",userloc)
                       .where("to_char(trn_sfg_stocks.pallet_rfid_date,'yyyy-mm-dd')=?",date)
                       .count
    end
    if !search.blank?
     return count = TrnSfgStock.where("trn_sfg_stocks.plant=?",userplant)
                       .where("trn_sfg_stocks.str_loc=?",userloc)
                       .where("to_char(trn_sfg_stocks.pallet_rfid_date,'yyyy-mm-dd')=?",date)
                       .where('work_center ILIKE :search or sfg_code ILIKE :search  
                       or sap_batch ILIKE :search  or lot_no ILIKE :search',{search: "%#{search}%"})  
                       .count

    end

  end

  def page_length_calculation(records,size)
    if records % 5 != 0
      page_length = size +1
    else
      page_length = size
    end
  end


  def pagination(offset,date,userplant,userloc,search)
    per_page = 5
    count = osm_count(date,userplant,userloc,search)
    size = count / per_page
    page_length_calculation(count,size)
    offset_value = (offset.to_i - 1) * per_page
  end

  def fetch_page_length
    begin
      userplant = params['plant']
      userloc = params['strloc']
      search = params['search']
      date = params['date']
      records =  osm_count(date,userplant,userloc,search)
      size = records / 5
      page_length = page_length_calculation(records,size)
      return page_length
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_sfg_stock
      @trn_sfg_stock = TrnSfgStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_sfg_stock_params
      params.require(:trn_sfg_stock).permit(:plant,:str_loc,:pallet_rfid_date,:sfg_group,:sfg_code,:batch_reference,:sfg_desc,:sfg_uom,:stock_qty,:stock_qty_kg,:lot_no,:rfid_tag,:expiry_dt,:stock_status,:sap_batch,:sap_docref,:sap_status,:sap_err_msg,:sap_trn_dttime,:sap_upd_dttime,:insp_lot_no,:issue_status,:sup_roll_ref,:work_center,:gross_wt,:tare_wt)
    end
end
