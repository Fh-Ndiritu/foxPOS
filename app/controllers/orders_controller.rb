class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy]
  before_action :set_category, only: %i[options]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end


  def options
    @products = @category.products.displayable if @category
    @order = Order.find(params.expect(:order_id))
  end

  # GET /orders/1 or /orders/1.jsonF
  def show
  end

  # GET /orders/new
  def new
    @order = Order.create
    redirect_to edit_order_path(@order)
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to home_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.items.present? && @order.update(order_params)
        format.html { redirect_to home_menu_path, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        flash[:error] =  "Order has no items!" if @order.items.blank?
        format.html { redirect_to edit_order_path(@order) }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_path, status: :see_other, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.permit(order: [ :customer_name, :progress ])
    end


    def set_category
      @category = Category.find_by(id: params[:category_id].to_i)
    end
end
