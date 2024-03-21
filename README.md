# SBC Case Builder


## Introduction

This project is about autonomous SBC case creation. It utilizes the SBC Model Framework project to automatically generate cases based on the data for any of the 84 current devices contained within the framework. This allows legacy, current and future SBC to have multiple cases available on day one of their inclusion in the framework. There are multiple base case designs(shell, panel, stacked, tray, tray-sides, round, hex, snap, fitted) available and each allows for different styles within the design.

All case openings are created automatically based on SBC data and the dimensions of any case design can be expanded in any axis allowing for the creation of larger cases. If you reposition the SBC in a case, you will see i/o openings created or removed appropriately based on it’s proximity to the case geometry. These cases might be useful for prototypes or other in house uses to quickly and easily create standard, specialized and custom SBC cases thru different case designs, styles and accessories.

License: GPLv3.

![Image](SBC_Case_Builder_Cases.gif)

### Install
```
  git clone https://github.com/hominoids/SBC_Case_Builder.git
  cd SBC_Case_Builder
  git submodule init
  git submodule update

```

### SBC Case Builder Features:
-  Autonomous Multi-SBC, Multi-Case Parametric Generation
-  Autonomous Case Standoffs with Variable Height
-  Extended Standoff SBC collision detection
-  Accessory Customization Framework
-  Accessory Multi-Associative Parametric Positioning
   - Absolute Location
   - Case Associations
   - SBC Associations
   - SBC_X,Y - Case_Z Association
-  SBC Model Framework Validation Tool

### Base Case Designs:
- Shell - complete
- Panel - complete
- Stacked - complete
- Tray - complete
- Tray-Sides - complete
- Tray-Vu5 - complete
- Tray-Vu7 - complete
- Round - complete
- Hex - complete
- Snap - complete
- Fitted - complete
- Paper, Folded - complete
- Sheet Metal, Folded
- Sliding
- Cylinder
- NAS
- Rack
- Adapters(itx, matx)
- CNC Cases

All case data is stored in the json file sbc_case_builder.json with the accessory data stored in a separate file structure in sbc_case_builder_accessories.cfg.  An accessory group name for a given case is stored as part of the case data in the json file.  This allows for the reuse or sharing of an accessory set by different cases and can be used to manage groups of accessories.

Variable height automated SBC standoffs, which can be individually adjusted, are also implemented to integrate add-on PCB, hats, heatsinks or other accessories that share SBC standoffs for mounting.

Multi-associative parametric positioning of accessories is implemented and allows each accessory to enable or disable parametric movement of the accessory for each axis.  The XY and Z axis can be associated with the case offset (size), SBC positioning, multi-associated axises or absolute positioning.  For instance, a SBC fan opening needs to follow the SBC in the X and Y axis but the case Z axis for the correct height.
```
                                              p
                                              a
                                              r
                                     r        a                                               s
                                     o        m                                               e
                                     t        e                           s s s             l t    m
       c          l  l  l            a        t                           i i i             e      s
       l      t   o  o  o      f     t        r                           z z z   d     m   n b    t
       a      y   c  c  c      a     i        i                           e e e   a     a   g a    y
       s      p                c     o        c                                   t     s   t c    l
       s,     e,  x, y, z,     e,    n,       s,                          x,y,z,  a,    k   h k    e

     "sub","fan",10,10,24.5,"top",[0,0,0],["sbc-case_z",true,true,true],[40,0,6],[0],[true,10,2,"default"],
```

An array holds a string and 3 Boolean that represent which association and axis are enabled for parametric movement.  In the accessory example above, the 8th parameter `["sbc-case_z",true,true,true]` means all axises are enabled for multi-associative movement with the X and Y accessory axis following the SBC X and Y axis and the accessory Z axis following the case Z axis. The other currently supported associations are “sbc” and “case”.  If other associations of objects are needed or are of value, they can be added in the future.  All of the existing cases have been made parametric and can serve as further working examples.

### Notes

Due to the number of possibilities, no pre-compiled case stl’s are included.

“tol”, located at the bottom of the Adjustments Tab, is a  tolerance fitment adjustment for the snap, fitted, round and hex tops.  Adjust accordingly if the tops are too tight or loose.

### Case Designs and Styles
The case naming convention for standard cases in the configuration file follow the basic form of “sbc”_”design”_”style” e.g. c4_shell or c4_tray_vu5.



### Accessory Schema
The schema for case accessories is documented in the beginning of the file sbc_case_builder_accessories.cfg. There is one fixed entry that is the accessory set name followed by an unlimited number of accessory entries each containing 11 entries.
```
schema:

"accessory_name",
"class","type",loc_x,loc_y,loc_z,face,rotation[x,y,z],parametrics[association,x,y,z],size[],data[],mask[]
```

### Accessories Entries
There are 6 classes, “add1”,“sub”,”suball”,”add2”,”model”,”platter” and all use the same command format for various “type”.
```
"class","type",loc_x,loc_y,loc_z,face,rotation[x,y,z],parametrics[association,x,y,z],size[],data[],mask[]
```
e.g.
```
                                              p
                                              a
                                              r
                                     r        a                                               s
                                     o        m                                               e
                                     t        e                           s s s             l t    m
       c          l  l  l            a        t                           i i i             e      s
       l      t   o  o  o      f     t        r                           z z z   d     m   n b    t
       a      y   c  c  c      a     i        i                           e e e   a     a   g a    y
       s      p                c     o        c                                   t     s   t c    l
       s,     e,  x, y, z,     e,    n,       s,                          x,y,z,  a,    k   h k    e

     "sub","fan",10,10,24.5,"top",[0,0,0],["sbc-case_z",true,true,true],[40,0,6],[0],[true,10,2,"default"],
```
  
Every type, regardless of it’s class, uses a basic set of variables
`(loc_x,loc_y,loc_z,”face”,rotation[],parametrics[])`
but each type doesn’t necessarily use all available data fields
`(size[],data[])`

The parametric array specifies the axis to enable for associated parametric positoning. An accessory can be associated with the sbc position("sbc"), case offset("case"),multi-associated which use sbc xy postion and case z offset(sbc-case_z) or uses absolute values if all axises are false.

#### classes: add1, sub, suball, add2, model, platter

Class “add1” and “add2” are used to add geometry to the case. The difference is when the addition occurs. “add1” happens at the beginning when the core case geometry is created and add2 happens after all subtractions have occurred. “suball” is used to affect all faces of a case, not just “face”. The “face” is the case piece that will be effected by the addition or subtraction. The "model" class is for placing supporting accessories in the model view. e.g. hard drives, fans. The "platter" class is for adding supporting accessories to the print platter.


**additive type:**

circle, rectangle, slot, text, art, standoff, batt_holder, uart_holder, hd_holder, hd_holes, hd_vertright_holes, hc4_oled_holder, access_port, button, pcb_holder, boom_grill, boom_speaker_holder


**subtractive type:**

circle, rectangle, slot, text, art, punchout, vent, fan, hd_holes, hd_vertleft_holes, hd_vertright_holes, microusb, sphere


**model type:**

uart_strap, fan_cover, hd25, hd35, hc4_oled, feet, access_cover, net_card, hk35_lcd, hk_boom, boom_speaker, boom_vring, hk_uart


**platter type:**

uart_strap, fan_cover, access_cover, button_top, boom_vring


#### Shared add and sub “type” commands


**circle**
```
DESCRIPTION: circlular geometry.

USES: size_x=dia, size_z=height
```

**rectangle**
```
DESCRIPTION: rectangular geometry with individual defined corner fillets. Radius1 is lower left corner then moves clockwise.

USES: size_x, size_y, size_z, data_4=[radius1, radius2, radius3, radius4]
```

**slot**
```
DESCRIPTION: slot geometry.

USES: size_x=diameter, size_y=length, size_z=height
```

**text**
```
DESCRIPTION: raised or sunk text

USES: data_1=size, data_3="text"
```

**art**
```
DESCRIPTION: art work in dxf or svg format

USES: data_1=scale, data_2=height, data_3=file
```

**keyhole**
```
DESCRIPTION: enclosed keyhole

USES: data4=[head_dia, slot_width, slot_length, floor_thick]
```


#### Add class only “types”


**uart_holder**
```
DESCRIPTION: console uart holder

USES: none
```

**batt_holder**
```
DESCRIPTION: rtc battery holder

USES: none
```

**standoff**
```
DESCRIPTION: user defined standoff

USES: data_4=

            [ 6.75, // radius
              5,    // height
              3.6,  // holesize
              10,   // supportsize
              4,    // supportheight
              1,    // 0=none, 1=countersink, 2=recessed hole, 3=nut holder, 4=blind hole
              0,    // standoff style 0=hex, 1=cylinder
              0,    // enable reverse standoff
              0,    // enable insert at top of standoff
              4.5,  // insert hole dia. mm
              5.1]  // insert depth mm
```

**hd_holder**
```
DESCRIPTION: double stacked holder for 2.5 and 3.5 drives

USES: data_1=2.5 or 3.5, data_3=”portrait” or “landscape”
```

**hd_vertleft_holder**
```
DESCRIPTION: vertical left side holder for 2.5 and 3.5 drives

USES: data_1=2.5 or 3.5, data_3=”portrait” or “landscape”
```

**hd_vertright_holder**
```
DESCRIPTION: vertical right side holder for 2.5 and 3.5 drives

USES: data_1=2.5 or 3.5, data_3=”portrait” or “landscape”
```

**hc4_oled_holder**
```
DESCRIPTION: hc4 oled holder

USES: size_z=floorthick
```

**access_port**
```
DESCRIPTION: bottom access for sd and emmc

USES: size_z=floorthick, data_3=”portrait” or “landscape”
```

**button**
```
DESCRIPTION: button top and plunger

USES: size_x=diameter,size_z=height, data_0=”reccess”, data_1=radius, data_2=post height
```

**pcb_holder**
```
DESCRIPTION: pcb bottom edge holder

USES: size_x=pcb_x,size_y=pcb_y,size_z=pcb_z, data_1=wall_thick
```

**boom_grill**
```
DESCRIPTION: hk boom bonnet grill covers

USES: data_3="flat", "dome", "frame"
```

**boom_speaker_holder**
```
DESCRIPTION: hk boom bonnet speaker friction holder

USES: data_1="friction","clamp", data_2=tolorence
```

**nut_holder**
```
DESCRIPTION: nut holder

USES: size_x=top diameter or x size in mm, size_y=bottom diameter or y size in mm, size_z=holder height in mm, data_0="m2" or "m2.5" or "m3" or "m4", data_1="default" or "sloped" or "trap"
```

#### Sub class only “types”


**punchout**
```
DESCRIPTION: punchout in rectangle, round or slot shape

USES: size_x=width, size_y=depth, data_1=gap, size_z=thick, data_2=fillet, data_3="rectangle","round" or "slot"
```

**vent**
```
DESCRIPTION: horizontal or vertical vent openings

USES: size_x=open_width, size_y=open_length, size_z=thick, data_1=rows, data_2=columns,
data_3=orientation("vertical","horizontal"), data_4=gap
```

**vent_hex**(cells_x, cells_y, cell_size, cell_spacing, orientation)
```
DESCRIPTION: horizontal or vertical hex vent openings

USES: size_x=cells_x, size_y=cells_y, size_z=thick, data_1=cell_size, data_2=cell_spacing, 
data_3=orientation("vertical","horizontal")
```

**fan**
```
DESCRIPTION: fan opening

USES: size_x=size, size_z=thick, date_1=style(0=open, 1=fan_1, 2=fan_2, 3=fan_hex)
```

**hd_holes**
```
DESCRIPTION: bottom hole pattern for 2.5 or 3.5 drives

USES: data_1=2.5 or 3.5, data_2=thick, data_3=”portrait” or “landscape”
```

**hd_vertleft_holes**
```
DESCRIPTION: bottom hole pattern for 2.5 or 3.5 drives

USES: data_1=2.5 or 3.5, data_2=thick, data_3=”portrait” or “landscape”
```

**hd_vertright_holes**
```
DESCRIPTION: bottom hole pattern for 2.5 or 3.5 drives

USES: data_1=2.5 or 3.5, data_2=thick, data_3=”portrait” or “landscape”-component mask(incomplete)
```

**microusb**
```
DESCRIPTION: micro usb opening

USES: none
```

**sphere**
```
DESCRIPTION: sphere subtraction

USES: size_x=diameter
```


#### Model class “types”


**uart_strap**
```
DESCRIPTION: console uart holder strap

USES: none
```

**fan_cover**
```
DESCRIPTION: cover for fan hole opening

USES: size_x=fan size, size_z=thick, data_1=style (0=open, 1=fan_1, 2=fan_2, 3=fan_hex)
```

**hd25**
```
DESCRIPTION: 2.5 hard drive

USES: data_1=height
```

**hd35**
```
DESCRIPTION: 3.5 hard drive

USES: none
```

**hc4_oled**
```
DESCRIPTION: hc4_oled model

USES: none
```

**feet**
```
DESCRIPTION: case feet

USES: size_x=diameter, size_z=height
```

**access_cover**
```
DESCRIPTION: bottom access cover for sd and emmc

USES: size_z=floorthick, data_3=”portrait” or “landscape”
```

**button_top**
```
DESCRIPTION: button top and plunger

USES: size_x=diameter,size_z=height, data_3=”reccess”
```

**h2_netcard**
```
DESCRIPTION: h2 network card model

USES: none
```

**hk_lcd35**
```
DESCRIPTION: hk 3.5 inch lcd model

USES: none
```

**hk_boom**
```
DESCRIPTION: hk stereo boom bonnet model

USES: data_1=speakers(true or false), data_3=”front” or "rear"
```

**boom_speaker**
```
DESCRIPTION: hk stereo boom bonnet speaker

USES: data_1=pcb(true or false), data_3=”left” or "right"
```

**hk_speaker**
```
DESCRIPTION: hk speaker model

USES: none
```

**boom_vring**
```
DESCRIPTION: hk stereo boom bonnet volume wheel extention

USES: data_1=tolerence
```

**hk_uart**
```
DESCRIPTION: hk console uart model

USES: none
```

**h3_port_extender**
```
DESCRIPTION: h3 usb port extender model

USES: data_3="header" or "remote"
```

**hk_pwr_button**
```
DESCRIPTION: hk power button model

USES: none
```

**dsub**
```
DESCRIPTION: d-sub connectors

USES: data4=[pin, type("male" or "female"), floor_thick]
```

**vent_panel_hex**
```
DESCRIPTION: cover for vent opening, honeycomb pattern

USES: size_x=x, size_y=y, size_z=thick,
        data1=cell_size, data2=cell_spacing, 
        data3="x", "y", "none", or "default", data4=border
```
#### Platter class “types”


**uart_strap**
```
DESCRIPTION: console uart holder strap

USES: none
```

**fan_cover**
```
DESCRIPTION: cover for fan hole opening

USES: size_x=40 or 80, size_z=thick
```

**access_cover**
```
DESCRIPTION:bottom access cover for sd and emmc

USES: size_z=floorthick, data_3=”portrait” or “landscape”
```

**button_top**
```
DESCRIPTION: button top and plunger

USES: size_x=diameter,size_z=height, data_3=”reccess”
```

**boom_vring**
```
DESCRIPTION: hk stereo boom bonnet volume wheel extention

USES: data_1=tolerence
```

**vent_panel_hex**
```
DESCRIPTION: cover for vent opening, honeycomb pattern

USES: size_x=x, size_y=y, size_z=thick,
        data1=cell_size, data2=cell_spacing, 
        data3="x", "y", "none", or "default", data4=border
```

### Accuracy
In the past there was been no way of validating whether a SBC Model Framework model and it’s components were dimensionaly accurate in their size and placement other then trial and error. Along with producing cases this project provides a much needed model validation tool to assure model accuracy thru the use of test cases. It works on the very simple premise that if the real SBC fits the test case then the virtual model is accurate or otherwise shows were corrections are needed. This will further increased the overall accuracy of models.

Some SBC in SBC Model Framework have not been validated or may be missing component data and may produce one or more aspects of a case incorrectly.  SBC status is noted in sbc.png, the README.md file and at the beginning of the SBC entry defined in sbc_models.cfg, all a part of SBC Model Framework.  The color coded indicator of an SBC’s verification and completion as indicated in sbc.png is as follows:

- GREEN = verified, complete and passes SBC Case Builder
- YELLOW = unverified, mostlikely usable and/or missing minor information
- ORANGE = unverified, may be usable but missing component data
- RED = unverified, not usable due to incomplete component data

The SBC that I do not own have been created using manufacturer supplied mechanical drawings.  Some of the drawings are missing information or have errors that effect all or part of the drawings and subsequent SBC models.  If you own an SBC that is not represented or verified in SBC Model Framework, please consider adding it or helping to correct errors in existing SBC data.  An SBC can be verified to be accurate if a printed shell case from SBC Case Builder fits.  Any misalignment is corrected in the SBC Model Framework model data(sbc_models.cfg).

### Future Development

There are a few more ideas for base cases to be worked on as well as a host of supporting accessory models that need to be created.  It would also be nice to have all of the OEM accessories for each SBC in the library as well.  I’m still looking for a better way to create accessory entries and groups, and  continue to expand and verify as many SBC as possible. With that and the obvious benefit of autonomously making SBC cases, this project has also been helping fulfill another personal goal.

Computer aided design(CAD) has been around along time but I have been interested in exploring approaches to the next step, computer autonomous design.  Regardless of the current or future object creation method, whether it be manufactured or materialized, I believe a universal approach to autonomous design will be needed to advance the human condition.  This application has helped me explore and think about practical approaches that might be possible right now in autonomous design and I hope to continue this work by developing new tools and techniques for the new CAD, Computer Autonomous Design.

