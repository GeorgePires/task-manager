# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :category, optional: true

  # normalizes :name, with: ->(name) { name.donwcase.titleize }
end
