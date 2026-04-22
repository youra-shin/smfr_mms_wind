pro SMFR_occurrence_xyposition_map

  ;restore, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_SMFR_ALLevents_position_ge30min.sav'
  restore, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final_usingOMNI/result_allphase_total_8sorted_ge30min_le720min_le1beta_position.sav'

  file = '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_SMFR_ALLeventlist_parameters_sorted_ge30min.csv'
  data = read_csv(file, header = sedheader, n_table_header = 1, table_header = sedtableheader)

  x_re = pos_x / 6378. ;-1 < x_re < 29
  y_re = pos_y / 6378. ;-28 < y_re < 28
  z_re = pos_z / 6378. ;-11 < z_re < 9

  restore, '/Users/ys/Desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_SMFR_Intpl_MED_ALLphase_position.sav'
  x_re_ap = pos_x_ALLphase / 6378.
  y_re_ap = pos_y_ALLphase / 6378.
  z_re_ap = pos_z_ALLphase / 6378.
  stop
  ;====== X-Y plane ======
  ;    result_e = hist_2d(x_re, y_re, min1 = -5., max1 = 35., min2 = -35., max2 = 35., bin1 = 2.5, bin2 = 2.5) ;x = x_re and y = y_re for occurence rate
  ;    result_ap = hist_2d(x_re_ap, y_re_ap, min1 = -5., max1 = 35., min2 = -35., max2 = 35., bin1 = 2.5, bin2 = 2.5)
  ;
  ;
  ;    sz = size(result_e)
  ;    result_new = fltarr(sz[1], sz[2])
  ;    for i = 0, sz[1]-1 do begin
  ;      for j = 0, sz[2]-1 do begin
  ;        result_new[i, j] = float(result_e[i, j]) / float(result_ap[i, j])
  ;        if result_new[i, j] eq 0. then result_new[i, j] = !values.f_nan
  ;      endfor
  ;    endfor
  ;
  ;    ;remove the outliers
  ;    ;result_new[2079] = !values.f_nan ;the second biggest value ;bin = 1
  ;    ;result_new[430] = !values.f_nan ;the biggest value ;bin = 1
  ;    ;result_new[111] = !values.f_nan ;the second biggest value ;bin = 2.5
  ;    ;result_new[335] = !values.f_nan ;the biggest value ;bin = 2.5
  ;
  ;
  ;    ;xx = findgen(41) - 5.
  ;    ;yy = findgen(71) - 35.
  ;    xx = (findgen(17) - 2.) * 2.5
  ;    yy = (findgen(29) - 14.) * 2.5
  ;
  ;    ;occurence rate
  ;    ;d_min = 0.1
  ;    ;d_max = 0.32
  ;    d_min = 0.1
  ;    d_max = 0.35
  ;    p3 = spec_plot(result_new, xx, yy, xrange = [35, -5], yrange = [35, -35], xtitle = 'X_GSE [$R_E$]', ytitle = 'Y_GSE [$R_E$]', data_min = d_min, data_max = d_max, font_size = 17, aspect_ratio = 1, xminor = 4, yminor = 4) ;title = 'without the two biggest values'
  ;    cb = colorbar(target = p3, orientation = 1, title = '[MMS] Occurence rate', textpos = 1, minor = 0, position = [-9, 35, -13, -35], font_size = 17, border_on = 1, /data)
  ;    stop
  ;    p3.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/plot/figure4.png'
  ;    stop
  ;====== X-Z plane ======
  ;    result_e1 = hist_2d(x_re, z_re, min1 = -5., max1 = 35., min2 = -15., max2 = 15., bin1 = 2.5, bin2 = 2.5) ;x = x_re and z = z_re for occurence rate
  ;    result_ap1 = hist_2d(x_re_ap, z_re_ap, min1 = -5., max1 = 35., min2 = -15., max2 = 15., bin1 = 2.5, bin2 = 2.5)
  ;
  ;
  ;    sz1 = size(result_e1)
  ;    result_new1 = fltarr(sz1[1], sz1[2])
  ;    for i1 = 0, sz1[1]-1 do begin
  ;      for j1 = 0, sz1[2]-1 do begin
  ;        result_new1[i1, j1] = float(result_e1[i1, j1]) / float(result_ap1[i1, j1])
  ;        if result_new1[i1, j1] eq 0. then result_new1[i1, j1] = !values.f_nan
  ;      endfor
  ;    endfor
  ;
  ;    ;remove the outliers - it is not used for x-z plane
  ;    ;result_new[2079] = !values.f_nan ;the second biggest value ;bin = 1
  ;    ;result_new[430] = !values.f_nan ;the biggest value ;bin = 1
  ;    ;result_new1[111] = !values.f_nan ;the second biggest value ;bin = 2.5
  ;    ;result_new1[335] = !values.f_nan ;the biggest value ;bin = 2.5
  ;
  ;
  ;    ;xx1 = findgen(41) - 5.
  ;    ;zz1 = findgen(31) - 15.
  ;    xx1 = (findgen(17) - 2.) * 2.5
  ;    zz1 = (findgen(13) - 6.) * 2.5
  ;
  ;    ;occurence rate
  ;    d_min1 = 0.1
  ;    d_max1 = 0.35
  ;    p31 = spec_plot(result_new1, xx1, zz1, xrange = [35, -5], yrange = [-15, 15], xtitle = 'X_GSE [$R_E$]', ytitle = 'Z_GSE [$R_E$]', data_min = d_min1, data_max = d_max1, font_size = 17, aspect_ratio = 1, xminor = 4, yminor = 4) ;title = 'without the two biggest values'
  ;    cb1 = colorbar(target = p31, orientation = 1, title = '[MMS] Occurence rate', textpos = 1, minor = 0, position = [-7, -15, -11, 15], font_size = 17, border_on = 1, /data)
  ;
  ;    stop
  ;  ;  p31.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/School/paper1_statistics/plot/v2/figure4_xz.png'

  ;====== Y-Z plane ======
  ;      result_e2 = hist_2d(y_re, z_re, min1 = -35., max1 = 35., min2 = -15., max2 = 15., bin1 = 2.5, bin2 = 2.5) ;x = x_re and y = y_re for occurence rate
  ;      result_ap2 = hist_2d(y_re_ap, z_re_ap, min1 = -35., max1 = 35., min2 = -15., max2 = 15., bin1 = 2.5, bin2 = 2.5)
  ;
  ;
  ;      sz2 = size(result_e2)
  ;      result_new2 = fltarr(sz2[1], sz2[2])
  ;      for i2 = 0, sz2[1]-1 do begin
  ;        for j2 = 0, sz2[2]-1 do begin
  ;          result_new2[i2, j2] = float(result_e2[i2, j2]) / float(result_ap2[i2, j2])
  ;          if result_new2[i2, j2] eq 0. then result_new2[i2, j2] = !values.f_nan
  ;        endfor
  ;      endfor
  ;
  ;      ;remove the outliers
  ;      ;result_new[2079] = !values.f_nan ;the second biggest value ;bin = 1
  ;      ;result_new[430] = !values.f_nan ;the biggest value ;bin = 1
  ;      ;result_new[111] = !values.f_nan ;the second biggest value ;bin = 2.5
  ;      ;result_new[335] = !values.f_nan ;the biggest value ;bin = 2.5
  ;
  ;
  ;      ;yy2 = findgen(71) - 35.
  ;      ;zz2 = findgen(31) - 15.
  ;      yy2 = (findgen(29) - 14.) * 2.5
  ;      zz2 = (findgen(13) - 6.) * 2.5
  ;
  ;      ;occurence rate
  ;      d_min2 = 0.1
  ;      d_max2 = 0.35
  ;      p32 = spec_plot(result_new2, yy2, zz2, xrange = [-35, 35], yrange = [-15, 15], xtitle = 'Y_GSE [$R_E$]', ytitle = 'Z_GSE [$R_E$]', data_min = d_min2, data_max = d_max2, font_size = 17, aspect_ratio = 1, xminor = 4, yminor = 4) ;title = 'without the two biggest values'
  ;      cb2 = colorbar(target = p32, orientation = 1, title = '[MMS] Occurence rate', textpos = 1, minor = 0, position = [38, -15, 42, 15], font_size = 17, border_on = 1, /data)
  ;      stop
  ;      ;p32.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/School/paper1_statistics/plot/v2/figure4_yz.png'

  ;====== MMS time span ======
  result_ap3 = hist_2d(x_re_ap, y_re_ap, min1 = -10., max1 = 35., min2 = -35., max2 = 35., bin1 = 2.5, bin2 = 2.5)

  result_new3 = float(result_ap3)
  idx = where(result_new3 eq 0)
  result_new3[idx] = !values.F_nan

  ;  sz3 = size(result_ap3)
  ;  result_new3 = fltarr(sz3[1], sz3[2])
  ;  for i3 = 0, sz3[1]-1 do begin
  ;    for j3 = 0, sz3[2]-1 do begin
  ;      result_new3[i3, j3] = float(result_new3[i3, j3])
  ;      if result_new3[i3, j3] eq 0. then result_new3[i3, j3] = !values.f_nan
  ;    endfor
  ;  endfor

  ;xx3 = findgen(41) - 5.
  ;yy3 = findgen(71) - 35.
  ;xx3 = (findgen(17) - 2.) * 2.5
  xx3 = (findgen(19) - 4.) * 2.5
  yy3 = (findgen(29) - 14.) * 2.5

  d_min = min(result_new3)
  d_max = max(result_new3)
  p33 = spec_plot(result_new3, xx3, yy3, xrange = [35, -10], yrange = [35, -35], xtitle = 'X_GSE [$R_E$]', ytitle = 'Y_GSE [$R_E$]', data_min = d_min, data_max = d_max, font_size = 17, aspect_ratio = 1, xminor = 4, yminor = 4) ;title = 'without the two biggest values'
  cb3 = colorbar(target = p33, orientation = 1, title = '[MMS] time span', textpos = 1, minor = 0, position = [-12, 35, -16, -35], font_size = 17, border_on = 1, /data)
  stop
  ;  ;p33.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list_final/plot/figure.png'

  stop
end