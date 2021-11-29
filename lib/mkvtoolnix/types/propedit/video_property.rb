# frozen_string_literal: true

module MkvToolNix
  module Types
    module PropEdit
      module VideoProperty
        include CommonProperty
        extend Extensions::Iterable

        PIXEL_WIDTH = Property.new('pixel-width', false)
        PIXEL_HEIGHT = Property.new('pixel-height', false)
        DISPLAY_WIDTH = Property.new('display-width')
        DISPLAY_HEIGHT = Property.new('display-height')
        DISPLAY_UNIT = Property.new('display-unit')
        STEREO_MODE = Property.new('stereo-mode')
      end
    end
  end
end
