pro smfr_counts_parameters

  ;=======hist duration/averageB vs # of events=======
  file = '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/result_allphase_total_7sorted_ge30min_le720min_le1beta.csv'
  ;  ;file = '/Users/ys/Desktop/Prac/SMFR/WIND/stats_yr/WIND_events_GE30min_LT12hr_L1point_wMMS.csv'; WIND
  ;
  data = read_csv(file, n_table_header = 1)
  st = data.field01
  et = data.field02
  dur = data.field03
  avB = data.field04
  ve = data.field12
  de = data.field13
  diameter = data.field11
  axis_x = data.field05
  axis_y = data.field06
  axis_z = data.field07
  al = data.field08
  am = data.field09

  ;print, 'duration: ', min(dur), max(dur)
  ;print, 'avB: ', min(avB), max(avB)
  ;====duration====
  ;  hist = histogram(dur, min = 0, max = 700, loc = loc, binsize = 10)
  ;  w = window(dimension = [600, 500])
  ;  bp1 = barplot(loc, hist, /histogram, xrange = [0, 700], yrange = [0, 600], pos = [0.2, 0.17, 0.9, 0.9], fill_color = 'gray', xtitle = '[MMS] Duration [min]', ytitle = 'Number of SMFR Events', font_size = 17, xminor = 4, xtickinterval = 100, ytickinterval = 100, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;  ;bp1 = barplot(loc, hist, /histogram, xrange = [0, 700], yrange = [0, 2300], pos = [0.18, 0.15, 0.9, 0.9], fill_color = 'gray', title = '[WIND] 7432 SMFR events for Nov 2017 to Dec 2022', xtitle = '[WIND] Duration [min]', ytitle = 'Number of SMFR Events', font_size = 13, xminor = 4, xtickinterval = 100, ytickinterval = 200, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;  t = text(0.78, 0.79, '(a)', 'black', font_size = 23, target = bp1)
  ;  bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/plot/figure1_a.png'
  ;  stop
  ;====avB====
  ;    hist = histogram(avB, min = 0, max = 55, loc = loc, binsize = 1)
  ;    w = window(dimension = [600, 500])
  ;    bp1 = barplot(loc, hist, /histogram, xrange = [0, 55], yrange = [0, 600], pos = [0.2, 0.17, 0.9, 0.9], fill_color = 'gray', xtitle = '[MMS] B magnitude [nT]', ytitle = 'Number of SMFR Events', font_size = 17, xminor = 4, xtickinterval = 5, ytickinterval = 100, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;
  ;    t = text(0.78, 0.79, '(b)', 'black', font_size = 23, target = bp1)
  ;    bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/plot/figure1_b.png'
  ;    stop
  ;=======hist velocity vs # of events=================
  ;  ;print, 'velocity:', min(ve), max(ve)
  ;    hist = histogram(ve, min = 0, max = 700, loc = loc, binsize = 20)
  ;    w = window(dimension = [600, 500])
  ;    ;bp1 = barplot(loc, hist, /histogram, xrange = [0, 700], yrange = [0, 90], pos = [0.2, 0.17, 0.9, 0.9], fill_color = 'gray', xtitle = '[MMS] Speed [km/s]', ytitle = 'Number of SMFR Events', font_size = 17, xminor = 4, xtickinterval = 100, ytickinterval = 10, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;    bp1 = barplot(loc, hist, /histogram, xrange = [0, 700], yrange = [0, 300], pos = [0.2, 0.17, 0.9, 0.9], fill_color = 'gray', xtitle = '[MMS] Speed [km/s]', ytitle = 'Number of SMFR Events', font_size = 17, xminor = 4, xtickinterval = 100, ytickinterval = 50, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;    t = text(0.78, 0.79, '(c)', 'black', font_size = 23, target = bp1)
  ;
  ;    bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/plot/figure1_c.png'
  ;    stop
  ;;=======hist density vs # of evnets=================
  ;    ;print, min(de), max(de)
  ;    hist = histogram(de, min = 0, max = 25, loc = loc, binsize = 1)
  ;    w = window(dimension = [600, 500])
  ;    ;bp1 = barplot(loc, hist, /histogram, xrange = [0, 25], yrange = [0, 140], pos = [0.2, 0.17, 0.9, 0.9], fill_color = 'gray', xtitle = '[MMS] Density [n/cc]', ytitle = 'Number of SMFR Events', font_size = 17, xminor = 4, xtickinterval = 5, ytickinterval = 20, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;    bp1 = barplot(loc, hist, /histogram, xrange = [0, 25], yrange = [0, 450], pos = [0.2, 0.17, 0.9, 0.9], fill_color = 'gray', xtitle = '[MMS] Density [n/cc]', ytitle = 'Number of SMFR Events', font_size = 17, xminor = 4, xtickinterval = 5, ytickinterval = 50, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;    t = text(0.78, 0.79, '(d)', 'black', font_size = 23, target = bp1)
  ;    ;bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/plot/figure1_d.png'
  ;  stop
  ;=======hist diameter/Re vs # of events==========
  d_range = [1e2, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8]
  n_dia = []
  for q = 0, d_range.length-2 do begin
    idx = where(diameter ge d_range[q] and diameter lt d_range[q+1], tmp)
    n = idx.length
    if tmp eq 0 then n = 0
    n_dia = [n_dia, n]
  endfor
  ;  bp = barplot(alog10(d_range[0:-2]), n_dia, /histogram, fill_color = 'gray', xr = [1, 9], title = '[MMS] 2440 SMFR events for Nov 2017 to Dec 2023', xtitle = '[MMS] diameter [km] [log]', ytitle = 'Number of SMFR Events', font_size = 10, xminor = 0, xtickinterval = 1, ytickinterval = 500, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)

  re = diameter / 6378.
  hist1 = histogram(re, min = 0, max = 500, loc = loc, binsize = 10) ;max = 500
  ww = window(dimension = [600, 500]) ;make a plot square
  bp1 = barplot(loc, hist1, /histogram, xrange = [0, 500], yr = [0, 300], pos = [0.2, 0.17, 0.9, 0.9], fill_color = 'gray', xtitle = '[MMS] Diameter ['+'$R_E$'+']', ytitle = 'Number of SMFR Events', font_size = 17, xminor = 4, xtickinterval = 100, ytickinterval = 50, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  t = text(0.78, 0.79, '(e)', 'black', font_size = 23, target = bp1)
  ;bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/plot/figure1_e.png'
  stop
  ;======hist/scatter altitude vs azimuth=========
  ;    altitude = atan(sqrt(axis_x ^2 + axis_y ^2) / axis_z) * 180./!pi
  ;    azimuth = atan(axis_y / axis_x) * 180./!pi
  ;
  ;    azimuth_new = []
  ;    altitude_new = abs(altitude)
  ;    for i = 0, azimuth.length-1 do begin
  ;      if axis_y[i] gt 0. and axis_x[i] gt 0. then azimuth_new = [azimuth_new, azimuth[i]]
  ;      if axis_y[i] gt 0. and axis_x[i] lt 0. then azimuth_new = [azimuth_new, azimuth[i] + 180.]
  ;      if axis_y[i] lt 0. and axis_x[i] lt 0. then azimuth_new = [azimuth_new, azimuth[i] + 180.]
  ;      if axis_y[i] lt 0. and axis_x[i] gt 0. then azimuth_new = [azimuth_new, azimuth[i] + 360.]
  ;    endfor
  ;
  ;  ;  ;make a plot square
  ;    hist = histogram(altitude_new, min = 0, max = 90, loc = loc, binsize = 10.)
  ;    ;hist = histogram(al, min = 0, max = 90, loc = loc, binsize = 10.) ;some of "al" data have values over 90
  ;    w = window(dimension = [600, 500])
  ;    bp1 = barplot(loc, hist, /histogram, fill_color = 'gray', xr = [0,90], yr = [0, 800], pos = [0.2, 0.17, 0.9, 0.9], xtitle = '[MMS] Polar angle $\theta$ [$\deg$]', ytitle = 'Number of SMFR Events', font_size = 17, xminor = 0, xtickinterval = 10, ytickinterval = 100, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;    t = text(0.24, 0.79, '(f)', 'black', font_size = 23, target = bp1)
  ;    bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/plot/figure3_f.png'

  ;    hist = histogram(azimuth_new, min = 0, max = 360, loc = loc, binsize = 10.)
  ;    ;hist = histogram(am, min = 0, max = 360, loc = loc, binsize = 10.) ;some of "am" data have (-) values
  ;    w = window(dimension = [600, 500])
  ;    bp1 = barplot(loc, hist, /histogram, fill_color = 'gray', xr = [0,360], yr = [0, 160], pos = [0.2, 0.17, 0.9, 0.9], xtitle = '[MMS] Azimuthal angle $\phi$ [$\deg$]', ytitle = 'Number of SMFR Events', font_size = 17, xminor = 5, xtickinterval = 60, ytickinterval = 20, yminor = 3, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
  ;    t = text(0.24, 0.79, '(g)', 'black', font_size = 23, target = bp1)
  ;    bp1.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/plot/figure1_g.png'
  ;==================================================

  stop

end