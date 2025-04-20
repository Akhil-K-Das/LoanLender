# frozen_string_literal: true
class Admin::LoansController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_loan, only: [:show, :update, :approve, :reject]
  
    def index
      @loans = Loan.all
    end
  
    def show; end
  
    def update
        # service = LoanApprovalService.new(@loan)
        @admin = User.admin.first
        puts "INSIDE APPROVAL SERVICE...............#{@admin.wallet.balance} and #{(params[:loan][:amount])}"
        if @admin.wallet.balance >= (params[:loan][:amount]).to_i
            if @loan.update(loan_params.merge(status: "waiting_for_adjustment_acceptance"))
            LoanAdjustment.create!(
                loan: @loan,
                new_amount: @loan.amount,
                new_interest_rate: @loan.interest_rate,
                made_by: "admin"
            )
            redirect_to admin_loans_path, notice: "Loan updated."
            else
            render :show
            end
        else
            puts " not enough funds"
            redirect_to admin_loans_path, alert: "Insufficient funds in admin's wallet"
        end
    end

    def approve
        # redirect_to admin_loans_path, notice: "Loan apporved."
        # service = LoanApprovalService.new(@loan)
        @admin = User.admin.first
        
        if @admin.wallet.balance >= @loan.amount
            puts "INSIDE APPROVAL SERVICE...............#{@admin.wallet.balance} and #{@loan.amount}"
            @loan.update(status: "approved")
            redirect_to admin_loans_path, notice: 'Loan approved!'
        else
            puts "not enough funds"
            redirect_to admin_loans_path, alert: "Insufficient funds in admin's wallet"
        end
    end

    def reject
        puts "INSIDE REJECT"
        @loan.update(status: "rejected")
        redirect_to admin_loans_path, alert: "You rejected the loan offer."
    end
    
    private
    
    def loan_params
    params.require(:loan).permit(:amount, :interest_rate, :status)
    end
  
    def require_admin
      redirect_to root_path unless current_user.admin?
    end
  
    def set_loan
      @loan = Loan.find(params[:id])
    end
end
  