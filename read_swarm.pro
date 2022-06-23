

PRO read_swarm, fn

;
;*---------- change attributes for all zVariables  ----------*
;
id  = CDF_OPEN(fn)
inq = CDF_INQUIRE(id)
;
FOR i = 0, inq.nzvars - 1 DO BEGIN
  vi    = CDF_VARINQ(id, i, /ZVAR)
  varname = vi.name
  CDF_ATTPUT, id, 'DEPEND_0', varname, 'Timestamp'
ENDFOR
;
CDF_CLOSE, id


;
;*---------- read cdf file  ----------*
;
cdf2tplot, fn


;
;*---------- set ephemeris  ----------*
;
; sattelite height
get_data, 'Radius', data=radi
;
altitude = (radi.y - !CONST.R_EARTH) * 1.e-3
store_data, 'Altitude', data = {x:radi.x, y:altitude}
options, 'Altitude', 'ysubtitle', '[km]'
options, 'Altitude', 'ytitle', 'Alt[km]'
;
options,  'QDLatitude','ytitle',  'MLAT'
;
tplot_options, 'var_label', ['MLT', 'QDLatitude', 'Altitude']


END
