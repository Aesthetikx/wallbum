require_relative './rectangle.rb'
require_relative './image.rb'

module Wallbum
  module ImagePacking
    class Packer
      def pack_images(size_x, size_y, images, &block)
        count = images.size

        puts "Packing #{images.size} images"

        root = Rectangle.new(nil, 0, 0, size_x, size_y)

        while (root.child_count < count) do
          puts "Child count: #{root.child_count}"
          root.largest_child.split
        end

        images.each do |fname|
          rect = root.empty_child
          rect.image = Image.new(fname)
          puts "#{fname} - #{rect.x},#{rect.y}, #{rect.width}x#{rect.height}"
        end

        wallpaper = Magick::Image.new(size_x, size_y) do
          self.background_color = 'black'
        end

        puts "Rect size: " + root.all_children.size.to_s

        root.all_children.each do |rect|
          wallpaper.composite!(rect.image.img.resize_to_fill(rect.width, rect.height),
            rect.x,
            rect.y,
            Magick::OverCompositeOp)
        end

        yield wallpaper
      end
    end
  end
end
