# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :category, optional: true
end
