

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
height = (radi.y - !CONST.R_EARTH) * 1.e-3
store_data, 'Height', data = {x:radi.x, y:height}
;
tplot_options, 'var_label', ['MLT', 'QDLatitude', 'Height']


END
