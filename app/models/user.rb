# frozen_string_literal: true

class User < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :contacts, through: :groups
  validates_presence_of :first_name, :last_name, :email, :password_digest
  validates :email, uniqueness: true

  #encrypt password
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, format: {with: /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{6,}/,
                                                                        message: "must include at least one lowercase letter, one uppercase letter, and one digit"}
end
