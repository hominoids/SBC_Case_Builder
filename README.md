# SBC Case Builder


## Introduction

This project is about autonomous SBC case creation. It utilizes the SBC Model Framework project to automatically generate cases based on the data for any of the current devices contained within the framework. This allows legacy, current and future SBC to have multiple cases available on day one of their inclusion in the framework. There are multiple base case designs available (shell, panel, stacked, tray, tray-sides, round, hex, snap, fitted, folded-paper and standard motherboard adapters) and each allows for customization within the design.

All case openings are created automatically based on SBC data and the dimensions of any case design can be expanded in any axis allowing for the creation of larger cases. If you reposition the SBC in a case, you will see I/O openings created or removed appropriately based on their proximity to the case geometry. These cases might be useful for prototypes or other in house uses to quickly and easily create standard, specialized and custom SBC cases thru different case designs, customization and accessories.

License: GPLv3.

![Image](SBC_Case_Builder_Cases.gif)

### Install
```
  git clone https://github.com/hominoids/SBC_Case_Builder.git
  cd SBC_Case_Builder
  git submodule init
  git submodule update

```

## SBC Case Builder Features:
-  Autonomous Multi-SBC, Multi-Case Parametric Generation
-  Autonomous SBC and Accessory Model I/O Openings
-  Autonomous Case Standoffs with Variable Height
-  Extended Standoff SBC collision detection
-  Accessory Customization Framework
-  Accessory Multi-Associative Parametric Positioning
   - Absolute Location
   - Case Associations
   - SBC Associations
   - SBC_X,Y - Case_Z Association
-  Graphical User Interface
-  SBC Meta Data Access
-  Individual Standoff Parameter Control
-  Dynamic Heatsink Fan Size, Vent and Mask Openings 
-  Top and Bottom Case Cover Patterns
-  Parametric Bottom Access Panel


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
- Standard MB SBC Adapters & io plates - completed
	+ SSI-EEB, SSI-CEB, ATX, Micro-ATX, DTX, Flex-ATX, Mini-DTX, Mini-Itx, Mini-ITX Thin, Mini-STX, Mini-STX Thin
- Standard MB Cases - completed
	+ SSI-EEB, SSI-CEB, ATX, Micro-ATX, DTX, Flex-ATX, Mini-DTX, Mini-ITX, Mini-ITX Thin, Mini-STX, Mini-STX Thin, Nano-ITX, NUC, Pico-ITX
- Sheet Metal, Folded
- Sliding
- Cylinder
- Free Form
- NAS
- Rack
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

## Notes

Due to the number of possibilities, no pre-compiled case stl’s are included.

“tol”, located at the bottom of the Adjustments Tab, is a  tolerance fitment adjustment for the snap, fitted, round and hex tops.  Adjust accordingly if the tops are too tight or loose.

## Case Designs and Styles
The case naming convention for standard cases in the configuration file follow the basic form of “sbc”_”design”_”style” e.g. c4_shell or c4_tray_vu5.

## Accessory Schema
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
  
Every type, regardless of its class, uses a basic set of variables
`(loc_x,loc_y,loc_z,”face”,rotation[],parametrics[])`
but each type doesn’t necessarily use all available data fields
`(size[],data[])`

The parametric array specifies the axis to enable for associated parametric positoning. An accessory can be associated with the sbc position("sbc"), case offset("case"),multi-associated which use sbc xy postion and case z offset(sbc-case_z) or use absolute values if all axises are false.

### classes: add1, sub, suball, add2, model, platter

Class “add1” and “add2” are used to add geometry to the case. The difference is when the addition occurs. “add1” happens at the beginning when the core case geometry is created before any subtractions and add2 happens at the end after all subtractions have occurred. “suball” is used to affect all faces of a case, not just a single face. The “face” is the case piece that will be effected by the addition or subtraction. The "model" class is for placing supporting accessories in the model view. e.g. hard drives, fans. The "platter" class is for adding supporting accessories to the print platter.


**additive type:**

circle, rectangle, slot, text, art, standoff, batt_holder, uart_holder, hd_holder, hd_holes, hd_vertright_holes, hc4_oled_holder, access_panel, button, pcb_holder, boom_grill, boom_speaker_holder


**subtractive type:**

circle, rectangle, slot, text, art, punchout, vent, fan, hd_holes, hd_vertleft_holes, hd_vertright_holes, microusb, sphere


**model type:**

uart_strap, fan_cover, hd25, hd35, hc4_oled, feet, access_cover, net_card, hk35_lcd, hk_boom, boom_speaker, boom_vring, hk_uart


**platter type:**

uart_strap, fan_cover, access_cover, button_assembly, boom_vring


## Accessory Reference Manual


### Add1 and Add2 class “types”


### access_cover

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates bottom access cover for access panels.
       MASK: no
      USAGE: "class", "access_cover", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "access_cover"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = x dimension
            size[1] = y dimension
            size[2] = floor thickness
            data[0] = "portrait", "landscape"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### access_panel

```
    CLASSES: add2
DESCRIPTION: creates bottom access panels.
       MASK: yes
      USAGE: "class", "access_panel", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "access_panel"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = x dimension
            size[1] = y dimension
            size[2] = floor thickness
            data[0] = "portrait", "landscape"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### art

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts art work geometry in dxf or svg format.
       MASK: no
      USAGE: "class", "art", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "art"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = scale
            data[1] = height
            data[2] = "file"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### battery_holder

```
    CLASSES: add1, add2
DESCRIPTION: creates battery holder for coin cr2032 batteries.
       MASK: no
      USAGE: "class", "battery_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "battery_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = tolerance adjustment
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### button

```
    CLASSES: add2
DESCRIPTION: adds various button styles.
       MASK: yes
      USAGE: "add2", "button", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "button"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = diameter of button body for recess style
            size[1] = not used
            size[2] = height above button for recess style
            data[0] = "recess", "cutout"
            data[1] = radius for cutout style
            data[2] = button post size for cutout style
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### button_assembly

```
    CLASSES: add2, platter
DESCRIPTION: adds button assembly for recess button style.
       MASK: yes
      USAGE: "add2", "button_assembly", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "button_assembly"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = diameter of button body for recess style
            size[1] = not used
            size[2] = height above button for recess style
            data[0] = "recess"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### fan_cover

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates fan cover for fan openings.
       MASK: no
      USAGE: "class", "fan_cover", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "fan_cover"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = fan size
            size[1] = not used
            size[2] = cover thickness
            data[0] = "fan_open", "fan_1", "fan_2", "fan_hex"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### feet

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates case feet.
       MASK: no
      USAGE: "class", "feet", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "feet"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = feet diameter
            size[1] = not used
            size[2] = feet height
             data[] = not used
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hd_holder

```
    CLASSES: add1, add2
DESCRIPTION: creates a horizontal double stacked holder for 2.5 and 3.5 drives.
       MASK: no
      USAGE: "class", "hd_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "hd_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = 2.5 or 3.5
            data[1] = ”portrait”, “landscape”
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hd_vertleft_holder

```
    CLASSES: add1, add2
DESCRIPTION: creates a vertical left facing holder for 2.5 and 3.5 drives.
       MASK: no
      USAGE: "class", "hd_vertleft_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "hd_vertleft_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = 2.5 or 3.5
            data[1] = ”portrait”, “landscape”
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hd_vertright_holder

```
    CLASSES: add1, add2
DESCRIPTION: creates a vertical right facing holder for 2.5 and 3.5 drives.
       MASK: no
      USAGE: "class", "hd_vertright_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "hd_vertright_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = 2.5 or 3.5
            data[1] = ”portrait”, “landscape”
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_boom_grill

```
    CLASSES: add2
DESCRIPTION: creates hk boom bonnet grill covers.
       MASK: yes
      USAGE: "class", "hk_boom_grill", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "hk_boom_grill"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = not used
            size[1] = not used
            size[2] = wall thickness
            data[0] = "flat", "dome", "frame"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_boom_speaker_holder

```
    CLASSES: add2, platter
DESCRIPTION: creates hk boom bonnet speaker clamp and friction style holder.
       MASK: no
      USAGE: "class", "hk_boom_speaker_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "hk_boom_speaker_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = "friction", "clamp"
            data[1] = tolerance adjustment
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_boom_vring

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates hk stereo boom bonnet volume wheel extention.
       MASK: no
      USAGE: "class", "hk_boom_vring", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "hk_boom_vring"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = tolerance adjustment
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_h3_port_extender_holder

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates odroid-h3 port extender holder parts.
       MASK: no
      USAGE: "class", "hk_h3_port_extender_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "hk_h3_port_extender_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = distance from mount face
            data[1] = "top", "bottom", "both"
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_hc4_oled_holder

```
    CLASSES: add2
DESCRIPTION: creates a holder for the hk odroid-hc4 oled display.
       MASK: yes
      USAGE: "class", "hk_hc4_oled_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "hk_hc4_oled_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = not used
            size[1] = not used
            size[2] = floor thickness
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_uart_holder

```
    CLASSES: add2
DESCRIPTION: creates a holder for the hk micro-usb uart.
       MASK: yes
      USAGE: "class", "hk_uart_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "hk_uart_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_uart_strap

```
    CLASSES: add2, platter
DESCRIPTION: creates a strap for the hk micro-usb uart holder.
       MASK: no
      USAGE: "class", "hk_uart_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "hk_uart_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### keyhole

```
    CLASSES: add1, add2
DESCRIPTION: creates enclosed keyhole.
       MASK: yes
      USAGE: "class", "keyhole", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "keyhole"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = [head_dia, slot_width, slot_length, floor_thick]
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### nut_holder

```
    CLASSES: add1, add2
DESCRIPTION: creates nut holder of various styles.
       MASK: no
      USAGE: "class", "nut_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "nut_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = top diameter or x size in mm
            size[1] = bottom diameter or y size in mm
            size[2] = holder height in mm
            data[0] = "m2", "m2.5", "m3", "m4"
            data[1] = "default", "sloped", "trap"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### pcb_holder

```
    CLASSES: add1, add2
DESCRIPTION: creates pcb holder for vertical mounting.
       MASK: no
      USAGE: "class", "pcb_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "pcb_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = pcb x size in mm
            size[1] = pcb y size in mm
            size[2] = pcb z size in mm
            data[0] = holder wall thickness
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### rectangle

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts rectangular geometry with individual defined corner fillets. 
             Radius1 is lower left corner then moves clockwise.
       MASK: no
      USAGE: "class", "rectangle", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "rectangle"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = width
            size[1] = depth
            size[2] = height
            data[0] = [radius1, radius2, radius3, radius4]
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### round

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts circular geometry.
       MASK: no
      USAGE: "class", "round", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "round"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = diameter
            size[1] = not used
            size[2] = height
             data[] = not used
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### slot

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts slot geometry.
       MASK: no
      USAGE: "class", "slot", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "slot"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = diameter
            size[1] = length
            size[2] = height
             data[] = not used
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### sphere

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts sphere geometry.
       MASK: no
      USAGE: "class", "sphere", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "sphere"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = diameter
            size[1] = not used
            size[2] = not used
             data[] = not used
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### standoff

```
    CLASSES: add2
DESCRIPTION: creates standoffs.
       MASK: yes
      USAGE: "add2", "standoff", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "standoff"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = [size,diameter,height,holesize,supportsize,supportheight,sink,pillarstyle,pillarsupport,reverse,insert_e,i_dia,i_depth]

                       size = "m2_tap","m2","m2+","m2.5_tap","m2.5","m2.5+","m3_tap","m3","m3+","m4_tap","m4","m4+","custom"
                       diameter = pillar radius
                       height = total height
                       holesize = hole diameter
                       supportsize = support size for sink
                       supportheight = height of support for sink
                       sink = "none", "countersunk", "recessed", "nut holder", "blind"
                       pillarstyle = "hex", "round"
                       pillarsupport = "none", "left", "rear", "front", "right"
                       reverse = true or false
                       insert_e = true or false
                       i_dia = insert diameter
                       i_depth = insert hole depth

            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### text

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts raised or sunk text geometry.
       MASK: no
      USAGE: "class", "text", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "text"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = text size
            data[1] = "text"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### vent_panel_hex

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates hex pattern covers for vent openings.
       MASK: no
      USAGE: "class", "vent_panel_hex", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "vent_panel_hex"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = #rows
            size[1] = #columns
            size[2] = thickness
            data[0] = size of hex
            data[1] = space between hex
            data[2] = size of borber
            data[3] = type of border "none", "default"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


## Sub and Suball class “types”


### art

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts art work geometry in dxf or svg format.
       MASK: no
      USAGE: "class", "art", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "art"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = scale
            data[1] = height
            data[2] = "file"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### fan_mask

```
    CLASSES: sub, suball
DESCRIPTION: creates fan openings in various styles and sizes.
       MASK: no
      USAGE: "class", "fan_mask", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "sub", "suball"
               type = "fan_mask"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = fan size of opening
            size[1] = not used
            size[2] = thickness
            data[0] = "fan_open", "fan_1", "fan_2", "fan_hex"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hd_holes

```
    CLASSES: sub, suball
DESCRIPTION: creates hard drive holes for 2.5 and 3.5 drives in various orientations.
       MASK: no
      USAGE: "class", "hd_holes", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "sub", "suball"
               type = "hd_holes"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = 2.5 or 3.5
            data[1] = "portrait", "landscape"
            data[2] = "left", "right", "both", "bottom", "all"
            data[3] = floor thickness
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### knockout

```
    CLASSES: sub, suball
DESCRIPTION: creates knockouts in rectangle, round or slot shape.
       MASK: no
      USAGE: "class", "knockout", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "sub", "suball"
               type = "knockout"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = length
            size[1] = height
            size[2] = thickness
            data[0] = gap
            data[1] = fillet size
            data[2] = "slot", "rectangle", "round"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### rectangle

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts rectangular geometry with individual defined corner fillets. 
             Radius1 is lower left corner then moves clockwise.
       MASK: no
      USAGE: "class", "rectangle", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "rectangle"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = width
            size[1] = depth
            size[2] = height
            data[0] = [radius1, radius2, radius3, radius4]
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### round

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts circular geometry.
       MASK: no
      USAGE: "class", "round", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "round"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = diameter
            size[1] = not used
            size[2] = height
             data[] = not used
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### slot

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts slot geometry.
       MASK: no
      USAGE: "class", "slot", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "slot"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = diameter
            size[1] = length
            size[2] = height
             data[] = not used
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### sphere

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts sphere geometry.
       MASK: no
      USAGE: "class", "sphere", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "sphere"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = diameter
            size[1] = not used
            size[2] = not used
             data[] = not used
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### text

```
    CLASSES: add1, add2, sub, suball
DESCRIPTION: creates or subtracts raised or sunk text geometry.
       MASK: no
      USAGE: "class", "text", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "sub", "suball"
               type = "text"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = text size
            data[1] = "text"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### vent

```
    CLASSES: sub, suball
DESCRIPTION: creates horizontal or vertical vent openings.
       MASK: no
      USAGE: "class", "vent", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "sub", "suball"
               type = "vent"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = coloumn size_x
            size[1] = column size_y
            size[2] = height
            data[0] = #row
            data[1] = #columns
            data[2] = "horizontal", "vertical"
            data[3] = gap size
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### vent_hex

```
    CLASSES: sub, suball
DESCRIPTION: creates horizontal or vertical hex vent openings.
       MASK: no
      USAGE: "class", "vent_hex", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "sub", "suball"
               type = "vent_hex"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = #rows
            size[1] = #columns
            size[2] = thickness
            data[0] = size of hex
            data[1] = space between hex
            data[2] = "horizontal", "vertical"
            data[3] = gap size
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


## Model class “types”


### adafruit_lcd

```
    CLASSES: model
DESCRIPTION: creates bottom access cover for access panels.
       MASK: yes
      USAGE: "model", "adafruit_lcd", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "adafruit_lcd"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### dsub

```
    CLASSES: model
DESCRIPTION: creates db connectors.
       MASK: yes
      USAGE: "model", "dsub", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "dsub"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = "db9"
            data[1] = "female"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### fan

```
    CLASSES: model
DESCRIPTION: creates db connectors.
       MASK: yes
      USAGE: "model", "fan", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "fan"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = "box30x10","box40x10","box50x10","box60x10","box80x10","box80x25","box92x10","box92x25","box120x25","box140x25"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default", "fan_open", "fan_1", "fan_2", "fan_hex"
```


### hd25

```
    CLASSES: model
DESCRIPTION: creates a 2.5 hard drive model.
       MASK: yes
      USAGE: "model", "hd25", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hd25"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = "landscape", "portrait"
            data[1] = height
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default", "bottom", "side", "both"
```


### hd35

```
    CLASSES: model
DESCRIPTION: creates a 3.5 hard drive model.
       MASK: yes
      USAGE: "model", "hd35", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hd35"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = "landscape", "portrait"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default", "bottom", "side", "both"
```


### hk_h3_port_extender

```
    CLASSES: model
DESCRIPTION: creates hk port extender model.
       MASK: yes
      USAGE: "model", "hk_h3_port_extender", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_h3_port_extender"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = "header", "remote"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_boom

```
    CLASSES: model
DESCRIPTION: creates hardkernel boom bonnet model.
       MASK: yes
      USAGE: "model", "hk_boom", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_boom"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = true, false speakers
            data[1] = "front", "rear" facing 
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_boom_speaker

```
    CLASSES: model
DESCRIPTION: creates hk stereo boom bonnet speaker model.
       MASK: yes
      USAGE: "model", "hk_boom_speaker", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_boom_speaker"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_boom_speaker_pcb

```
    CLASSES: model
DESCRIPTION: creates hk stereo boom bonnet speaker pcb mounted model.
       MASK: yes
      USAGE: "model", "hk_boom_speaker_pcb", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_boom_speaker_pcb"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = true, false pcb
            data[1] = "left", "right"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_hc4_oled

```
    CLASSES: model
DESCRIPTION: creates hk odroid-hc4 oled model.
       MASK: yes
      USAGE: "model", "hk_hc4_oled", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_hc4_oled"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_lcd35

```
    CLASSES: model
DESCRIPTION: creates hk 3.5" lcd model.
       MASK: yes
      USAGE: "model", "hk_lcd35", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_lcd35"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_m1s_ups

```
    CLASSES: model
DESCRIPTION: creates hk odroid-m1s ups model.
       MASK: yes
      USAGE: "model", "hk_m1s_ups", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_m1s_ups"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_netcard

```
    CLASSES: model
DESCRIPTION: creates hk 4 port 2.5gb netcard model.
       MASK: yes
      USAGE: "model", "hk_netcard", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_netcard"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_pwr_button

```
    CLASSES: model
DESCRIPTION: creates hk backlite power button model.
       MASK: yes
      USAGE: "model", "hk_pwr_button", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_pwr_button"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_speaker

```
    CLASSES: model
DESCRIPTION: creates hk speaker model.
       MASK: yes
      USAGE: "model", "hk_speaker", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_speaker"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_uart

```
    CLASSES: model
DESCRIPTION: creates hk micro-usb uart model.
       MASK: yes
      USAGE: "model", "hk_uart", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_uart"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```



### hk_vu7c

```
    CLASSES: model
DESCRIPTION: creates hk vu7c model with optional gpio extension and tabs.
       MASK: yes
      USAGE: "model", "hk_vu7c", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_vu7c"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = true, false gpio_ext
            data[1] = true, false tabs
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_vu8m

```
    CLASSES: model
DESCRIPTION: creates hk vu8m model with optional brackets.
       MASK: yes
      USAGE: "model", "hk_vu8m", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_vu8m"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = true, false brackets
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_vu8s

```
    CLASSES: model
DESCRIPTION: creates hk vu8s model.
       MASK: yes
      USAGE: "model", "hk_vu8s", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_vu8s"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_wb2

```
    CLASSES: model
DESCRIPTION: creates hk weather board 2 model.
       MASK: no
      USAGE: "model", "hk_wb2", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_wb2"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_xu4_shifter_shield

```
    CLASSES: model
DESCRIPTION: creates hk odroid-xu5 level shifter shield model.
       MASK: yes
      USAGE: "model", "hk_xu4_shifter_shield", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "model"
               type = "hk_xu4_shifter_shield"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### stl_model

```
    CLASSES: add1, add2
DESCRIPTION: adds stl models.
       MASK: no
      USAGE: "class", "stl_model", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "stl_model"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = scale
            data[1] = "file"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


## Platter class “types”


### access_cover

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates bottom access cover for access panels.
       MASK: no
      USAGE: "class", "access_cover", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "access_cover"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = x dimension
            size[1] = y dimension
            size[2] = floor thickness
            data[0] = "portrait", "landscape"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### button_assembly

```
    CLASSES: add2, platter
DESCRIPTION: adds button assembly for recess button style.
       MASK: yes
      USAGE: "add2", "button_assembly", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "button_assembly"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = diameter of button body for recess style
            size[1] = not used
            size[2] = height above button for recess style
            data[0] = "recess"
            mask[0] = true
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### fan_cover

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates fan cover for fan openings.
       MASK: no
      USAGE: "class", "fan_cover", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "fan_cover"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = fan size
            size[1] = not used
            size[2] = cover thickness
            data[0] = "fan_open", "fan_1", "fan_2", "fan_hex"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### feet

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates case feet.
       MASK: no
      USAGE: "class", "feet", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "feet"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = feet diameter
            size[1] = not used
            size[2] = feet height
             data[] = not used
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_boom_speaker_holder

```
    CLASSES: add2, platter
DESCRIPTION: creates hk boom bonnet speaker clamp and friction style holder.
       MASK: no
      USAGE: "class", "hk_boom_speaker_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "hk_boom_speaker_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = "friction", "clamp"
            data[1] = tolerance adjustment
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_boom_vring

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates hk stereo boom bonnet volume wheel extention.
       MASK: no
      USAGE: "class", "hk_boom_vring", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "hk_boom_vring"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = tolerance adjustment
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_h3_port_extender_holder

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates odroid-h3 port extender holder parts.
       MASK: no
      USAGE: "class", "hk_h3_port_extender_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2", "platter"
               type = "hk_h3_port_extender_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
            data[0] = distance from mount face
            data[1] = "top", "bottom", "both"
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### hk_uart_strap

```
    CLASSES: add2, platter
DESCRIPTION: creates a strap for the hk micro-usb uart holder.
       MASK: no
      USAGE: "class", "hk_uart_holder", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add2"
               type = "hk_uart_holder"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
             size[] = not used
             data[] = not used
            mask[0] = false
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


### vent_panel_hex

```
    CLASSES: add1, add2, platter
DESCRIPTION: creates hex pattern covers for vent openings.
       MASK: no
      USAGE: "class", "vent_panel_hex", loc_x, loc_y, loc_z, face, rotation[], parametric[], size[], data[], mask[]

              class = "add1", "add2"
               type = "vent_panel_hex"
              loc_x = x location placement
              loc_y = y location placement
              loc_z = z location placement
               face = "top", "bottom", "right", "left", "front", "rear"
         rotation[] = object rotation
       parametric[] = "case", "sbc", "sbc-case_z"
            size[0] = #rows
            size[1] = #columns
            size[2] = thickness
            data[0] = size of hex
            data[1] = space between hex
            data[2] = size of borber
            data[3] = type of border "none", "default"
            mask[0] = false, not used
            mask[1] = length
            mask[2] = set back
            mask[3] = mstyle "default"
```


## Accuracy
In the past there was been no way of validating whether a SBC Model Framework model and its components were dimensionaly accurate in their size and placement other then trial and error. Along with producing cases this project provides a much needed model validation tool to assure model accuracy thru the use of test cases. It works on the very simple premise that if the real SBC fits the test case then the virtual model is accurate or otherwise shows were corrections are needed. This will further increased the overall accuracy of models.

Some SBC in SBC Model Framework have not been validated or may be missing component data and may produce one or more aspects of a case incorrectly.  SBC status is noted in sbc.png, the README.md file and at the beginning of the SBC entry defined in sbc_models.cfg, all a part of SBC Model Framework.  The color coded indicator of an SBC’s verification and completion as indicated in sbc.png is as follows:

- GREEN = verified, complete and passes SBC Case Builder
- YELLOW = unverified, mostlikely usable and/or missing minor information
- ORANGE = unverified, may be usable but missing component data
- RED = unverified, not usable due to incomplete component data

The SBC that I do not own have been created using manufacturer supplied mechanical drawings.  Some of the drawings are missing information or have errors that effect all or part of the drawings and subsequent SBC models.  If you own an SBC that is not represented or verified in SBC Model Framework, please consider adding it or helping to correct errors in existing SBC data.  An SBC can be verified to be accurate if a printed shell case from SBC Case Builder fits.  Any misalignment is corrected in the SBC Model Framework model data(sbc_models.cfg).

## Future Development

There are a few more ideas for base cases to be worked on as well as a host of supporting accessory models that need to be created.  It would also be nice to have all of the OEM accessories for each SBC in the library as well.  I’m still looking for a better way to create accessory entries and groups, and  continue to expand and verify as many SBC as possible. With that and the obvious benefit of autonomously making SBC cases, this project has also been helping fulfill another personal goal.

Computer aided design(CAD) has been around along time but I have been interested in exploring approaches to the next step, computer autonomous design.  Regardless of the current or future object creation method, whether it be manufactured or materialized, I believe a universal approach to autonomous design will be needed to advance the human condition.  This application has helped me explore and think about practical approaches that might be possible right now in autonomous design and I hope to continue this work by developing new tools and techniques for the new CAD, Computer Autonomous Design.

