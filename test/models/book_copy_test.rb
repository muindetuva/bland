require "test_helper"

class BookCopyTest < ActiveSupport::TestCase
  setup do
    @book = books(:one)
    @user = users(:one)
  end


  test "is valid with a book" do
    book_copy = BookCopy.new(book: @book)
    assert book_copy.valid?
  end

  test "is invalid without a book" do
    book_copy = BookCopy.new
    assert_not book_copy.valid?
    assert_includes book_copy.errors[:book], "must exist"
  end

  test "available? returns true when the book copy has no active borrowing record" do
    book_copy = BookCopy.create!(book: @book)
    assert book_copy.available?
  end

  test "available? returns false when the book copy has an active borrowing record" do
    book_copy = BookCopy.create!(book: @book)

    BorrowingRecord.create!(
      user: @user,
      book_copy: book_copy,
      borrowed_at: Time.current,
      returned_at: nil
    )

    assert_not book_copy.available?
  end

end
