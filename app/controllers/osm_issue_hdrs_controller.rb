class OsmIssueHdrsController < ApplicationController
  before_action :set_osm_issue_hdr, only: [:show, :edit, :update, :destroy]

  # GET /osm_issue_hdrs
  # GET /osm_issue_hdrs.json
  def index
    @osm_issue_hdrs = OsmIssueHdr.all
  end

  # GET /osm_issue_hdrs/1
  # GET /osm_issue_hdrs/1.json
  def show
  end

  # GET /osm_issue_hdrs/new
  def new
    @osm_issue_hdr = OsmIssueHdr.new
  end

  # GET /osm_issue_hdrs/1/edit
  def edit
  end

  # POST /osm_issue_hdrs
  # POST /osm_issue_hdrs.json
  def create
    @osm_issue_hdr = OsmIssueHdr.new(osm_issue_hdr_params)

    respond_to do |format|
      if @osm_issue_hdr.save
        format.html { redirect_to @osm_issue_hdr, notice: 'Osm issue hdr was successfully created.' }
        format.json { render :show, status: :created, location: @osm_issue_hdr }
      else
        format.html { render :new }
        format.json { render json: @osm_issue_hdr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /osm_issue_hdrs/1
  # PATCH/PUT /osm_issue_hdrs/1.json
  def update
    respond_to do |format|
      if @osm_issue_hdr.update(osm_issue_hdr_params)
        format.html { redirect_to @osm_issue_hdr, notice: 'Osm issue hdr was successfully updated.' }
        format.json { render :show, status: :ok, location: @osm_issue_hdr }
      else
        format.html { render :edit }
        format.json { render json: @osm_issue_hdr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /osm_issue_hdrs/1
  # DELETE /osm_issue_hdrs/1.json
  def destroy
    @osm_issue_hdr.destroy
    respond_to do |format|
      format.html { redirect_to osm_issue_hdrs_url, notice: 'Osm issue hdr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_osm_issue_hdr
      @osm_issue_hdr = OsmIssueHdr.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def osm_issue_hdr_params
      params.fetch(:osm_issue_hdr, {})
    end
end
