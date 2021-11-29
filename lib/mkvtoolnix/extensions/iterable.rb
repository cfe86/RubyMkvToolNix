# frozen_string_literal: true

module MkvToolNix
  module Extensions
    # offers iterable methods
    module Iterable

      # @return [Array<Property>] returns all constant values if sorted order
      def all_properties
        constants.map { |it| const_get(it) }.sort! { |a, b| a.property <=> b.property }
      end

      def find_property(property_name)
        all_properties.find { |it| it.property == property_name }
      end
    end
  end
end
