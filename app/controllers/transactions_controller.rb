class TransactionsController < ApplicationController
  before_action :set_transaction

  def show

    puts @transaction
    @transaction.each do |transaction|

      # puts transaction
    @products = Product.where(params[transaction.product_id])
    end
  end


  private
  def set_transaction
    @transaction = Transaction.where(params[:user_id])
  end
end
