# frozen_string_literal: true

module MkvToolNix
  module Types
    module Merge
      class OutputControl

        attr_reader :title, :default_language, :track_order, :cluster_length_blocks, :generate_meta_seek,
                    :timestamp_scale, :enable_duration, :no_cues, :no_date, :disable_lacing, :disable_language_ietf,
                    :disable_track_statistics_tags

        def with_title(title)
          @title = title
          self
        end

        def with_default_language(language)
          @default_language = language
          self
        end

        def with_track_order(order)
          if order.is_a?(String)
            @track_order = order
            return self
          end

          @track_order = order.map do |it|
            # @track_order.map(&:to_s).join(',')
            case it
            when TrackOrder
              next it.to_s
            when Array
              next ["#{it[0]}:#{it[1]}"]
            when Hash
              next ["#{it[:file_index]}:#{it[:track_id]}"]
            end
          end.join(',')

          self
        end

        def with_cluster_length_in_blocks(blocks)
          @cluster_length_blocks = blocks
          self
        end

        def with_meta_seek_element
          @generate_meta_seek = true
          self
        end

        def with_timestamp_scale(factor)
          @timestamp_scale = factor
          self
        end

        def with_durations_enabled
          @enable_duration = true
          self
        end

        def without_cues
          @no_cues = true
          self
        end

        def without_date
          @no_date = true
          self
        end

        def with_disabled_lacing
          @disable_lacing = true
          self
        end

        def without_track_statistics_tags
          @disable_track_statistics_tags = true
          self
        end

        def without_language_ietf
          @disable_language_ietf = true
          self
        end

        def add_to_cmd(cmd)
          cmd << '--title' << @title unless @title.nil?
          cmd << '--default-language' << @default_language unless @default_language.nil?
          cmd << '--track-order' << @track_order unless @track_order.nil?
          cmd << '--cluster-length' << @cluster_length_blocks unless @cluster_length_blocks.nil?
          cmd << '--clusters-in-meta-seek' if @generate_meta_seek
          cmd << '--timestamp-scale' << @timestamp_scale unless @timestamp_scale.nil?
          cmd << '--enable-durations' if @enable_duration
          cmd << '--no-cues' if @no_cues
          cmd << '--no-date' if @no_date
          cmd << '--disable-lacing' if @disable_lacing
          cmd << '--disable-track-statistics-tags' if @disable_track_statistics_tags
          cmd << '--disable-language-ietf' if @disable_language_ietf
          nil
        end
      end

      class TrackOrder

        attr_reader :file_index, :track_id

        def to_s
          "#{@file_index}:#{@track_id}"
        end

        def initialize(file_index, track_id)
          @file_index = file_index
          @track_id = track_id
        end
      end
    end
  end
end
