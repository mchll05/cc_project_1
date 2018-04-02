require('sinatra')
require('sinatra/contrib/all')
require_relative('models/book')
require('pry')

get '/books' do
  @books = Book.all
  erb(:index)
end

get '/books/new' do
  @books = Book.all
  @authors = Author.all
  erb(:new)
end

get '/books/:id' do
  @book = Book.find(params[:id].to_i)

  erb(:show)

end

post '/books' do
  book = Book.new(params)
  book.save
  redirect to '/books'
end

get '/books/:id' do
  @book = Book.find(params['id'])
  erb(:show)
end

get '/books/:id/edit' do
  @book = Book.find(params['id'].to_i)
  erb(:edit)
end

post '/books/:id' do
  @book = Book.new(params)
  @book.update()
  redirect '/books'
end
