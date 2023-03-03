require_relative 'lib/database_connection'
require_relative 'lib/book_repository'

DatabaseConnection.connect('book_store')
repo = BookRepository.new
all_books = repo.list_all_books


all_books.each do |book|
  puts "#{book.id} - #{book.title} - #{book.author_name}"
end