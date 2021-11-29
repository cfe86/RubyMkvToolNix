# frozen_string_literal: true

def run_mod(mod, expect_cmd: nil, ret_stdout: nil, ret_stderr: nil, ret_status: 0, raise_error: nil)
  mkvtoolnix = MkvToolNix.mkv_bin_path('')
  mod = mkvtoolnix.instance_variable_get(mod)

  if raise_error.nil?
    allow(mod).to receive(:call_cmd).and_return(MkvToolNix::Modules::MkvModule::CmdResult.new(ret_stdout, ret_stderr,
                                                                                              ret_status))
  else
    allow(mod).to receive(:call_cmd).and_raise(raise_error)
  end

  expect(mod).to receive(:call_cmd).with(expect_cmd) unless expect_cmd.nil?

  mod
end
