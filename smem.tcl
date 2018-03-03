#!/usr/local/bin/wish8.5

# Author: Dr. Nicola Mingotti, nmingotti AT gmail.com
# 
# License: This code is tailored to FreeBSD and it goes with the
#          same license.
# 
# Platform: -] It reads "top" output but it is adjusted only to FreeBSD-11.1
#              "top" output. 
#           -] Tcl/Tk8.5 must be installed (it should work with newer versions
#              as well).
# 
# WHAT IT DOES 
# 
# Simple memory monitor widget 'a la wmaker dockapps'.
# -] It shows: memory Free, memory Inact, and used Swap 
# -] It updates values every second
# -] It takes memory values from "top"
# -] It is tested only in FreeBSD-11.1
# -] it should be very easy to modify this code to adjust it 
#    to personal preferences.
# 

set topV [exec top -w -d1]
set topL [split $topV "\n"]

# linea di top che contiene l'uso di memoria 
# Mem: 668M Active, 1413M Inact, 34M Laundry, 828M Wired, 483M Buf, 1891M Free
set l3 [lindex $topL 3]

regexp {(\d+)M Active} $l3 tmp memActive
regexp {(\d+)M Inact} $l3 tmp memInact
regexp {(\d+)M Laundry} $l3 tmp memLaundry
regexp {(\d+)M Free} $l3 tmp memFree

# linea di top che contiene l'uso di swap 
# Swap: 4096M Total, 87M Used, 4009M Free, 2% Inuse
set l4 [lindex $topL 4]
regexp {(\d+)M Free} $l4 tmp swapFree
regexp {(\d+)M Used} $l4 tmp swapUsed


# Get memory use values from "top" and return them in a list
# (unpacked array)
proc getMemVals {} { 
    set topV [exec top -w -d1]
    set topL [split $topV "\n"]

    # linea di top che contiene l'uso di memoria 
    # Mem: 668M Active, 1413M Inact, 34M Laundry, 828M Wired, 483M Buf, 1891M Free
    set l3 [lindex $topL 3]

    regexp {(\d+)M Active} $l3 tmp out(memActive)
    regexp {(\d+)M Inact} $l3 tmp out(memInact)
    regexp {(\d+)M Laundry} $l3 tmp out(memLaundry)
    regexp {(\d+)M Free} $l3 tmp out(memFree)

    # linea di top che contiene l'uso di swap 
    # Swap: 4096M Total, 87M Used, 4009M Free, 2% Inuse
    set l4 [lindex $topL 4]
    regexp {(\d+)M Free} $l4 tmp out(swapFree)
    regexp {(\d+)M Used} $l4 tmp out(swapUsed)
    
    # trasforma array in una lista per passarlo fuori 
    return [array get out]
}


# ================================================== 
# === Interface 
# ================================================== 


# remover decorations and ratain the window manager to get control
# on this app.
wm overrideredirect . true 

# window positioning on the screen
wm geometry . +0+40
wm minsize . 40 40

# preferred font to display results 
set fontMono {Mono -10}

# I use only one label widget to show all data because 
# it consumes less vertical space, wich I can use for larger fonts.
label .lAll -text "None" -font $fontMono
pack .lAll -side "top"


# ========================================================

# Each seconds update the results.
# We do not use the classic while loop + sleep 1 here 
# because that would interfere with Tk.
proc looper {} {
    set tmp [getMemVals]
    array set ar $tmp
    # puts "memFree: $ar(memFree)"
    # global variable for interacting with the label widget
    variable .lAll;
    set free [format "F:%.2f" [expr $ar(memFree) / 1000.0]] 
    set inact [format "I:%.2f" [expr $ar(memInact) / 1000.0]] 
    set swap [format "S:%.2f" [expr $ar(swapUsed) / 1000.0]] 

    .lAll config -text "$free\n$inact\n$swap"

    after 1000 {looper}
}

# start the looper 
looper 
