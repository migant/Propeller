''*****************************
''*  COP Driver v0.2          *
''*  Colin Phillips           *
''*****************************
'
' 576p driver   
'
CON

  fprog         = 6_750_000     'Progressive pixel frequency / 4
  lprog         = 3456          'Progressive cycles per line * 4
  sprog         = 576           'Progressive cycles per sync * 4
  vprog         = lprog-sprog


  #0, h_cop_status, h_cop_control, h_cop_debug

  
VAR

  long  cogon, cog


PUB start(copptr) : okay

'' Start COP driver - starts a cog
'' returns false if no cog available
''
''   tvptr = pointer to TV parameters

  stop
  okay := cogon := (cog := cognew(@entry,copptr)) > 0


PUB stop

'' Stop TV driver - frees a cog

  if cogon~
    cogstop(cog)


DAT


'********************************
'* Assembly language COP driver *
'********************************

                        org
'
'
' Entry

entry
                        nop                                                     'alignment bug??? not sure yet.
                        ' setup Debug LED pin (pin 0) to output
                        or      dira, debugled_mask                             'set debug led to output

                        ' VCFG: setup Video Configuration register and 3-bit tv DAC pins to output
                        movs    vcfg, #%0000_0111                               ' vcfg'S = pinmask (pin31: 0000_0111 : pin24)
                        movd    vcfg, #3                                        ' vcfg'D = pingroup (grp. 3 i.e. pins 24-31)
                        movi    vcfg, #%010111_000                              ' baseband video on bottom nibble, 2-bit color, enable chroma on broadcast & baseband
                        or      dira, tvport_mask                               ' set DAC pins to output

                        ' CTRA: setup Frequency to Drive Video
                        movi    ctra,#%00001_111                                ' pll internal routed to Video, PHSx+=FRQx (mode 1) + pll(16x)
                        mov     r1, v_freq                                      ' r1: TV frequency in Hz
                        rdlong  r2,#0                                           ' r2: CLKFREQ
                        call    #dividefract                                    ' perform r3 = 2^32 * r1 / r2
                        mov     frqa, r3                                        ' set frequency for counter
                        






next_frame              ' start of new frame

                        mov     r6,par
                        
                        mov     r1, #96
:top_border             call    #border
                        djnz    r1 ,#:top_border


                        mov     r1, #384                                       ' set visible scanlines to do

                        ' reset pattern
                        mov     r2, #0
                        mov     v_ptemp, v_phvis
                        mov     v_ctemp, v_chvis


' Horizontal Scanline Loop (r1 itterations)
next_scanline

                        test    r1, #1          wz                              
              if_nz     call    #empty_scanline       
              if_nz     jmp     #:line_loop           


                        ' HSYNC 5.33us (Horizontal Sync)
                        mov     vscl, v_shsync
                        waitvid v_chsync, v_phsync

                        ' HVIS 26.66us (Visible Scanline)
                        mov     vscl, v_shvis_lb
                        waitvid v_cborder, #0

                        mov     r4, #16                                         ' 16 longs to define all pixels in a line
                        
                        mov     vscl, v_shvis_scr                               ' Scale for 512 pixels

:pattern                rdlong  r5, r6
                        add     r6, #4


                        mov     r7, #10                                         ' add a delay to check for available cycles
                        call    #delay

                        
                        'waitvid v_ctemp, v_ptemp
                        waitvid v_ctemp, r5
                        djnz    r4, #:pattern

                        mov     vscl, v_shvis_rb
                        waitvid v_cborder, #0

                        ' rotate the 16 pixel indices along every 16 lines to make a pattern
                        ' and also change the colors every 16 lines :-)
                        add     r2, #1
                        cmp     r2, #2                            wz
        if_z            rol     v_ptemp, #2
        if_z            mov     r2, #0
        if_z            add     v_ctemp, v_cadd
                        

:line_loop              djnz    r1, #next_scanline


                        mov     r1, #96
:bottom_border          call    #border
                        djnz    r1 ,#:bottom_border


' End of Horizontal Scanline Loop

                        ' VSYNC Pulse (Vertical Sync)
                        ' 49 scanlines: 5 'high syncs', 5 'low syncs', and finally another 39 'high syncs'
                        mov     r1, #5
                        call    #vsync_high

                        mov     r1, #5
                        call    #vsync_low

                        mov     r1, #39
                        call    #vsync_high

                        jmp     #next_frame



empty_scanline
                        ' HSYNC 5.33us (Horizontal Sync)
                        mov     vscl, v_shsync  
                        waitvid v_chsync, v_phsync

                        ' HVIS 26.66us (Visible Scanline)
                        mov     vscl, v_shvis2
                        'waitvid v_chvis, #0
                        waitvid v_cborder, #0


empty_scanline_ret      ret



border                  
                        ' HSYNC 5.33us (Horizontal Sync)
                        mov     vscl, v_shsync  
                        waitvid v_chsync, v_phsync

                        ' HVIS 26.66us (Visible Scanline)
                        mov     vscl, v_shvis2
                        waitvid v_cborder, #0

border_ret              ret

                 
' vsync_high: Generate 'HIGH' vsync signal for r1 horizontal lines.
vsync_high              
'vsync                  
                        ' HSYNC 10.9us (Horizontal Sync)
:vsync_loop             mov     vscl, v_shsync
                        waitvid v_chsync, v_pvsync_high_1

                        ' HVIS 52.6us (Visible Scanline)
                        mov     vscl, v_shvis2
                        waitvid v_chsync, v_pvsync_high_2
                        djnz    r1, #:vsync_loop

vsync_high_ret          ret

' vsync_low: Generate 'LOW' vsync signal for r1 horizontal lines.
vsync_low
                        
                        ' HSYNC 10.9us (Horizontal Sync)
:vsync_loop             mov     vscl, v_shsync
                        waitvid v_chsync, v_pvsync_low_1

                        ' HVIS 52.6us (Visible Scanline)
                        mov     vscl, v_shvis2
                        waitvid v_chsync, v_pvsync_low_2
                        djnz    r1, #:vsync_loop

vsync_low_ret           ret
                        

delay                   djnz    r7, #delay
delay_ret               ret                                       

'
' Perform 2^32 * r1/r2, result stored in r3 (useful for TV calc)
' This is taken from the tv driver.
' NOTE: It divides a bottom heavy fraction e.g. 1/2 and gives the result as a 32-bit fraction.
'

dividefract                                     
                        mov     r0,#32+1
:loop                   cmpsub  r1,r2           wc
                        rcl     r3,#1
                        shl     r1,#1
                        djnz    r0,#:loop

dividefract_ret         ret                             '+140


r0                      long                    $0                              ' should typically equal 0
r1                      long                    $0
r2                      long                    $0
r3                      long                    $0
r4                      long                    $0
r5                      long                    $0
r6                      long                    $0
r7                      long                    $0



debugled_ctr            long                    $0
debugled_brightness     long                    $4fffffff
debugled_mask           long                    $00000001
debugled_nmask          long                    debugled_mask^$ffffffff
tvport_mask             long                    %0000_0111<<24

vlines                  long                    576

v_ptemp                 long                    $0
v_ctemp                 long                    $0
v_cadd                  long                    $00_00_00_00


' hsync (576 cycles)
v_shsync                long                    sprog >> 4 << 12 + sprog
v_chsync                long                    $00_00_02_02
v_phsync                long                    %0101_00000000_01_10101010101010_0101


' hvis (2880 cycles)
'v_shvis                long                    ((vprog >> 4)/16) << 12 + (vprog/16)
v_shvis_lb              long                    1 << 12 + 416
v_shvis_rb              long                    1 << 12 + 416
v_shvis_scr             long                    8 << 12 + 128

v_chvis                 long                    $07060302
v_phvis                 long                    %%3210_3210_3210_3210
'v_phvis                long                    %%3333_2222_1111_0000


' hvis (2880 cycles) (for use during vsync)
v_shvis2                long                    vprog >> 4 << 12 + vprog

' hline (3456 cycles = 576 + 2880)
v_shline                long                    lprog >> 4 << 12 + lprog
v_chline                long                    $00_00_02_02
v_phline                long                    %%3210_3210_3210_3210

v_cborder               long                    $00000002


' vsync pulses 5x High, 5x Low, 39x High
v_pvsync_high_1         long                    %0101010101010101010101_101010_0101
v_pvsync_high_2         long                    %01010101010101010101010101010101
v_pvsync_low_1          long                    %1010101010101010101010101010_0101
v_pvsync_low_2          long                    %01_101010101010101010101010101010
  
v_freq                  long                    fprog


rom                     long                    $8000


                        fit                     $100


                        