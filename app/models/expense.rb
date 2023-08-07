class Expense < ApplicationRecord
  has_many :groups, dependent: :destroy
  belongs_to :author, class_name: 'User'
end
