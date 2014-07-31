module Wallbum
  module ImagePacking
    class Rectangle
      def initialize(parent, x, y, width, height)
        @parent = parent
        @width = width
        @height = height
        @x = x
        @y = y
        @children = []
        @image = nil
      end

      def leaf?
        @children.empty?
      end

      def root?
        @parent.nil?
      end

      def empty?
        @image.nil?
      end

      def area
        @width * @height
      end

      def child_count
        if leaf?
          1
        else
          @children.map(&:child_count).reduce(:+)
        end
      end

      def largest_child
        if leaf?
          self
        else
          @children.map(&:largest_child).sort_by { |rect| rect.area }.last
        end
      end

      def empty_child
        if leaf? 
          if empty?
            self
          else
            nil
          end
        else
          @children.map(&:empty_child).compact.first
        end
      end

      def split
        if @width > @height
          puts "Splitting horz"
          split_horz
        else
          puts "Splitting vert"
          split_vert
        end
      end

      attr_reader :x
      attr_reader :y
      attr_reader :width
      attr_reader :height
      attr_reader :children
      attr_accessor :image

      private

      def split_horz
        new_width = @width / 2
        @children << Rectangle.new(self, @x, @y, new_width, @height)
        @children << Rectangle.new(self, @x + new_width, @y, new_width, @height)
      end

      def split_vert
        new_height = @height / 2
        @children << Rectangle.new(self, @x, @y, @width, new_height)
        @children << Rectangle.new(self, @x, @y + new_height, @width, new_height)
      end
    end
  end
end
