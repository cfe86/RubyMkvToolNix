# frozen_string_literal: true

module MkvToolNix
  module Modules
    # https://mkvtoolnix.download/doc/mkvpropedit.html#mkvpropedit.edit_selectors
    class MkvExtract
      include MkvModule

      attr_accessor :abort_at_warning

      def initialize(bin_path)
        @bin_path = "#{bin_path}mkvextract"
        @abort_at_warning = false
      end

      def version
        cmd = [@bin_path, '-V']

        result = call_cmd(cmd)

        result.stdout.strip
      end

      def extract_tracks(file, tracks, extract_cue: false, raw: false, full_raw: false, full_parse_mode: false)
        cmd = [@bin_path, file , 'tracks']
        add_default_options(cmd, full_parse_mode)
        cmd << '--cuesheet' if extract_cue
        cmd << '--raw' if raw
        cmd << '--fullraw' if full_raw

        tracks.each { |track| cmd << "#{track.track_id}:#{track.output_file}" }

        call_cmd(cmd)
      end

      def add_default_options(cmd, full_parse_mode)
        cmd << '--parse-fully' if full_parse_mode
        cmd << '--abort-on-warnings' if @abort_at_warning
      end

      private :add_default_options
    end
  end
end
