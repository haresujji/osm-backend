class Api::ApiController < ActionController::API
include ActionController::MimeResponds
def authenticate_user
	token = request.headers['Authorization']
	# link = Rails.application.credentials.dig(:ip_address)
    response = HTTParty.get(

    "http://10.10.1.206:32405/users/user_info", headers: {"Authorization" =>  token})

  

    if  response.code != 200
    	render json: {"error": response.body}, status: 401
    end
end


end
