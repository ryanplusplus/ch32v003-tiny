local xpack_sdk = '~/.local/xPacks/@xpack-dev-tools/riscv-none-elf-gcc/14.2.0-3.1/.content/'
before_build(function()
  os.exec('xpm install @xpack-dev-tools/riscv-none-elf-gcc@14.2.0-3.1 -g -s')
end)

toolchain('gcc-riscv')
  set_kind('standalone')
  set_sdkdir(xpack_sdk)
  add_cxflags('-march=rv32ec_zicsr', '-mabi=ilp32e')
  add_ldflags('-march=rv32ec', '-mabi=ilp32e')
toolchain_end()

target('ch32v003')
  set_kind('binary')
  add_files('src/*.c')
  add_includedirs('src')

  set_toolchains('gcc-riscv')

  add_cflags(
    '-Os',
    '-ffunction-sections',
    '-fdata-sections',
    '-Wall',
    '-Wextra',
    '-Werror',
    '-g'
  )

  add_ldflags(
    '-nostartfiles',
    '-T ch32v00x.ld',
    '-Wl,--gc-sections',
    '-Wl,-Map,$(builddir)/$(plat)/$(arch)/$(mode)/ch32v003.map',
    '--specs=nano.specs',
    '--specs=nosys.specs'
  )
