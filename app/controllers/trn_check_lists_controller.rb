class TrnCheckListsController < ApplicationController
  before_action :set_trn_check_list, only: [:show, :update, :destroy]

  # GET /trn_check_lists
  # GET /trn_check_lists.json
  def index
    @trn_check_lists = TrnCheckList.all
  end

  # GET /trn_check_lists/1
  # GET /trn_check_lists/1.json
  def show
  end

  # POST /trn_check_lists
  # POST /trn_check_lists.json
  def create
    @trn_check_list = TrnCheckList.new(trn_check_list_params)

    if @trn_check_list.save
      render :show, status: :created, location: @trn_check_list
    else
      render json: @trn_check_list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trn_check_lists/1
  # PATCH/PUT /trn_check_lists/1.json
  def update
    if @trn_check_list.update(trn_check_list_params)
      render :show, status: :ok, location: @trn_check_list
    else
      render json: @trn_check_list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trn_check_lists/1
  # DELETE /trn_check_lists/1.json
  def destroy
    @trn_check_list.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_check_list
      @trn_check_list = TrnCheckList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trn_check_list_params
      params.fetch(:trn_check_list, {})
    end
end
