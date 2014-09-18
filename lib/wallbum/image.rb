require 'RMagick'

module Wallbum
  module ImagePacking
    class Image
      def initialize(path)
        @path = path

        @img = Magick::Image.read(path).first
        @width = @img.columns
        @height = @img.rows

        puts "Loaded image #{@path} at #{width} x #{height}"
      end

      attr_reader :path
      attr_reader :width
      attr_reader :height
      attr_reader :img
      attr_accessor :rectangle
    end
  end
end
