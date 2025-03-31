class AddBookCopyToBorrowingRecords < ActiveRecord::Migration[8.0]
  def change
    add_reference :borrowing_records, :book_copy, null: true, foreign_key: true
  end
end
