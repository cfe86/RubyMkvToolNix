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

require 'mkvtoolnix/types/extract/track'
require 'mkvtoolnix/types/extract/attachment'

require 'mkvtoolnix/types/info/mkv_container'
require 'mkvtoolnix/types/info/audio'
require 'mkvtoolnix/types/info/subtitle'
require 'mkvtoolnix/types/info/video'
require 'mkvtoolnix/types/info/attachment'

require 'mkvtoolnix/types/merge/attachment'
require 'mkvtoolnix/types/merge/chapter'
require 'mkvtoolnix/types/merge/input_track_options'
require 'mkvtoolnix/types/merge/input_file'
require 'mkvtoolnix/types/merge/output_control'
require 'mkvtoolnix/types/merge/segment_info'
require 'mkvtoolnix/types/merge/tags'

require 'mkvtoolnix/modules/mkvpropedit'
require 'mkvtoolnix/modules/mkvextract'
require 'mkvtoolnix/modules/mkvmerge'

module MkvToolNix

  def self.init
    mkv_bin_path('')
  end

  def self.mkv_bin_path(bin_path)
    bin_path = "#{bin_path}/" if !bin_path.empty? && !bin_path.end_with?('/')
    MkvToolNix.new(bin_path)
  end

  class MkvToolNix

    attr_reader :mkvmerge, :mkvpropedit, :mkvextract

    def initialize(bin_path)
      @mkvmerge = Modules::MkvMerge.new(bin_path)
      @mkvpropedit = Modules::MkvPropEdit.new(bin_path)
      @mkvextract = Modules::MkvExtract.new(bin_path)
    end

    def info(file)
      @mkvmerge.info(file)
    end

    def abort_at_warning(abort: true)
      @mkvpropedit.abort_at_warning = abort
      @mkvextract.abort_at_warning = abort
      self
    end

    def disable_language_ietf(disabled: true)
      @mkvpropedit.disable_language_ietf = disabled
      @mkvmerge.disable_language_ietf = disabled
      self
    end

    def default_language(language = 'und')
      @mkvmerge.default_language = language
    end
  end
end
