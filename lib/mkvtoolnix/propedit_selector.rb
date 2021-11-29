# frozen_string_literal: true

module MkvToolNix
  # https://mkvtoolnix.download/doc/mkvpropedit.html#mkvpropedit.edit_selectors
  module PropEditSelector

    def self.for_info
      'info'
    end

    def self.for_nth_track(n)
      raise Errors::MkvToolNixError, "Number must be > 0, got #{n}" if n.nil? || n.negative?

      "track:#{n}"
    end

    def self.for_nth_video(n)
      raise Errors::MkvToolNixError, "Number must be > 0, got #{n}" if n.nil? || n.negative?

      "track:v#{n}"
    end

    def self.for_nth_audio(n)
      raise Errors::MkvToolNixError, "Number must be > 0, got #{n}" if n.nil? || n.negative?

      "track:a#{n}"
    end

    def self.for_nth_subtitle(n)
      raise Errors::MkvToolNixError, "Number must be > 0, got #{n}" if n.nil? || n.negative?

      "track:s#{n}"
    end

    def self.by_track_number(track_number)
      n = track_number
      raise Errors::MkvToolNixError, "Number must be > 0, got #{n}" if n.nil? || n.negative?

      "track:@#{n}"
    end

    def self.by_track_uid(uid)
      "track:=#{uid}"
    end

    def self.for_attachment_by_id(id)
      id
    end

    def self.for_attachment_by_name(name)
      "name:#{name}"
    end

    def self.for_attachment_by_mime_type(mime_type)
      "mime-type:#{mime_type}"
    end

    def self.tag_all
      'all'
    end

    def self.tag_global
      'global'
    end
  end
end
