class ItemsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_item, only: %i[ show edit update destroy ]
  after_action :update_order, only: %i[ create ]

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end
  def create
    @item = Item.find_or_initialize_by(item_params)

    if @item.persisted?
      update_quantity
    elsif params[:commit] == "add"
      if @item.save
        render_turbo_response(action: :append)
      else
        render_flash
      end
    else
      render_turbo_response(action: :remove)
    end
  end

  def update_quantity
    case params[:commit]
    when "add"
      if @item.increment_quantity
      else
        flash.now[:error] = "Item is low on stock!"
      end
    when "subtract"
      if @item.quantity <= 1
        @item.destroy
        flash.now[:notice] = "Item removed!"
        render_turbo_response(action: :remove) and return
      else
        @item.decrement_quantity
      end
    end
    render_turbo_response(action: :replace)
  end

  def destroy
    @item.destroy
    flash.now[:notice] = "Item removed!"
    render_turbo_response(action: :remove)
  end

  private

  def render_turbo_response(action:)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream_response(action)
      end
    end
  end

  def turbo_stream_response(action)
    case action
    when :append
      turbo_stream.replace("order_details", partial: "orders/details", locals: { order: @item.order }) +
      turbo_stream.replace(dom_id(@item.product), partial: "orders/option", locals: { product: @item.product, order: @item.order }) +
      turbo_stream.replace("flash", partial: "shared/flash")
    when :replace
       turbo_stream.replace("order_details", partial: "orders/details", locals: { order: @item.order }) +
      turbo_stream.replace(dom_id(@item.product), partial: "orders/option", locals: { product: @item.product, order: @item.order }) +
      turbo_stream.replace("flash", partial: "shared/flash")
    when :remove
      turbo_stream.remove(dom_id(@item)) +
      turbo_stream.replace(dom_id(@item.product), partial: "orders/option", locals: { product: @item.product, order: @item.order }) +
      turbo_stream.replace("flash", partial: "shared/flash")
    end
  end

  def render_flash
    render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash")
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.permit(:order_id, :product_id)
  end

  def update_order
    @item.order.recompute_cost
  end
end
