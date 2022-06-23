
;fn = '/home/step/goto/SW_EXPT_EFIA_TCT16_20150117T000000_20150117T235959_0302.cdf'
fn = '~/idl/swarm/SW_EXPT_EFIA_TCT16_20150117T000000_20150117T235959_0302.cdf'


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
 

cdf2tplot, fn
;
timespan, ['2015-01-17/12:58:00', '2015-01-17/13:00:00']

;tnames = ['Ehx', 'Ehy', 'Ehz', 'Evx', 'Evy', 'Evz']
;tplot, tnames

tname = 'By'
tsavgol, tname, 10, 10, 0, 4, /subtract

end
