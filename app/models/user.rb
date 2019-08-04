class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :last_one_administrator
  has_many :blogs, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  private

  def last_one_administrator
    admin_user = User.where(administrator: true)
    if admin_user.count == 1 && administrator
      throw :abort
    else
    end
  end
end
