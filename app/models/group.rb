class Group < ApplicationRecord
  has_one_attached :icon do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  # has_one_attached :icon
  has_many :expenses, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id, message: ' already exist'
end
