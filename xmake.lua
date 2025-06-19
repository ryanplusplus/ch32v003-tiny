includes('xmake.toolchain.lua')

set_toolchains('gcc-riscv')

add_cxflags(
  '-march=rv32ec_zicsr',
  '-mabi=ilp32e',
  { force = true }
)

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
  '-march=rv32ec',
  '-mabi=ilp32e',
  '-nostartfiles',
  '-T ch32v00x.ld',
  '-Wl,--gc-sections',
  '-Wl,-Map,$(buildir)/$(plat)/$(arch)/$(mode)/ch32v003.map',
  '--specs=nano.specs',
  '--specs=nosys.specs',
  { force = true }
)

target('tiny')
  set_kind('static')
  add_files('lib/tiny/src/*.c')
  add_includedirs('lib/tiny/include', { public = true })

target('ch32v003') do
  set_kind('binary')
  add_deps('tiny')
  add_files('src/*.c')
  add_includedirs('src')
end
