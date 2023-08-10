class Group < ApplicationRecord
  has_one_attached :icon do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  has_many :categorizations, dependent: :destroy
  has_many :expenses, through: :categorizations
  belongs_to :user

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id, message: ' already exist'
end
