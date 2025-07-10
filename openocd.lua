rule('openocd-flash') do
  on_run(function(target)
    import('core.base.option')
    local binfile = target:targetfile()
    print('Flashing ' .. binfile .. ' using OpenOCD...')
  end)
end
