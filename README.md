# TTY rapid Dump/Load
an extension to M.Gönners hex Loader by Bruce Nazarian

Located in Compute II June 1980

Usage
Start at 0100
enter the address you want to write in or read from and press (SPACE)
Press Q (Dump) or L (Load)

---
 - If you Dump a memory area, the programm will print out the mem from the adress onwards and ir will only stop if you hit a key on the KEYPAD
  to change this behaviour change location 

> 0147  20 6A 1F    JSR KEYIN instead of GETKEY <br>
> 014A  D0 FB       BNE 0147<BR>
> 014C  EA EA       NOPS to fil previous<br>
---
 - If you want to Load  into memory after pressing L start inserting hex code with or without spaces. they are ignored. Press ESC to end
