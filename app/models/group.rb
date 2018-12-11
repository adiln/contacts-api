# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :contacts, dependent: :destroy
  validates_presence_of :name
  validates :name, uniqueness: true
end
