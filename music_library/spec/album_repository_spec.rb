require 'album'
require 'album_repository'

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

  it 'gets all 12 albums in the music library' do
    albums = @repo.lists_all_albums
    expect(albums.length).to eq 12
  end

  it 'gets the correct albums' do
    albums = @repo.lists_all_albums

    expect(albums[0].id).to eq '1'
    expect(albums[0].title).to eq 'Doolittle'
    expect(albums[0].release_year).to eq '1989'

    expect(albums[-1].id).to eq '12'
    expect(albums[-1].title).to eq 'Ring Ring'
    expect(albums[-1].release_year).to eq '1973'
  end

  it 'gets the specified album' do
    album3 = @repo.finds_an_album(3)
    album6 = @repo.finds_an_album(6)
    
    expect(album3.id).to eq '3'
    expect(album3.title).to eq 'Waterloo'
    expect(album3.release_year).to eq '1974'

    expect(album6.id).to eq '6'
    expect(album6.title).to eq 'Lover'
    expect(album6.release_year).to eq '2019'
  end

  it 'inserts a new album into the table' do
    classic = Album.new
    classic.title = 'Red'
    classic.release_year ='2012' 
    classic.artist_id = 3

    albums = @repo.creates_an_album(classic)
    albums = @repo.lists_all_albums

    expect(albums[-1]).to have_attributes(title:'Red', release_year: '2012')
  end

  it 'deletes an album from the table' do
    albums = @repo.deletes_an_album(12)
    albums = @repo.lists_all_albums

    albums.each do |album|
      expect(album).not_to have_attributes(title:'Ring', release_year: '1973')
    end
  end
end