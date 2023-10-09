require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Group.reflect_on_association(:categorizations).macro).to eq(:has_many)
      expect(Group.reflect_on_association(:expenses).macro).to eq(:has_many)
      expect(Group.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    user = User.create(name: 'Harriet', email: 'exam@email.com', password: 'password',
                       password_confirmation: 'password')

    subject { Group.new(name: 'Sports', user_id: user.id) }

    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'name should be unique for each user' do
      subject.name = 'Outdoor'
      expect(subject).to_not be_valid
    end
  end
end
