require_relative('../db/sql_runner')

class Author

  attr_reader :name, :id

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

def save()
  sql = "INSERT INTO authors (name) VALUES($1) RETURNING *"
  values = [@name]
  author_data = SqlRunner.run(sql, values)
  @id = author_data.first['id'].to_i
end

def update()
  sql = "UPDATE authors SET(name) VALUES($1) WHERE id = $2"
  values = [@name]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM authors;"
  SqlRunner.run(sql)
end

def delete()
  sql = "DELETE FROM authors WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM authors ORDER BY name"
  authors = SqlRunner.run( sql )
  result = authors.map { |author| Author.new(author) }
  return result
end

def self.find(id)
  sql = "SELECT * FROM authors WHERE id = $1"
  values = [id]
  authors = SqlRunner.run(sql, values)
  result = Author.new(author.first)
  return result
end

end
