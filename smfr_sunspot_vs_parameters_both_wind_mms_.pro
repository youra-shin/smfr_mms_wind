pro smfr_sunspot_vs_parameters_both_WIND_MMS_

  dir='/Users/ys/Desktop/Prac/Geo/sunspot/'

  file = dir + 'monthly.txt'
  readcol, file, year, month, fr, sn, sd, no ; date in fraction of year, standard deviation, number of observations

  yrs = []
  ct = []

  xrange = [2003, 2024]
  y_title = 'Total duration [min]' ;Total diameter [km, /log]' ;axial flux [nTkm^2*#ofevents/year [z], /log]
  yr = ['2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022', '2022', '2023']
  yr_mms = ['2017', '2018', '2019', '2020', '2021', '2022', '2022', '2023']

  for i = 2004, 2023 do begin ;for WIND, 2004, 2022 and for MMS, 2017, 2023
    idx = where(year eq i)
    nos = total(sn[idx], /nan)

    yrs = [yrs, i]
    ct = [ct, nos]
  endfor

  plot_margin = [0.15, 0.2, 0.15, 0.2]

  w = window(dimension = [1200, 500])
  p = plot(yrs, ct, xrange = xrange, 'b', axis_style = 1, margin = plot_margin, font_size = 17, thick = 2, $
    title = t_title, xtitle = 'Year', ytitle = 'Number of sunspots', Name = 'Sunspot number', $;WIND/26305 SMFRs or WIND/7432 SMFRs
    xminor = 1, xtickinterval = 2, ytickinterval = 500, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)

  ;===== [WIND] to make a frame of another y axis on the right
  ;total magnetic flux, weighted average of magnetic flux, normalized weighted average of magnetic flux
  ;axial magnetic flux, diameter
  ;  d_range = []
  ;  dd_range = []
  ;
  ;  for d1= 2, 7 do begin  ;magnetic flux = [4, 16] and [10, 14]_2, axial magnetic flux = [4, 16] and [9, 13]_2, diameter = [2, 7] and [4.5, 6.5] and open all 'if' for 0.25, 0.5, 0.75
  ;    dd_range = [dd_range, d1]
  ;    ;if d1 ne 7 then dd_range = [dd_range, d1 + 0.25]
  ;    if d1 ne 7 then dd_range = [dd_range, d1 + 0.5]
  ;    ;if d1 ne 7 then dd_range = [dd_range, d1 + 0.75]
  ;  endfor
  ;
  ;  for d2 = 0, dd_range.length-1 do begin
  ;    d_range = [d_range, 10^(dd_range[d2])]
  ;  endfor
  ;  rr = alog10(d_range[0:-2])
  ;==== magnitude, duration ====
  rr = findgen(56)
  ;=============================
  p0 =  plot(yrs, rr, /nodata, xrange = xrange, margin = plot_margin, axis_style = 0, $
    XTITLE="Year", xminor = 0, xtickinterval = 1,  xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)

  ap1 = axis('y', target = p0, location = [max(p.xrange), 0, 0], textpos = 1, tickfont_size = 17, minor = 0, title = y_title) ;delete this line while plotting for normalized, tickinterval

  ;====== [MMS] to calculate dwell time each year =======
  file0 = '/Users/ys/Desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_region_Intpl_Med_ALLphase.csv'
  data0 = read_csv(file0, n_table_header = 1)
  st0 = data0.field1
  et0 = data0.field2

  for sidx = 0, 1 do begin
    ;======= [WIND/MMS] [year] magnetic flux vs # of events [statistics] =================
    if sidx eq 0 then begin
      file = '/Users/ys/Desktop/Prac/SMFR/WIND/stats_yr/WIND_events_GE30min_LT12hr_L1point.csv'
      data = read_csv(file, n_table_header = 1)
      st = data.field01
      et = data.field02
      diameter = data.field04 ;WIND
      axis_x = data.field09 ;WIND
      axis_y = data.field10 ;WIND
      axis_z = data.field11 ;WIND
      avg_b = data.field14 ;WIND
    endif else begin
      file = '/Users/ys/Desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_SMFR_ALLeventlist_parameters_sorted_ge30min.csv'
      data = read_csv(file, n_table_header = 1)
      st = data.field01
      et = data.field02
      avg_b = data.field04 ;MMS
      axis_x = data.field05 ;MMS
      axis_y = data.field06 ;MMS
      axis_z = data.field07 ;MMS
      diameter = data.field11 ;MMS
    endelse

    duration = (time_double(et) - time_double(st)) / 60.
    mf_b = !pi * (diameter/2.)^2 * avg_b
    mf_b_re = !pi * ((diameter/6378.)/2.)^2 * avg_b
    mf_bn = mf_b * axis_z
    mf_bn_re = mf_b_re * axis_z

    n_mf_2004 = [] & n_mf_2005 = [] & n_mf_2006 = [] & n_mf_2007 = [] & n_mf_2008 = [] & n_mf_2009 = [] & n_mf_2010 = [] & n_mf_2011 = [] & $
      n_mf_2012 = [] & n_mf_2013 = [] & n_mf_2014 = [] & n_mf_2015 = [] & n_mf_2016 = []
    n_mf_2017 = [] & n_mf_2018 = [] & n_mf_2019 = [] & n_mf_2020 = [] & n_mf_2021 = [] & n_mf_2022 = [] & n_mf_2023 = []
    tt = [] & ttt = [] & avg_tt = []

    for i = 0, yr.length-1 do begin
      ii = where(strmid(st, 0, 4) eq yr[i], tmp)
      if tmp eq 0 then continue
      avg_b_i = avg_b[ii]
      duration_i = duration[ii]
      diameter_i = diameter[ii]
      mf_b_i = mf_b[ii]
      mf_b_re_i = mf_b_re[ii]
      mf_bn_i = mf_bn[ii]
      mf_bn_re_i = mf_bn_re[ii]
      ;==== magnetic flux ==== (total magnetic flux, weighted average of magnetic flux, normalized weighted average of magnetic flux)
      ;==== axial magnetic flux, diameter too ====
      ;      d_range = []
      ;      dd_range = []
      ;
      ;      for d1= 2, 7 do begin  ;; magnetic flux = [4, 16] and [10, 14]_2, axial magnetic flux = [4, 16] and [9, 13]_2, diameter = [2, 7] and [4.5, 6.5] and open all 'if' for 0.25, 0.5, 0.75
      ;        dd_range = [dd_range, d1]
      ;        ;if d1 ne 7 then dd_range = [dd_range, d1 + 0.25]
      ;        if d1 ne 7 then dd_range = [dd_range, d1 + 0.5]
      ;        ;if d1 ne 7 then dd_range = [dd_range, d1 + 0.75]
      ;      endfor
      ;
      ;      for d2 = 0, dd_range.length-1 do begin
      ;        d_range = [d_range, 10^(dd_range[d2])]
      ;      endfor
      ;
      ;      n_mf = []
      ;      for q1 = 0, d_range.length-2 do begin
      ;        idx1 = where(diameter_i ge d_range[q1] and diameter_i lt d_range[q1+1], tmp1)
      ;        n1 = idx1.length
      ;        if tmp1 eq 0 then n1 = 0
      ;        n_mf = [n_mf, n1]
      ;      endfor
      ;;==== B magnitude (avg_B) ====
      ;      n_mf = []
      ;      binsize = 2.0
      ;      hist1 = histogram(avg_b_i, min = 0, max = 55, loc = loc, binsize = binsize) ;[0, 55] and [0, 10]
      ;      n_mf = [n_mf, hist1]
      ;==== duration ====
      n_mf = []
      binsize = 30
      hist1 = histogram(duration_i, min = 30, max = 720, loc = loc, binsize = binsize) ;[0, 720], [0, 120]
      n_mf = [n_mf, hist1]
      ;============================

      ;======== dwell_time ========
      if sidx eq 0 then begin
        if yr[i] eq 2004 then dwell_time = 0.5 else dwell_time = 1.
      endif else begin
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
      endelse

      ;==== magnetic flux, axial magnetic flux, diameter ====
      ;tt = [tt, total((d_range[0:-2]) * (n_mf / dwell_time))] ;for magnetic flux/axial magnetic flux in Mx unit: * (10.^5.)
      ;==== magnitude, duration ====
      tt = [tt, total(loc * (n_mf / dwell_time))] ;total

    endfor

    ;==== magnetic flux, axial magnetic flux, diameter ====
    ;a3 = alog10(tt) ;total
    ;==== magnitude, duration ====
    a3 = tt  ;total, for duration: / 60. / 24. for days in unit

    if sidx eq 0 then p1 = plot(float(yr), a3, thick = 2, Name = 'Wind', yminor = 4, /overplot) else p2 = plot(float(yr_mms), a3, 'r', thick = 2, Name = 'MMS', /overplot) ;total
    ;magnetic flux: bin = 0.5: yrange = [20.3, 21.001], ytickinterval = 0.2, yminor = 1 // bin = 0.25: yrange = [20.4, 21.2], ytickinterval = 0.2, yminor = 1
    ;diameter: yrange = [8.74, 8.92], ytickinterval = 0.04, yminor = 3
    print, max(a3), min(a3)
  endfor

  leg = legend(target = [p, p1, p2],  position = [0.42, 0.87], transparency = 50, font_size = 15, /auto_text_color)
  t = text(0.17, 0.8, '(e)', 'black', font_size = 23, target = p)

  p.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/School/paper1_statistics/plot/v2/figure7_e_min.png'

  stop
end