class Post < ApplicationRecord
  acts_as_votable
  validates :image, presence: true
  has_attached_file :image, styles: { :medium => '640x' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :user
  validates :user_id, presence: true
  has_many :comments, dependent: :destroy
  paginates_per 3
  has_many :notifications, dependent: :destroy
end
