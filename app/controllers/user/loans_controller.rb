#frozen_string_literal: true
class User::LoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan, only: [:show, :accept, :reject, :repay, :request_readjustment, :adjustment_details]

  def index
    @loans = current_user.loans
  end

  def new
    @loan = Loan.new
  end

  def create
    @loan = current_user.loans.build(loan_params.merge(status: "requested"))
    if @loan.save
      redirect_to user_loans_path, notice: "Loan request submitted!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def accept
    @loan.update!(status: "open")
    # Fund transfer logic
    LoanService.new(@loan).fund!
    redirect_to user_loan_path(@loan), notice: "Loan accepted and activated."
  end

  def reject
    @loan.update!(status: "rejected")
    redirect_to user_loan_path(@loan), alert: "You rejected the loan offer."
  end

  def repay
    LoanService.new(@loan).repay!
    redirect_to user_loans_path, notice: "Loan repaid successfully."
  end

  def request_readjustment
    @loan.update!(status: "readjustment_requested")
    redirect_to user_loan_path(@loan), alert: "Readjustment requested."
  end

  def adjustment_details
    puts "######INSIDE ADJUSTMENT #{@loan.id}"
    @loan_adjustments = LoanAdjustment.where(loan_id:@loan.id)#@loan.loan_adjustments
    puts ".........#{@loan_adjustments}........."
  end

  private

  def set_loan
    @loan = current_user.loans.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate)
  end
end
