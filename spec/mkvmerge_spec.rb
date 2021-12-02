# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'test_helper'

RSpec.describe MkvToolNix::MkvToolNix do

  let(:mod_name) { :@mkvmerge }

  it 'fails due to something goes wrong' do
    merge = run_mod(mod_name, raise_error: MkvToolNix::Errors::MkvToolNixError, expect_cmd: %w[mkvmerge -V])

    expect { merge.version }.to raise_error(MkvToolNix::Errors::MkvToolNixError)
  end

  it 'returns the correct version' do
    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge -V], ret_stdout: "mkvmerge v63.0.0 ('Everything') 64-bit\n")

    expect(merge.version).to eq('mkvmerge v63.0.0 (\'Everything\') 64-bit')
  end

  it 'creates chapter options correctly' do
    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge --chapters myChapters.xml --chapter-language en --chapter-charset
                                             myCS --generate-chapters interval:360s --generate-chapters-name-template
                                             name_template --cue-chapter-name-format cue_format -o myFile inputFile])

    chapter_options = merge.build_chapter
    chapter_options.with_chapter_language('en').with_chapters_file('myChapters.xml').with_chapter_charset('myCS')
                   .generate_chapter_every_secs(360).generate_chapter_name_template('name_template')
                   .generate_chapter_cue_name_format('cue_format')

    merge.merge('myFile', merge.build_input_file('inputFile'), chapter_options: chapter_options)
  end

  it 'creates 2 attachment options correctly' do
    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge --attachment-description d1 --attachment-mime-type jpeg
                                             --attachment-name a1 --attach-file file1 --attachment-description d2
                                             --attachment-mime-type png --attachment-name a2 --attach-file file2
                                             -o myFile inputFile])

    attachment1 = merge.build_attachment('file1').with_name('a1').with_mime_type('jpeg').with_description('d1')
    attachment2 = merge.build_attachment('file2').with_name('a2').with_mime_type('png').with_description('d2')

    merge.merge('myFile', merge.build_input_file('inputFile'), attachments: [attachment1, attachment2])
  end

  it 'creates adds segment infos correctly' do
    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge --segmentinfo segmentFile --segment-uid uid1,uid2
                                             -o myFile inputFile])

    segment_info = merge.build_segment_info.for_file('segmentFile').for_uids(%w[uid1 uid2])

    merge.merge('myFile', merge.build_input_file('inputFile'), segment_info: segment_info)
  end

  it 'creates adds tags correctly' do
    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge --global-tags tagFile -o myFile inputFile])

    tag_options = merge.build_tags('tagFile')

    merge.merge('myFile', merge.build_input_file('inputFile'), tag_options: tag_options)
  end

  it 'creates output control correctly' do
    merge = run_mod(mod_name, expect_cmd: ['mkvmerge', '--title', 'myTitle', '--default-language', 'en',
                                           '--track-order', '1:1,1:2,1:3', '--cluster-length', 12_345,
                                           '--clusters-in-meta-seek', '--timestamp-scale', 10_000, '--enable-durations',
                                           '--no-cues', '--no-date', '--disable-lacing',
                                           '--disable-track-statistics-tags', '--disable-language-ietf',
                                           '-o', 'myFile', 'inputFile'])

    output_control = merge.build_output_control.with_cluster_length_in_blocks(12_345).with_meta_seek_element
                          .with_timestamp_scale(10_000).with_durations_enabled.without_cues.without_date
                          .with_disabled_lacing.without_track_statistics_tags.without_language_ietf
                          .with_track_order([[1, 1], MkvToolNix::Types::Merge::TrackOrder.new(1, 2),
                                             { file_index: 1, track_id: 3 }])
                          .with_title('myTitle').with_default_language('en')

    merge.merge('myFile', merge.build_input_file('inputFile'), output_control: output_control)
  end

  it 'creates input file correctly' do
    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge -o myFile --audio-tracks 1,2 --video-tracks 1,2
                                             --subtitle-tracks 1,2 --track-tags 1,2 --attachments 1,2 --no-audio
                                             --no-video --no-subtitles --no-track-tags --no-chapters --no-attachments
                                             --no-global-tags inputFile1])

    input_file = merge.build_input_file('inputFile1').with_audio_tracks(1, 2).with_video_tracks(1, 2)
                      .with_subtitle_tracks(1, 2).with_track_tags(1, 2).with_attachments(1, 2).with_no_audio
                      .with_no_video.with_no_subtitles.with_no_chapters.with_no_track_tags.with_no_global_tags
                      .with_no_attachments

    merge.merge('myFile', input_file)
  end

  it 'creates input file with track options correctly' do
    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge -o myFile --audio-tracks 1,2 --video-tracks 1,2 --subtitle-tracks
                                             1,2 --track-tags 1,2 --attachments 1,2 --no-audio --no-video --no-subtitles
                                             --no-track-tags --no-chapters --no-attachments --no-global-tags
                                             --cues 1:iframes --default-track 1:true --hearing-impaired-flag 1:true
                                             --visual-impaired-flag 1:true --text-descriptions-flag 1:true
                                             --original-flag 1:true --commentary-flag 1:true --track-name 1:track1Name
                                             --language 1:en --tags 1:tagFile --aac-is-sbr 1:1 --reduce-to-core
                                             --remove-dialog-normalization-gain --timestamps 1:timestampFile
                                             --default-duration 1:12345s --fix-bitstream-timing-information 1:1
                                             --compression 1:none --fourcc 1:fourCC --display-dimensions 1:42x42
                                             --aspect-ratio 1:1.2 --cropping 1:1,2,3,4 --colour-matrix-coefficients 1:42
                                             --colour-bits-per-channel 1:42 --chroma-subsample 1:1,2
                                             --cb-subsample 1:1,2 --chroma-siting 1:1,2 --colour-range 1:range
                                             --colour-transfer-characteristics 1:ctc --colour-primaries 1:cp
                                             --max-content-light 1:maxcl --max-frame-light 1:mincl
                                             --chromaticity-coordinates 1:1,2,3,4,5,6 --white-colour-coordinates 1:1,2
                                             --max-luminance 1:maxl --min-luminance 1:minl --projection-type 1:pt
                                             --projection-private 1:0x1234 --projection-pose-yaw 1:yaw
                                             --projection-pose-pitch 1:pitch --projection-pose-roll 1:roll
                                             --field-order 1:fo --stereo-mode 1:stereo --sub-charset 1:cs inputFile1])

    input_file = merge.build_input_file('inputFile1').with_audio_tracks(1, 2).with_video_tracks(1, 2)
                      .with_subtitle_tracks(1, 2).with_track_tags(1, 2).with_attachments(1, 2).with_no_audio
                      .with_no_video.with_no_subtitles.with_no_chapters.with_no_track_tags.with_no_global_tags
                      .with_no_attachments
    track1 = input_file.build_track_option('1').with_name('track1Name').with_language('en').with_tags('tagFile')
                       .handle_as_aac_sbr.with_cues.default?.hearing_impaired?.visual_impaired?.text_description?
                       .original?.commentary?.reduce_audio_to_core.with_timestamps('timestampFile')
                       .remove_dialog_normalization_gain.with_default_duration_in_secs(12_345)
                       .fix_bitstream_timing_information.with_compression_mode.with_four_cc('fourCC')
                       .with_dimensions(42, 42).with_aspect_ratio(1.2).with_cropping(1, 2, 3, 4)
                       .with_color_matrix_coefficients(42).with_color_bits_per_channel(42)
                       .with_chroma_sub_sample(1, 2).with_cb_sub_sample(1, 2).with_chroma_siting(1, 2)
                       .with_color_range('range').with_color_transfer_characteristics('ctc').with_color_primaries('cp')
                       .with_max_content_light('maxcl').with_max_frame_light('mincl')
                       .with_chromaticity_coordinates(1, 2, 3, 4, 5, 6).with_white_color_coordinate(1, 2)
                       .with_max_luminance('maxl').with_min_luminance('minl').with_projection_type('pt')
                       .with_projection_private('0x1234').with_projection_pose_yaw('yaw')
                       .with_projection_pose_pitch('pitch').with_projection_pose_roll('roll').with_field_order('fo')
                       .with_stereo_mode('stereo').with_sub_charset('cs')
    input_file.add_track_options(track1)

    merge.merge('myFile', input_file)
  end

  it 'creates input file with 2 track options correctly' do
    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge -o myFile --audio-tracks 1,2 --no-attachments
                                             --default-track 1:true --original-flag 1:true --commentary-flag 1:true
                                             --track-name 1:track1Name --language 1:en --tags 1:tagFile
                                             --default-track 2:false --track-name 2:track2Name --language 2:de
                                             --tags 2:tagFile2 inputFile1])

    input_file = merge.build_input_file('inputFile1').with_audio_tracks(1, 2).with_no_attachments
    track1 = input_file.build_track_option('1').with_name('track1Name').with_language('en').with_tags('tagFile')
                       .default?.original?.commentary?
    track2 = input_file.build_track_option('2').with_name('track2Name').with_language('de').with_tags('tagFile2')
                       .default?(enabled: false)
    input_file.add_track_options(track1)
    input_file.add_track_options(track2)

    merge.merge('myFile', input_file)
  end

  it 'creates with 2 input files with 2 track options each correctly' do
    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge -o myFile --audio-tracks 1,2 --no-attachments
                                             --default-track 1:true --original-flag 1:true --commentary-flag 1:true
                                             --track-name 1:track1Name --language 1:en --tags 1:tagFile
                                             --default-track 2:false --track-name 2:track2Name --language 2:de
                                             --tags 2:tagFile2 inputFile1 --audio-tracks 1,2 --no-attachments
                                             --default-track 1:true --original-flag 1:true --commentary-flag 1:true
                                             --track-name 1:track3Name --language 1:en2 --tags 1:tagFil3
                                             --default-track 2:false --track-name 2:track4Name --language 2:de2
                                             --tags 2:tagFile4 inputFile2])

    input_file1 = merge.build_input_file('inputFile1').with_audio_tracks(1, 2).with_no_attachments
    track1_1 = input_file1.build_track_option('1').with_name('track1Name').with_language('en').with_tags('tagFile')
                          .default?.original?.commentary?
    track2_2 = input_file1.build_track_option('2').with_name('track2Name').with_language('de').with_tags('tagFile2')
                          .default?(enabled: false)
    input_file1.add_track_options(track1_1)
    input_file1.add_track_options(track2_2)

    input_file2 = merge.build_input_file('inputFile2').with_audio_tracks(1, 2).with_no_attachments
    track2_1 = input_file2.build_track_option('1').with_name('track3Name').with_language('en2').with_tags('tagFil3')
                          .default?.original?.commentary?
    track2_2 = input_file2.build_track_option('2').with_name('track4Name').with_language('de2').with_tags('tagFile4')
                          .default?(enabled: false)
    input_file2.add_track_options(track2_1)
    input_file2.add_track_options(track2_2)

    merge.merge('myFile', input_file1, input_file2)
  end

  it 'reads mkv file infos' do
    json = '{"attachments":[{"content_type":"image\/jpeg","description":"description",'\
           '"file_name":"ca713988ba2f8e28e4af1b5973b18f4b.jpeg","id":1,"properties":{"uid":3168221515511725050},'\
           '"size":209748}],"chapters":[],"container":{"properties":{"container_type":17,'\
           '"date_local":"2021-11-27T23:48:09-05:00","date_utc":"2021-11-28T04:48:09Z","duration":5801804000000,'\
           '"is_providing_timestamps":true,"muxing_application":"libebml v1.4.2 + libmatroska v1.6.4",'\
           '"segment_uid":"2c16f02cde0bc688b594bd6e815138c4","title":"the title",'\
           '"writing_application":"mkvmerge v63.0.0 (\'Everything\') 64-bit"},"recognized":true,"supported":true,'\
           '"type":"Matroska"},"errors":[],"file_name":"the_title.mkv","global_tags":[],'\
           '"identification_format_version":14,"track_tags":[],"tracks":[{"codec":"AVC\/H.264\/MPEG-4p10","id":0,'\
           '"properties":{"codec_delay":12,"codec_id":"V_MPEG4\/ISO\/AVC","codec_name":"codec name",'\
           '"codec_private_data":"01640029ffe1001767640029acd98078065a1000003e90000bb808f18319a001000668e978273c8f",'\
           '"codec_private_length":40,"cropping":"1,2,3,4","default_duration":41708333,"default_track":true,'\
           '"display_dimensions":"1920x800","display_unit":0,"enabled_track":true,"flag_commentary":true,'\
           '"flag_hearing_impaired":true,"flag_original":true,"flag_text_descriptions":true,'\
           '"flag_visual_impaired":true,"forced_track":true,"language":"und","language_ietf":"und",'\
           '"minimum_timestamp":0,"number":1,"packetizer":"mpeg4_p10_video","pixel_dimensions":"1920x800",'\
           '"stereo_mode":5,"track_name":"name","uid":5952078905726844927},"type":"video"},{"codec":"DTS","id":1,'\
           '"properties":{"audio_bits_per_sample":24,"audio_channels":6,"audio_sampling_frequency":48000,'\
           '"codec_delay":42,"codec_id":"A_DTS","codec_name":"codec name","codec_private_length":0,'\
           '"default_duration":10666667,"default_track":true,"enabled_track":true,"flag_commentary":true,'\
           '"flag_hearing_impaired":true,"flag_original":true,"flag_text_descriptions":true,'\
           '"flag_visual_impaired":true,"forced_track":true,"language":"ger","language_ietf":"de",'\
           '"minimum_timestamp":0,"number":2,"track_name":"DTS 5.1","uid":1.249959052231837e+19},"type":"audio"},'\
           '{"codec":"DTS","id":2,"properties":{"audio_bits_per_sample":24,"audio_channels":6,'\
           '"audio_sampling_frequency":48000,"codec_id":"A_DTS","codec_private_length":0,"default_duration":10666667,'\
           '"default_track":false,"enabled_track":true,"forced_track":false,"language":"eng","language_ietf":"en",'\
           '"minimum_timestamp":0,"number":3,"track_name":"DTS 5.1","uid":5381728609680316351},"type":"audio"},'\
           '{"codec":"SubRip\/SRT","id":3,"properties":{"codec_delay":42,"codec_id":"S_TEXT\/UTF8",'\
           '"codec_name":"codec name","codec_private_length":0,"default_duration":123,"default_track":false,'\
           '"enabled_track":false,"encoding":"UTF-8","flag_commentary":true,"flag_hearing_impaired":false,'\
           '"flag_original":true,"flag_text_descriptions":true,"flag_visual_impaired":true,"forced_track":false,'\
           '"language":"ger","language_ietf":"de","number":4,"text_subtitles":true,"track_name":"Forced (SRT)",'\
           '"uid":5288965518122946780},"type":"subtitles"},{"codec":"HDMV PGS","id":4,'\
           '"properties":{"codec_id":"S_HDMV\/PGS","codec_private_length":0,"content_encoding_algorithms":"0",'\
           '"default_track":false,"enabled_track":true,"forced_track":false,"language":"ger","language_ietf":"de",'\
           '"number":5,"track_name":"Full (PGS)","uid":9092044684843089397},"type":"subtitles"}],"warnings":[]}'

    merge = run_mod(mod_name, expect_cmd: %w[mkvmerge -J myfile], ret_stdout: json)

    mkv_file = merge.info('myfile')
    # puts mkv_file
  end
end
