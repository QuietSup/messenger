class User < ApplicationRecord
  has_many :messages_sent, class_name: "Message", foreign_key: :sender_id
  has_many :messages_received, class_name: "Message", foreign_key: :receiver_id

  has_secure_password

  validates :username, presence: true
  validates :password, length: 3..20
end
