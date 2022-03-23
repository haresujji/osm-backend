class Api::OsmIssueHdrsController < Api::ApiController
  before_action :authenticate_user
  before_action :set_osm_issue_hdr, only: [:show, :edit, :update, :destroy]



  def create
    begin
      truck = OsmIssueHdr.where('truck_no=? and truck_status=?',params['truck_no'],'open')
      if !truck.blank? 
        if truck.first.trns_doc_no != params['trns_doc_no']
          return   render json: 'Truck is not free', status: :ok 
        else
          params = osm_issue_hdr_params 
          truck.update(params)
          render json:'Saved Successfully',status: :ok
        end
      else
        params = osm_issue_hdr_params 
        params[:action_status] = 'open'  
        @osm_hdr = OsmIssueHdr.new(params)
        @osm_hdr.save
        render json: @osm_hdr, status: :created
      end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  def fetch_truck_details
     begin
      truck = OsmIssueHdr.select('distinct truck_no')
        render json: truck, status: :created
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end  
  end
  
   def update_truck_details_admin
     begin
     truck_no = params['truck_no']
      truck = OsmIssueHdr.where(truck_no:truck_no).update_all(truck_status:'completed')
        render json: 'Updated', status: :created
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end  
  end
  


  def fetch_docno
    begin
      now = Date.today
      start_date = (now - 3)
      plant = params['plant']
      records = OsmIssueHdr.select('distinct trns_doc_no').where("to_char(created_at,'yyyy-mm-dd') between ? and ? and plant=?", start_date, now, plant)
        if records.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:records,status: :ok
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_docno_list
    begin
      trns_doc_no = params['trns_doc_no']
      records = OsmIssueHdr.all.where('trns_doc_no=?',trns_doc_no).first
        if records.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:records,status: :ok
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def update_list
    begin
      trns_doc_no = params['trns_doc_no']
      list = OsmIssueHdr.find_by(trns_doc_no:trns_doc_no)
      if params['total_truck_wt'] == 'null'  
        total_truck_wt = ''    
      else
        total_truck_wt = params['total_truck_wt']
      end
      if params['empty_truck_wt'] == 'null'
        empty_truck_wt = ''
      else
        empty_truck_wt = params['empty_truck_wt']
      end
      if !list.blank?
        list.update(total_truck_wt:total_truck_wt,truck_no:params['truck_no'],transport_vendor:params['transport_vendor'],trip_type:params['trip_type'],truck_type:params['truck_type'],driver_name:params['driver_name'],driver_phone:params['driver_phone'],empty_truck_wt:empty_truck_wt,driver_license:params['driver_license'],truck_route:params['truck_route'],truck_type_desc:params['truck_type_desc'],vendor:params['vendor'])
      end
        render json:list,status: :ok
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def updatevehicle_time
    begin
      sto_no = params['sto_no']
      list = OsmIssueHdr.find_by(sto_no:sto_no)
      if !list.blank?
        list.update(vehicle_receiving_dt:Time.now)
      end
        render json:'ok',status: :ok
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def update_status
    begin
      trns_doc_no = params['trns_doc_no']
      @total = OsmIssueDtl.where('trns_doc_no=?',trns_doc_no)
      trn_tare_wt = 0
      if !@total.blank?
        @total.each do |s|   
          OsmIssueDtl.find_by(trns_doc_no:s.trns_doc_no)
          if s.trns_tare_wt.blank?
            trntare = 0
          else
            trntare = s.trns_tare_wt
          end
          trn_tare_wt += trntare
        end
      end
      truck_net_wt = params['total_truck_wt'].to_f - params['empty_truck_wt'].to_f
      total_mat_wt = truck_net_wt.to_f - trn_tare_wt.to_f
      hdr = OsmIssueHdr.find_by(trns_doc_no:trns_doc_no)
      if !hdr.blank?
        hdr.update(action_status:'closed',truck_net_wt:truck_net_wt,total_tare_wt:trn_tare_wt,total_mat_wt:total_mat_wt,truck_flag:'Y',total_truck_wt:params['total_truck_wt'],truck_no:params['truck_no'],transport_vendor:params['transport_vendor'],trip_type:params['trip_type'],truck_type:params['truck_type'],driver_name:params['driver_name'],driver_phone:params['driver_phone'],empty_truck_wt:params['empty_truck_wt'],driver_license:params['driver_license'],truck_route:params['truck_route'],truck_type_desc:params['truck_type_desc'],vendor:params['vendor'])
      end
      @dtl_lists = OsmIssueDtl.where('trns_doc_no=?',trns_doc_no)
      if !@dtl_lists.blank?
        @dtl_lists.each do |s|   
          @dtl_lists.update(action_status:'closed')
        end
      end
        render json: @dtl_lists,status: :ok
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def fetch_trucknumber
    begin
      plant = params['plant']
      records = OsmIssueHdr.select('distinct truck_no').where('action_status=? and truck_status=? and plant=?','open','open',plant)
        if records.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_transport_vendor
    begin
      truck_no = params['truck_no'] 
      records = OsmIssueHdr.all.where('truck_no=? and action_status=? and truck_status=?',truck_no,'open','open').first
        if records.blank?
          render json: {status:"error", "message": "No datas found for this truck no"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_sto_dtls
    begin
      sto_no = params['sto']
      sto_object = OsmIssueHdr.where('sto_no=? and action_status=?',sto_no,'completed').first
      issue_dtls = OsmIssueDtl.where('trns_doc_no=?',sto_object.trns_doc_no).order('pallet_no,mat_group_name')
      mat_group_names = OsmIssueDtl.select('distinct mat_group_name').where('trns_doc_no=?',sto_object.trns_doc_no)
        if sto_object.blank? || issue_dtls.blank? 
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
            render json: {sto_object: sto_object, issue_dtls: issue_dtls,mat_group_names:mat_group_names }, status: :ok
        end    
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def update_action_status
    begin
      sto_no = params['sto']
      puts sto_no
      object = OsmIssueHdr.where('sto_no=?',sto_no).first
      puts object.to_json
      if !object.blank?
        object.update(action_status:'issued')
      end
      render json:'ok',status: :ok
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def update_completed
    begin
      trns_doc_no = params['trns_doc_no']
      records = OsmIssueHdr.find_by(trns_doc_no:trns_doc_no)
        if !records.blank?
          records.update(action_status:'completed')
        end
         render json: records
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


 def update_truck_status
    begin
     sto_no = params['sto_no']
      records = OsmIssueHdr.find_by(sto_no:sto_no)
        if !records.blank?
          records.update(truck_status:'completed')
        end
         render json: 'ok'
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end  

  def fetch_hdrs
    begin
    from_date = params['date']
    userplant = params['plant']
    userloc = params['strloc']
    offset = params['page']
    search = params["search"]
    offset_value = pagination(offset,from_date,userplant,userloc,search)
    query =  OsmIssueHdr.all
     if(!from_date.blank?)
     query = query.where("to_char(osm_issue_hdrs.created_at,'yyyy-mm-dd')=?",from_date)
    end
    if userplant !='' || !userplant.blank?
     query = query.where("osm_issue_hdrs.plant=?",userplant)
    end
    if userloc !='' || userloc.blank?
      query = query.where("osm_issue_hdrs.str_loc=?",userloc)
    end
    if search == ''
      query = query
    end
    if !search.blank?
     query = query.   
              where('transport_vendor ILIKE :search or truck_no ILIKE :search  
              or action_status ILIKE :search  or trip_type ILIKE :search',{search: "%#{search}%"})                                  
    end

    query = query.limit(5).offset(offset_value) 
    fetch_page_length
    if query.blank?
      render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
    else
      render json: {osmlists: query, pagelength: fetch_page_length}, status: :ok
    end
      rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end 
  end

  def osm_count(from_date,userplant,userloc,search)
    if search.blank?
     return  count = OsmIssueHdr.where("to_char(osm_issue_hdrs.created_at,'yyyy-mm-dd')=?",from_date)
                       .where("osm_issue_hdrs.plant=?",userplant)
                       .where("osm_issue_hdrs.str_loc=?",userloc)
                       .count
                         puts count
    end
    if !search.blank?
     return count = OsmIssueHdr.where("to_char(osm_issue_hdrs.created_at,'yyyy-mm-dd')=?",from_date)
                       .where("osm_issue_hdrs.plant=?",userplant)
                       .where("osm_issue_hdrs.str_loc=?",userloc)
                       . where('transport_vendor ILIKE :search or truck_no ILIKE :search  
                       or action_status ILIKE :search  or trip_type ILIKE :search',{search: "%#{search}%"})  
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


  def pagination(offset,from_date,userplant,userloc,search)
    per_page = 5
    count = osm_count(from_date,userplant,userloc,search)
    size = count / per_page
    page_length_calculation(count,size)
    offset_value = (offset.to_i - 1) * per_page
  end

  def fetch_page_length
    begin
      from_date = params['date']
      userplant = params['plant']
      userloc = params['strloc']
      search = params['search']
      records =  osm_count(from_date,userplant,userloc,search)
      size = records / 5
      page_length = page_length_calculation(records,size)
      return page_length
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_sto_list
    begin
      sto_no = params['sto_no'] 
      stos = OsmIssueHdr.all.where('sto_no=?',sto_no).first
        if stos.blank?
          render json: {status:"error", "message": "No datas found for this sto no"}, status: :internal_server_error 
        else
          render json:stos
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_stos
    begin
      stos = OsmIssueHdr.select('sto_no')
        if stos.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:stos
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def update_truck_transfer
    begin
     sto_no = params['getSto']
      records = OsmIssueHdr.find_by(sto_no:sto_no)
        if !records.blank?
          records.update(old_truck_no:params['getFromTruck'],truck_no:params['getToTruckNo'],old_driver_name:params['getOldDriverName'],
            driver_name:params['getDriverName'],old_driver_phone:params['getOldPhone'],driver_phone:params['getPhone'],old_vendor:params['getOldVendor'],vendor:params['getNewVendor'],
            old_truck_type:params['getOldTruckType'],truck_type:params['getNewTruckType'],old_truck_type_desc:params['getOldTruckTypeDesc'],
            truck_type_desc:params['getNewTruckTypeDesc'],old_transport_vendor:params['getFromTransport'],transport_vendor:params['getToTransport'])
        end
         render json: 'ok'
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end  

  def fetch_current_date_object
    begin
      from_date = Time.now.strftime('%Y-%m-%d')
      register_count = OsmIssueHdr.where("action_status='open' and to_char(osm_issue_hdrs.created_at,'yyyy-mm-dd')=?",from_date).count
      picked_count = OsmIssueHdr.where("action_status='picked'  and to_char(osm_issue_hdrs.created_at,'yyyy-mm-dd')=?",from_date).count
      factory_count = OsmIssueHdr.where("action_status='issued'  and to_char(osm_issue_hdrs.created_at,'yyyy-mm-dd')=?",from_date).count   
      render json: {register_count: register_count, picked_count: picked_count,factory_count:factory_count }, status: :ok
        
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_osm_issue_hdr
      @osm_issue_hdr = OsmIssueHdr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def osm_issue_hdr_params
        params.permit(:trns_doc_no,:dbname,:ebbill,:trns_doc_date,:sto_no,:plant,:str_loc,:to_plant,:to_str_loc,:truck_no,
                  :truck_type,:trip_type,:transport_vendor,:driver_name,:driver_phone,:driver_license,:total_truck_wt, :truck_flag,
                   :truck_arrival_docno,:truck_arrival_dt,:truck_receipt_user,:action_status,:sap_status,:sap_transfer_dt,:sap_ack_update_dt,:empty_truck_wt,:sto_date,:vendor,:truck_type_desc,:truck_route)
    end
end