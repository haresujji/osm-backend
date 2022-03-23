class LoginsController < ApplicationController
  before_action :set_login, only: [:show, :update, :destroy]

  # GET /logins
  # GET /logins.json
  def index
    @logins = Login.all
  end

  # GET /logins/1
  # GET /logins/1.json
  def show
  end

  # POST /logins
  # POST /logins.json
  def create
    @login = Login.new(login_params)

    if @login.save
      render :show, status: :created, location: @login
    else
      render json: @login.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logins/1
  # PATCH/PUT /logins/1.json
  def update
    if @login.update(login_params)
      render :show, status: :ok, location: @login
    else
      render json: @login.errors, status: :unprocessable_entity
    end
  end

  # DELETE /logins/1
  # DELETE /logins/1.json
  def destroy
    @login.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_login
      @login = Login.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def login_params
      params.fetch(:login, {})
    end
end
