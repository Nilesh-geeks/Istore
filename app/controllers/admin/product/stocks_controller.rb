class Admin::Product::StocksController < ApplicationController
  before_action :set_admin_product_stock, only: %i[ show edit update destroy ]

  # GET /admin/product/stocks or /admin/product/stocks.json
  def index
    @admin_product_stocks = Admin::Product::Stock.all
  end

  # GET /admin/product/stocks/1 or /admin/product/stocks/1.json
  def show
  end

  # GET /admin/product/stocks/new
  def new
    @admin_product_stock = Admin::Product::Stock.new
  end

  # GET /admin/product/stocks/1/edit
  def edit
  end

  # POST /admin/product/stocks or /admin/product/stocks.json
  def create
    @admin_product_stock = Admin::Product::Stock.new(admin_product_stock_params)

    respond_to do |format|
      if @admin_product_stock.save
        format.html { redirect_to @admin_product_stock, notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @admin_product_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_product_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/product/stocks/1 or /admin/product/stocks/1.json
  def update
    respond_to do |format|
      if @admin_product_stock.update(admin_product_stock_params)
        format.html { redirect_to @admin_product_stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_product_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_product_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/product/stocks/1 or /admin/product/stocks/1.json
  def destroy
    @admin_product_stock.destroy!

    respond_to do |format|
      format.html { redirect_to admin_product_stocks_path, status: :see_other, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product_stock
      @admin_product_stock = Admin::Product::Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_product_stock_params
      params.require(:admin_product_stock).permit(:size, :amount, :product_id)
    end
end
