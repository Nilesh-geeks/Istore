class Admin::CategoriesController < AdminController
  before_action :set_admin_category, only: %i[ show edit update destroy ]

  # GET /admin/categories or /admin/categories.json
  def index
    @admin_categories = Category.all
  end

  # GET /admin/categories/1 or /admin/categories/1.json
  def show
  end

  # GET /admin/categories/new
  def new
    @admin_category = Category.new
  end

  # GET /admin/categories/1/edit
  def edit
  end

  # POST /admin/categories or /admin/categories.json
  def create
    @admin_category = Category.new(admin_category_params)
    respond_to do |format|
      begin
        if @admin_category.save
          format.html { redirect_to admin_category_path(@admin_category), notice: "Category was successfully created." }
          format.json { render :show, status: :created, location: @admin_category }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @admin_category.errors, status: :unprocessable_entity }
        end
      rescue StandardError => e
        # Log the error and handle it
        logger.error "Error creating category: #{e.message}"
        format.html { render :new, alert: "An error occurred while creating the category." }
        format.json { render json: { error: "An unexpected error occurred." }, status: :internal_server_error }
      end
    end
  end



  # PATCH/PUT /admin/categories/1 or /admin/categories/1.json
  def update
    respond_to do |format|
      if @admin_category.update(admin_category_params)
        format.html { redirect_to admin_category_path(@admin_category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/categories/1 or /admin/categories/1.json
  def destroy
    @admin_category = Category.find(params[:id]) # Ensure you fetch the category first

    respond_to do |format|
      if @admin_category.destroy
        format.html { redirect_to admin_categories_path, status: :see_other, notice: "Category was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_categories_path, alert: "Failed to destroy the category." }
        format.json { render json: { error: "Failed to destroy the category." }, status: :unprocessable_entity }
      end
    rescue StandardError => e
      # Log the error and respond appropriately
      logger.error "Error destroying category: #{e.message}"
      format.html { redirect_to admin_categories_path, alert: "An unexpected error occurred." }
      format.json { render json: { error: "An unexpected error occurred." }, status: :internal_server_error }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_category
      @admin_category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_category_params
      params.require(:category).permit(:name, :description)
    end
end
