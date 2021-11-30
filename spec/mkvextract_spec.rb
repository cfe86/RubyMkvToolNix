# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'test_helper'

RSpec.describe MkvToolNix::MkvToolNix do

  let(:mod_name) { :@mkvextract }

  it 'fails due to something goes wrong' do
    extract = run_mod(mod_name, raise_error: MkvToolNix::Errors::MkvToolNixError, expect_cmd: %w[mkvextract -V])

    expect { extract.version }.to raise_error(MkvToolNix::Errors::MkvToolNixError)
  end

  it 'gets the version' do
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract -V], ret_stdout: "mkvextract v63.0.0 ('Everything') 64-bit\n")

    expect(extract.version).to eq('mkvextract v63.0.0 (\'Everything\') 64-bit')
  end

  it 'extracts tracks' do
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract myFile tracks 1:out1.file 2:out2.file 3:out3.file 
                                               4:out4.file 5:out5.file])

    extract.extract_tracks('myFile', [MkvToolNix::Types::Extract::Track.new(1, 'out1.file'),
                                      'out2.file',
                                      MkvToolNix::Types::Extract::Track.new(3, 'out3.file'),
                                      [4, 'out4.file'],
                                      { id: 5, output_file: 'out5.file' }])
  end

  it 'extracts attachments' do
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract myFile attachments 1:out1.file 2:out2.file 3:out3.file
                                               4:out4.file 5:out5.file])

    extract.extract_attachments('myFile', [MkvToolNix::Types::Extract::Attachment.new(1, 'out1.file'),
                                           'out2.file',
                                           MkvToolNix::Types::Extract::Attachment.new(3, 'out3.file'),
                                           [4, 'out4.file'],
                                           { id: 5, output_file: 'out5.file' }])
  end

  it 'extracts chapters' do
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract myFile chapters --simple --simple-language en out_file.xml])

    extract.extract_chapters('myFile', 'out_file.xml', simple: true, simple_language: 'en')
  end

  it 'extracts tags' do
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract myFile tags out_file.xml])

    extract.extract_tags('myFile', 'out_file.xml')
  end

  it 'extracts cue sheet' do
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract myFile cuesheet out_file.xml])

    extract.extract_cue_sheet('myFile', 'out_file.xml')
  end

  it 'extracts timestamps' do
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract myFile timestamps_v2 1:out1.file 2:out2.file 3:out3.file
                                               4:out4.file 5:out5.file])

    extract.extract_timestamps('myFile', [MkvToolNix::Types::Extract::Track.new(1, 'out1.file'),
                                          'out2.file',
                                          MkvToolNix::Types::Extract::Track.new(3, 'out3.file'),
                                          [4, 'out4.file'],
                                          { id: 5, output_file: 'out5.file' }])
  end

  it 'extracts cues' do
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract myFile cues 1:out1.file 2:out2.file 3:out3.file
                                               4:out4.file 5:out5.file])

    extract.extract_cues('myFile', [MkvToolNix::Types::Extract::Track.new(1, 'out1.file'),
                                    'out2.file',
                                    MkvToolNix::Types::Extract::Track.new(3, 'out3.file'),
                                    [4, 'out4.file'],
                                    { id: 5, output_file: 'out5.file' }])
  end
end
