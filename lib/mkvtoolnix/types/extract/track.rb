# frozen_string_literal: true

module MkvToolNix
  module Types
    module Extract
      class Track

        attr_accessor :track_id, :output_file

        def initialize(track_id, output_file)
          @track_id = track_id
          @output_file = output_file
        end
      end
    end
  end
end
