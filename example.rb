require_relative './discogs_helper.rb'

require 'fileutils'

helper = Wallbum::DiscogsHelper.new

artist_id = helper.get_discogs_artist_id("Rrose")

dir = "images_#{artist_id}"

FileUtils.mkdir_p dir

helper.get_artist_images(artist_id) do |filename, image|
  puts "\t#{filename}"
  File.open("#{dir}/#{filename}", "wb") do |f|
    f.write image.read
  end
end
