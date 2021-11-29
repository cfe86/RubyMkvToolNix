# frozen_string_literal: true

module MkvToolNix
  module Modules
    # https://mkvtoolnix.download/doc/mkvmerge.html
    class MkvMerge
      include MkvModule

      def initialize(bin_path)
        @bin_path = "#{bin_path}mkvmerge"
      end

      def version
        cmd = [@bin_path, '-V']

        result = call_cmd(cmd)

        result.stdout.strip
      end

      def info(file)
        cmd = [@bin_path, '-J']
        # cmd = [@bin_path, '--identififcation-format', 'json', '--identify']
        cmd << file

        result = call_cmd(cmd)

        json = JSON.parse(result.stdout)
        Types::Info::MkvContainer.create(json)
      end
    end
  end
end
