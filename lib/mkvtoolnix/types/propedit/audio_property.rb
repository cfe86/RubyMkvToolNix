# frozen_string_literal: true

module MkvToolNix
  module Types
    module PropEdit
      module AudioProperty
        include CommonProperty
        extend Extensions::Iterable

        SAMPLING_FREQUENCY = Property.new('sampling-frequency')
        BIT_DEPTH = Property.new('bit-depth')
        CHANNELS = Property.new('channels')
      end
    end
  end
end

