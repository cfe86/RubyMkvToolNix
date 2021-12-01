# frozen_string_literal: true

module MkvToolNix
  module Types
    module Merge
      class InputFile

        attr_reader :audio_tracks, :video_tracks, :subtitle_tracks, :track_tags, :attachments, :no_audio,
                    :no_video, :no_subtitles, :no_chapters, :no_attachments, :no_track_tags, :no_global_tags,
                    :track_options

        def with_audio_tracks(*track_ids)
          @audio_tracks = track_ids
          self
        end

        def with_video_tracks(*track_ids)
          @video_tracks = track_ids
          self
        end

        def with_subtitle_tracks(*track_ids)
          @subtitle_tracks = track_ids
          self
        end

        def with_track_tags(*track_ids)
          @track_tags = track_ids
          self
        end

        def with_attachments(*attachment_ids)
          @attachments = attachment_ids
          self
        end

        def with_no_audio
          @no_audio = true
          self
        end

        def with_no_video
          @no_video = true
          self
        end

        def with_no_subtitles
          @no_subtitles = true
          self
        end

        def with_no_chapters
          @no_chapters = true
          self
        end

        def with_no_track_tags
          @no_track_tags = true
          self
        end

        def with_no_global_tags
          @no_global_tags = true
          self
        end

        def with_no_attachments
          @no_attachments = true
          self
        end

        def add_track_options(option)
          @track_options << option
          self
        end

        def with_track_options(options)
          @track_options = options
          self
        end

        def chapter_sync(d = 0, o_div_p = 1.0)
          @chapter_sync = "-2:#{d},#{o_div_p}"
          self
        end

        def build_track_option(track_id)
          InputTrackOption.new(track_id)
        end

        def add_to_cmd(cmd)
          cmd << '--audio-tracks' << @audio_tracks.join(',') unless @audio_tracks.nil?
          cmd << '--video-tracks' << @video_tracks.join(',') unless @video_tracks.nil?
          cmd << '--subtitle-tracks' << @subtitle_tracks.join(',') unless @subtitle_tracks.nil?
          cmd << '--track-tags' << @track_tags.join(',') unless @track_tags.nil?
          cmd << '--attachments' << @attachments.join(',') unless @attachments.nil?
          cmd << '--no-audio' unless @no_audio.nil?
          cmd << '--no-video' unless @no_video.nil?
          cmd << '--no-subtitles' unless @no_subtitles.nil?
          cmd << '--no-track-tags' unless @no_track_tags.nil?
          cmd << '--no-chapters' unless @no_chapters.nil?
          cmd << '--no-attachments' unless @no_attachments.nil?
          cmd << '--no-global-tags' unless @no_global_tags.nil?
          cmd << '--sync' << @chapter_sync unless @chapter_sync.nil?

          @track_options.each { |option| option.add_to_cmd(cmd) }

          cmd  << @file
          nil
        end

        def initialize(file)
          @file = file
          @track_options = []
        end
      end
    end
  end
end
