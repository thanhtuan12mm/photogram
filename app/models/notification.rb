class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :subscribed_user
  belongs_to :post
  belongs_to :notified_by, class_name: 'User'
  validates :user_id, :notified_by_id, :post_id, :identifier, :notice_type, presence: true
end
