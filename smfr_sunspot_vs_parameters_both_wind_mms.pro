pro SMFR_sunspot_vs_parameters_both_WIND_MMS

;if you don't know what exact numbers should be for inputs, refer to "SMFR_sunspot_vs_parameters.pro" and "SMFR_overplotting_year.pro".
;total_[parameters] => the entire period from 2004 to 2023
;weighted/normalized_[parameters] => only from 2017 to 2023 to compare MMS with WIND

dir='/Users/ys/Desktop/Prac/Geo/sunspot/'

file = dir + 'monthly.txt'
readcol, file, year, month, fr, sn, sd, no ; date in fraction of year, standard deviation, number of observations

yrs = []
ct = []

xrange = [2016, 2024]
y_title = 'diameter [km*#ofevents/year]' ;axial flux [nTkm^2*#ofevents/year [z], /log]
t_title = '[WIND/7432 SMFRs and MMS/2440 SMFRs]' ;[WIND/26305 SMFRs and MMS/2440 SMFRs] or [WIND/7432 SMFRs and MMS/2440 SMFRs]
;yr = ['2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022', '2022', '2023']
yr = ['2017', '2018', '2019', '2020', '2021', '2022', '2022', '2023']
yr_mms = ['2017', '2018', '2019', '2020', '2021', '2022', '2022', '2023']

for i = 2017, 2023 do begin ;for WIND, 2004, 2022 and for MMS, 2017, 2023
  idx = where(year eq i)
  nos = total(sn[idx], /nan)

  yrs = [yrs, i]
  ct = [ct, nos]
endfor

plot_margin = [0.1, 0.2, 0.2, 0.2]

w = window(dimension = [1200, 400])
p = plot(yrs, ct, xrange = xrange, 'b', axis_style = 1, margin = plot_margin, font_size = 11, $
  title = t_title, xtitle = 'year', ytitle = '# of sunspot', $;WIND/26305 SMFRs or WIND/7432 SMFRs
  xminor = 1, xtickinterval = 2, ytickinterval = 200, yminor = 4, xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)

;===== [WIND] to make a frame of another y axis on the right
;total magnetic flux, weighted average of magnetic flux, normalized weighted average of magnetic flux
;axial magnetic flux, diameter
d_range = []
dd_range = []

for d1= 2, 7 do begin  ;magnetic flux = [4, 16] and [10, 14]_2, axial magnetic flux = [4, 16] and [9, 13]_2, diameter = [2, 7] and [4.5, 6.5]
  dd_range = [dd_range, d1]
  ;if d1 ne 16 then dd_range = [dd_range, d1 + 0.25]
  if d1 ne 16 then dd_range = [dd_range, d1 + 0.5]
  ;if d1 ne 16 then dd_range = [dd_range, d1 + 0.75]
endfor

for d2 = 0, dd_range.length-1 do begin
  d_range = [d_range, 10^(dd_range[d2])]
endfor
rr = alog10(d_range[0:-2])
;==== magnitude, duration ====
;rr = findgen(56)
;=============================
p =  plot(yrs, rr, /nodata, xrange = xrange, yrange = [5.65, 5.77], margin = plot_margin, axis_style = 0, $
  XTITLE="year", xminor = 0, xtickinterval = 1,  xticklen = 0.02, yticklen = 0.02, xtickdir = 1, ytickdir = 1, /current)
;ap1 = axis('y', target = p, location = [max(p.xrange), 0, 0], textpos = 1, tickfont_size = 11, tickinterval = 0.02, minor = 0, title = y_title) ;delete this line while plotting for normalized

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
    ;print, max(alog10(diameter_i))
    ;==== magnetic flux ==== (total magnetic flux, weighted average of magnetic flux, normalized weighted average of magnetic flux)
    ;==== axial magnetic flux, diameter too ====   
    d_range = []
    dd_range = []

    for d1= 2, 7 do begin  ;; magnetic flux = [4, 16] and [10, 14]_2, axial magnetic flux = [4, 16] and [9, 13]_2, diameter = [2, 7] and [4.5, 6.5]
      dd_range = [dd_range, d1]
      ;if d1 ne 16 then dd_range = [dd_range, d1 + 0.25]
      if d1 ne 16 then dd_range = [dd_range, d1 + 0.5]
      ;if d1 ne 16 then dd_range = [dd_range, d1 + 0.75]
    endfor

    for d2 = 0, dd_range.length-1 do begin
      d_range = [d_range, 10^(dd_range[d2])]
    endfor

    n_mf = []
    for q1 = 0, d_range.length-2 do begin
      idx1 = where(diameter_i ge d_range[q1] and diameter_i lt d_range[q1+1], tmp1)
      n1 = idx1.length
      if tmp1 eq 0 then n1 = 0
      n_mf = [n_mf, n1]
    endfor
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
    ;;==== B magnitude (avg_B) ====
    ;n_mf = []
    ;binsize = 2.0
    ;hist1 = histogram(avg_b_i, min = 0, max = 55, loc = loc, binsize = binsize) ;[0, 55] and [0, 10]
    ;n_mf = [n_mf, hist1]
    ;==== duration ====
    ;n_mf = []
    ;binsize = 30
    ;hist1 = histogram(duration_i, min = 30, max = 720, loc = loc, binsize = binsize) ;[0, 720], [0, 120]
    ;n_mf = [n_mf, hist1]
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
    ;=============================
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
;    if yr[i] eq 2017 then n_mf_2017 = n_mf / dwell_time
;    if yr[i] eq 2018 then n_mf_2018 = n_mf / dwell_time
;    if yr[i] eq 2019 then n_mf_2019 = n_mf / dwell_time
;    if yr[i] eq 2020 then n_mf_2020 = n_mf / dwell_time
;    if yr[i] eq 2021 then n_mf_2021 = n_mf / dwell_time
;    if yr[i] eq 2022 then n_mf_2022 = n_mf / dwell_time
;    if yr[i] eq 2023 then n_mf_2023 = n_mf / dwell_time
    ;==== magnetic flux, axial magnetic flux, diameter ====
    tt = [tt, total((d_range[0:-2]) * (n_mf / dwell_time))] ;total
    avg_tt = [avg_tt, total((d_range[0:-2]) * (n_mf / dwell_time)) / total(n_mf /dwell_time)] ;weighted average
    ;==== magnitude, duration ====
    ;tt = [tt, total(loc * (n_mf / dwell_time))] ;total
    ;avg_tt = [avg_tt, total(loc * (n_mf / dwell_time)) / total(n_mf /dwell_time)] ;weighted average

  endfor
  
  ;==== magnetic flux, axial magnetic flux, diameter ====
  a1 = alog10(avg_tt) ;weighted
  a3 = alog10(tt) ;total
  ;==== magnitude, duration ====
  ;a1 = avg_tt ;weighted
  ;a3 = tt  ;total
  ;=============================
  print, max(a1), min(a1)
  a2 = (a1 - min(a1))/(max(a1)-min(a1)) ;normalized
  print, a2
  
;  if sidx eq 0 then p1 = plot(float(yr), a3, /overplot) else p1 = plot(float(yr_mms), a3, 'r', /overplot) ;total  
;  if sidx eq 0 then p = plot(float(yr), a1, /overplot) else p = plot(float(yr_mms), a1, 'r', /overplot) ;weighted
  if sidx eq 0 then p1 = plot(float(yr), a2, /overplot) else p1 = plot(float(yr_mms), a2, 'r', /overplot) ;normalized 
  if sidx eq 0 then p = plot(float(yr), a2, 'black', XRANGE=xrange, yrange = [0, 1],  margin = plot_margin, axis_style = 0, /current) $ ;normalized
    else p3 = plot(float(yr_mms), a2, 'r', XRANGE=xrange, yrange = [0, 1],  margin = plot_margin, axis_style = 0, /current) ;normalized
endfor
  ap2 = axis('y', target = p1, location = [max(p.xrange), 0, 0], textpos = 1, tickfont_size = 11, tickinterval = 0.2, minor = 4, title = 'normalized weighted average') ;normalized

t = text(0.35, 0.75, '# of sunspot', 'blue', target = p)
t = text(0.35, 0.71, 'WIND: normalized weighted average of diameter', 'black', target = p) ;normalized weighted average of axial magnetic flux
t = text(0.35, 0.67, 'MMS: normalized weighted average of diameter', 'red', target = p) ;normalized weighted average of axial magnetic flux
;total magnetic flux, weighted average of magnetic flux, normalized weighted average of magnetic flux
stop
p.save, '/Users/ys/Desktop/Prac/SMFR/plot/WIMD_MMS/vs_sunspot/diameter/plot_WIND_MMS_SMFR_ge30min_LT12hr_L1point_sunspot_diameter_km_bin0.5_normalized.png'
stop
end