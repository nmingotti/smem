# smem
Simple, non-intrusive, memory monitor X widget for FreeBSD 

### WHAT IT DOES
- It is a simple memory monitor application to run in X Window customized for FreeBSD.
- Its look is similar to a WindowMaker dockapp. 
- Each seconds it prints on the graphical widget the amount of ***Free Memory***, ***Inact Memory***
and ***Swap used memory***. These are the same names appearing in FreeBSD ***top*** output.

### Requires
- Requires TclTk, at least release 8.5
- Tested in FreeBSD-11.1, TclTk release 8.5.
- Techincally it should work on every Unix-like system having the command ***top***,
in practice, different OS will provide different "top" output, se the script will need
some little modifications. 


### Rationale 
- I developed this little monitor because I want to track continuously what happens
in my system memory. We have [long thread running](https://forums.freebsd.org/threads/swap-memory.64139/) about ***swap*** in forums.freebsd.org, 
I maitain some kind of summary of that [here](https://docs.google.com/document/d/1cubX4cRAyk3dyOR5ed4t0dngQrhrUjCec6VXpMl8zC0/edit?usp=sharing)
- This app was originally developed in Ruby + Tk. Since there is not 
   package to easily install Ruby-Tk in FreeBSD-11.1 I rewrote it in TclTk. 
- ***extra -- complaint*** it is a mistake not to have Tk bundled with Ruby. It is a lot annoying not to have a GUI
by default in a scripting language. Python and Tcl have shown the way. 


