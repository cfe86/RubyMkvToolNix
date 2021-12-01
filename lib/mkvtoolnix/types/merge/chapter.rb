# frozen_string_literal: true

module MkvToolNix
  module Types
    module Merge
      class Chapter

        attr_reader :chapter_language, :chapter_charset, :generate_chapter_interval_secs,
                    :gen_chapter_cue_name_format, :gen_chapter_name_template, :chapters_file

        def with_chapter_language(language_code)
          @chapter_language = language_code
          self
        end

        def with_chapter_charset(charset)
          @chapter_charset = charset
          self
        end

        def generate_chapter_every_secs(num_secs)
          @generate_chapter_interval_secs = num_secs
          self
        end

        def generate_chapter_name_template(template)
          @gen_chapter_name_template = template
          self
        end

        def generate_chapter_cue_name_format(format)
          @gen_chapter_cue_name_format = format
          self
        end

        def with_chapters_file(file)
          @chapters_file = file
          self
        end

        def add_to_cmd(cmd)
          cmd << '--chapters' << @chapters_file unless @chapters_file.nil?
          cmd << '--chapter-language' << @chapter_language unless @chapter_language.nil?
          cmd << '--chapter-charset' << @chapter_charset unless @chapter_charset.nil?
          cmd << '--generate-chapters' << "interval:#{@generate_chapter_interval_secs}s" unless @generate_chapter_interval_secs.nil?
          cmd << '--generate-chapters-name-template' << @gen_chapter_name_template unless @gen_chapter_name_template.nil?
          cmd << '--cue-chapter-name-format' << @gen_chapter_cue_name_format unless @gen_chapter_cue_name_format.nil?
          nil
        end
      end
    end
  end
end
