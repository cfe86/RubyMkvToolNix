# frozen_string_literal: true

module MkvToolNix
  module Types
    module Info
      class Attachment

        attr_accessor :id, :uid, :file_name, :description, :content_type, :size_in_b

        def self.create(hash)
          props = hash['properties']
          new(id: hash['id'], uid: props['uid'], file_name: hash['file_name'], description: hash['description'],
              content_type: hash['content_type'], size_in_b: hash['size'])
        end

        def initialize(id:, uid:, file_name:, description:, content_type:, size_in_b:)
          @id = id
          @uid = uid
          @file_name = file_name
          @description = description
          @content_type = content_type
          @size_in_b = size_in_b
        end
      end
    end
  end
end
