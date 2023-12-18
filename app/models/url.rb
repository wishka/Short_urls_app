class Url < ApplicationRecord
  validates :original_url, presence: true
  validates :short_url, presence: true, uniqueness: true
end