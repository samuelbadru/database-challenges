require 'book_repository'

def reset_books_table
  seed_sql = File.read('spec/books_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
  connection.exec(seed_sql)
end

describe BookRepository do
  # Remember to use instance when using before hook
  # Don't need :each (aka :example) as is the default
  before do 
    reset_books_table
    repo = BookRepository.new
    @all_books = repo.list_all_books
  end

  it 'gets all 5 books from the book store' do
    expect(@all_books.length).to eq 5
  end

  it 'gets the correct books in the book store' do
    expect(@all_books[0].id).to eq '1'
    expect(@all_books[0].title).to eq 'Nineteen Eighty-Four'
    expect(@all_books[0].author_name).to eq 'George Orwell'

    expect(@all_books[4].id).to eq '5'
    expect(@all_books[4].title).to eq 'The Age of Innocence'
    expect(@all_books[4].author_name).to eq 'Edith Wharton'
  end
end