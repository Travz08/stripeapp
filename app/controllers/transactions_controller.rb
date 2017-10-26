class TransactionsController < ApplicationController
  before_action :set_transaction

  def show

  end


  private
  def set_transaction
    @transaction = Transaction.where(params[:user_id])
  end
end
