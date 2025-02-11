class Task < ApplicationRecord
  has_many :sub_tasks, dependent: :destroy
  accepts_nested_attributes_for :sub_tasks, allow_destroy: true

  validates :title, presence: true
end
