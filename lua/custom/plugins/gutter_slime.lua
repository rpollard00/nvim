return {
  {
    {
      'rpollard00/gutter-slime.nvim',
      config = function()
        require('gutter-slime').setup {
          old_days = 14,
          curve = 'recent',
          bucket_mode = 'relative_time',
          gradient = {
            style = 'vibrant',
          },
        }
      end,
    },
  },
}
