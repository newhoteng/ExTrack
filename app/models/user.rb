class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  
  has_many :expenses, dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true

  # def image_thumbnail
  #   if image.attached?
  #     image.variant(resize: '150x150!').processed
  #   else
  #     '/default_profile.png'
  #   end
  # end

  # private

  # def add_default_image
  #   unless image.attached?
  #     image.attach(
  #       io: File.open(
  #         Rails.root.join(
  #           'app', 'assets', 'images', 'default_profile.png'
  #         )
  #       ), filename: 'default_profile.png',
  #       content_type: 'image/png'
  #     )
  #   end
  # end
end
