includes('xpack.lua')
includes('openocd.lua')

xpack_toolchain('gcc-riscv', 'riscv-none-elf-gcc@14.2.0-3.1')
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
  '-Wl,-Map,$(builddir)/$(plat)/$(arch)/$(mode)/target.map',
  '--specs=nano.specs',
  '--specs=nosys.specs',
  { force = true }
)

target('tiny')
  set_kind('static')
  add_files('lib/tiny/src/*.c')
  add_includedirs('lib/tiny/include', { public = true })

target('target') do
  set_kind('binary')
  set_extension('.elf')
  add_deps('tiny')
  add_files('src/*.c')
  add_includedirs('src')
end

target('upload') do
  set_kind('phony')
  add_deps('target')
  add_rules('openocd-upload')
  set_values('upload-binfile-target', 'target')
end
