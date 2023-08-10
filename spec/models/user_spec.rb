require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(User.reflect_on_association(:groups).macro).to eq(:has_many)
      expect(User.reflect_on_association(:expenses).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    subject do
      User.new(name: 'Harriet', email: 'example@email.com', password: 'password', password_confirmation: 'password')
    end

    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'email should be present' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'password should be present' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'password_confirmation should match password' do
      subject.password_confirmation = 'Password'
      expect(subject).to_not be_valid
    end
  end
end
