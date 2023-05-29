# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :category, optional: true
  # normalizes :name, with: ->(name) { name.donwcase.titleize }

  validates :name, :position, presence: true
  validates :name, length: { minimum: 3, maximum: 50 }
  validates :position, numericality: { greater_than: 0 }

  scope :sorted, -> { order(:position) }
  scope :complete, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  scope :search, ->(word) { where('LOWER(name) LIKE ?', "%#{word.downcase}%") }
end
