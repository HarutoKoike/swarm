
; .r crib_sheet で実行

; 読み込むファイルの名前。ファイルの場所におうじて適宜変更。
fn = '~/idl/swarm/SW_EXPT_EFIA_TCT16_20150117T000000_20150117T235959_0302.cdf'
read_swarm, fn

timespan, ['2015-01-17/12:58:00', '2015-01-17/13:00:00'] ; プロットする時間範囲を決める。

nleft  = 800  ;　フィッティングに使うデータ点で、現在時刻からどれだけ前のデータ点まで使うか
nright = 800  ;　フィッティングに使うデータ点で、現在時刻からどれだけ後のデータ点まで使うか
order  = 0   ;  何階微分の係数を取得するか。単純なフィッティングであれば0で良い。
degree = 2   ;  多項式でフィッティングする時に、何次の項まで使うか。とりあえず4次くらい？

tsavgol, 'By', nleft, nright, order, degree, /subtract ; "By" というtplot変数をSavgolフィルターにかける   

window, 1, retain=2  ;おまじない

tplot_options, 'title', 'SWARM-A'   ; プロットのタイトルをつける
tplot_options, 'thick', 1.5         ; プロットの線の太さを決める。デフォルトは1
options, 'By_Savitzky-Golay', 'ytitle', 'By_savgol' ;y軸のタイトルを変更する。ここでは２段目のパネルのタイトルを変更
options, 'By_Savitzky-Golay', 'ycharsize', 1.2 ;y軸の文字サイズを変更する。
options, 'By_subtracted_Savitzky-Golay', 'ytitle', 'By - By_savgol' 
options, 'By_subtracted_Savitzky-Golay', 'ycharsize', 1.2 
options, 'By', 'ycharsize', 1.2


get_timespan, ts
ts = time_string(ts)
time_clip, 'By_subtracted_Savitzky-Golay', ts[0], ts[1]
tdpwrspc, 'By_subtracted_Savitzky-Golay_tclip', ndatap=256



tplot, ['By', 'By_Savitzky-Golay', 'By_subtracted_Savitzky-Golay', $
        'By_subtracted_Savitzky-Golay_tclip_dpwrspc']

save_png, '~/idl/swarm/swarm_By.png', window=1
end
