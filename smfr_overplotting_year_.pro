pro SMFR_overplotting_year_

  ;====== [MMS] to calculate dwell time each year =======
  file0 = '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_region_Intpl_Med_ALLphase.csv'
  data0 = read_csv(file0, n_table_header = 1)
  st0 = data0.field1
  et0 = data0.field2

  ;======= [WIND/MMS] [year] hist axial magnetic flux vs # of events [statistics] =================
  ;file = '/Users/ys/Desktop/Prac/SMFR/WIND/stats_yr/WIND_events_GE30min_LT12hr_L1point_wMMS.csv'
  ;file = '/Users/ys/Desktop/Prac/SMFR/WIND/stats_yr/WIND_events_GE30min_LT12hr_L1point.csv'
  file = '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_SMFR_ALLeventlist_parameters_sorted_ge30min.csv'
  data = read_csv(file, n_table_header = 1)
  st = data.field01
  et = data.field02
  ;  diameter = data.field04 ;WIND
  ;  axis_x = data.field09 ;WIND
  ;  axis_y = data.field10 ;WIND
  ;  axis_z = data.field11 ;WIND
  ;  avg_b = data.field14 ;WIND
  avg_b = data.field04 ;MMS
  axis_x = data.field05 ;MMS
  axis_y = data.field06 ;MMS
  axis_z = data.field07 ;MMS
  diameter = data.field11 ;MMS

  duration = (time_double(et) - time_double(st)) / 60.
  mf_b = !pi * (diameter/2.)^2 * avg_b
  mf_b_re = !pi * ((diameter/6378.)/2.)^2 * avg_b
  mf_bn = mf_b * axis_z
  mf_bn_re = mf_b_re * axis_z

  yr = ['2017', '2018', '2019', '2020', '2021', '2022', '2023']
  ;yr = ['2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022']

  n_mf_2004 = [] & n_mf_2005 = [] & n_mf_2006 = [] & n_mf_2007 = [] & n_mf_2008 = [] & n_mf_2009 = [] & n_mf_2010 = [] & n_mf_2011 = [] & $
    n_mf_2012 = [] & n_mf_2013 = [] & n_mf_2014 = [] & n_mf_2015 = [] & n_mf_2016 = []
  n_mf_2017 = [] & n_mf_2018 = [] & n_mf_2019 = [] & n_mf_2020 = [] & n_mf_2021 = [] & n_mf_2022 = [] & n_mf_2023 = []
  tt = [] & ttt  = []
  avg_tt = []

  for i = 0, yr.length-1 do begin
    ii = where(strmid(st, 0, 4) eq yr[i], tmp)
    if tmp eq 0 then continue
    avg_b_i = avg_b[ii]
    duration_i = duration[ii]
    diameter_i = diameter[ii]
    mf_b_i = mf_b[ii]
    mf_b_re_i = mf_b_re[ii]
    mf_bn_i = abs(mf_bn[ii])
    mf_bn_re_i = abs(mf_bn_re[ii])

    ;==== magnetic flux ==== (total magnetic flux, weighted average of magnetic flux, normalized weighted average of magnetic flux)
    ;==== axial magnetic flux, diameter too ====
    ;    d_range = []
    ;    dd_range = []
    ;
    ;    for d1= 4, 16 do begin     ; magnetic flux = [4, 16] and [10, 14]_2 and 0.5, axial magnetic flux = [4, 16] and [9, 13]_2 and 0.5, diameter = [2, 7] and [4.5, 6.5] and open all 'if' for 0.25, 0.5, 0.75
    ;      dd_range = [dd_range, d1]
    ;      ;if d1 ne 16 then dd_range = [dd_range, d1 + 0.25]
    ;      if d1 ne 16 then dd_range = [dd_range, d1 + 0.5]
    ;      ;if d1 ne 16 then dd_range = [dd_range, d1 + 0.75]
    ;    endfor
    ;
    ;    for d2 = 0, dd_range.length-1 do begin
    ;      d_range = [d_range, 10^(dd_range[d2])]
    ;    endfor
    ;
    ;    n_mf = []
    ;    for q1 = 0, d_range.length-2 do begin
    ;      idx1 = where(mf_bn_i ge d_range[q1] and mf_bn_i lt d_range[q1+1], tmp1)
    ;      n1 = idx1.length
    ;      if tmp1 eq 0 then n1 = 0
    ;      n_mf = [n_mf, n1]
    ;    endfor
    ;==== magnetic flux_re ====
    ;  d_range = []
    ;  dd_range = []
    ;
    ;  for d1= -3, 8 do begin
    ;    dd_range = [dd_range, d1]
    ;    ;if d1 ne 8 then dd_range = [dd_range, d1 + 0.25]
    ;    if d1 ne 8 then dd_range = [dd_range, d1 + 0.5]
    ;    ;if d1 ne 8 then dd_range = [dd_range, d1 + 0.75]
    ;  endfor
    ;
    ;  for d2 = 0, dd_range.length-1 do begin
    ;    d_range = [d_range, 10^(dd_range[d2])]
    ;  endfor
    ;  n_mf = []
    ;  for q2 = 0, d_range.length-2 do begin
    ;    idx2 = where(mf_b_re_i ge d_range[q2] and mf_b_re_i lt d_range[q2+1], tmp2)
    ;    n2 = idx2.length
    ;    if tmp2 eq 0 then n2 = 0
    ;    n_mf = [n_mf, n2]
    ;  endfor
    ;==== B magnitude (avg_B) ====
    n_mf = []
    binsize = 2.0
    hist1 = histogram(avg_b_i, min = 0, max = 55, loc = loc, binsize = binsize) ;[0, 55] and [0, 10]
    n_mf = [n_mf, hist1]
    ;==== duration ====
    ;    n_mf = []
    ;    binsize = 15
    ;    hist1 = histogram(duration_i, min = 30, max = 720, loc = loc, binsize = binsize) ;[0, 720], [0, 120]
    ;    n_mf = [n_mf, hist1]

    ;==== dwell time for MMS ====
    i0 = where(strmid(st0, 0, 4) eq yr[i], tmp0)
    if tmp0 eq 0 then continue
    st0_i = st0[i0]
    et0_i = et0[i0]

    d_time = []
    for j = 0, i0.length-1 do begin
      each_time = time_double(et0_i[j]) - time_double(st0_i[j])
      d_time = [d_time, each_time / 60.]
    endfor
    dwell_time0 = total(d_time);[min]
    if yr[i] eq 2020 then dwell_time = dwell_time0 * (1./(60.*24.*366.)) else dwell_time = dwell_time0 * (1./(60.*24.*365.));[year]
    ;  ;==== dwell time for WIND ====
    ;if yr[i] eq 2004 then dwell_time = 0.5 else dwell_time = 1.
    ;  ;=============================
    ;    if yr[i] eq 2004 then n_mf_2004 = n_mf / dwell_time
    ;    if yr[i] eq 2005 then n_mf_2005 = n_mf / dwell_time
    ;    if yr[i] eq 2006 then n_mf_2006 = n_mf / dwell_time
    ;    if yr[i] eq 2007 then n_mf_2007 = n_mf / dwell_time
    ;    if yr[i] eq 2008 then n_mf_2008 = n_mf / dwell_time
    ;    if yr[i] eq 2009 then n_mf_2009 = n_mf / dwell_time
    ;    if yr[i] eq 2010 then n_mf_2010 = n_mf / dwell_time
    ;    if yr[i] eq 2011 then n_mf_2011 = n_mf / dwell_time
    ;    if yr[i] eq 2012 then n_mf_2012 = n_mf / dwell_time
    ;    if yr[i] eq 2013 then n_mf_2013 = n_mf / dwell_time
    ;    if yr[i] eq 2014 then n_mf_2014 = n_mf / dwell_time
    ;    if yr[i] eq 2015 then n_mf_2015 = n_mf / dwell_time
    ;    if yr[i] eq 2016 then n_mf_2016 = n_mf / dwell_time
    if yr[i] eq 2017 then n_mf_2017 = n_mf / dwell_time
    if yr[i] eq 2018 then n_mf_2018 = n_mf / dwell_time
    if yr[i] eq 2019 then n_mf_2019 = n_mf / dwell_time
    if yr[i] eq 2020 then n_mf_2020 = n_mf / dwell_time
    if yr[i] eq 2021 then n_mf_2021 = n_mf / dwell_time
    if yr[i] eq 2022 then n_mf_2022 = n_mf / dwell_time
    if yr[i] eq 2023 then n_mf_2023 = n_mf / dwell_time
    ;  tt = [tt, total((d_range[0:-2]) * (n_mf / dwell_time))]
    ;  avg_tt = [avg_tt, total((d_range[0:-2]) * (n_mf / dwell_time)) / total(n_mf /dwell_time)]
  endfor

  ;==== magnetic flux ==== total magnetic flux, weighted average of magnetic flux, normalized weighted average of magnetic flux
  ;;for the whole WIND data at the L1 point
  ;p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2004, 'orange', position = [0.17, 0.17, 0.93, 0.93], xrange = [15,19],xtitle = '[Wind] Magnetic flux '+'$\Phi$'+' [Mx, /log]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 3, xtickinterval = 1, ytickinterval = 100, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)
  ;MMS data
  ;p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2017, 'green', position = [0.17, 0.17, 0.93, 0.93], xrange = [15, 19], xtitle = '[MMS] Magnetic flux '+'$\Phi$'+' [Mx, /log]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 3, xtickinterval = 1, ytickinterval = 100, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)
  ;;==== axial magnetic flux ====
  ;for the whole WIND data at the L1 point
  ;p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2004, 'orange', position = [0.17, 0.17, 0.93, 0.93], xrange = [14, 18], xtitle = '[Wind] Axial magnetic flux '+'$\Phi$'+' [Mx, /log]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 3, xtickinterval = 1, ytickinterval = 100, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)
  ;MMS data
  ;p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2017, 'green', position = [0.17, 0.17, 0.93, 0.93], xrange = [14, 18], xtitle = '[MMS] Axial magnetic flux '+'$\Phi$'+' [Mx, /log]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 3, xtickinterval = 1, ytickinterval = 100, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)
  ;;==== diameter ====
  ;for the whole WIND data at the L1 point
  ;p = plot(alog10(d_range[0:-2]), n_mf_2004, 'orange', position = [0.17, 0.17, 0.93, 0.93], xrange = [4.5, 6.5], xtitle = '[Wind] Diameter [km, /log]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 3, xtickinterval = 1, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)
  ;MMS data
  ;p = plot(alog10(d_range[0:-2]), n_mf_2017, 'green', position = [0.17, 0.17, 0.93, 0.93], xrange = [4.5, 6.5], xtitle = '[MMS] Diameter [km, /log]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 3, yminor = 4, xtickinterval = 1, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)
  ;;==== B magnitude ====
  ;for the whole WIND data at the L1 point
  ;p = plot(loc, n_mf_2004, 'orange', position = [0.17, 0.17, 0.93, 0.93], xrange = [0, 10], xtitle = '[Wind] B magnitude [nT]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 1, xtickinterval = 2, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)
  ;MMS data
  p = plot(loc, n_mf_2017, 'green', position = [0.17, 0.17, 0.93, 0.93], xrange = [0, 10], xtitle = '[MMS] B magnitude [nT]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 1, yminor = 4, xtickinterval = 2, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)
  ;;==== duration ====
  ;for the whole WIND data at the L1 point
  ;p = plot(loc, n_mf_2004, 'orange', position = [0.17, 0.17, 0.93, 0.93], xrange = [30, 120], yrange = [0, 700], xtitle = '[Wind] Duration [min]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 2, yminor = 4, xtickinterval = 30, ytickinterval = 100, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)
  ;MMS data
  ;p = plot(loc, n_mf_2017, 'green', position = [0.17, 0.17, 0.93, 0.93], xrange = [30, 120], yrange = [0, 700], xtitle = '[MMS] Duration [min]', ytitle = 'Number of SMFR Events [Counts/year]', font_size = 17, xminor = 2, yminor = 4, xtickinterval = 30, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1)

  ;==== magnetic flux, axial magnetic flux, diameter ====
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2005, 'yellow', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2006, 'green', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2007, 'blue', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2008, 'navy', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2009, 'purple', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2010, 'cyan', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2011, 'peru', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2012, 'magenta', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2013, 'black', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2014, 'red', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2015, 'orange', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2016, 'yellow', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2017, 'green', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2018, 'blue', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2019, 'navy', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2020, 'purple', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2021, 'cyan', /overplot)
  ;  p = plot(alog10(d_range[0:-2] * (10.^5.)), n_mf_2022, 'peru', /overplot)
  ;p = plot(alog10(d_range[0:-2] ), n_mf_2023, 'magenta', /overplot)

  ;==== magnitude, duration ====
  ;  p = plot(loc, n_mf_2005, 'yellow', /overplot)
  ;  p = plot(loc, n_mf_2006, 'green', /overplot)
  ;  p = plot(loc, n_mf_2007, 'blue', /overplot)
  ;  p = plot(loc, n_mf_2008, 'navy', /overplot)
  ;  p = plot(loc, n_mf_2009, 'purple', /overplot)
  ;  p = plot(loc, n_mf_2010, 'cyan', /overplot)
  ;  p = plot(loc, n_mf_2011, 'peru', /overplot)
  ;  p = plot(loc, n_mf_2012, 'magenta', /overplot)
  ;  p = plot(loc, n_mf_2013, 'black', /overplot)
  ;  p = plot(loc, n_mf_2014, 'red', /overplot)
  ;  p = plot(loc, n_mf_2015, 'orange', /overplot)
  ;  p = plot(loc, n_mf_2016, 'yellow', /overplot)
  ;  p = plot(loc, n_mf_2017, 'green', /overplot)
  p = plot(loc, n_mf_2018, 'blue', /overplot)
  p = plot(loc, n_mf_2019, 'navy', /overplot)
  p = plot(loc, n_mf_2020, 'purple', /overplot)
  p = plot(loc, n_mf_2021, 'cyan', /overplot)
  p = plot(loc, n_mf_2022, 'peru', /overplot)
  p = plot(loc, n_mf_2023, 'magenta', /overplot)
  ;========Wind text================
  ;  t = text(0.71, 0.85, '2004', 'orange', font_size = 15, target = p)
  ;  t = text(0.71, 0.81, '2005', 'yellow', font_size = 15, target = p)
  ;  t = text(0.71, 0.77, '2006', 'green', font_size = 15, target = p)
  ;  t = text(0.71, 0.73, '2007', 'blue', font_size = 15, target = p)
  ;  t = text(0.71, 0.69, '2008', 'navy', font_size = 15, target = p)
  ;  t = text(0.71, 0.65, '2009', 'purple', font_size = 15, target = p)
  ;  t = text(0.71, 0.61, '2010', 'cyan', font_size = 15, target = p)
  ;  t = text(0.71, 0.57, '2011', 'peru', font_size = 15, target = p)
  ;  t = text(0.71, 0.53, '2012', 'magenta', font_size = 15, target = p)
  ;
  ;  t = text(0.8, 0.85, '2013', 'black', font_size = 15, target = p)
  ;  t = text(0.8, 0.81, '2014', 'red', font_size = 15, target = p)
  ;  t = text(0.8, 0.77, '2015', 'orange', font_size = 15, target = p)
  ;  t = text(0.8, 0.73, '2016', 'yellow', font_size = 15, target = p)
  ;  t = text(0.8, 0.69, '2017', 'green', font_size = 15, target = pm)
  ;  t = text(0.8, 0.65, '2018', 'blue', font_size = 15, target = p)
  ;  t = text(0.8, 0.61, '2019', 'navy', font_size = 15, target = p)
  ;  t = text(0.8, 0.57, '2020', 'purple', font_size = 15, target = p)
  ;  t = text(0.8, 0.53, '2021', 'cyan', font_size = 15, target = p)
  ;  t = text(0.8, 0.49, '2022', 'peru', font_size = 15, target = p)
  ;  t = text(0.2, 0.85, '(j)', 'black', font_size = 23, target = p)
  ;=========MMS text============================
  t = text(0.8, 0.85, '2017', 'green', font_size = 15, target = pm)
  t = text(0.8, 0.81, '2018', 'blue', font_size = 15, target = p)
  t = text(0.8, 0.77, '2019', 'navy', font_size = 15, target = p)
  t = text(0.8, 0.73, '2020', 'purple', font_size = 15, target = p)
  t = text(0.8, 0.69, '2021', 'cyan', font_size = 15, target = p)
  t = text(0.8, 0.65, '2022', 'peru', font_size = 15, target = p)
  t = text(0.8, 0.61, '2023', 'magenta', font_size = 15, target = p)
  t = text(0.2, 0.85, '(c)', 'black', font_size = 23, target = p)

  ;p.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/School/paper1_statistics/plot/v2/figure6_c.png'

  stop
end