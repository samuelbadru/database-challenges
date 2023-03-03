require_relative 'album'

class AlbumRepository
  def lists_all_albums
    sql = 'SELECT id, title, release_year FROM albums'
    albums = DatabaseConnection.exec_params(sql, [])
    
    album_objects = []

    albums.each do |album|
      record = Album.new
      record.id = album['id']
      record.title = album['title']
      record.release_year = album['release_year']
      album_objects << record
    end

    album_objects
  end

  def finds_an_album(id)
    sql = 'SELECT id, title, release_year FROM albums WHERE id = $1'
    params = [id]
    album = DatabaseConnection.exec_params(sql, params)

    # Need to index as even though there's only one object, still in array
    record = Album.new
    record.id = album[0]['id']
    record.title = album[0]['title']
    record.release_year = album[0]['release_year']

    record
  end
end