namespace :books do
  desc "Generate random books (Default: 20 books)"
  task generate: :environment do
    require 'faker'

    num_books = ENV["COUNT"]&.to_i || 10 # Default to 10 books if no count is provided

    puts "Generating #{num_books} books..."

    num_books.times do
      book = Book.find_or_create_by!(
        isbn: Faker::Code.isbn # Ensures no duplicate books
      ) do |book|
        book.title = Faker::Book.title
        book.author = Faker::Book.author
      end

      # Generate between 1 to 3 copies for each book
      num_copies = rand(1..3)
      num_copies.times do
        BookCopy.create!(book: book)
      end
    end

    puts "Successfully generated #{num_books} books!"
  end
end
