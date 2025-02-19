class BooksController < ApplicationController
  def index

    @filter = params[:filter] || "all"

    @books = case @filter
    when "available"
      Book.where.not(id: BorrowingRecord.where(returned_at: nil).select(:book_id))
    when "borrowed"
      Book.where(id: BorrowingRecord.where(returned_at: nil).select(:book_id))
    else
      Book.all
    end
  end


  def show
    @book = Book.find(params[:id])
  end
end
