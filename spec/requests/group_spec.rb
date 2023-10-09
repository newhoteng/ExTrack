require 'rails_helper'

RSpec.describe 'Group', type: :request do
  before(:example) do
    @user = User.first
    sign_in @user
  end

  describe 'GET root_path when user is signed in' do
    it 'returns http success if signed in' do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the correct template if signed in' do
      get root_path
      expect(response).to render_template('index')
    end
  end

  describe 'GET root_path when user is signed out' do
    it 'should redirect to splash page' do
      sign_out @user
      get '/'
      expect(response).to redirect_to exTrack_path
      expect(response.status).to eq(302)
    end
  end

  describe 'GET new_group_path when user is signed in' do
    it 'returns http success if signed in' do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the correct template if signed in' do
      get new_group_path
      expect(response).to render_template('new')
    end
  end
end
