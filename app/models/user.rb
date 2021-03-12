class User < ApplicationRecord
  validates :username, uniqueness: true
  validates :username, presence: true

  has_many :messages

  def self.generator(username)
    User.find_or_create_by(username: username)
  end
end
