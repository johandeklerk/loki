# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'digest/md5'

User.delete_all
User.create!(:username => 'johan', :password => Digest::MD5.hexdigest('password'), :token => SecureRandom.hex, :token_expires => Time.now + 1.hour)

Publisher.delete_all
publisher = Publisher.create!(name: 'somepub')

Artist.delete_all
artist = Artist.create!(name: 'someart')
artist1 = Artist.create!(name: 'someart11')

Genre.delete_all
genre = Genre.create!(name: 'somegen')

Track.delete_all
track = Track.create!(title: 'sometra', length: '1:50')

Album.delete_all
Album.create!(title: 'somealbum', isbn: '9780672317248', published_date: Time.now, publisher: publisher, artists: [artist, artist1], genres: [genre], tracks: [track])
