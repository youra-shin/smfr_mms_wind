pro smfr_occurrence_year_

  ;============[norm] hist Year vs # of events=======================
  yr = ['2017', '2018', '2019', '2020', '2021', '2022', '2023']
  ;yr = ['2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022']
  file1 = '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_SMFR_ALLeventlist_parameters_sorted_ge30min.csv' ;MMS
  ;file1 = '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/WIND/stats_yr/WIND_events_GE30min_LT12hr_L1point.csv' ;WIND from 2004 to 2022
  data1 = read_csv(file1, n_table_header = 1)
  st = data1.field01
  et = data1.field02
  file2 = '/Users/ys/Desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_region_Intpl_Med_ALLphase.csv'                   ;MMS
  data2 = read_csv(file2, n_table_header = 1)
  st_sw = data2.field1
  et_sw = data2.field2

  co_norm = []
  for i = 0, yr.length-1 do begin
    idx = where(strmid(st, 0, 4) eq yr[i], tmp)
    print, yr[i], ':', idx.length
    if tmp eq 0 then continue
    st_i = st[idx]
    ;===MMS===
    idx_sw = where(strmid(st_sw, 0, 4) eq yr[i], tmp)
    if tmp eq 0 then continue
    st_sw_i = st_sw[idx_sw]
    et_sw_i = et_sw[idx_sw]
    d_time = []
    for j = 0, idx_sw.length-1 do begin
      each_time = time_double(et_sw_i[j]) - time_double(st_sw_i[j])
      d_time = [d_time, each_time]
    endfor
    dwell_time0 = total(d_time);[sec]
    ;===WIND===
    ;    if yr[i] eq '2004' then st_sw_i = '2004-07-01/00:00:00' else st_sw_i = yr[i] + '-01-01/00:00:00'   ;WIND from 2004 to 2022
    ;    et_sw_i = yr[i] + '-12-31/23:59:59'
    ;    dwell_time0 = time_double(et_sw_i) - time_double(st_sw_i)
    ;==========

    ;if tmp eq 0 then cal = 0.
    if yr[i] eq 2020 then dwell_time = dwell_time0 * (1./(60.*60.*24.*366.)) else dwell_time = dwell_time0 * (1./(60.*60.*24.*365.));[year]
    co = st_i.length / dwell_time
    co_norm = [co_norm, co]


  endfor

  year = double(yr)-0.5
  ;=====Wind=====
  ;w = window(dimension = [700, 600]) ;xr = [2016, 2024], xr = [2003, 2024]
  ;bp1 = barplot(year, co_norm, /histogram, xr = [2003, 2023], yr = [0, 2000], position = [0.2, 0.15, 0.93, 0.9], fill_color = 'gray', xtitle = '[Wind] Year', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xtickinterval = 3, xminor = 2, yminor = 4, ticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;=====MMS====
  ticks = [2017, 2019, 2021, 2023]
  w = window(dimension = [700, 600])
  ;bp1 = barplot(year, co_norm, /histogram, xr = [2016, 2024], yr = [0, 2000], position = [0.2, 0.15, 0.93, 0.9], fill_color = 'gray', xtitle = '[MMS] Year', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xtickinterval = 2, xminor = 1, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  bp1 = barplot(year, co_norm, /histogram, xr = [2016, 2024], yr = [0, 2000], position = [0.2, 0.15, 0.93, 0.9], fill_color = 'gray', xtitle = '[MMS] Year', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xtickvalues = ticks, xminor = 1, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  t = text(0.23, 0.81, '(a)', 'black', font_size = 23, target = bp1)
  stop
  ;bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/School/paper1_statistics/plot/v2/figure5_a.png'

  stop
  ;==================================================================
  ;
end