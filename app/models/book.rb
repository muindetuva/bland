class Book < ApplicationRecord
  has_many :borrowing_records, dependent: :destroy
  has_many :users, through: :borrowing_records

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
end
