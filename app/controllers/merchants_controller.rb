class MerchantsController <ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    merchant = @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    merchant = Merchant.create(merchant_params)
    if merchant.save
      flash[:succes] = "Thank You for signing up to become a Merchant!"
      redirect_to "/merchants/#{merchant.id}"
    else
      flash[:error] = merchant.errors.full_messages
      redirect_to "/merchants/new"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    if merchant.save
      flash[:success] = "Thank You for updating your information!"
      redirect_to "/merchants/#{merchant.id}"
    else
      flash[:error] = merchant.errors.full_messages
      redirect_to "/merchants/#{merchant.id}/edit"
    end
  end

  def destroy
    Merchant.destroy(params[:id])
    redirect_to '/merchants'
  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
