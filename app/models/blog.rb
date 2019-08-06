class Blog < ApplicationRecord
  validates :name, presence: true
  validates :details, presence: true

  enum priority:{"低": 0, "中": 1, "高": 2}

  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  has_many :task_have_labels, through: :labelings, source: :label
  # accepts_nested_attributes_for :labels, allow_destroy: true
  # reject_if: all_blank
end
