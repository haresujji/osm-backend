class Api::OsmIssueDtlsController < Api::ApiController
  before_action :authenticate_user
  before_action :set_osm_issue_dtl, only: [:show, :edit, :update, :destroy]


   def create
    begin
      osm_dtls = OsmIssueDtl.where('rfid_tag=? and trns_doc_no=? and action_status=?',params[:rfid_tag],params[:trns_doc_no],'open').first
      event = params[:event]
      rfid_tag = params[:rfid_tag]
      trns_net_wt = params[:trns_net_wt]
      params = osm_issue_dtls_params 
      params[:action_status] = 'open'  
      params[:trns_doc_date] = Time.now
      if osm_dtls
        return render json: {status:"error", "message": 'Tag already exists'}, status: :internal_server_error 
      end
        @osm_dtl = OsmIssueDtl.new(params)
        @osm_dtl.save
        update_issue_qty_in_sfg(rfid_tag,trns_net_wt)
        render json: @osm_dtl, status: :created
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def update_issue_qty_in_sfg(rfid_tag,trns_net_wt)
    dtl = TrnSfgStock.where('rfid_tag=?',rfid_tag).first
    if !dtl.blank?    
      dtl.update(issue_qty:trns_net_wt)
    end
  end


  def fetch_issue_dtls
    begin
      truck_no = params['truck_no']
      records = OsmIssueDtl.all.where('truck_no=?',truck_no)
        if records.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_docno_lists
    begin
      trns_doc_no = params['trns_doc_no']
      docnos = OsmIssueDtl.all.where('trns_doc_no=? and action_status=?',trns_doc_no,'open')
        if docnos.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:docnos
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def delete_issue_dtls
    begin
      id = params['id']
      list = OsmIssueDtl.find_by(id:id)
        if !list.blank?
          list.update(action_status:'delete')
          render json: 'ok'
        end    
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end



  def update_issue_status
    begin
    trns_doc_no = params['trns_doc_no']
    source_plant = params['source_plant']
    source_str_loc = params['source_str_loc']
    no_of_bin = params['no_of_bin']
    hdrs_object = OsmIssueHdr.find_by(trns_doc_no:trns_doc_no)
    if !hdrs_object.blank?
      hdrs_object.update(action_status:'picked',source_plant:source_plant,source_str_loc:source_str_loc,no_of_bins:no_of_bin)
      @records = params['rfid_list'].each do |s|   
      @rfid_tag_record = TrnSfgStock.find_by(rfid_tag:s['rfid_tag'])
        if !@rfid_tag_record.blank?
          @rfid_tag_record.update(issue_status:"Y")
        end
      end
      @records = params['rfid_list'].each do |s|   
      @dtl_lists = OsmIssueDtl.find_by(rfid_tag:s['rfid_tag'],trns_doc_no:trns_doc_no)
        if !@dtl_lists.blank?
          @dtl_lists.update(action_status:'picked')
        end
      end
    render json:@rfid_tag_record
    end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_dtls
    begin
    from_date = params['fromdate']
    from = from_date.to_date
    todate = params['todate']
    to = todate.to_date
    userplant = params['plant']
    userloc = params['strloc']
    offset = params['page']
    search = params["search"]
    offset_value = pagination(offset,from,to,userplant,userloc,search)
    query =  OsmIssueDtl.all
     if(!from_date.blank? || !todate.blank?)
     query = query.where("osm_issue_dtls.created_at  between  ? AND ?", from,to)
    end
    if userplant !='' || !userplant.blank?
     query = query.where("osm_issue_dtls.plant=?",userplant)
    end
    if userloc !='' || userloc.blank?
      query = query.where("osm_issue_dtls.str_loc=?",userloc)
    end
     if search == ''
      query = query
    end
    if !search.blank?
     query = query.   
              where('mat_desc ILIKE :search  or mat_batch ILIKE :search or  mat_group_name ILIKE :search  
              or action_status ILIKE :search',{search: "%#{search}%"})                                  
    end
    @hdrs = query.where('excess_flag=? and action_status=?','Y','open').limit(5).offset(offset_value)
    fetch_page_length
    if @hdrs.blank?
      render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
    else
      render json:{osmdtllists: @hdrs, pagelength: fetch_page_length}
    end
      rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end 
  end


  def pagination(offset,from,to,userplant,userloc,search)
    per_page = 5
    count = osm_count(from,to,userplant,userloc,search)
    size = count / per_page
    page_length_calculation(count,size)
    offset_value = (offset.to_i - 1) * per_page
  end

  def osm_count(from,to,userplant,userloc,search)
    if search.blank?
     return  count = OsmIssueDtl.where("osm_issue_dtls.created_at  between  ? AND ?", from,to)
                     .where("osm_issue_dtls.plant=?",userplant)
                     .where("osm_issue_dtls.str_loc=?",userloc)
                     .where('excess_flag=? and action_status=?','Y','open')
                     .count
    end
    if !search.blank?
     return count = OsmIssueDtl.where("osm_issue_dtls.created_at  between  ? AND ?", from,to)
                     .where("osm_issue_dtls.plant=?",userplant)
                     .where("osm_issue_dtls.str_loc=?",userloc)
                     .where('excess_flag=? and action_status=?','Y','open')
                     .where('mat_desc ILIKE :search  or mat_batch ILIKE :search or mat_group_name ILIKE :search  
                      or action_status ILIKE :search',{search: "%#{search}%"})    
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

  def fetch_page_length
    begin
      from_date = params['fromdate']
      from = from_date.to_date
      todate = params['todate']
      to = todate.to_date
      userplant = params['plant']
      userloc = params['strloc']
      offset = params['page']
      search = params["search"]
      records =  osm_count(from,to,userplant,userloc,search)
      size = records / 5
      page_length = page_length_calculation(records,size)
      return page_length
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  def update_new_sapbatch
    begin
    dtl_lists = params['dtls']
    dtl_lists.each do |d|
      if(d['excess_qty'].to_f > d['balanceqty'].to_f)
        return render json: 'Truck is not free', status: :created
      end
      dtl = OsmIssueDtl.where('sto_no_ref=? and excess_status=? and action_status=?',d['sto_no_ref'],'open','open').first
      dtl.update(charg:d['batch'],action_status:'closed',excess_status:'closed')
    end
    render json: 'ok',status: :ok
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def fetch_plantlocation
    begin
      trns_doc_no = params['trns_doc_no']
      docnos = OsmIssueDtl.all.where('trns_doc_no=?',trns_doc_no).first
        if docnos.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:docnos
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_wt
    begin
      trns_doc_no = params['trns_doc_no']
      wt = OsmIssueDtl.select('sum(trns_gross_wt)').where('trns_doc_no=?',trns_doc_no)
      count = OsmIssueDtl.where('trns_doc_no=?',trns_doc_no).count
        if wt.blank? || count.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json: {total_wt: wt, rfid_list: count}, status: :ok
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def create_offline_dlts
    begin
      dtl_array = []
      @records = params['osm_issue_dtls_items'].each do |s|     
        dtl_object = OsmIssueDtl.find_by(rfid_tag:s['rfid_tag'])
          if dtl_object
            dtl_array << s 
          else
            OsmIssueDtl.create!(trns_doc_no:s['trns_doc_no'], trns_doc_date:Time.now,sto_no:s['sto_no'],plant:s['plant'],str_loc:s['str_loc'],po_item:s['po_item'],to_plant:s['to_plant'],mat_group_name:s['mat_group_name'],mat_code:s['mat_code'],mat_desc:s['mat_desc'],mat_uom:s['mat_uom'],
       mat_batch:s['mat_batch'],vbelp_st:s['vbelp_st'],charg:s['charg'],sap_batch_qty:s['sap_batch_qty'],expirty_date:s['expirty_date'],rfid_tag:s['rfid_tag'],trns_gross_wt:s['trns_gross_wt'],trns_tare_wt:s['trns_tare_wt'],trns_net_wt:s['trns_net_wt'],trns_status:s['trns_status'],
       trns_transfer_dt:s['trns_transfer_dt'],trns_ack_update_dt:s['trns_ack_update_dt'], trns_err_msg:s['trns_err_msg'],pallet_no:s['pallet_no'],
        sto_date:s['sto_date'],lot_no:s['lot_no'],source_plant:s['source_plant'],source_str_loc:s['source_str_loc'])
          end
      end
      render json:dtl_array,status: 200
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


   private
    # Use callbacks to share common setup or constraints between actions.
    def set_osm_issue_dtl
      @osm_issue_dtl = OsmIssueDtl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def osm_issue_dtls_params
        params.require(:osm_issue_dtl).permit(:trns_doc_no, :trns_doc_date,:sto_no,:plant,:str_loc,:po_item,:to_plant,:mat_group_name, :mat_code,:mat_desc,:mat_uom,
		 :mat_batch,:vbelp_st,:charg,:sap_batch_qty,:expirty_date,:rfid_tag,:trns_gross_wt, :trns_tare_wt,:trns_net_wt, :trns_status,
	     :trns_transfer_dt,:trns_ack_update_dt, :trns_err_msg,:gate_entry_docno,:gate_entry_docdt,:rec_gross_wt, :rec_tare_wt, :rec_net_wt,
	     :rec_status,:rec_transfer_dt,:rec_ack_update_dt,:rec_err_msg,:sap_grn_no,:sap_grn_date,
	     :sap_insp_docno, :sap_insp_result, :weighment_flag, :min_qty,  :max_qty, :sap_acutal,  :sap_wd,:sap_we,:sap_od,
	     :sap_grn_transfer_lot,:sap_grn_transfer_no, :sap_doc_no,:pallet_no,:sto_date,:lot_no,:source_plant,:source_str_loc)
    end
end