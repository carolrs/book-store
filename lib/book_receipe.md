# Books Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: books

Columns:
id | title | author_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

```ruby
# EXAMPLE
# Table name: books

class Book
end

class BookRepository
end
```

## 4. Implement the Model class

```ruby
# EXAMPLE
# Table name: books

# Model class
# (in lib/books.rb)

class Book

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :author_name
  
end

```
## 5. Define the Repository Class interface


```ruby
# EXAMPLE
# Table name: books

class BookRepository

  # Selecting all books
=
  def all
    # Executes the SQL query:
    # SELECT id, title, author_name FROM books;

    # Returns an array of Book objects.
  end

  def find_by_id(id)
    # SELECT id, title, author_name FROM books WHERE id = id;
  end

  
end
```

## 6. Write Test Examples

```ruby
# EXAMPLES

# 1
# Get all books

repo = BookRepository.new
books = repo.all

books.length # => 2
books.first.title # => 'Nineteen Eighty-Four'
books.first.author_name # => 'George Orwell'

#find by id
repo = BookRepository.new
book = repo.find(2)

book.title = "Mrs Dalloway"
book.author_name = "Virginia Woolf"


```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/book_repository_spec.rb

def reset_books_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe BookRepository do
  before(:each) do 
    reset_books_table
  end

  # (your tests will go here).
end
```
