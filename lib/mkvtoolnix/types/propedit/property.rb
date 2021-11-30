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
      end
    end
  end
end
