
; save_png, 'test.png', window=0
PRO save_png, filename, window=window 
SET_PLOT, 'X'
DEVICE, DECOMPOSED=0, RETAIN=2
WSET, window
WRITE_PNG, filename, TVRD(/TRUE)
END


 
