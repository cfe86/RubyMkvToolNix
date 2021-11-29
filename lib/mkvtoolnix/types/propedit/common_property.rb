# frozen_string_literal: true

module MkvToolNix
  module Types
    module PropEdit
      module CommonProperty

        TRACK_NUMBER = Property.new('track-number', false)
        UID = Property.new('track-uid', false)
        NAME = Property.new('name')
        CODEC_ID = Property.new('codec-id', false)
        CODEC_NAME = Property.new('codec-name')
        CODEC_INHERENT_DELAY = Property.new('codec-delay')
        FLAG_DEFAULT = Property.new('flag-default')
        FLAG_ENABLED = Property.new('flag-enabled')
        FLAG_COMMENTARY = Property.new('flag-commentary')
        FLAG_HEARING_IMPAIRED = Property.new('flag-hearing-impaired')
        FLAG_ORIGINAL = Property.new('flag-original')
        FLAG_TEXT_DESCRIPTIONS = Property.new('flag-text-descriptions')
        FLAG_VISUAL_IMPAIRED = Property.new('flag-visual-impaired')
        FLAG_FORCED = Property.new('flag-forced')
        LANGUAGE = Property.new('language')
        LANGUAGE_IETF = Property.new('language-ietf')
      end
    end
  end
end


