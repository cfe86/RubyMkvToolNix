# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'test_helper'

RSpec.describe MkvToolNix::MkvToolNix do

  let(:mod_name) { :@mkvpropedit }

  it 'fails due to something goes wrong' do
    propedit = run_mod(mod_name, raise_error: MkvToolNix::Errors::MkvToolNixError, expect_cmd: %w[mkvpropedit -V])

    expect { propedit.version }.to raise_error(MkvToolNix::Errors::MkvToolNixError)
  end

  it 'gets the version' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit -V],
                                 ret_stdout: "mkvpropedit v63.0.0 ('Everything') 64-bit\n")

    expect(propedit.version).to eq('mkvpropedit v63.0.0 (\'Everything\') 64-bit')
  end

  it 'adds track statistics tags' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit --parse-mode full myFile --add-track-statistics-tags])

    propedit.add_track_statistics_tags('myFile', full_parse_mode: true)
  end

  it 'delete track statistics tags' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit myFile --delete-track-statistics-tags])

    propedit.delete_track_statistics_tags('myFile')
  end

  it 'sets chapters' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit myFile --chapters chapters.xml])

    propedit.set_chapters('myFile', 'chapters.xml')
  end

  it 'sets tags' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit myFile --tags track:a1:tags.xml])

    propedit.set_tags('myFile', 'tags.xml', MkvToolNix::PropEditSelector.for_nth_audio(1))
  end

  it 'removes a property' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit myFile --edit track:@1 --delete name])

    propedit.remove_property('myFile', MkvToolNix::PropEditSelector.by_track_number(1), ['name'])
  end

  it 'sets a property' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit myFile --edit info --set title=newVal])

    propedit.set_property('myFile', MkvToolNix::PropEditSelector.for_info, 'title', 'newVal')
  end

  it 'adds an attachment' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit myFile --attachment-name name --attachment-description
                                                description --attachment-mime-type mime --attachment-uid uid
                                                --add-attachment attachmentFile])

    propedit.add_attachment('myFile', 'attachmentFile', 'name', 'description', 'uid', 'mime')
  end

  it 'replaces an attachment' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit myFile --attachment-name name --attachment-description
                                                description --attachment-mime-type mime --attachment-uid uid
                                                --replace-attachment 42:attachmentFile])

    propedit.replace_attachment('myFile', MkvToolNix::PropEditSelector.for_attachment_by_id(42), 'attachmentFile',
                                'name', 'description', 'uid', 'mime')
  end

  it 'removes an attachment' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit myFile --delete-attachment name:att_name])

    propedit.remove_attachment('myFile', MkvToolNix::PropEditSelector.for_attachment_by_name('att_name'))
  end

  it 'updates an attachment' do
    propedit = run_mod(mod_name, expect_cmd: %w[mkvpropedit myFile --attachment-name name --attachment-description
                                                description --attachment-mime-type mime --attachment-uid uid
                                                --update-attachment mime-type:my_mime])

    propedit.update_attachment('myFile', MkvToolNix::PropEditSelector.for_attachment_by_mime_type('my_mime'), 'name',
                               'description', 'uid', 'mime')
  end
end
