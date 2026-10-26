'' This simple test loads a SCR file and displays it 

CON

        _CLKMODE                = xtal2 + pll8x
        _XINFREQ                = 10_000_000 + 0000

DAT

'  Screen   file "SabreWulf.scr"
'  Screen   file "BruceLee.scr"
'  Screen   file "DaleyThompsonsSupertest.scr"
'  Screen   file "EnduroRacer.scr"
  Screen   file "TirNaNog.scr" 
OBJ
  Spectrum : "JLC_Spectrum_TV_010"

PUB Start
  Spectrum.Start(@Screen, 1)
  
  ' Uncomment the following code to see a simulated loading screen :-)
  
  {
  repeat
    repeat 2000
      Spectrum.SetBorderColor(2)
      waitcnt(45_000 + cnt)
      Spectrum.SetBorderColor(5)
      waitcnt(40_000 + cnt)
    repeat 15000
      Spectrum.SetBorderColor(6)
      waitcnt(20_000 + cnt)
      Spectrum.SetBorderColor(1)
      waitcnt(20_000 + cnt)
  }       