class TransportMastersController < ApplicationController
  before_action :set_transport_master, only: [:show, :update, :destroy]

  # GET /transport_masters
  # GET /transport_masters.json
  def index
    @transport_masters = TransportMaster.all
  end

  # GET /transport_masters/1
  # GET /transport_masters/1.json
  def show
  end

  # POST /transport_masters
  # POST /transport_masters.json
  def create
    @transport_master = TransportMaster.new(transport_master_params)

    if @transport_master.save
      render :show, status: :created, location: @transport_master
    else
      render json: @transport_master.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transport_masters/1
  # PATCH/PUT /transport_masters/1.json
  def update
    if @transport_master.update(transport_master_params)
      render :show, status: :ok, location: @transport_master
    else
      render json: @transport_master.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transport_masters/1
  # DELETE /transport_masters/1.json
  def destroy
    @transport_master.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport_master
      @transport_master = TransportMaster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transport_master_params
      params.fetch(:transport_master, {})
    end
end
