class BooksController < ApplicationController
  def index
    @books = Book.all
  end


  def show
    @book = Book.find(params[:id])

    @total_copies = @book.book_copies.count
    @available_copies = @book.book_copies.where(status: "available").count
    @user_borrowing_record = Current.user.borrowing_records.find_by(book_copy: @book.book_copies, returned_at: nil)
    @available_copy = @book.book_copies.find_by(status: "available") # Find the first available book copy
  end
end
