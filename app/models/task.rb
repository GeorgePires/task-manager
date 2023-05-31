# frozen_string_literal: true

class Task < ApplicationRecord
  attr_accessor :skip_titleize_name

  belongs_to :category, optional: true
  has_and_belongs_to_many :tags
  # normalizes :name, with: ->(name) { name.donwcase.titleize }

  before_validation :titleize_name, unless: :skip_titleize_name
  before_validation :set_default_position,
                    if: proc { |t| t.position.blank? || t.position < 1 }

  before_create :log_create
  before_update :log_update

  after_save :log_save
  after_commit :cleaning_reminder, if: :too_many_records?

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
    return if description.blank?

    prohibited_words = %w[later eventually someday]
    prohibited_words.each do |word|
      errors.add(:description, "Cannot contain prohibited word: #{word}") if description.include?(word)
    end
  end

  def titleize_name
    self.name = name.titleize
  end

  def set_default_position
    max = Task.maximum(:position) || 0
    self.position = max + 1
  end

  def log_create
    logger.debug("Task being created: #{name}")
  end

  def log_update
    logger.debug("Task being updated: #{name}")
  end

  def log_save
    # runs on both create & update
    logger.debug("Task was saved: #{name}")
  end

  def cleaning_reminder
    # This could be a placeholder for sending an email to an admin
    logger.debug('Remember to prune old tasks')
  end

  def too_many_records?
    Task.count > 4
  end
end
