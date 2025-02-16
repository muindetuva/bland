require "test_helper"

class BookTest < ActiveSupport::TestCase

  test "should be save book without title" do
    book = Book.new(author: "Alfred", isbn: "1234567890")
    assert_not book.valid?, "Book must have title"
  end

  test "should be save book without author" do
    book = Book.new(title: "Of mice and men", isbn: "1234567890")
    assert_not book.valid?, "Book must have author"
  end

  test "should not save book without isbn" do
    book = Book.new(title: "Of mice and men", author: "Alfred")
    assert_not book.valid?, "Book must have isbn"
  end

  test "should not save book with duplicate isbn" do
    book = Book.create(title: "Of mice and men", author: "Alfred", isbn: "1234567890")
    duplicate_book = Book.new(title: "1948", author: "Tuva", isbn: "1234567890")

    assert_not duplicate_book.valid?, "Book must have unique isbn"
  end

end
