require_relative './discogs_helper.rb'
require_relative './image_packer.rb'

require 'fileutils'

artist_name = ARGV.join(" ")

helper = Wallbum::DiscogsHelper.new

artist_id = helper.get_discogs_artist_id(artist_name)

dir = "images_#{artist_id}"

unless File.directory? dir
  FileUtils.mkdir_p dir

  helper.get_artist_images(artist_id) do |filename, image|
    puts "\t#{filename}"
    File.open("#{dir}/#{filename}", "wb") do |f|
      f.write image.read
    end
  end
else
  puts "Using cached dir #{dir}"
end

fnames = Dir["#{dir}/*"].collect

Wallbum::ImagePacking::Packer.new().pack_images(1920, 1080, fnames) do |wallp|
  wallp.write("#{artist_name.gsub(' ', '_')}.jpeg")
end
