# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :group
  validates_presence_of :name, :email
  validates :name, uniqueness: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }

end

