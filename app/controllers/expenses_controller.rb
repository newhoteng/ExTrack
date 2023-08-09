class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /expenses or /expenses.json
  def index
    @group = Group.find(params[:group_id])
    @expenses = @group.expenses.where(author_id: current_user.id)
    # @products = Product.where(author_id: current_user.id, group_id: group.id)
    # @expenses = Expense.all
    # @expenses = current_user.expenses
    # @expenses = Expense.where(group_id: params[:group_id])
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end
  # http://127.0.0.1:3000/groups/2/expenses/new
  # GET groups/group_id/expenses/new
  def new
    @expense = Expense.new(group_ids: [params[:group_id]])
  end

  # GET /expenses/1/edit
  def edit
  end
 
  # POST /expenses or /expenses.json
  def create
    @expense = Expense.new(expense_params)
    # @expense = current_user.expenses.new(expense_params)
    @expense.author_id = current_user.id
    # @expense.group_ids = params[:group_ids]
    @expense.name = @expense.name.titleize

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:name, :amount)
    end
end
