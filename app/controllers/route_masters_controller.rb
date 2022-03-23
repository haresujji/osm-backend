class RouteMastersController < ApplicationController
  before_action :set_route_master, only: [:show, :update, :destroy]

  # GET /route_masters
  # GET /route_masters.json
  def index
    @route_masters = RouteMaster.all
  end

  # GET /route_masters/1
  # GET /route_masters/1.json
  def show
  end

  # POST /route_masters
  # POST /route_masters.json
  def create
    @route_master = RouteMaster.new(route_master_params)

    if @route_master.save
      render :show, status: :created, location: @route_master
    else
      render json: @route_master.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /route_masters/1
  # PATCH/PUT /route_masters/1.json
  def update
    if @route_master.update(route_master_params)
      render :show, status: :ok, location: @route_master
    else
      render json: @route_master.errors, status: :unprocessable_entity
    end
  end

  # DELETE /route_masters/1
  # DELETE /route_masters/1.json
  def destroy
    @route_master.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route_master
      @route_master = RouteMaster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def route_master_params
      params.fetch(:route_master, {})
    end
end
