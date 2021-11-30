# frozen_string_literal: true

module MkvToolNix
  module Types
    module Info
      class Video

        attr_accessor :id, :uid, :name, :codec, :codec_id, :codec_name, :codec_inherent_delay, :is_default, :is_enabled,
                      :is_commentary, :is_hearing_impaired, :is_original, :is_text_descriptions, :is_visual_impaired,
                      :is_forced, :language, :language_ietf, :packetizer, :display_unit, :pixel_dimension, :pixel_width,
                      :pixel_height, :display_dimension, :display_width, :display_height, :cropping, :stereo_mode,
                      :track_number

        def self.create(hash)
          props = hash['properties']
          new(id: hash['id'], uid: props['uid'], name: props['track_name'], codec: hash['codec'],
              codec_id: props['codec_id'], codec_name: props['codec_name'], codec_inherent_delay: props['codec_delay'],
              is_default: props['default_track'], is_enabled: props['enabled_track'],
              is_commentary: props['flag_commentary'], is_hearing_impaired: props['flag_hearing_impaired'],
              is_original: props['flag_original'], is_text_descriptions: props['flag_text_descriptions'],
              is_visual_impaired: props['flag_visual_impaired'], is_forced: props['forced_track'],
              language: props['language'], language_ietf: props['language_ietf'], packetizer: props['packetizer'],
              pixel_dimension: props['pixel_dimensions'], display_dimension: props['display_dimensions'],
              display_unit: props['display_unit'], cropping: props['cropping'], stereo_mode: props['stereo_mode'],
              track_number: props['number'])
        end

        def initialize(id:, uid:, name:, codec:, codec_id:, codec_name:, codec_inherent_delay:, is_default:,
                       is_enabled:, is_commentary:, is_hearing_impaired:, is_original:, is_text_descriptions:,
                       is_visual_impaired:, is_forced:, language:, language_ietf:, packetizer:, pixel_dimension:,
                       display_dimension:, display_unit:, cropping:, stereo_mode:, track_number:)
          @id = id
          @uid = uid
          @name = name
          @codec = codec
          @codec_id = codec_id
          @codec_name = codec_name
          @codec_inherent_delay = codec_inherent_delay
          @is_default = is_default
          @is_enabled = is_enabled
          @is_commentary = is_commentary
          @is_hearing_impaired = is_hearing_impaired
          @is_original = is_original
          @is_text_descriptions = is_text_descriptions
          @is_visual_impaired = is_visual_impaired
          @is_forced = is_forced
          @language = language
          @language_ietf = language_ietf
          @packetizer = packetizer
          @display_unit = display_unit
          @pixel_dimension = pixel_dimension
          if pixel_dimension.include?('x')
            @pixel_width = pixel_dimension.split('x')[0]
            @pixel_height = pixel_dimension.split('x')[1]
          end
          @display_dimension = display_dimension
          if display_dimension.include?('x')
            @display_width = display_dimension.split('x')[0]
            @display_height = display_dimension.split('x')[1]
          end

          @cropping = cropping
          @stereo_mode = stereo_mode
          @track_number = track_number
        end
      end
    end
  end
end
