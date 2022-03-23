class TrucktypeMastersController < ApplicationController
  before_action :set_trucktype_master, only: [:show, :update, :destroy]

  # GET /trucktype_masters
  # GET /trucktype_masters.json
  def index
    @trucktype_masters = TrucktypeMaster.all
  end

  # GET /trucktype_masters/1
  # GET /trucktype_masters/1.json
  def show
  end

  # POST /trucktype_masters
  # POST /trucktype_masters.json
  def create
    @trucktype_master = TrucktypeMaster.new(trucktype_master_params)

    if @trucktype_master.save
      render :show, status: :created, location: @trucktype_master
    else
      render json: @trucktype_master.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trucktype_masters/1
  # PATCH/PUT /trucktype_masters/1.json
  def update
    if @trucktype_master.update(trucktype_master_params)
      render :show, status: :ok, location: @trucktype_master
    else
      render json: @trucktype_master.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trucktype_masters/1
  # DELETE /trucktype_masters/1.json
  def destroy
    @trucktype_master.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trucktype_master
      @trucktype_master = TrucktypeMaster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trucktype_master_params
      params.fetch(:trucktype_master, {})
    end
end
