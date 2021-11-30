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

      # returns the mkvextract version
      #
      # return [String] the version string
      def version
        cmd = [@bin_path, '-V']

        result = call_cmd(cmd)

        result.stdout.strip
      end

      # extracts the selected tracks
      #
      # @param file [String] path to the mkv file
      # @param tracks [Array] a list of Tracks, Strings or Hashes or a mix of them.
      # @param extract_cuesheet [Boolean] extracts the cuesheet to [filename].cue
      # @param raw [Boolean] if true, extracts the raw file, does not contain the CodecPrivate element
      # @param full_raw [Boolean] if true, extracts the raw file, does contain the CodecPrivate element
      # @param full_parse_mode [Boolean] sets full parse mod
      def extract_tracks(file, tracks, extract_cuesheet: false, raw: false, full_raw: false, full_parse_mode: false)
        cmd = [@bin_path, file, 'tracks']
        add_default_options(cmd, full_parse_mode)
        cmd << '--cuesheet' if extract_cuesheet
        cmd << '--raw' if raw
        cmd << '--fullraw' if full_raw

        add_id_file_list(cmd, tracks)

        call_cmd(cmd)
      end

      # extracts the selected attachments
      #
      # @param file [String] path to the mkv file
      # @param attachments [Array] a list of Attachments, Strings or Hashes or a mix of them.
      # @param full_parse_mode [Boolean] sets full parse mod
      def extract_attachments(file, attachments, full_parse_mode: false)
        cmd = [@bin_path, file, 'attachments']
        add_default_options(cmd, full_parse_mode)

        add_id_file_list(cmd, attachments)

        call_cmd(cmd)
      end

      # extracts the chapter xml file
      #
      # @param file [String] path to the mkv file
      # @param out_file [String] path to the file to write the chapter xml file to
      # @param full_parse_mode [Boolean] sets full parse mod
      def extract_chapters(file, out_file, simple: false, simple_language: nil, full_parse_mode: false)
        cmd = [@bin_path, file, 'chapters']
        add_default_options(cmd, full_parse_mode)

        cmd << '--simple' if simple
        cmd << '--simple-language' << simple_language unless simple_language.nil?

        cmd << out_file

        call_cmd(cmd)
      end

      # extracts the tags xml file
      #
      # @param file [String] path to the mkv file
      # @param out_file [String] path to the file to write the tags xml file to
      # @param full_parse_mode [Boolean] sets full parse mod
      def extract_tags(file, out_file, full_parse_mode: false)
        cmd = [@bin_path, file, 'tags']
        add_default_options(cmd, full_parse_mode)

        cmd << out_file

        call_cmd(cmd)
      end

      # extracts the cue sheet
      #
      # @param file [String] path to the mkv file
      # @param out_file [String] path to the file to write cue sheet file to
      # @param full_parse_mode [Boolean] sets full parse mod
      def extract_cue_sheet(file, out_file, full_parse_mode: false)
        cmd = [@bin_path, file, 'cuesheet']
        add_default_options(cmd, full_parse_mode)

        cmd << out_file

        call_cmd(cmd)
      end

      # extracts the timestamps of the selected tracks
      #
      # @param file [String] path to the mkv file
      # @param tracks [Array] a list of Tracks, Strings or Hashes or a mix of them.
      # @param full_parse_mode [Boolean] sets full parse mod
      def extract_timestamps(file, tracks, full_parse_mode: false)
        cmd = [@bin_path, file, 'timestamps_v2']
        add_default_options(cmd, full_parse_mode)

        add_id_file_list(cmd, tracks)

        call_cmd(cmd)
      end

      # extracts the cues of the selected tracks
      #
      # @param file [String] path to the mkv file
      # @param tracks [Array] a list of Tracks, Strings or Hashes or a mix of them.
      # @param full_parse_mode [Boolean] sets full parse mod
      def extract_cues(file, tracks, full_parse_mode: false)
        cmd = [@bin_path, file, 'cues']
        add_default_options(cmd, full_parse_mode)

        add_id_file_list(cmd, tracks)

        call_cmd(cmd)
      end

      def add_id_file_list(cmd, id_file_list)
        id_file_list.each_with_index do |ele, index|
          cmd << "#{ele.track_id}:#{ele.output_file}" if ele.is_a?(Types::Extract::Track)
          cmd << "#{ele.attachment_id}:#{ele.output_file}" if ele.is_a?(Types::Extract::Attachment)
          cmd << "#{ele[:id]}:#{ele[:output_file]}" if ele.is_a?(Hash)
          cmd << "#{ele[0]}:#{ele[1]}" if ele.is_a?(Array)
          cmd << "#{index + 1}:#{ele}" if ele.is_a?(String)
        end
      end

      def add_default_options(cmd, full_parse_mode)
        cmd << '--parse-fully' if full_parse_mode
        cmd << '--abort-on-warnings' if @abort_at_warning
      end

      private :add_default_options, :add_id_file_list
    end
  end
end
