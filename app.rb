# file: app.rb
require_relative 'lib/database_connection'
require_relative 'lib/book_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('book-store')

book_repo = BookRepository.new

# Print out each record from the result set .
book_repo.all.each_with_index do |book, index|
  puts "#{index + 1} - #{book}"
end
