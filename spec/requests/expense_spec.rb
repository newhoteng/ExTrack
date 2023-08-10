require 'rails_helper'

RSpec.describe 'Expense', type: :request do
  before(:example) do
    @user = User.first
    sign_in @user
    @group = Group.create(name: 'Outdoor', user_id: @user.id)
  end

  describe 'GET group_expenses_path when user is signed in' do
    it 'returns http success if signed in' do
      get group_expenses_path(@group)
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the correct template if signed in' do
      get group_expenses_path(@group)
      expect(response).to render_template('index')
    end
  end

  describe 'GET group_expenses_path when user is signed out' do
    it 'should redirect to splash page' do
      sign_out @user
      get group_expenses_path(@group)
      expect(response).to redirect_to exTrack_path
      expect(response.status).to eq(302)
    end
  end

  describe 'GET new_group_expense_path when user is signed in' do
    it 'returns http success if signed in' do
      get new_group_expense_path(@group)
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the correct template if signed in' do
      get new_group_expense_path(@group)
      expect(response).to render_template('new')
    end
  end
end