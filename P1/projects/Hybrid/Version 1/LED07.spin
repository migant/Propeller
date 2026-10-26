{{
   LEDs 07.spin
}}

CON
  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

  
VAR


OBJ


PUB Start
  cognew(@entry, 0)


DAT
              org

entry             
              mov       dira, dira_data
              mov       outa, outa_data
              mov       cnt_data, cnt
              add       cnt_data, cnt_delay


:loop         call      #Delay
              add       outa, #1
              jmp       #:loop



              mov       outa, MARK
              call      #Delay

:rs232loop    mov       outa, STARTBIT
              call      #Delay

              mov       outa, BIT0
              call      #Delay              
              mov       outa, BIT0
              call      #Delay              
              mov       outa, BIT0
              call      #Delay              
              mov       outa, BIT0
              call      #Delay              

              mov       outa, BIT1
              call      #Delay              
              mov       outa, BIT1
              call      #Delay              
              mov       outa, BIT0
              call      #Delay              
              mov       outa, BIT0
              call      #Delay              
                  
              mov       outa, STOP
              call      #Delay              

              jmp       #:rs232loop
                     

MARK          long      $00000000
STARTBIT      long      $FFFFFFFF      
BIT0          long      $FFFFFFFF
BIT1          long      $00000000
STOP          long      $00000000


Delay         waitcnt   cnt_data, cnt_delay
Delay_ret     ret
                                      

dira_data     long      %00000000_00000000_00000000_00001111
outa_data     long      %00000000_00000000_00000000_00001111
cnt_data      long      0
'cnt_delay     long      694                                                     ' ticks per bit
cnt_delay     long      10_000_000                                                     ' ticks per bit
                