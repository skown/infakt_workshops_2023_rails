class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :finish_date, presence: true

  def self.by_finish_date
    order(finish_date: :asc)
  end
end
