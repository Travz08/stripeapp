class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  def new
  end

  def create
   @amount = (@product.price * 100).to_i

   if current_user.stripe_id == nil
   customer = StripeTool.create_customer(email: params[:stripeEmail],
   stripe_token: params[:stripeToken])

   current_user.stripe_id = customer.id
   current_user.save()


   charge = StripeTool.create_charge(customer_id: customer.id,
   amount: @amount,
   description: 'Rails Stripe customer')

   @transaction = Transaction.create(user_id: current_user.id, charge_id: charge.id, item_id: @product.id, amount: @amount)
   @transaction.user = current_user
   @transaction.save

  else
    charge = StripeTool.create_charge(customer_id: current_user.stripe_id,
    amount: @amount,
    description: 'Rails Stripe customer')

    @transaction = Transaction.create(user_id: current_user.id, product_id: @product.id, charge_id: charge.id, amount: @amount)
    @transaction.user = current_user
    @transaction.save
  end
 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
 end

 private

 def set_product
   @product = Product.find(params[:product_id])
 end

 def set_transaction
   @transaction = Transaction.find(params[:id])
 end
end
