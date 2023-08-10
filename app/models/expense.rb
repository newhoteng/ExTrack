class Expense < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :groups, through: :categorizations
  belongs_to :author, class_name: 'User'

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_save :update_group_total

  def update_group_total
    groups.each do |group|
      group.group_total = group.group_total + self.amount
    end
  end
end

