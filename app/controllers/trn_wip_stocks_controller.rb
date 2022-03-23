class TrnWipStocksController < ApplicationController
  before_action :set_trn_wip_stock, only: [:show, :edit, :update, :destroy]

  # GET /trn_wip_stocks
  # GET /trn_wip_stocks.json
  def index
    @trn_wip_stocks = TrnWipStock.all
  end

  # GET /trn_wip_stocks/1
  # GET /trn_wip_stocks/1.json
  def show
  end

  # GET /trn_wip_stocks/new
  def new
    @trn_wip_stock = TrnWipStock.new
  end

  # GET /trn_wip_stocks/1/edit
  def edit
  end

  # POST /trn_wip_stocks
  # POST /trn_wip_stocks.json
  def create
    @trn_wip_stock = TrnWipStock.new(trn_wip_stock_params)

    respond_to do |format|
      if @trn_wip_stock.save
        format.html { redirect_to @trn_wip_stock, notice: 'Trn wip stock was successfully created.' }
        format.json { render :show, status: :created, location: @trn_wip_stock }
      else
        format.html { render :new }
        format.json { render json: @trn_wip_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_wip_stocks/1
  # PATCH/PUT /trn_wip_stocks/1.json
  def update
    respond_to do |format|
      if @trn_wip_stock.update(trn_wip_stock_params)
        format.html { redirect_to @trn_wip_stock, notice: 'Trn wip stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_wip_stock }
      else
        format.html { render :edit }
        format.json { render json: @trn_wip_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_wip_stocks/1
  # DELETE /trn_wip_stocks/1.json
  def destroy
    @trn_wip_stock.destroy
    respond_to do |format|
      format.html { redirect_to trn_wip_stocks_url, notice: 'Trn wip stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wip_stock
      @trn_wip_stock = TrnWipStock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trn_wip_stock_params
      params.fetch(:trn_wip_stock, {})
    end
end
