require_relative('../models/book')
require_relative('../models/author')
require_relative('sql_runner')

Book.delete_all()
Author.delete_all()

author1 = Author.new ({'name' => 'Ray Celestin'})
author2 = Author.new ({'name' => 'Leo Tolstoy'})
author3 = Author.new ({'name' => 'Neil Gaiman'})
author4 = Author.new ({'name' => 'Walt Whitman'})
author5 = Author.new ({'name' => 'Philip K. Dick'})
author6 = Author.new ({'name' => 'J.R.R. Tolkein'})
author7 = Author.new ({'name' => 'Edmund de Waal'})
author8 = Author.new ({'name' => 'William Shakespeare'})
author9 = Author.new ({'name' => 'Margaret Atwood'})

author1.save()
author2.save()
author3.save()
author4.save()
author5.save()
author6.save()
author7.save()
author8.save()
author9.save()

book1 = Book.new ({'title' => 'The Axeman\'s Jazz',
  'genre' => 'crime',
  'author_id' => author1.id,
  'stock' => 4})

book2 = Book.new ({'title' => 'War and Peace',
  'genre' => 'fiction',
  'author_id' => author2.id,
  'stock' => 2})

book3 = Book.new ({'title' => 'Coraline',
  'genre' => 'children',
  'author_id' => author3.id,
  'stock' => 6})

book4 = Book.new ({'title' => 'Leaves of Grass',
  'genre' => 'poetry',
  'author_id' => author4.id,
  'stock' => 1})

book5 = Book.new ({'title' => 'Do Androids Dream of Electric Sheep',
  'genre'  => 'science fiction',
  'author_id' => author5.id,
  'stock' => 5})

book6 = Book.new ({'title' => 'Dead Man\'s Blues',
  'genre' => 'crime',
  'author_id' => author1.id,
  'stock' => 5})

book7 = Book.new ({'title' => 'The Hobbit',
  'genre' => 'fantasy',
  'author_id' => author6.id,
  'stock' => 4})

book8 = Book.new ({'title' => 'The Hare With Amber Eyes',
  'genre' => 'non-fiction',
  'author_id' => author7.id,
  'stock' => 2})

book9 = Book.new ({'title' => 'The Tempest',
  'genre' => 'drama',
  'author_id' => author8.id,
  'stock' => 5})

book10 = Book.new ({'title' => 'Alias Grace',
  'genre' => 'fiction',
  'author_id' => author9.id,
  'stock' => 10})

book1.save()
book2.save()
book3.save()
book4.save()
book5.save()
book6.save()
book7.save()
book8.save()
book9.save()
book10.save()
