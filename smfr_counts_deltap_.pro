pro smfr_counts_deltaP_

  ;======= [MMS] hist delta_pressure vs # of evnets [statistics] =================
  ;file = '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list/pressure/averaged/MMS_SMFR_ALLeventlist_diff_pressure_sorted_ge30min_pm10min_beginning_pm10min.csv'
  ;data = read_csv(file, n_table_header = 1)
  ;
  ;st = data.field1
  ;et = data.field2
  ;mid_t = data.field3
  ;dp = data.field4
  ;loc = data.field5
  ;nmp = data.field6
  ;err = data.field7
  ;
  ;hist = histogram(dp, min = -10, max = 10, loc = loc, binsize = 0.05)
  ;
  ;w = window(dimension = [600, 500])
  ;bp1 = barplot(loc, hist, /histogram, xrange = [-3, 3], yrange = [0, 70], pos = [0.2, 0.17, 0.9, 0.9], fill_color = 'gray', xtitle = '[MMS] $\Delta$p [nPa]', ytitle = 'Number of SMFR Events', font_size = 17, xtickinterval = 1, xminor = 4, ytickinterval = 10, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;t = text(0.24, 0.80, '(a)', 'black', font_size = 23, target = bp1)
  ;
  ;bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/School/paper1_statistics/plot/v2/figure8_a.png'
  ;stop

  ;======= [WIND] hist delta_pressure vs # of evnets [statistics] =================
  file = '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/WIND/stats_yr/pressure/averaged/WIND_SMFR_ALLeventlist_diff_pressure_ge30min_LT12hr_L1point_pm10min_beginning_wMMS_wo9999_pm10min.csv'
  data = read_csv(file, n_table_header = 1)

  st = data.field1
  et = data.field2
  mid_t = data.field3
  dp = data.field4
  loc = data.field5
  nmp = data.field6
  err = data.field7

  hist = histogram(dp, min = -10, max = 10, loc = loc, binsize = 0.05)
  w = window(dimension = [600, 500])
  bp1 = barplot(loc, hist, /histogram, xrange = [-3,3], yrange = [0, 1000], pos = [0.2, 0.17, 0.9, 0.9], fill_color = 'gray', xtitle = '[Wind] $\Delta$p [nPa]', ytitle = 'Number of SMFR Events', font_size = 17, xtickinterval = 1, xminor = 4, ytickinterval = 200, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
    t = text(0.24, 0.80, '(b)', 'black', font_size = 23, target = bp1)


  bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/School/paper1_statistics/plot/v2/figure8_b.png'
  stop



end