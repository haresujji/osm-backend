class CheckListsController < ApplicationController
  before_action :set_check_list, only: [:show, :update, :destroy]

  # GET /check_lists
  # GET /check_lists.json
  def index
    @check_lists = CheckList.all
  end

  # GET /check_lists/1
  # GET /check_lists/1.json
  def show
  end

  # POST /check_lists
  # POST /check_lists.json
  def create
    @check_list = CheckList.new(check_list_params)

    if @check_list.save
      render :show, status: :created, location: @check_list
    else
      render json: @check_list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /check_lists/1
  # PATCH/PUT /check_lists/1.json
  def update
    if @check_list.update(check_list_params)
      render :show, status: :ok, location: @check_list
    else
      render json: @check_list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /check_lists/1
  # DELETE /check_lists/1.json
  def destroy
    @check_list.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_check_list
      @check_list = CheckList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def check_list_params
      params.fetch(:check_list, {})
    end
end
