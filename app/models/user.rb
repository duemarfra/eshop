# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  admin           :boolean          default(FALSE)
#  business        :boolean          default(FALSE)
#  customer        :boolean          default(TRUE)
#  email           :string           not null
#  password_digest :string           not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true,
                    format: {
                      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                      message: :invalid,
                    }
  validates :username, presence: true, uniqueness: true,
                       length: { in: 3..15 },
                       format: {
                         with: /\A[a-z0-9A-Z]+\z/,
                         message: :invalid,
                       }
  validates :password, length: { minimum: 6 }, unless: -> { password.blank? }

  has_many :items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :shoppings, dependent: :destroy

  before_save :downcase_attributes

  private

  def downcase_attributes
    self.email = email.downcase
    self.username = username.downcase
  end
end
