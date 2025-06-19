local toolchain_version = '14.2.0-3.1'
local sdkdir = '~/.local/xPacks/@xpack-dev-tools/riscv-none-elf-gcc/' .. toolchain_version .. '/.content/'
on_load(function()
  os.exec('xpm install @xpack-dev-tools/riscv-none-elf-gcc@' .. toolchain_version .. ' -g -s')
end)

toolchain('gcc-riscv')
set_kind('standalone')
set_sdkdir(sdkdir)
add_cxflags('-march=rv32ec_zicsr', '-mabi=ilp32e')
add_ldflags('-march=rv32ec', '-mabi=ilp32e')
toolchain_end()
