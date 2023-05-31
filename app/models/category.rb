# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, length: { within: 2..50 }

  scope :sorted, -> { order(:name) }
end
