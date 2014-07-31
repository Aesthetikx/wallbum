require 'rubystats'

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
        half = (@width / 2)
        cut = (half*multiplier).ceil
        @children << Rectangle.new(self, @x, @y, cut, @height)
        @children << Rectangle.new(self, @x + cut, @y, @width - cut, @height)
      end

      def split_vert
        half = (@width / 2)
        cut = (half * multiplier).ceil
        @children << Rectangle.new(self, @x, @y, @width, cut)
        @children << Rectangle.new(self, @x, @y + cut, @width, @height - cut)
      end

      def multiplier
        pct = Rubystats::NormalDistribution.new(1.0, 0.2).rng
        if pct < 0.2
          pct = 0.2
        elsif pct > 1.8
          pct = 1.8
        end
        pct
      end
    end
  end
end
