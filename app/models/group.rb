class Group < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :expenses, through: :categorizations, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id, message: ' already exist'

  def total_amount
    expenses.sum(:amount)
  end

  ICONS = {
    'fa-car' => 'Car',
    'fa-credit-card' => 'Credit Card',
    'fa-solid fa-gift fa-lg' => 'Gift'
  }.freeze
end
