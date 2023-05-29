# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :category, optional: true

  # normalizes :name, with: ->(name) { name.donwcase.titleize }

  scope :sorted, -> { order(:position) }

  scope :complete, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }

  scope :search, ->(word) { where('LOWER(name) LIKE ?', "%#{word.downcase}%") }
end
