class SubTask < ApplicationRecord
  belongs_to :task

  validates :title, presence: true
end
