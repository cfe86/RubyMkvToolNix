# frozen_string_literal: true

module MkvToolNix
  module Types
    module Merge
      class SegmentInfo

        attr_reader :file, :uids

        def for_file(file)
          @file = file
          self
        end

        def for_uids(uids)
          @uids = uids
          self
        end

        def add_to_cmd(cmd)
          cmd << '--segmentinfo' << @file unless @file.nil?
          cmd << '--segment-uid' << @uids.join(',') unless @uids.nil?
          nil
        end
      end
    end
  end
end
