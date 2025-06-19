includes('xmake.toolchain.lua')

target('ch32v003') do
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
    '-Wl,-Map,$(buildir)/$(plat)/$(arch)/$(mode)/ch32v003.map',
    '--specs=nano.specs',
    '--specs=nosys.specs'
  )
end
