# frozen_string_literal: true

module MkvToolNix
  module Errors

    class MkvToolNixError < StandardError

      def initialize(msg = nil)
        super
      end
    end
  end
end
