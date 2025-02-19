namespace :books do
  desc "Generate random books (Default: 20 books)"
  task generate: :environment do
    require 'faker'

    num_books = ENV["COUNT"]&.to_i || 20 # Default to 20 books if no count is provided

    puts "📚 Generating #{num_books} books..."

    num_books.times do
      Book.find_or_create_by!(
        isbn: Faker::Code.isbn # Ensures no duplicate books
      ) do |book|
        book.title = Faker::Book.title
        book.author = Faker::Book.author
      end
    end

    puts "✅ Successfully generated #{num_books} books!"
  end
end
