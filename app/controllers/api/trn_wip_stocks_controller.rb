class Api::TrnWipStocksController < Api::ApiController
  before_action :authenticate_user
  before_action :set_trn_wip_stock, only: [ :update]


  def index
    begin
      plant = params['plant']
      str_loc = params['str_loc']
      requested_date = Date.yesterday
      @trn_wip_stocks = TrnWipStock.all
                                   .where('plant=? and str_loc=?   and pallet_rfid_date >=?',plant,str_loc,requested_date)
                                   .where('rfid_tag is not null')
        if @trn_wip_stocks.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:@trn_wip_stocks
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_workcenter
    begin
      plant = params["plant"]
      str_loc = params['str_loc']
      records = TrnWipStock.select('distinct work_center').where('work_center is not null')
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

  def fetch_work_center_list
    begin
      work_center = params["work_center"]
      records = TrnWipStock.select('id,mat_code as sfg_code,sap_batch,mat_desc as sfg_desc,comp_lotno as lot_no,mat_qty as stock_qty_kg,batch_reference')
                           .where("work_center=?",work_center)
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

  def update
    begin
      event = params[:event]
      quantity = params[:quantity]
      params = trn_wip_stock_params
      trn_wip_stock = TrnWipStock.find_by(rfid_tag:params[:rfid_tag])
      if trn_wip_stock
        render json: {status:"error", "message": 'Rfid already exists'}, status: :internal_server_error        
      else
        if event == 'Full'
          @trn_wip_stock.update(params)
          @trn_wip_stock.update(pallet_rfid_date: Time.now)
        end
        update_wip(event,quantity,params[:sap_batch],params[:mat_code],params[:plant],params[:rfid_tag],params[:batch_reference],params[:vendor_batch])
        render json: @trn_wip_stock, status: :ok
      end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def update_wip(ob_type,quantity,sap_batch,mat_code,plant,rfid_tag,batch_reference,vendor_batch)
    if ob_type == 'Partial'
      wip = TrnWipStock.where('sap_batch=?',sap_batch).where("rfid_tag is null or rfid_tag=?",'').first
       if !wip.blank?
         cons_qty = wip.cons_qty.to_i + quantity.to_i
         bal_qty = wip.received_qty.to_i - cons_qty.to_i
         wip.update(cons_qty:cons_qty,bal_qty:bal_qty)
         TrnWipStock.create!(plant:wip.plant,work_center:wip.work_center,batch_reference:batch_reference,comp_rfid_date:wip.comp_rfid_date,plan_order_no:wip.plan_order_no,str_loc:wip.str_loc,mat_group:wip.mat_group,mat_code:wip.mat_code,mat_desc:wip.mat_desc,mat_uom:wip.mat_uom,mat_qty:wip.mat_qty,received_qty:quantity,cons_qty:0,bal_qty:quantity,comp_lotno:wip.comp_lotno,sap_batch:wip.sap_batch,expiry_dt:wip.expiry_dt,rfid_status:'open',action_status:'open',load_dttime:wip.load_dttime,vendor_batch:vendor_batch,comp_batchno:wip.comp_batchno,rfid_tag:rfid_tag,mat_group_name:wip.mat_group_name,pallet_rfid_date:Time.now)
       end
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wip_stock
      @trn_wip_stock = TrnWipStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wip_stock_params
      params.require(:trn_wip_stock).permit(:plant,:pallet_rfid_date,:batch_reference,:trt_code,:net_wt,:plan_order_no,:str_loc,:mat_group, :mat_code,:mat_desc,:mat_uom,:mat_qty,:received_qty,:cons_qty, :bal_qty, :comp_lotno,:sap_batch,:expiry_dt,:rfid_status,:action_status, :load_dttime,:rm_gross_wt,  :tare_wt,  :rm_empty_shell_wt, :rm_net_wt, :vendor_batch, :unload_type,:user_id,:req_no,:comp_batchno,:rfid_tag,:mat_group_name,:station,:work_center,:gross_wt)
    end
end
