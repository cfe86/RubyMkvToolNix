# frozen_string_literal: true

module MkvToolNix
  module Modules
    # https://mkvtoolnix.download/doc/mkvpropedit.html#mkvpropedit.edit_selectors
    class MkvPropEdit
      include MkvModule

      attr_writer :abort_at_warning, :disable_language_ietf

      def initialize(bin_path)
        @bin_path = "#{bin_path}mkvpropedit"
        @abort_at_warning = false
        @disable_language_ietf = false
      end

      # returns the mkvpropedit version
      #
      # return [String] the version string
      def version
        cmd = [@bin_path, '-V']

        result = call_cmd(cmd)

        result.stdout.strip
      end

      # deletes the track statistics tags
      #
      # @param file [String] path to the mkv file
      # @param full_parse_mode [Boolean] sets full parse mod
      def delete_track_statistics_tags(file, full_parse_mode: false)
        cmd = [@bin_path]
        cmd << '--parse-mode' << 'full' if full_parse_mode
        cmd << '--abort-on-warnings' if @abort_at_warning
        cmd << file
        cmd << '--delete-track-statistics-tags'

        call_cmd(cmd)
      end

      # calculates and adds the statistics tags
      #
      # @param file [String] path to the mkv file
      # @param full_parse_mode [Boolean] sets full parse mod
      def add_track_statistics_tags(file, full_parse_mode: false)
        cmd = [@bin_path]
        add_default_options(cmd, full_parse_mode)
        cmd << file
        cmd << '--add-track-statistics-tags'

        call_cmd(cmd)
      end

      # adds or replaces the given chapter file to the given mkv file. If the chapter file is empty (valid xml file,
      # but the <chapter/> tag is empty), it removes the chapters from the mkv file
      #
      # @param file [String] path to the mkv file
      # @param chapter_file [String] path to the chapter xml file
      # @param full_parse_mode [Boolean] sets full parse mod
      def set_chapters(file, chapter_file, full_parse_mode: false)
        cmd = [@bin_path]
        add_default_options(cmd, full_parse_mode)
        cmd << file
        cmd << '--chapters'
        cmd << chapter_file

        call_cmd(cmd)
      end

      # sets the given tags to the tag field matching the given selector. A selector can either be all, global or for
      # a specific track.
      #
      # @param file [String] path to the mkv file
      # @param tag_file [String] path to the tag xml file
      # @param selector [String] the selector, all, global or a track selector
      # @param full_parse_mode [Boolean] sets full parse mod
      def set_tags(file, tag_file, selector, full_parse_mode: false)
        cmd = [@bin_path]
        add_default_options(cmd, full_parse_mode)
        cmd << file
        cmd << '--tags'
        cmd << "#{selector}:#{tag_file}"

        call_cmd(cmd)
      end

      # removes a property from the mkv file
      #
      # @param file [String] path to the mkv file
      # @param selector [String] the info or track selector
      # @param properties [String, Property] a list containing a Property or a String (Property will be determined
      #                                      automatically)
      # @param full_parse_mode [Boolean] sets full parse mod
      def remove_property(file, selector, properties, full_parse_mode: false)
        props = properties.map { |it| it.is_a?(Types::PropEdit::Property) ? it : find_property(it) }

        cmd = [@bin_path]
        add_default_options(cmd, full_parse_mode)
        cmd << file
        cmd << '--edit'
        cmd << selector
        props.each do |prop|
          raise Errors::MkvToolNixError, "Property is not removable: #{prop.property}" unless prop.removable

          cmd << '--delete'
          cmd << prop.property
        end

        call_cmd(cmd)
      end

      # sets a property to the mkv file
      #
      # @param file [String] path to the mkv file
      # @param selector [String] the info or track selector
      # @param property [String, Property] a Property or a String (Property will be determined automatically)
      # @param value [Any] the value to set
      # @param full_parse_mode [Boolean] sets full parse mod
      def set_property(file, selector, property, value, full_parse_mode: false)
        prop = property.is_a?(Types::PropEdit::Property) ? property : find_property(property)
        cmd = [@bin_path]
        add_default_options(cmd, full_parse_mode)
        cmd << file
        cmd << '--edit'
        cmd << selector
        cmd << '--set'
        # noinspection RubyNilAnalysis
        cmd << "#{prop.property}=#{value}"

        call_cmd(cmd)
      end

      # adds an attachment to the mkv file
      #
      # @param file [String] path to the mkv file
      # @param attachment_file [String] path to the attachment file
      # @param name [String] the attachment name, or nil to use the attachment's file name
      # @param description [String] attachments description
      # @param uid [String] the uid to use, if nil, will be determined automatically
      # @param mime_type [String] the files mime type. If nil, will be determined automatically
      # @param full_parse_mode [Boolean] sets full parse mod
      def add_attachment(file, attachment_file, name = nil, description = nil, uid = nil, mime_type = nil,
                         full_parse_mode: false)
        cmd = [@bin_path]
        add_default_options(cmd, full_parse_mode)
        cmd << file
        cmd << '--attachment-name' << name unless name.nil?
        cmd << '--attachment-description' << description unless description.nil?
        cmd << '--attachment-mime-type' << mime_type unless mime_type.nil?
        cmd << '--attachment-uid' << uid unless uid.nil?
        cmd << '--add-attachment' << attachment_file

        call_cmd(cmd)
      end

      # replaces an attachment of the mkv file
      #
      # @param file [String] path to the mkv file
      # @param selector [String] a selector to determine which attachment(s) to replace.
      #                          See MkvToolNix::PropEditSelector
      # @param attachment_file [String] path to the attachment file
      # @param name [String] the attachment name, or nil to use the attachment's file name
      # @param description [String] attachments description
      # @param uid [String] the uid to use, if nil, will be determined automatically
      # @param mime_type [String] the files mime type. If nil, will be determined automatically
      # @param full_parse_mode [Boolean] sets full parse mod
      def replace_attachment(file, selector, attachment_file, name = nil, description = nil, uid = nil, mime_type = nil,
                             full_parse_mode: false)
        cmd = [@bin_path]
        add_default_options(cmd, full_parse_mode)
        cmd << file
        cmd << '--attachment-name' << name unless name.nil?
        cmd << '--attachment-description' << description unless description.nil?
        cmd << '--attachment-mime-type' << mime_type unless mime_type.nil?
        cmd << '--attachment-uid' << uid unless uid.nil?
        cmd << '--replace-attachment' << "#{selector}:#{attachment_file}"

        call_cmd(cmd)
      end

      # removes an attachment of the mkv file
      #
      # @param file [String] path to the mkv file
      # @param selector [String] a selector to determine which attachment(s) to remove. See MkvToolNix::PropEditSelector
      # @param full_parse_mode [Boolean] sets full parse mod
      def remove_attachment(file, selector, full_parse_mode: false)
        cmd = [@bin_path]
        add_default_options(cmd, full_parse_mode)
        cmd << file
        cmd << '--delete-attachment' << selector

        call_cmd(cmd)
      end

      # updates an attachment of the mkv file
      #
      # @param file [String] path to the mkv file
      # @param selector [String] a selector to determine which attachment to replace. See MkvToolNix::PropEditSelector
      # @param name [String] the new attachment name
      # @param description [String] new attachments description
      # @param uid [String] the new uid
      # @param mime_type [String] the new files mime type
      # @param full_parse_mode [Boolean] sets full parse mod
      def update_attachment(file, selector, name = nil, description = nil, uid = nil, mime_type = nil,
                            full_parse_mode: false)
        cmd = [@bin_path]
        add_default_options(cmd, full_parse_mode)
        cmd << file
        cmd << '--attachment-name' << name unless name.nil?
        cmd << '--attachment-description' << description unless description.nil?
        cmd << '--attachment-mime-type' << mime_type unless mime_type.nil?
        cmd << '--attachment-uid' << uid unless uid.nil?
        cmd << '--update-attachment' << selector

        call_cmd(cmd)
      end

      def add_default_options(cmd, full_parse_mode)
        cmd << '--parse-mode' << 'full' if full_parse_mode
        cmd << '--abort-on-warnings' if @abort_at_warning
      end

      def find_property(property_name)
        prop = Types::PropEdit::InfoProperty.find_property(property_name)
        return prop unless prop.nil?

        prop = Types::PropEdit::VideoProperty.find_property(property_name)
        return prop unless prop.nil?

        prop = Types::PropEdit::AudioProperty.find_property(property_name)
        return prop unless prop.nil?

        prop = Types::PropEdit::SubtitleProperty.find_property(property_name)
        return prop unless prop.nil?

        raise Errors::MkvToolNixError, "Could not find Property: #{property_name}"
      end

      private :find_property, :add_default_options
    end
  end
end
