# frozen_string_literal: true

module MkvToolNix
  module Modules

    module MkvModule

      def call_cmd(cmd)
        status, out, err = nil
        Open3.popen3(*cmd) do |_, stdout, stderr, thread|
          out = stdout.read
          err = stderr.read
          status = thread.value
        end

        raise Errors::MkvToolNixError, out if status != 0

        CmdResult.new(out, err, status)
      end

      class CmdResult

        attr_reader :stdout, :stderr, :status

        def initialize(stdout, stderr, status)
          @stdout = stdout
          @stderr = stderr
          @status = status
        end

        def error?
          status != 0
        end
      end
    end
  end
end
