require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Expense.reflect_on_association(:categorizations).macro).to eq(:has_many)
      expect(Expense.reflect_on_association(:groups).macro).to eq(:has_many)
      expect(Expense.reflect_on_association(:author).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    user = User.create(name: 'Harriet', email: 'exam@email.com', password: 'password',
                       password_confirmation: 'password')

    subject { Expense.new(name: 'Ball', amount: 30, author_id: user.id) }

    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'amount should be a number' do
      subject.amount = 'two'
      expect(subject).to_not be_valid
    end

    it 'amount should be greater than or equal to zero' do
      subject.amount = -1
      expect(subject).to_not be_valid
      expect(subject.errors[:amount]).to include('must be greater than or equal to 0')
    end
  end
end
