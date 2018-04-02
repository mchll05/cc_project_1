require_relative('../db/sql_runner')
require_relative('./author')

class Book

  attr_reader :title, :genre, :author_id, :id

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @genre = options['genre']
    @author_id = options['author_id'].to_i
    # @quantity = options['quantity'].to_i
    # @price = 10
  end

  # def pretty_title()
  #   return "#{@title}"
  # end

  # def total()
  #   return @quantity * @price
  # end

  def save()
    sql = "INSERT INTO books (title, genre, author_id) VALUES($1, $2, $3) RETURNING *"
    values = [@title, @genre, @author_id]
    book_data = SqlRunner.run(sql, values)
    @id = book_data.first['id'].to_i
  end

  def update()
    sql = "UPDATE books SET(title, genre) VALUES($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @author_id, @id]
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

end
