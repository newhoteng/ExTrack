require 'rails_helper'

RSpec.describe Categorization, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Categorization.reflect_on_association(:expense).macro).to eq(:belongs_to)
      expect(Categorization.reflect_on_association(:group).macro).to eq(:belongs_to)
    end
  end
end