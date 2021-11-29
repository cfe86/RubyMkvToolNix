# frozen_string_literal: true

module MkvToolNix
  module Types
    module PropEdit
      module InfoProperty
        extend Extensions::Iterable

        TITLE = Property.new('title')
        DATE = Property.new('date')
        SEGMENT_UUID = Property.new('segment-uid')
        MUX_APPLICATION = Property.new('muxing-application', false)
        WRITING_APPLICATION = Property.new('writing-application', false)
      end
    end
  end
end
