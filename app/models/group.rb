class Group < ApplicationRecord
  has_one_attached :icon do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  has_many :expenses, through: :expenses_groups
  has_many :expenses_groups
  belongs_to :user

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id, message: ' already exist'
end
