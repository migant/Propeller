{{
   Mike_Demo.spin
}}

CON
  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

VAR
  long  f


OBJ
  osc: "Video_Osc"              
  frq: "FrequencyMeter"
  ctr: "PulseCounterMeter"
  txt: "TV_Text"


PUB Start

  osc.Start
  frq.Start
  ctr.Start
  
  txt.Start(12)

 
  repeat
    txt.str(string($A,3,$B,3, "Frequency"))
    txt.str(string($A,6,$B,4))
    txt.dec(frq.GetFreq)
    txt.str(string(" Hz             "))

    txt.str(string($A,3,$B,6, "Pulse Counter"))
    txt.str(string($A,6,$B,7))
    txt.dec(ctr.GetCounter)
    txt.str(string(" Pulses         "))
      