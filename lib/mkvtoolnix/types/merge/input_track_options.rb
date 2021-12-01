# frozen_string_literal: true

module MkvToolNix
  module Types
    module Merge
      class InputTrackOption

        attr_reader :track_id, :name, :language, :tag_file, :aac_sbr, :track_sync, :cues, :is_default,
                    :is_forced, :is_hearing_impaired, :is_visual_impaired, :is_text_description, :is_original,
                    :is_commentary, :reduce_to_core, :no_dialog_norm_gain, :timestamp_file, :default_duration_in_secs,
                    :fix_bitstream_timing_info, :compression, :four_cc, :dimensions, :aspect_ratio,
                    :color_matrix_coefficients, :color_bits_per_channel, :chroma_sub_sample, :cb_sub_sample,
                    :color_transfer_characteristics, :color_primaries, :max_content_light, :max_frame_light,
                    :chromaticity_coordinates, :white_color_coordinate, :max_luminance, :min_luminance,
                    :projection_type, :projection_private, :projection_pose_yaw, :projection_pose_pitch,
                    :projection_pose_roll, :field_order, :stereo_mode, :sub_charset

        def with_name(name)
          @name = "#{@track_id}:#{name}"
          self
        end

        def with_language(language)
          @language = "#{@track_id}:#{language}"
          self
        end

        def with_tags(file)
          @tag_file = "#{@track_id}:#{file}"
          self
        end

        def _handle_as_aac_sbr(enabled: true)
          @aac_sbr = "#{@track_id}:#{enabled ? 1 : 0}"
          self
        end

        def with_track_sync(d = 0, o_div_p = 1.0)
          @track_sync = "#{@track_id}:#{d},#{o_div_p}"
          self
        end

        def with_cues(mode = CueMode::I_FRAMES)
          @cues = "#{@track_id}:#{mode}"
          self
        end

        def default?(enabled: true)
          @is_default = "#{@track_id}:#{enabled}"
          self
        end

        def forced?(enabled: true)
          @is_forced = "#{@track_id}:#{enabled}"
          self
        end

        def hearing_impaired?(enabled: true)
          @is_hearing_impaired = "#{@track_id}:#{enabled}"
          self
        end

        def visual_impaired?(enabled: true)
          @is_visual_impaired = "#{@track_id}:#{enabled}"
          self
        end

        def text_description?(enabled: true)
          @is_text_description = "#{@track_id}:#{enabled}"
          self
        end

        def original?(enabled: true)
          @is_original = "#{@track_id}:#{enabled}"
          self
        end

        def commentary?(enabled: true)
          @is_commentary = "#{@track_id}:#{enabled}"
          self
        end

        def reduce_audio_to_core
          @reduce_to_core = true
          self
        end

        def with_timestamps(file)
          @timestamp_file = "#{@track_id}:#{file}"
          self
        end

        def remove_dialog_normalization_gain
          @no_dialog_norm_gain = true
          self

        end

        def with_default_duration_in_secs(secs)
          @default_duration_in_secs = "#{@track_id}:#{secs}s"
          self
        end

        def fix_bitstream_timing_information(fix: true)
          @fix_bitstream_timing_info = "#{@track_id}:#{fix ? 1 : 0}"
          self
        end

        def with_compression_mode(mode = Compression::NONE)
          @compression = "#{@track_id}:#{mode}"
          self
        end

        def with_four_cc(four_cc)
          @four_cc = "#{@track_id}:#{four_cc}"
          self
        end

        def with_dimensions(width, height)
          @dimensions = "#{@track_id}:#{width}x#{height}"
          self
        end

        def with_aspect_ratio(ratio)
          @aspect_ratio = "#{@track_id}:#{ratio}"
          self
        end

        def with_cropping(left, top, right, bottom)
          @cropping = "#{@track_id}:#{left},#{top},#{right},#{bottom}"
          self
        end

        def with_color_matrix_coefficients(coefficient)
          @color_matrix_coefficients = "#{@track_id}:#{coefficient}"
          self
        end

        def with_color_bits_per_channel(bits)
          @color_bits_per_channel = "#{@track_id}:#{bits}"
          self
        end

        def with_chroma_sub_sample(horizontal, vertical)
          @chroma_sub_sample = "#{@track_id}:#{horizontal},#{vertical}"
          self
        end

        def with_cb_sub_sample(horizontal, vertical)
          @cb_sub_sample = "#{@track_id}:#{horizontal},#{vertical}"
          self
        end

        def with_chroma_siting(horizontal, vertical)
          @chroma_siting = "#{@track_id}:#{horizontal},#{vertical}"
          self
        end

        def with_color_range(range)
          @color_range = "#{@track_id}:#{range}"
          self
        end

        def with_color_transfer_characteristics(characteristics)
          @color_transfer_characteristics = "#{@track_id}:#{characteristics}"
          self
        end

        def with_color_primaries(primaries)
          @color_primaries = "#{@track_id}:#{primaries}"
          self
        end

        def with_max_content_light(light)
          @max_content_light = "#{@track_id}:#{light}"
          self
        end

        def with_max_frame_light(light)
          @max_frame_light = "#{@track_id}:#{light}"
          self
        end

        def with_chromaticity_coordinates(red_x, red_y, green_x, green_y, blue_x, blue_y)
          @chromaticity_coordinates = "#{@track_id}:#{red_x},#{red_y},#{green_x},#{green_y},#{blue_x},#{blue_y}"
          self
        end

        def with_white_color_coordinate(x, y)
          @white_color_coordinate = "#{@track_id}:#{x},#{y}"
          self
        end

        def with_max_luminance(luminance)
          @max_luminance = "#{@track_id}:#{luminance}"
          self
        end

        def with_min_luminance(luminance)
          @min_luminance = "#{@track_id}:#{luminance}"
          self
        end

        def with_projection_type(type)
          @projection_type = "#{@track_id}:#{type}"
          self
        end

        def with_projection_private(hex_data)
          @projection_private = "#{@track_id}:#{hex_data}"
          self
        end

        def with_projection_pose_yaw(yaw)
          @projection_pose_yaw = "#{@track_id}:#{yaw}"
          self
        end

        def with_projection_pose_pitch(pitch)
          @projection_pose_pitch = "#{@track_id}:#{pitch}"
          self
        end

        def with_projection_pose_roll(roll)
          @projection_pose_roll = "#{@track_id}:#{roll}"
          self
        end

        def with_field_order(order)
          @field_order = "#{@track_id}:#{order}"
          self
        end

        def with_stereo_mode(mode)
          @stereo_mode = "#{@track_id}:#{mode}"
          self
        end

        def with_sub_charset(charset)
          @sub_charset = "#{@track_id}:#{charset}"
          self
        end

        def initialize(track_id)
          raise Errors::MkvToolNixError, 'track_id can\'t be nil' if track_id.nil?

          @track_id = track_id
        end

        def add_to_cmd(cmd)
          cmd << '--sync' << @track_sync unless @track_sync.nil?
          cmd << '--cues' << @cues unless @cues.nil?
          cmd << '--default-track' << @is_default unless @is_default.nil?
          cmd << '--forced-track' << @is_forced unless @is_forced.nil?
          cmd << '--hearing-impaired-flag' << @is_hearing_impaired unless @is_hearing_impaired.nil?
          cmd << '--visual-impaired-flag' << @is_visual_impaired unless @is_visual_impaired.nil?
          cmd << '--text-descriptions-flag' << @is_text_description unless @is_text_description.nil?
          cmd << '--original-flag' << @is_original unless @is_original.nil?
          cmd << '--commentary-flag' << @is_commentary unless @is_commentary.nil?
          cmd << '--track-name' << @name unless @name.nil?
          cmd << '--language' << @language unless @language.nil?
          cmd << '--tags' << @tag_file unless @tag_file.nil?
          cmd << '--aac-is-sbr' << @aac_sbr unless @aac_sbr.nil?
          cmd << '--reduce-to-core' unless @reduce_to_core.nil?
          cmd << '--remove-dialog-normalization-gain' unless @no_dialog_norm_gain.nil?
          cmd << '--timestamps' << @timestamp_file unless @timestamp_file.nil?
          cmd << '--default-duration' << @default_duration_in_secs unless @default_duration_in_secs.nil?
          cmd << '--fix-bitstream-timing-information' << @fix_bitstream_timing_info unless @fix_bitstream_timing_info.nil?
          cmd << '--compression' << @compression unless @compression.nil?
          cmd << '--fourcc' << @four_cc unless @four_cc.nil?
          cmd << '--display-dimensions' << @dimensions unless @dimensions.nil?
          cmd << '--aspect-ratio' << @aspect_ratio unless @aspect_ratio.nil?
          cmd << '--cropping' << @cropping unless @cropping.nil?
          cmd << '--colour-matrix-coefficients' << @color_matrix_coefficients unless @color_matrix_coefficients.nil?
          cmd << '--colour-bits-per-channel' << @color_bits_per_channel unless @color_bits_per_channel.nil?
          cmd << '--chroma-subsample' << @chroma_sub_sample unless @chroma_sub_sample.nil?
          cmd << '--cb-subsample' << @cb_sub_sample unless @cb_sub_sample.nil?
          cmd << '--chroma-siting' << @chroma_siting unless @chroma_siting.nil?
          cmd << '--colour-range' << @color_range unless @color_range.nil?
          cmd << '--colour-transfer-characteristics' << @color_transfer_characteristics unless @color_transfer_characteristics.nil?
          cmd << '--colour-primaries' << @color_primaries unless @color_primaries.nil?
          cmd << '--max-content-light' << @max_content_light unless @max_content_light.nil?
          cmd << '--max-frame-light' << @max_frame_light unless @max_frame_light.nil?
          cmd << '--chromaticity-coordinates' << @chromaticity_coordinates unless @chromaticity_coordinates.nil?
          cmd << '--white-colour-coordinates' << @white_color_coordinate unless @white_color_coordinate.nil?
          cmd << '--max-luminance' << @max_luminance unless @max_luminance.nil?
          cmd << '--min-luminance' << @min_luminance unless @min_luminance.nil?
          cmd << '--projection-type' << @projection_type unless @projection_type.nil?
          cmd << '--projection-private' << @projection_private unless @projection_private.nil?
          cmd << '--projection-pose-yaw' << @projection_pose_yaw unless @projection_pose_yaw.nil?
          cmd << '--projection-pose-pitch' << @projection_pose_pitch unless @projection_pose_pitch.nil?
          cmd << '--projection-pose-roll' << @projection_pose_roll unless @projection_pose_roll.nil?
          cmd << '--field-order' << @field_order unless @field_order.nil?
          cmd << '--stereo-mode' << @stereo_mode unless @stereo_mode.nil?
          cmd << '--sub-charset' << @sub_charset unless @sub_charset.nil?
          nil
        end
      end

      module CueMode
        NONE = 'none'
        I_FRAMES = 'iframes'
        ALL = 'all'
      end

      module Compression
        NONE = 'none'
        ZLIB = 'zlib'
        MPEG4_P2 = 'mpeg4_p2'
      end

      module ColorMatrixCoefficients
        GBR = 0
        BT709 = 1
        UNSPECIFIED = 2
        FCC = 4
        BT470BG = 5
        SMPTE_170M = 6
        SMPTE_240M = 7
        YCOCG = 8
        BT2020_NON_CONSTANT_LUMINANCE = 9
        BT2020_CONSTANT_LUMINANCE = 10
      end

      module ColorRange
        UNSPECIFIED = 0
        BROADCAST_RANGE = 1
        FULL_RANGE = 2
        DEFINED_BY_MATRIX_TRANSFER_COEFFICIENTS = 3
      end

      module ColorTransferCharacteristics
        ITU_R_BT_709 = 1
        UNSPECIFIED = 2
        GAMMA_2_2_CURVE = 4
        GAMMA_8_CURVE = 5
        SMPTE_170M = 6
        SMPTE_240M = 7
        LINEAR = 8
        LOG = 9
        LOG_SQRT = 10
        IEC_61966_2_4 = 11
        ITU_R_BT_1361_EXTENDED_COLOR_GAMUT = 12
        IEC_61966_2_1 = 13
        ITU_R_BT_2020_10_BIT = 14
        ITU_R_BT_2020_12_BIT = 15
        SMPTE_ST_2084 = 16
        SMPTE_ST_428_1 = 17
        ARIB_STD_B67_HLG = 18
      end

      module ColorPrimaries
        ITU_R_BT_709 = 1
        ITU_R_BT_470M = 4
        ITU_R_BT_470BG = 5
        SMPTE_170M = 6
        SMPTE_240M = 7
        FILM = 8
        ITU_R_BT_2020 = 9
        SMPTE_ST_428_1 = 10
        JEDEC_P22_PHOSPHORS = 22
      end

      module ProjectionType
        RECTANGULAR = 0
        EQUIRECTANGULAR = 1
        CUBEMAP = 2
        MESH = 3
      end

      module StereoMode
        MONO = 'mono'
        SIDE_BY_SIDE_LEFT_FIRST = 'side_by_side_left_first'
        TOP_BOTTOM_RIGHT_FIRST = 'top_bottom_right_first'
        TOP_BOTTOM_LEFT_FIRST = 'top_bottom_left_first'
        CHECKERBOARD_RIGHT_FIRST = 'checkerboard_right_first'
        CHECKERBOARD_LEFT_FIRST = 'checkerboard_left_first'
        ROW_INTERLEAVED_RIGHT_FIRST = 'row_interleaved_right_first'
        ROW_INTERLEAVED_LEFT_FIRST = 'row_interleaved_left_first'
        COLUMN_INTERLEAVED_RIGHT_FIRST = 'column_interleaved_right_first'
        COLUMN_INTERLEAVED_LEFT_FIRST = 'column_interleaved_left_first'
        ANAGLYPH_CYAN_RED = 'anaglyph_cyan_red'
        SIDE_BY_SIDE_RIGHT_FIRST = 'side_by_side_right_first'
        ANAGLYPH_GREEN_MAGENTA = 'anaglyph_green_magenta'
        BOTH_EYES_LACED_LEFT_FIRST = 'both_eyes_laced_left_first'
        BOTH_EYES_LACED_RIGHT_FIRST = 'both_eyes_laced_right_first'
      end
    end
  end
end
