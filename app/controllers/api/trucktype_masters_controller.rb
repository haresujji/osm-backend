class Api::TrucktypeMastersController < Api::ApiController
 before_action :authenticate_user

def fetch_trucktypes
    begin
      trucktypes = TrucktypeMaster.select('distinct truck_type,truck_type_desc')
        if trucktypes.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:trucktypes
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_truck_code
    code = params['code']
    begin
      trucktypes = TrucktypeMaster.select('distinct truck_type').where('truck_type_desc=?',code)
        if trucktypes.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:trucktypes
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
end