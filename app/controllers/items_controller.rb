class ItemsController<ApplicationController

  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    if Item.where(id: params[:id]).empty?
      flash[:error] = "Sorry, that item does not exist"
      redirect_to '/items'
    else
      @item = Item.find(params[:id])
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    if item.save
      flash[:success] = "Thanks for adding your new item!"
      redirect_to "/merchants/#{merchant.id}/items"
    else
      flash[:error] = item.errors.full_messages
      redirect_to "/merchants/#{merchant.id}/items/new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      flash[:success] = "Thank You for updating your item information!"
      redirect_to "/items/#{item.id}"
    else
      flash[:error] = item.errors.full_messages
      redirect_to "/items/#{item.id}/edit"
    end
  end

  def destroy
    item = Item.destroy(params[:id])
    redirect_to '/items'
  end

  private

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end

end
