class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :set_group, only: %i[index new]
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

  # GET /expenses/1 or /expenses/1.json
  def show; end

  # GET groups/group_id/expenses/new
  def new
    @expense = Expense.new(group_ids: [params[:group_id]])
  end

  # GET /expenses/1/edit
  def edit; end

  # POST /expenses or /expenses.json
  def create
    @group = Group.find(params[:group_id])
    @expense = Expense.new(expense_params)
    @expense.author_id = current_user.id
    # @expense.group_ids = params[:group_ids]
    # @expense.name = @expense.name.titleize

    if @expense.save
      redirect_to group_expenses_path(@group), notice: 'Transaction was successfully created.' 
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Expense was successfully updated.' }
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
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
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

# group_ids: []
#   <div>
# <%= form.hidden_field :group_id, value: @group.id %>
# </div>

# <%= form.collection_check_boxes :group_ids, Group.order(:name), :id, :name %>

# <%= form_with(model: [@expense, @group], url: group_expenses_path, :html => {:class => "registration"}) do |form| %>