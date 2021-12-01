# frozen_string_literal: true

module MkvToolNix
  module Types
    module Merge
      class Attachment

        attr_reader :file, :mime_type, :name, :description

        def with_mime_type(type)
          @mime_type = type
          self
        end

        def with_name(name)
          @name = name
          self
        end

        def with_description(description)
          @description = description
          self
        end

        def initialize(file)
          @file = file
        end

        def add_to_cmd(cmd)
          unless @file.nil?
            cmd << '--attachment-description' << @description unless @description.nil?
            cmd << '--attachment-mime-type' << @mime_type unless @mime_type.nil?
            cmd << '--attachment-name' << @name unless @name.nil?
            cmd << '--attach-file' << @file
          end
          nil
        end
      end
    end
  end
end
