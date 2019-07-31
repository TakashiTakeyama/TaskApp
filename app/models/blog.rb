class Blog < ApplicationRecord
  validates :name, presence: true
  validates :details, presence: true
  enum priority:{"低": 0, "中": 1, "高": 2}
end
