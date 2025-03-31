class BooksController < ApplicationController
  def index
    @books = Book.all
  end


    def show
    @book = Book.find(params[:id])

    @total_copies = @book.book_copies.count
    @available_copies = @book.book_copies.where.not(id: BorrowingRecord.where(returned_at: nil).select(:book_copy_id)).count
    end
end
