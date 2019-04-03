class Trip < ApplicationRecord
  belongs_to :user
  validates :started_at, presence: true
end
