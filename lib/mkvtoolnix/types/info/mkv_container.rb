# frozen_string_literal: true

module MkvToolNix
  module Types
    module Info
      class MkvContainer

        attr_accessor :title, :file_name, :format_version, :type, :is_supported, :is_recognized, :container_type,
                      :date_utc, :duration_in_secs, :is_providing_timestamps, :mux_application, :segment_uid,
                      :writing_application, :attachments, :videos, :audios, :subtitles

        def self.create(hash)
          container = hash['container']
          props = container['properties']
          attachments = hash['attachments'].map { |it| Attachment.create(it) }
          tracks = hash['tracks']
          video_hash = tracks.select { |it| it['type'] == 'video' }
          videos = video_hash.nil? ? [] : video_hash.map { |it| Video.create(it) }
          audio_hash = tracks.select { |it| it['type'] == 'audio' }
          audios = audio_hash.nil? ? [] : audio_hash.map { |it| Audio.create(it) }
          subtitle_hash = tracks.select { |it| it['type'] == 'subtitles' }
          subtitles = subtitle_hash.nil? ? [] : subtitle_hash.map { |it| Subtitle.create(it) }

          new(title: props['title'], file_name: hash['file_name'],
              format_version: hash['identification_format_version'], type: container['type'],
              is_supported: container['supported'], is_recognized: container['recognized'],
              container_type: props['container_type'], date_utc: props['date_utc'],
              duration_in_nano: props['duration'], is_providing_timestamps: props['is_providing_timestamps'],
              mux_application: props['muxing_application'], segment_uid: props['segment_uid'],
              writing_application: props['writing_application'], attachments: attachments, videos: videos,
              audios: audios, subtitles: subtitles)
        end

        def initialize(title:, file_name:, format_version:, type:, is_supported:, is_recognized:, container_type:,
                       date_utc:, duration_in_nano:, is_providing_timestamps:, mux_application:, segment_uid:,
                       writing_application:, attachments:, videos:, audios:, subtitles:)
          @title = title
          @file_name = file_name
          @format_version = format_version
          @type = type
          @is_supported = is_supported
          @is_recognized = is_recognized
          @container_type = container_type
          @date_utc = date_utc
          @duration_in_secs = duration_in_nano.to_f / 1_000_000_000
          @is_providing_timestamps = is_providing_timestamps
          @mux_application = mux_application
          @segment_uid = segment_uid
          @writing_application = writing_application
          @attachments = attachments
          @videos = videos
          @audios = audios
          @subtitles = subtitles
        end
      end
    end
  end
end
