class Label < ApplicationRecord
  validates :label_name, presence: true
  has_many :labelings, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :blog, optional: true
end
