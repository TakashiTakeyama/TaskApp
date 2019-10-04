class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :blog, optional: true
end
