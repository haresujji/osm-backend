class UserLoginsController < ApplicationController
  before_action :set_user_login, only: [:show, :update, :destroy]

  # GET /user_logins
  # GET /user_logins.json
  def index
    @user_logins = UserLogin.all
  end

  # GET /user_logins/1
  # GET /user_logins/1.json
  def show
  end

  # POST /user_logins
  # POST /user_logins.json
  def create
    @user_login = UserLogin.new(user_login_params)

    if @user_login.save
      render :show, status: :created, location: @user_login
    else
      render json: @user_login.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_logins/1
  # PATCH/PUT /user_logins/1.json
  def update
    if @user_login.update(user_login_params)
      render :show, status: :ok, location: @user_login
    else
      render json: @user_login.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_logins/1
  # DELETE /user_logins/1.json
  def destroy
    @user_login.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_login
      @user_login = UserLogin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_login_params
      params.fetch(:user_login, {})
    end
end
