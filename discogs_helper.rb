require 'discogs'

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

    def get_image_link(release)
      begin
        img = release.thumb.scan(%r!http://api\.discogs\.com/image/R-150-(.*)!).first.first
        "http://s.pixogs.com/image/R-#{img}"
      rescue
        nil
      end
    end
  end
end
