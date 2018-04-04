require('sinatra')
require('sinatra/contrib/all')
require_relative('models/book')
require('pry')

#index - list all books
get '/books' do
  @book = Book.all
  erb(:index)
end

#new - get a new book form
get '/books/new' do
  @authors = Author.all
  erb(:new)
end

#create - recieve new book form
post '/books' do
  # binding.pry
  @book = Book.new(params)
  @book.save()

  redirect '/books'
end

#show
get '/books/:id' do
  @book = Book.find(params[:id].to_i)
  erb(:show)
end

#edit form - display form
get '/books/:id/edit' do
  @book = Book.find(params[:id].to_i)
  @authors = Author.all
  erb(:edit)
end

#update - process edit form and show results
post '/books/:id' do
  @book = Book.new(params)
  @book.update()
  redirect '/books'
end


#delete
post '/books/:id/delete' do
  @book = Book.find(params[:id].to_i)
  @book.delete()
  redirect '/books'
end
