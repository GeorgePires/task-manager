# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :category, optional: true
  # normalizes :name, with: ->(name) { name.donwcase.titleize }

  validates :name, :position, presence: true
  validates :name, length: { minimum: 3, maximum: 50 }
  validates :position, numericality: { greater_than: 0 }

  validate :description_has_no_prohibited_words

  scope :sorted, -> { order(:position) }
  scope :complete, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  scope :search, ->(word) { where('LOWER(name) LIKE ?', "%#{word.downcase}%") }

  private

  def description_has_no_prohibited_words
    return unless description.present?

    prohibited_words = %w[later eventually someday]
    prohibited_words.each do |word|
      if description.include?(word)
        errors.add(:description, "Cannot contain prohibited word: #{word}")
      end
    end
  end
end
