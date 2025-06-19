function xpack_toolchain(name, which)
  local toolchain_type = which:match('([^@]+)')
  local toolchain_version = which:match('@(.+)')

  on_load(function()
    os.exec('xpm install @xpack-dev-tools/' .. toolchain_type .. '@' .. toolchain_version .. ' -g -s')
  end)

  toolchain(name)
  set_kind('standalone')
  set_sdkdir('~/.local/xPacks/@xpack-dev-tools/' .. toolchain_type .. '/' .. toolchain_version .. '/.content/')
  toolchain_end()
end
