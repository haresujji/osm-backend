class OsmIssueDtlsController < ApplicationController
  before_action :set_osm_issue_dtl, only: [:show, :edit, :update, :destroy]

  # GET /osm_issue_dtls
  # GET /osm_issue_dtls.json
  def index
    @osm_issue_dtls = OsmIssueDtl.all
  end

  # GET /osm_issue_dtls/1
  # GET /osm_issue_dtls/1.json
  def show
  end

  # GET /osm_issue_dtls/new
  def new
    @osm_issue_dtl = OsmIssueDtl.new
  end

  # GET /osm_issue_dtls/1/edit
  def edit
  end

  # POST /osm_issue_dtls
  # POST /osm_issue_dtls.json
  def create
    @osm_issue_dtl = OsmIssueDtl.new(osm_issue_dtl_params)

    respond_to do |format|
      if @osm_issue_dtl.save
        format.html { redirect_to @osm_issue_dtl, notice: 'Osm issue dtl was successfully created.' }
        format.json { render :show, status: :created, location: @osm_issue_dtl }
      else
        format.html { render :new }
        format.json { render json: @osm_issue_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /osm_issue_dtls/1
  # PATCH/PUT /osm_issue_dtls/1.json
  def update
    respond_to do |format|
      if @osm_issue_dtl.update(osm_issue_dtl_params)
        format.html { redirect_to @osm_issue_dtl, notice: 'Osm issue dtl was successfully updated.' }
        format.json { render :show, status: :ok, location: @osm_issue_dtl }
      else
        format.html { render :edit }
        format.json { render json: @osm_issue_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /osm_issue_dtls/1
  # DELETE /osm_issue_dtls/1.json
  def destroy
    @osm_issue_dtl.destroy
    respond_to do |format|
      format.html { redirect_to osm_issue_dtls_url, notice: 'Osm issue dtl was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_osm_issue_dtl
      @osm_issue_dtl = OsmIssueDtl.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def osm_issue_dtl_params
      params.fetch(:osm_issue_dtl, {})
    end
end
