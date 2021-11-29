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
