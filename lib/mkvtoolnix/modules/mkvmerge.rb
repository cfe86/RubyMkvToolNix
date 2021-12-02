# frozen_string_literal: true

module MkvToolNix
  module Modules
    # https://mkvtoolnix.download/doc/mkvmerge.html
    class MkvMerge
      include MkvModule

      attr_accessor :default_language, :disable_language_ietf

      def initialize(bin_path)
        @bin_path = "#{bin_path}mkvmerge"
        @default_language = 'und'
        @disable_language_ietf = false
      end

      def version
        cmd = [@bin_path, '-V']

        result = call_cmd(cmd)

        result.stdout.strip
      end

      def merge(output_file, *input_files, attachments: nil, chapter_options: nil, tag_options: nil,
                output_control: nil, segment_info: nil)
        raise Errors::MkvToolNixError, 'No Input File(s) given.' if input_files.nil?

        cmd = ['mkvmerge']

        attachments&.each { |attachment| attachment.add_to_cmd(cmd) }
        chapter_options&.add_to_cmd(cmd)
        segment_info&.add_to_cmd(cmd)
        tag_options&.add_to_cmd(cmd)
        output_control&.add_to_cmd(cmd)

        cmd << '-o' << output_file

        input_files.each { |input| input.add_to_cmd(cmd) }

        a = cmd.join(' ')

        call_cmd(cmd)
      end

      def info(file)
        cmd = [@bin_path, '-J']
        cmd << file

        result = call_cmd(cmd)

        json = JSON.parse(result.stdout)
        Types::Info::MkvContainer.create(json)
      end

      def build_segment_info
        Types::Merge::SegmentInfo.new
      end

      def build_attachment(file)
        Types::Merge::Attachment.new(file)
      end

      def build_chapter
        Types::Merge::Chapter.new
      end

      def build_tags(file)
        Types::Merge::Tags.new(file)
      end

      def build_output_control
        Types::Merge::OutputControl.new
      end

      def build_input_file(file)
        Types::Merge::InputFile.new(file)
      end
    end
  end
end
