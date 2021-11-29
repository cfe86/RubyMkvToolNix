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
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract -V],
                                ret_stdout: "mkvextract v63.0.0 ('Everything') 64-bit\n")

    expect(extract.version).to eq('mkvextract v63.0.0 (\'Everything\') 64-bit')
  end

  it 'extracts tracks' do
    extract = run_mod(mod_name, expect_cmd: %w[mkvextract myFile tracks 1:out1.file 2:out2.file])

    extract.extract_tracks('myFile', [MkvToolNix::Types::Extract::Track.new(1, 'out1.file'),
                                      MkvToolNix::Types::Extract::Track.new(2, 'out2.file')])
  end
end
