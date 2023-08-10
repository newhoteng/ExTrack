require 'rails_helper'

RSpec.describe 'Expense index page', type: :feature do
  before(:example) do
    @user = User.first
    sign_in @user
    @group = Group.create(name: 'Outdoor', user_id: @user.id)
    visit group_expenses_path(@group)
    Expense.create(name: 'Ball', amount: 30, author_id: @user.id)
    Expense.create(name: 'Chair', amount: 20, author_id: @user.id)
  end

  describe "page's content" do
    it "should see the 'ADD A NEW TRANSACTION' button" do
      expect(page).to have_content('ADD A NEW TRANSACTION')
    end

    it 'should see names of all transactions created by user' do
      @group.expenses.each do |expense|
        expect(page).to have_content expense.name
      end
    end

    it 'should see amount value of all transactions created by user' do
      @group.expenses.each do |expense|
        expect(page).to have_content expense.amount
      end
    end
  end

  describe "clicking on 'ADD A NEW TRANSACTION' button" do
    it 'redirects to expenses#new page' do
      click_link(href: new_group_expense_path(@group))
      expect(page).to have_current_path(new_group_expense_path(@group))
    end
  end

  describe 'clicking the back arrow' do
    it 'redirects to root page' do
      click_link(href: root_path)
      expect(page).to have_current_path(root_path)
    end
  end
end
