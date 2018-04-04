require_relative('../db/sql_runner')
require_relative('./author')

class Book

  attr_reader :title, :genre, :author_id, :stock, :id

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @genre = options['genre']
    @author_id = options['author_id'].to_i
    @stock = options['stock'].to_i
    #@buy_price = 10
    #@sell_price
  end

  def save()
    sql = "INSERT INTO books (title, genre, author_id, stock) VALUES($1, $2, $3, $4) RETURNING *"
    values = [@title, @genre, @author_id, @stock]
    book_data = SqlRunner.run(sql, values)
    @id = book_data.first['id'].to_i
  end


  def update()
    sql = "UPDATE books SET title = $1, genre = $2 , author_id = $3, stock = $4 WHERE id = $5"
    values = [@title, @genre, @author_id, @stock, @id]
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

end
