require_relative('../db/sql_runner')
require_relative('./author')

class Book

  attr_reader :title, :genre, :author_id, :price, :stock, :id

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @genre = options['genre']
    @author_id = options['author_id'].to_i
    @price = options['price'].to_i
    @stock = options['stock'].to_i
  end

  def save()
    sql = "INSERT INTO books (title, genre, author_id, price, stock) VALUES($1, $2, $3, $4, $5) RETURNING *"
    values = [@title, @genre, @author_id, @price, @stock]
    book_data = SqlRunner.run(sql, values)
    @id = book_data.first['id'].to_i
  end

  def update()
    sql = "UPDATE books
    SET
    (title, genre, author_id, price, stock)
    =
    ($1, $2, $3, $4, $5)
    WHERE id = $6;"
    values = [@title, @genre, @author_id, @price, @stock, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM books;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM books WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM books"
    books = SqlRunner.run( sql )
    result = books.map { |book| Book.new(book) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM books WHERE id = $1"
    values = [id]
    books = SqlRunner.run(sql, values)
    result = Book.new(books.first)
    return result
  end

def author
  sql = 'SELECT * FROM authors
  INNER JOIN books ON books.author_id = authors.id
  WHERE books.id = $1'
  values = [@id]
  author = SqlRunner.run(sql, values)
  result = Author.new(author.first)
  return result
end

def stock_level_check()
    if @stock <= 3
      return "New Order required"
    elsif @stock >= 4  && @stock <= 10
      return "Okay"
    elsif @stock >= 11
      return "Fully Loaded"
    end
  end

  def self.search_by_title(title)
    sql = "SELECT * FROM books WHERE title = $1"
    values = [title]
    books = SqlRunner.run( sql, values )
    result = books.map { |book| Book.new(book) }
    return result[0]
  end
end
