class TrnSfgStocksController < ApplicationController
  before_action :set_trn_sfg_stock, only: [:show, :edit, :update, :destroy]

  # GET /trn_sfg_stocks
  # GET /trn_sfg_stocks.json
  def index
    @trn_sfg_stocks = TrnSfgStock.all
  end

  # GET /trn_sfg_stocks/1
  # GET /trn_sfg_stocks/1.json
  def show
  end

  # GET /trn_sfg_stocks/new
  def new
    @trn_sfg_stock = TrnSfgStock.new
  end

  # GET /trn_sfg_stocks/1/edit
  def edit
  end

  # POST /trn_sfg_stocks
  # POST /trn_sfg_stocks.json
  def create
    @trn_sfg_stock = TrnSfgStock.new(trn_sfg_stock_params)

    respond_to do |format|
      if @trn_sfg_stock.save
        format.html { redirect_to @trn_sfg_stock, notice: 'Trn sfg stock was successfully created.' }
        format.json { render :show, status: :created, location: @trn_sfg_stock }
      else
        format.html { render :new }
        format.json { render json: @trn_sfg_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_sfg_stocks/1
  # PATCH/PUT /trn_sfg_stocks/1.json
  def update
    respond_to do |format|
      if @trn_sfg_stock.update(trn_sfg_stock_params)
        format.html { redirect_to @trn_sfg_stock, notice: 'Trn sfg stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_sfg_stock }
      else
        format.html { render :edit }
        format.json { render json: @trn_sfg_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_sfg_stocks/1
  # DELETE /trn_sfg_stocks/1.json
  def destroy
    @trn_sfg_stock.destroy
    respond_to do |format|
      format.html { redirect_to trn_sfg_stocks_url, notice: 'Trn sfg stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_sfg_stock
      @trn_sfg_stock = TrnSfgStock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trn_sfg_stock_params
      params.fetch(:trn_sfg_stock, {})
    end
end
