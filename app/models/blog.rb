class Blog < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  has_many :task_have_labels, through: :labelings, source: :label
  belongs_to :user


  validates :name, presence: true
  validates :details, presence: true

  enum priority:{"低": 0, "中": 1, "高": 2}

  # accepts_nested_attributes_for :labels, allow_destroy: true
  # reject_if: all_blank
end
