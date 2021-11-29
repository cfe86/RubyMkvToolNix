# frozen_string_literal: true

module MkvToolNix
  module Types
    module PropEdit
      class Property

        attr_reader :property, :removable

        def initialize(property, removable = true)
          @property = property
          @removable = removable
        end

        def value
          @property
        end
      end
    end
  end
end
