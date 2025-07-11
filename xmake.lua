includes('xpack.lua')
includes('openocd.lua')

xpack_toolchain('gcc-riscv', 'riscv-none-elf-gcc@14.2.0-3.1')
set_toolchains('gcc-riscv')

add_asflags(
  '-march=rv32ec_zicsr',
  '-mabi=ilp32e',
  { force = true }
)

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
  '-march=rv32ec_zicsr',
  '-mabi=ilp32e',
  '-nostartfiles',
  '-T ch32v00x.ld',
  '-Wl,--gc-sections',
  '-Wl,-Map,$(builddir)/$(plat)/$(arch)/$(mode)/target.map',
  '--specs=nano.specs',
  '--specs=nosys.specs',
  { force = true }
)

target('tiny') do
  set_kind('static')
  add_files('lib/tiny/src/*.c')
  add_includedirs('lib/tiny/include', { public = true })
end

target('target') do
  set_kind('binary')
  set_extension('.elf')
  add_deps('tiny')
  add_files('lib/ch32v003/core_riscv.c')
  add_files('lib/ch32v003/debug.c', { cflags = { '-Wno-unused-parameter' } })
  add_files('lib/ch32v003/startup_ch32v00x.S')
  add_files('lib/ch32v003/system_ch32v00x.c')
  add_files('lib/ch32v003/ch32v00x_*.c')
  add_includedirs('lib/ch32v003')
  add_files('src/*.c')
  add_includedirs('src')
end

target('upload') do
  set_kind('phony')
  add_deps('target')
  add_rules('openocd-upload')
  set_values('upload-binfile-target', 'target')
end
