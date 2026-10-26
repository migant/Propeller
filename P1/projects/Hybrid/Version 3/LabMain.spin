{{
   Mike_Demo.spin
}}

CON
  _clkmode = xtal1 + pll8x
  _xinfreq = 10_000_000

VAR
  long  f


OBJ
  vosc: "Video_Osc"
                  

PUB Start


  vosc.Start

  repeat
 
      