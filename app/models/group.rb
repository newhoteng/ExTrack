class Group < ApplicationRecord
  has_one_attached :icon
  has_many :expenses, dependent: :destroy
  belongs_to :user
end
