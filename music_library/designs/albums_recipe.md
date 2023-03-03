# {{Albums}} Model and Repository Classes Design Recipe

## 1. Design and create the Table

Table already created, can skip this step.

## 2. Create Test SQL seeds

Seeds already created and imported into tables.

## 3. Define the class names

```ruby
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end
```

## 4. Implement the Model class

```ruby
# Table name: albums

# Model class
# (in lib/album.rb)

class Album
  attr_accessor :id, :title, :release_year, :artist_id
end
```

## 5. Define the Repository Class interface

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def lists_all_albums
    # Executes the SQL query:
    # SELECT id, title, release_year FROM albums

    # Returns an array of Album objects.
  end

  # Selecting a specific record
  def finds_an_album(id) # One argument - id - int
    # Executes the SQL query:
    # SELECT id, title, release_year FROM albums WHERE id = $1

    # Returns an album object
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# Before hook
@repo = AlbumRepository.new



# 1
# Gets the correct number of albums
albums = @repo.lists_all_albums
albums.length # =>  13


# 2
# Gets the correct albums
albums = @repo.lists_all_albums

albums[0].id # =>  1
albums[0].title # =>  'Doolittle'
albums[0].release_year # =>  '1989'

albums[-1].id # =>  12
albums[-1].title # =>  'Ring Ring'
albums[-1].release_year # =>  '1973'

# 3
# Gets specified album
album3 = @repo.finds_an_album(3)
album6 = @repo.finds_an_album(6)

album3.id # =>  3
album3.title # =>  'Waterloo'
album3.release_year # =>  '1974'

album6.id # =>  6
album6.title # =>  'Lover'
album6.release_year # =>  '2019'

```

## 7. Reload the SQL seeds before each test run

```ruby
# EXAMPLE

# file: spec/album_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/music_library_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before do 
    reset_albums_table
    @repo = AlbumRepository.new
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
