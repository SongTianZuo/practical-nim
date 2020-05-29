import webview, os

const
    CONFIG_FILE = "/alarm.txt"

var
    wv = newWebView("Alarm Clock", getAppDir() & "/web/alarm.html", 300, 320)
    configFile = getAppDir() & CONFIG_FILE

proc sSave(s:string) = 
    var
        f : File
    f = open( configFile , fmWrite )
    write(f,s)
    close(f)

proc sLoad() =
    var
        f : File
        txt : string
    try:
        f = open( configFile , fmRead )
        txt = readLine(f)
        close(f)
    except:
        txt = ""
    discard eval(wv, "load('" & txt & "')")

wv.bindProcs("api"):
    proc xsave(s:string) = sSave(s)
    proc xload() = sLoad()

wv.run()
wv.exit()