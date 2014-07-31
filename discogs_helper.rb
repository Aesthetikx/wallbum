require 'discogs'
require 'open-uri'

module Wallbum
  class DiscogsHelper
    def initialize
      @discogs_wrapper = Discogs::Wrapper.new('wallbum')
    end

    def get_discogs_artist_id(name)
      @discogs_wrapper.search(name, type: :artist).results.first.id
    end

    def get_discogs_releases(artist_id)
      @discogs_wrapper.get_artist_releases(artist_id).releases
    end

    def get_release_images(release, &block)
      release_images = @discogs_wrapper.get_release(release.id).images
      filenames = release_images.map { |image| image.resource_url.split("/").last }
      filenames.each do |fn|
        yield fn,
          open(
            "http://s.pixogs.com/image/#{fn}",
            "User-Agent" => "Mozilla/5.0",
            "Referer" => "http://www.discogs.com/viewimages?release=#{release.id}")
      end
    end
  end
end
