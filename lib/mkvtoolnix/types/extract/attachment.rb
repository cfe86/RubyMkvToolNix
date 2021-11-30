# frozen_string_literal: true

module MkvToolNix
  module Types
    module Extract
      class Attachment

        attr_accessor :attachment_id, :output_file

        def initialize(attachment_id, output_file)
          @attachment_id = attachment_id
          @output_file = output_file
        end
      end
    end
  end
end

