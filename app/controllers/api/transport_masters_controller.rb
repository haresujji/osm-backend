class Api::TransportMastersController < Api::ApiController
  before_action :authenticate_user

def fetch_vendors
    begin
      vendors = TransportMaster.select('distinct name1')
        if vendors.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:vendors
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
end