# frozen_string_literal: true

module MkvToolNix
  module Types
    module Info
      class Subtitle

        attr_accessor :id, :uid, :name, :codec, :codec_id, :codec_name, :codec_inherent_delay, :encoding, :is_default,
                      :is_enabled, :is_commentary, :is_hearing_impaired, :is_original, :is_text_descriptions,
                      :is_visual_impaired, :is_forced, :language, :language_ietf, :is_text, :track_number

        def self.create(hash)
          props = hash['properties']
          new(id: hash['id'], uid: props['uid'], name: props['track_name'], codec: hash['codec'],
              codec_id: props['codec_id'], codec_name: props['codec_name'], codec_inherent_delay: props['codec_delay'],
              encoding: props['encoding'], is_default: props['default_track'], is_enabled: props['enabled_track'],
              is_commentary: props['flag_commentary'], is_hearing_impaired: props['flag_hearing_impaired'],
              is_original: props['flag_original'], is_text_descriptions: props['flag_text_descriptions'],
              is_visual_impaired: props['flag_visual_impaired'], is_forced: props['forced_track'],
              language: props['language'], language_ietf: props['language_ietf'], is_text: props['text_subtitles'],
              track_number: props['number'])
        end

        def initialize(id:, uid:, name:, codec:, codec_id:, codec_name:, codec_inherent_delay:, encoding:, is_default:,
                       is_enabled:, is_commentary:, is_hearing_impaired:, is_original:, is_text_descriptions:,
                       is_visual_impaired:, is_forced:, language:, language_ietf:, is_text:, track_number:)
          @id = id
          @uid = uid
          @name = name
          @codec = codec
          @codec_id = codec_id
          @codec_name = codec_name
          @codec_inherent_delay = codec_inherent_delay
          @encoding = encoding
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
          @is_text = is_text
          @track_number = track_number
        end
      end
    end
  end
end
