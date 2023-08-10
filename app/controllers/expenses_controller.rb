class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :set_group, only: %i[index new create]
  before_action :authenticate_user!

  # GET /expenses or /expenses.json
  def index
    @expenses = @group.expenses.where(author_id: current_user.id).order('created_at Desc')

    @total_amount = 0
    # Loop through expenses and tally amounts
    @expenses.each do |expense|
      @total_amount += expense.amount
    end
  end

  # GET groups/group_id/expenses/new
  def new
    @expense = Expense.new(group_ids: [params[:group_id]])
  end

  # POST /expenses or /expenses.json
  def create
    @expense = Expense.new(expense_params)
    @expense.author_id = current_user.id

    @expense.name = @expense.name.capitalize

    if @expense.save
      redirect_to group_expenses_path(@group), notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:name, :amount, group_ids: [])
  end
end
