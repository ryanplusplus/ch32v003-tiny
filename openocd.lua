rule('openocd-upload') do
  on_run(function(target)
    local binfile do
      local binfile_target = target:values('upload-binfile-target')
      if binfile_target then
        binfile = target:dep(binfile_target):targetfile()
      else
        binfile = target:targetfile()
      end
    end

    print('Flashing ' .. binfile .. ' using OpenOCD...')
  end)
end
