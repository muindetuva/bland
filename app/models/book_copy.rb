class BookCopy < ApplicationRecord
  belongs_to :book
  has_many :borrowing_records, dependent: :destroy
  has_many :users, through: :borrowing_records

  def available?
    borrowing_records.where(returned_at: nil).empty?
  end

  scope :available, -> {
    left_outer_joins(:borrowing_records)
      .where(borrowing_records: { returned_at: nil })
      .group("book_copies.id")
      .having("COUNT(borrowing_records.id) = 0")
  }
end
