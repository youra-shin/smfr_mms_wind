pro SMFR_occurrence_xyposition_map_

  restore, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_SMFR_ALLevents_position_ge30min.sav'

  file = '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_SMFR_ALLeventlist_parameters_sorted_ge30min.csv'
  data = read_csv(file, header = sedheader, n_table_header = 1, table_header = sedtableheader)

  x_re = pos_x / 6378. ;-1 < x_re < 29
  y_re = pos_y / 6378. ;-28 < y_re < 28
  z_re = pos_z / 6378. ;-11 < z_re < 9

  restore, '/Users/ys/Desktop/Prac/SMFR/MMS/stats_yr/new_list/MMS_SMFR_Intpl_MED_ALLphase_position.sav'
  x_re_ap = pos_x_ALLphase / 6378.
  y_re_ap = pos_y_ALLphase / 6378.
  z_re_ap = pos_z_ALLphase / 6378.

    result_e = hist_2d(x_re, y_re, min1 = -5., max1 = 35., min2 = -35., max2 = 35., bin1 = 2.5, bin2 = 2.5) ;x = x_re and y = y_re for occurence rate
    result_ap = hist_2d(x_re_ap, y_re_ap, min1 = -5., max1 = 35., min2 = -35., max2 = 35., bin1 = 2.5, bin2 = 2.5)
  
  
    sz = size(result_e)
    result_new = fltarr(sz[1], sz[2])
    for i = 0, sz[1]-1 do begin
      for j = 0, sz[2]-1 do begin
        result_new[i, j] = float(result_e[i, j]) / float(result_ap[i, j])
        if result_new[i, j] eq 0. then result_new[i, j] = !values.f_nan
      endfor
    endfor
  
    ;remove the outliers
    ;result_new[2079] = !values.f_nan ;the second biggest value ;bin = 1
    ;result_new[430] = !values.f_nan ;the biggest value ;bin = 1
    result_new[111] = !values.f_nan ;the second biggest value ;bin = 2.5
    result_new[335] = !values.f_nan ;the biggest value ;bin = 2.5
  
  
    ;xx = findgen(41) - 5.
    ;yy = findgen(71) - 35.
    xx = (findgen(17) - 2.) * 2.5
    yy = (findgen(29) - 14.) * 2.5
  
    ;occurence rate
    d_min = 0.1
    d_max = 0.32
    p3 = spec_plot(result_new, xx, yy, xrange = [35, -5], yrange = [35, -35], xtitle = 'X_GSE [$R_E$]', ytitle = 'Y_GSE [$R_E$]', data_min = d_min, data_max = d_max, font_size = 17, aspect_ratio = 1, xminor = 4, yminor = 4) ;title = 'without the two biggest values'
    cb = colorbar(target = p3, orientation = 1, title = '[MMS] Occurence rate', textpos = 1, minor = 0, position = [-9, 35, -13, -35], font_size = 17, border_on = 1, /data)
    stop
    p3.save, '/Users/ys/Library/Mobile Documents/com~apple~CloudDocs/ys_desktop/School/paper1_statistics/plot/v2/figure4.png'


  stop
end