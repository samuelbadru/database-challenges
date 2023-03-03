require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

repo = AlbumRepository.new
#all_albums = repo.lists_all_albums
album3 = repo.finds_an_album(3)

# Print out each record from the result set .
#all_albums.each do |album|
#  puts "#{album.id} - #{album.title} - #{album.release_year}"
#end

puts "#{album3.id} - #{album3.title} - #{album3.release_year}"