require 'rails_helper'

RSpec.describe 'Group index page', type: :feature do
  before(:example) do
    @user = User.first
    sign_in @user
    @group = Group.create(name: 'Outdoor', user_id: @user.id)
    Group.create(name: 'Sports', user_id: @user.id)
    visit root_path
  end

  describe "page's content" do
    it "should see the 'ADD A NEW CATEGORY' button" do
      expect(page).to have_content('ADD A NEW CATEGORY')
    end

    it "should see the 'Sign Out' button" do
      expect(page).to have_content('Sign Out')
    end

    it 'should see names of all groups created by user' do
      @user.groups.each do |group|
        expect(page).to have_content group.name
      end
    end
  end

  describe "clicking on 'ADD A NEW CATEGORY' button" do
    it 'redirects to groups#new page' do
      click_link(href: new_group_path)
      expect(page).to have_current_path(new_group_path)
    end
  end

  describe 'clicking on a category item' do
    it 'redirects to groups#new page' do
      click_link(href: group_expenses_path(@group))
      expect(page).to have_current_path(group_expenses_path(@group))
    end
  end
end
