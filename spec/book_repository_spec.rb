require 'book_repository'

RSpec.describe BookRepository do

  def reset_books_table
    seed_sql = File.read('spec/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_books_table
  end

  it 'returns the first book of the list' do
    repo = BookRepository.new
    books = repo.all
    
    #expect(books.length).to eq (2) 
    expect(books.first.title).to eq ('Nineteen Eighty-Four') 
    expect(books.first.author_name).to eq ('George Orwell') 
    
  end

  it 'returns only one book' do
    repo = BookRepository.new
  
    book = repo.find(2)
    
    expect(book.title).to eq ('Mrs Dalloway') 
    expect(book.author_name).to eq ('Virginia Woolf') 
    
  end

  it 'returns only one book' do
    repo = BookRepository.new
  
    book = repo.find(3)
    
    expect(book.title).to eq ('Emma') 
    expect(book.author_name).to eq ('Jane Austen') 
    
  end
end