# frozen_string_literal: true

module MkvToolNix
  module Types
    module Merge
      class Tags

        attr_reader :file

        def initialize(file)
          @file = file
        end

        def add_to_cmd(cmd)
          cmd << '--global-tags' << @file unless @file.nil?
          nil
        end
      end
    end
  end
end