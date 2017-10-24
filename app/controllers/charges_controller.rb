class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  def new
  end

  def create
   @amount = (@product.price * 100).to_i

   customer = StripeTool.create_customer(email: current_user.email,
   stripe_token: params[:stripeToken])

   charge = StripeTool.create_charge(customer_id: customer.id,
   amount: @amount,
   description: 'Rails Stripe customer')

 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
 end

 private

 def set_product
   @product = Product.find(params[:product_id])
 end
end
