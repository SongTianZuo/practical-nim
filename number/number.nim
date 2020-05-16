import iup, strutils

var
    label1, label2, label3 : PIhandle
    btn_start, btn1, btn2, btn3 : PIhandle
    timer1, timer2, timer3 : PIhandle
    dlg : PIhandle
    num1, num2, num3 : int

proc check()=
    var bTimer1_stop, bTimer2_stop, bTimer3_stop : bool
    
    bTimer1_stop = (getAttribute(timer1, "RUN")=="NO")
    bTimer2_stop = (getAttribute(timer2, "RUN")=="NO")
    bTimer3_stop = (getAttribute(timer3, "RUN")=="NO")
    
    if bTimer1_stop and bTimer2_stop and bTimer3_stop:
        if (num1==num2) and (num2==num3):
            message("number","congratulations!")
        setAttribute(btn_start, "ACTIVE", "YES")
        
proc timer1_cb(handle : PIhandle):cint{. cdecl .}=
    inc(num1)
    num1 = num1 mod 10
    setAttribute(label1, "TITLE", intToStr(num1))
    return 0
    
proc timer2_cb(handle : PIhandle):cint{. cdecl .}=
    inc(num2)
    num2 = num2  mod 10
    setAttribute(label2, "TITLE", intToStr(num2))
    return 0
    
proc timer3_cb(handle : PIhandle):cint{. cdecl .}=
    inc(num3)
    num3 = num3 mod 10
    setAttribute(label3, "TITLE", intToStr(num3))
    return 0

proc btn_start_cb(handle : PIhandle):cint{. cdecl .}=
    setAttribute(btn_start, "ACTIVE", "NO")
    num1 = 0
    num2 = 0
    num3 = 0
    setAttribute(label1, "TITLE", intToStr(num1))
    setAttribute(label2, "TITLE", intToStr(num2))
    setAttribute(label3, "TITLE", intToStr(num3))
    setAttribute(timer1, "RUN", "YES")
    setAttribute(timer2, "RUN", "YES")
    setAttribute(timer3, "RUN", "YES")
    setAttribute(btn1, "ACTIVE", "YES")
    setAttribute(btn2, "ACTIVE", "YES")
    setAttribute(btn3, "ACTIVE", "YES")
    return 0
    
proc btn1_cb(handle : PIhandle):cint{. cdecl .}=
    setAttribute(btn1, "ACTIVE", "NO")
    setAttribute(timer1, "RUN", "NO")
    
    check()
    return 0

proc btn2_cb(handle : PIhandle):cint{. cdecl .}=
    setAttribute(btn2, "ACTIVE", "NO")
    setAttribute(timer2, "RUN", "NO")
    check()
    return 0

proc btn3_cb(handle : PIhandle):cint{. cdecl .}=
    setAttribute(btn3, "ACTIVE", "NO")
    setAttribute(timer3, "RUN", "NO")
    check()
    return 0



discard open(nil,nil)

btn_start = button("start", nil)
setAttribute(btn_start, "CX", "40")
setAttribute(btn_start, "CY", "20")
setAttribute(btn_start, "SIZE", "80x25")

label1 = label("0")
setAttribute(label1, "CX","30")
setAttribute(label1, "CY","80")
setAttribute(label1, "FONT", "Arial, 32")
setAttribute(label1, "FGCOLOR", "0 255 0")


label2 = label("1")
setAttribute(label2, "CX","80")
setAttribute(label2, "CY","80")
setAttribute(label2, "FONT", "Arial, 32")
setAttribute(label2, "FGCOLOR", "0 255 0")


label3 = label("2")
setAttribute(label3, "CX","130")
setAttribute(label3, "CY","80")
setAttribute(label3, "FONT", "Arial, 32")
setAttribute(label3, "FGCOLOR", "0 255 0")


btn1 = button("stop", nil)
setAttribute(btn1, "CX","20")
setAttribute(btn1, "CY","140")
setAttribute(btn1, "SIZE","33x33")
setAttribute(btn1, "ACTIVE", "NO")

btn2 = button("stop", nil)
setAttribute(btn2, "CX","73")
setAttribute(btn2, "CY","140")
setAttribute(btn2, "SIZE","33x33")
setAttribute(btn2, "ACTIVE", "NO")

btn3 = button("stop", nil)
setAttribute(btn3, "CX","126")
setAttribute(btn3, "CY","140")
setAttribute(btn3, "SIZE","33x33")
setAttribute(btn3, "ACTIVE", "NO")

dlg = dialog(cbox(btn_start, label1, label2, label3, btn1, btn2, btn3))
setAttribute(dlg, "TITLE", "number")
setAttribute(dlg, "SIZE", "140x130")

timer1 = timer()
setAttribute(timer1, "TIME", "90")
setCallback(timer1, "ACTION_CB",cast[Icallback](timer1_cb))
timer2 = timer()
setAttribute(timer2, "TIME", "70")
setCallback(timer2, "ACTION_CB",cast[Icallback](timer2_cb))
timer3 = timer()
setAttribute(timer3, "TIME", "50")
setCallback(timer3, "ACTION_CB",cast[Icallback](timer3_cb))

setCallback(btn_start, "ACTION", cast[Icallback](btn_start_cb))
setCallback(btn1, "ACTION", cast[Icallback](btn1_cb))
setCallback(btn2, "ACTION", cast[Icallback](btn2_cb))
setCallback(btn3, "ACTION", cast[Icallback](btn3_cb))

show(dlg)
mainLoop()
close()