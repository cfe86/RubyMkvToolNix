# frozen_string_literal: true

require 'open3'
require 'json'

require 'mkvtoolnix/errors/mkvtoolnix_error'

require 'mkvtoolnix/modules/mkv_module'

require 'mkvtoolnix/extensions/iterable'

require 'mkvtoolnix/propedit_selector'

require 'mkvtoolnix/types/propedit/property'
require 'mkvtoolnix/types/propedit/common_property'
require 'mkvtoolnix/types/propedit/audio_property'
require 'mkvtoolnix/types/propedit/video_property'
require 'mkvtoolnix/types/propedit/info_property'
require 'mkvtoolnix/types/propedit/subtitle_property'

require 'mkvtoolnix/types/extract/Track'

require 'mkvtoolnix/types/info/mkv_container'
require 'mkvtoolnix/types/info/audio'
require 'mkvtoolnix/types/info/subtitle'
require 'mkvtoolnix/types/info/video'
require 'mkvtoolnix/types/info/attachment'

require 'mkvtoolnix/modules/mkvmerge'
require 'mkvtoolnix/modules/mkvpropedit'
require 'mkvtoolnix/modules/mkvextract'

module MkvToolNix
  # extend Extensions::Chainable

  def self.init
    mkv_bin_path('')
  end

  def self.mkv_bin_path(bin_path)
    bin_path = "#{bin_path}/" if !bin_path.empty? && !bin_path.end_with?('/')
    MkvToolNix.new(bin_path)
  end

  class MkvToolNix
    # include Extensions::Chainable

    attr_reader :mkvmerge, :mkvpropedit, :mkvextract

    def initialize(bin_path)
      @mkvmerge = Modules::MkvMerge.new(bin_path)
      @mkvpropedit = Modules::MkvPropEdit.new(bin_path)
      @mkvextract = Modules::MkvExtract.new(bin_path)
    end

    def abort_at_warning(abort = true)
      @mkvpropedit.abort_at_warning = abort
      @mkvextract.abort_at_warning = abort
      self
    end

    def disable_language_ietf(disabled = true)
      @mkvpropedit.disable_language_ietf = disabled
      self
    end
  end
end

# a = MkvToolNix::Types::PropEdit::AudioProperty
# b = a.find_property('codec-name')
# puts a
# e = MkvToolNix::Types::PropEdit::SubtitleProperty::CODEC_ID
# mkv = MkvToolNix.init.abort_at_warning
# ext = mkv.mkvextract
# ext.extract_tracks('/Users/chris/mkv/full_fields/Axel.mkv', [MkvToolNix::Types::Extract::Track.new(1, '/Users/chris/mkv/full_fields/out.eac3')])
# pe = mkv.mkvpropedit
# # puts pe.version
# # pe.remove_property('/Users/chris/mkv/full_fields/Axel.mkv', 'track:2', ['name', 'language'], full_parse_mode: true)
# pe.set_property('/Users/chris/mkv/full_fields/Axel.mkv', MkvToolNix::PropEditSelector.for_nth_audio(1), 'language', 'eng')
# pe.update_attachment('/Users/chris/mkv/full_fields/Axel.mkv', '1', 'new name', '--update-attachment', '12345', 'jpeg/jpg')
# merge = mkv.mkvmerge
# version =  merge.version
# res = merge.info('/Users/chris/mkv/Neighbors_att.mkv')
# puts res
# file = '/Users/chris/mkv/Axel.mkv'
# cmd = ['mkvmerge', '-J', file]
#
# out = ''
# Open3.popen3(*cmd) do |_, stdout, _, thread|
#   out = stdout.read
# end
#
# puts out
#
# json = JSON.parse(out)
#
# tracks = json['tracks']
# puts tracks