class AddStatusToBookCopies < ActiveRecord::Migration[8.0]
  def change
    add_column :book_copies, :status, :string
  end
end
