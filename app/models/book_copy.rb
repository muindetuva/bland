class BookCopy < ApplicationRecord
  belongs_to :book
  has_many :borrowing_records, dependent: :destroy
  has_many :users, through: :borrowing_records

  def available?
    borrowing_records.where(returned_at: nil).empty?
  end
end
