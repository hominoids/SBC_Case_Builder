/*
    SBC Case Builder Library Copyright 2022 Edward A. Kisiel, hominoid @ www.forum.odroid.com
    
    Contributions:
    hk_vu8m(brackets),u_bracket(),screw(),m1_hdmount() Copyright 2022 Tomek Szczęsny, mctom @ www.forum.odroid.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    Code released under GPLv3: http://www.gnu.org/licenses/gpl.html

    20220212 version 1.1.0 SBC Case Builder Library
    20220220 version 1.1.1 added fan_cover(size, thick), hd_mount(hd,orientation), hd25_tab(side)
                           hd35_tab(side), hd_bottom_holes(hd,orientation,thick)
                           adjusted hd35(), other fixes and maintenance
    20220227 version 1.1.2 adjusted hd25(), hd35(), updated hd_mount(hd,orientation,position,side),
                           hd_bottom_holes(hd,orientation,position,side,thick), hd25_tab(side), hd35_tab(side)
                           added hd25_vtab(side), hc4_oled() rotated 180, 
                           added pcb_z to mask(loc_x,loc_y,rotation,side,class,type,case_z,wallthick,gap,floorthick,pcb_z)
                           adjusted hdmi_open() for bottom placment, added hc4_oled_holder(side,floorthick)
                           added buttom to mask(),
    20220306 version 1.1.3 added access_port(size[],orientation), access_cover(size[],orientation), h2_netcard(), rj45(), 
                           button(style, diameter, height), button_plunger(style, diameter, height), button_top(style, 
                           diameter, height), button_clip(style), fixed momentary_6x6x4 mask, adjusted masks,
    20220312 version 1.2.0 rotated slot in hd25_vtab(side),adjusted hc4_oled_holder(side,floorthick), adjust stud(), 
                           added hk35_lcd(),header_5x1(),momentary45x15  
    20220320 version 1.2.1 added hk_boom(speakers,orientation), hk_boom_speaker(side,speaker,pcb), boom_speaker()   
                           replaced header5x1() with header(pins), added encl_header_12(), micro2pin(), audio_jack35(), 
                           capacitor(diameter, height), ic(size), added hk_boom_grill(), boom_speaker_holder(tolerance),
                           pcb_holder(size,wallthick), hk_uart(), usb_micro(), uart_micro(), boom_vring(tolerance), 
                           added tolerance to batt_holder(tolerance)
    20220406 version 1.2.2 hk_wb2(), hk_vu7c(gpio_ext, tabs), hdmi_a(), header_f(pins, height), pcb_pad(pads), 
                           embelished boom_speaker(), changed boom_speaker_holder(style, tolerance), added boom_speaker_strap(),
                           adjusted access_port(), access_cover(), added @mctom's hk_vu8m(bracket), u_bracket(), spacer()
    2022xxxx version 1.2.x removed spacer(); added screw(); modified hk_vu8m(); added m1_hdmount(); added hdd35_25holder(length)
    
    place(x,y,z,size_x,size_y,rotation,side)
    add(type,loc_x,loc_y,loc_z,size_x,size_y,size_z,rotation,face,side,case_z,data_1,data_2,data_3,data_4)
    sub(type,loc_x,loc_y,loc_z,size_x,size_y,size_z,rotation,face,side,case_z,data_1,data_2,data_3,data_4)
    
    art(scale_d1,type,size_z)
    screw(screw[d, l, style])
    slab(size, radius)
    slab_r(size, radius)
    slot(hole,length,depth)
    standoff(standoff[radius,height,holesize,supportsize,supportheight,sink,style,i_dia,i_depth])
    button(style, diameter, height)
    button_assembly(style, diameter, height
    button_plunger(style, diameter, height)
    button_top(style, diameter, height)
    button_clip(style)
    feet (height)
    pcb_holder(size,wallthick)
    batt_holder(tolerance)
    uart_holder()
    uart_strap ()
    fan_cover(size, thick)
    hc4_oled_holder(side,floorthick)
    hd_mount(hd,orientation,position,side)
    hd25_tab(side)
    hd25_vtab(side)
    hd35_tab(side)
    hd_bottom_holes(hd,orientation,position,side,thick)
    hd25(height)
    hd35()
    hdd35_25holder(length)
    hk_wb2()
    hc4_oled()
    h2_netcard()
    hk35_lcd()
    hk_uart()
    hk_vu7c(gpio_ext, tabs)
    hk_vu8m(bracket)
    u_bracket()
    m1_hdmount()
    hdmi_a()
    header_f(pins, height)
    pcb_pad(pads)
    usb_micro()
    uart_micro()
    rj45()
    header(pins)
    momentary45x15
    encl_header_12()
    micro2pin()
    audio_jack35()
    capacitor(diameter, height)
    ic(size)
    hk_speaker()
    hk_boom(speakers,orientation)
    hk_boom_speaker(side,speaker,pcb)
    boom_speaker()
    hk_boom_grill(style,thick)
    boom_speaker_holder(style,tolerance)
    boom_speaker_strap()
    boom_vring(tolerance)
    access_port(size[],orientation)
    access_cover(size[],orientation)
    hdmi_open()
    microusb_open()
    fan_mask(size, thick, style)
    mask(loc_x,loc_y,rotation,side,class,type,case_z,wallthick,gap,floorthick,pcb_z)
    punchout(width,depth,gap,thick,fillet,shape)
    
    
*/

use <./lib/fillets.scad>;

/* placement module *must be first* for children() */
module place(x,y,z,size_x,size_y,rotation,side) {

    if (side == "top") {
        if (rotation == 0 || rotation == 90 || rotation == 180 || rotation == 270) {    
            if ((rotation >= 0 && rotation < 90) || (rotation < -270 && rotation > -360))
                translate([x,y,z]) rotate([0,0,-rotation]) children();

            if ((rotation >= 90 && rotation < 180) || (rotation < -180 && rotation >= -270))
                translate([x,y+size_x,z]) rotate([0,0,-rotation]) children();
           
            if ((rotation >= 180 && rotation < 270) || (rotation < -90 && rotation >= -180))
                translate([x+size_x,y+size_y,z]) rotate([0,0,-rotation]) children(0);
           
            if ((rotation >= 270 && rotation < 360) || (rotation < 0 && rotation >= -90))
                translate([x+size_y,y,z]) rotate([0,0,-rotation]) children(); }
        else {
            translate([x,y,z]) rotate([0,0,-rotation]) children();            
        }
    }   
    if (side == "bottom") {
        if (rotation == 0 || rotation == 90 || rotation == 180 || rotation == 270) {   
            if ((rotation >= 0 && rotation < 90) || (rotation < -270 && rotation > -360))
                translate([x+size_x,y,z]) rotate([0,180,rotation]) children();
           
            if ((rotation >= 90 && rotation < 180) || (rotation < -180 && rotation >= -270))
                translate([x+size_y,y+size_x,z]) rotate([0,180,rotation]) children();
               
            if ((rotation >= 180 && rotation < 270) || (rotation < -90 && rotation >= -180))
                translate([x,y+size_y,z]) rotate([0,180,rotation]) children();
           
            if ((rotation >= 270 && rotation < 360) || (rotation < 0 && rotation >= -90))
                translate([x,y,z]) rotate([0,180,rotation]) children(); }
        else {
            translate([x,y,z]) rotate([0,180,rotation]) children();
            
        }
    }    
    children([1:1:$children-1]);
}


/* addition module */
module add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4) {
    
    if(type == "rectangle") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) slab_r([size_x,size_y,size_z],data_4);
    }
    if(type == "round") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) cylinder(d=size_x,h=size_z);
    }
    if(type == "slot") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) slot(size_x,size_y,size_z);
    }
    if(type == "text") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) linear_extrude(height = size_z) text(data_3, size=data_1);
    }    
    if(type == "art") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) art(data_1,data_2,data_3); 
    }
    if(type == "button") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) button(data_3,[size_x,size_y,size_z],data_4,data_1); 
    }
    if(type == "button_top") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) button_assembly(data_3,size_x,size_z); 
    }
    if(type == "pcb_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) pcb_holder([size_x,size_y,size_z],data_1);
    }
    if(type == "batt_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) batt_holder(data_1);
    }
    if(type == "uart_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) uart_holder();
    }
    if(type == "uart_strap") {
        color("grey",1) translate([loc_x,loc_y,loc_z]) rotate(rotation) uart_strap();
    }
    if(type == "standoff") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) standoff(data_4);
    }
    if(type == "hd_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd_mount(data_1,data_3,"horizontal","none"); 
    }
    if(type == "hd_vertleft") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd_mount(data_1,data_3,"vertical","left"); 
    }
    if(type == "hd_vertright") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd_mount(data_1,data_3,"vertical","right"); 
    }
    if(type == "hd25") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd25(data_1); 
    }
    if(type == "hd35") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd35(); 
    }
    if(type == "hk_wb2") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_wb2(); 
    }
    if(type == "hc4_oled") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hc4_oled(); 
    }
    if(type == "hc4_oled_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hc4_oled_holder(face,size_z); 
    }
    if(type == "h2_netcard") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) h2_netcard(); 
    }
    if(type == "hk_lcd35") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk35_lcd(); 
    }
    if(type == "hk_uart") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_uart(); 
    }
    if(type == "hk_vu7c") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_vu7c(data_1,data_2); 
    }
    if(type == "hk_boom") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom(data_1,data_3); 
    }
    if(type == "boom_speaker") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom_speaker(data_3,true,data_1); 
    }
    if(type == "boom_grill") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom_grill(data_3,size_z); 
    }
    if(type == "boom_speaker_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) boom_speaker_holder(data_1); 
    }
    if(type == "hk_speaker") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_speaker(); 
    }
    if(type == "fan_cover") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) fan_cover(size_x, size_z);
    }
    if(type == "feet") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) feet(size_x, size_z);
    }
    if(type == "access_port") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) access_port([size_x,size_y,size_z],data_3);
    }
    if(type == "access_cover") {
        color("grey",1) translate([loc_x,loc_y,loc_z])  rotate(rotation) access_cover([size_x,size_y,size_z],data_3);
    }
    if(type == "boom_vring") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) boom_vring(data_1);
    }
}


/* subtractive module */
module sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4) {

    if(type == "rectangle") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) slab_r([size_x,size_y,size_z],data_4);
    }
    if(type == "round") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) cylinder(d=size_x,h=size_z);
    }
    if(type == "slot") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) slot(size_x,size_y,size_z);
    }
    if(type == "text") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) linear_extrude(height = size_z) text(data_3, size=data_1);
    }
    if(type == "art") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) art(data_1,data_2,data_3); 
    }
    if(type == "button") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) button(data_3,[size_x,size_y,size_z],data_4,data_1); 
    }
    if(type == "hd_holes") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hd_bottom_holes(data_1,data_3,"none","none",data_2);
    }    
    if(type == "hd_vertleft_holes") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hd_bottom_holes(data_1,data_3,"vertical","left",data_2);
    }    
    if(type == "hd_vertright_holes") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hd_bottom_holes(data_1,data_3,"vertical","right",data_2);
    }    
    if(type == "hk_fan_top") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hk_fan_top();
    }    
    if(type == "punchout") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation)  punchout(size_x,size_y,data_1,size_z,data_2,data_3);
    }    
    if(type == "fan") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) fan_mask(size_x, size_z, data_1);
    }
    if(type == "vent") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) vent(size_x,size_y,size_z,data_4,data_1,data_2,data_3);
    }
}


/* art work module */
module art(scale_d1,size_z,type) {
    
    linear_extrude(height = size_z) import(file = type, scale=scale_d1);

}

// General purpose screw
// screw(screw[d, l, style])
// 	d - thread diameter
// 	l - thread length
// 	style - screw head style
//
// 	Styles:
// 	0 - Mushroom head, 5mm diameter

module screw(screw_type) {
    d = screw_type[0];
    l = screw_type[1];
    style = screw_type[2];

    // Head
        if(style == 0) {
            difference() {
                translate([  0,  0, -0.3]) sphere(2.7);
                translate([-10,-10,-10]) cube([20,20,10]);
                translate([-10,-10,  2]) cube([20,20,10]);
            }
        }
    // Thread
        rotate([180,0,0]) cylinder(d=d, h=l);
}

/* slab module */
module slab(size, radius) {
    
    x = size[0];
    y = size[1];
    z = size[2];   
    linear_extrude(height=z)
    hull() {
        translate([0+radius ,0+radius, 0]) circle(r=radius);	
        translate([0+radius, y-radius, 0]) circle(r=radius);	
        translate([x-radius, y-radius, 0]) circle(r=radius);	
        translate([x-radius, 0+radius, 0]) circle(r=radius);
    }  
}


/* multi-radius round slab */
module slab_r(size, radius) {
    
    x = size[0];
    y = size[1];
    z = size[2];
    r0 = radius[0];
    r1 = radius[1];
    r2 = radius[2];
    r3 = radius[3];
    
    linear_extrude(height=z)
    hull() {
        translate([0+radius[0] ,0+radius[0], 0]) circle(r=radius[0]);	
        translate([0+radius[1], y-radius[1], 0]) circle(r=radius[1]);	
        translate([x-radius[2], y-radius[2], 0]) circle(r=radius[2]);	
        translate([x-radius[3], 0+radius[3], 0]) circle(r=radius[3]);
    }  
}


/* slot module */
module slot(hole,length,depth) {
    
    hull() {
        translate([0,0,0]) cylinder(d=hole,h=depth);
        translate([length,0,0]) cylinder(d=hole,h=depth);        
        }
    } 


/* standoff module
    standoff(standoff[radius,height,holesize,supportsize,supportheight,sink,style,reverse,insert_e,i_dia,i_depth])
        sink=0 none
        sink=1 countersink
        sink=2 recessed hole
        sink=3 nut holder
        sink=4 blind hole
        
        style=0 hex shape
        style=1 cylinder
*/
module standoff(stand_off){

    radius = stand_off[0];
    height = stand_off[1];
    holesize = stand_off[2];
    supportsize = stand_off[3];
    supportheight = stand_off[4];
    sink = stand_off[5];
    style = stand_off[6];
    reverse = stand_off[7];
    insert_e = stand_off[8];
    i_dia = stand_off[9];
    i_depth = stand_off[10];
    
    adjust = 0.1;
    
    difference (){ 
        union () { 
            if(style == 0 && reverse == 0) {
                rotate([0,0,30]) cylinder(d=radius*2/sqrt(3),h=height,$fn=6);
            }
            if(style == 0 && reverse == 1) {
                translate([0,0,-height]) rotate([0,0,30]) cylinder(d=radius*2/sqrt(3),h=height,$fn=6);
            }
            if(style == 1 && reverse == 0) {
                cylinder(d=radius,h=height,$fn=90);
            }
            if(style == 1 && reverse == 1) {
                translate([0,0,-height]) cylinder(d=radius,h=height,$fn=90);
            }
            if(reverse == 1) {
                translate([0,0,-supportheight]) cylinder(d=(supportsize),h=supportheight,$fn=60);
            }
            else {
                cylinder(d=(supportsize),h=supportheight,$fn=60);
            }
        }
        // hole
        if(sink <= 3  && reverse == 0) {
                translate([0,0,-adjust]) cylinder(d=holesize, h=height+(adjust*2),$fn=90);
        }
        if(sink <= 3  && reverse == 1) {
                translate([0,0,-adjust-height]) cylinder(d=holesize, h=height+(adjust*2),$fn=90);
        }
        // countersink hole
        if(sink == 1 && reverse == 0) {
            translate([0,0,-adjust]) cylinder(d1=6.5, d2=(holesize), h=3);
        }
        if(sink == 1 && reverse == 1) {
            translate([0,0,+adjust-2.5]) cylinder(d1=(holesize), d2=6.5, h=3);
        }
        // recessed hole
        if(sink == 2 && reverse == 0) {
            translate([0,0,-adjust]) cylinder(d=6.5, h=3);
        }
        if(sink == 2 && reverse == 1) {
            translate([0,0,+adjust-3]) cylinder(d=6.5, h=3);
        }
        // nut holder
        if(sink == 3 && reverse == 0) {
            translate([0,0,-adjust]) cylinder(r=3.3,h=3,$fn=6);     
        }
        if(sink == 3 && reverse == 1) {
            translate([0,0,+adjust-3]) cylinder(r=3.3,h=3,$fn=6);     
        }
        // blind hole
        if(sink == 4 && reverse == 0) {
            translate([0,0,2]) cylinder(d=holesize, h=height,$fn=90);
        }
        if(sink == 4 && reverse == 1) {
            translate([0,0,-height-2-adjust]) cylinder(d=holesize, h=height,$fn=90);
        }
        if(insert_e > 0 && reverse == 0) {
            translate([0,0,height-i_depth]) cylinder(d=i_dia, h=i_depth+adjust,$fn=90);
        }
        if(insert_e > 0 && reverse == 1) {
            translate([0,0,-height-adjust]) cylinder(d=i_dia, h=i_depth+adjust,$fn=90);
        }
    }
}


/* buttons */
module button(style, size, radius, pad) {

    diameter = size[0];
    height = size[2];
    gap = 1.5;
    adjust = .01;
    $fn = 90;

    if(style == "recess") {
        difference() {
            union() {
                sphere(d=diameter);
                translate([0,0,-height+3]) cylinder(d=6, h=height-6);
            }
            translate([-(diameter/2)-1,-(diameter/2)-1,0]) cube([diameter+2,diameter+2,(diameter/2)+2]);
            difference() {
                union() {
                    sphere(d=diameter-2);
                }
            }
            translate([-1.75,-1.25,-height-1]) cube([3.5,2.5,height+2]);
            translate([0,0,-(diameter/2)]) cylinder(d=5, h=2);
        }
    }
    if(style == "cutout") {
        difference() {
            translate([-size[0]+2,-3-size[1]/2,0]) slab_r([size[0]+2,size[1]+6,size[2]-2*adjust], [.1,.1,.1,.1]);            
            difference() {
                translate([-size[0]+3,-size[1]/2,-adjust]) 
                    slab_r([size[0],size[1],size[2]], [radius[0],radius[1],radius[2],radius[3]]);
                translate([-size[0]+3+(gap/2),-size[1]/2+(gap/2),-1]) slab_r([size[0]-gap,size[1]-gap,1+size[2]+2*adjust], 
                    [radius[0],radius[1],radius[2]-gap/2,radius[3]-gap/2]);
                translate([-size[0]+3-gap,-1,-1]) cube([gap*2,2,1+height+2*adjust]);
            }
            translate([0,0,2]) sphere(d=3);
        }
        translate([0,0,-pad+adjust]) cylinder(d=3, h=pad);
    }
}


/* button plunger,top,clip */
module button_assembly(style, diameter, height) {

adjust = .01;
$fn = 90;

    if(style == "recess") {
        button_plunger(style, diameter, height);
        button_top(style, diameter, height);
        translate([0,0,-height]) button_clip(style);
    }
}


/* button plunger */
module button_plunger(style, diameter, height) {

adjust = .01;
$fn = 90;

    if(style == "recess") {
        difference() {
            translate([-1.5,-1,-(height)-2]) cube([3,2,height+1]);
            translate([-1.5-adjust,-1.5,-height]) cube([.5,3,1]);
            translate([1+adjust,-1.5,-height]) cube([.5,3,1]);
            translate([-1.5-adjust,-1.5,-4]) cube([.5,3,4]);
            translate([1+adjust,-1.5,-4]) cube([.5,3,4]);
        }
    }
}


/* button top */
module button_top(style, diameter, height) {

adjust = .01;
$fn = 90;

    if(style == "recess") {
        difference() {
            translate([0,0,-3]) cylinder(d=5, h=2.75);
            translate([-1.25,-1.25,-3-adjust]) cube([2.5,2.5,2]);
        }
    }
}


/* button c-clip */
module button_clip(style) {

adjust = .01;
$fn = 90;

    if(style == "recess") {
        difference() {
            cylinder(d=8.5, h=.8);
            translate([-1.25,-1.25,-adjust]) cube([2.5,2.5,1]);
            translate([-.75,-.75,-adjust]) cube([5,1.25,1.25]);
        }
    }
}
/* case feet */
module feet (diameter,height) {
    
    difference (){ 
        cylinder (d=diameter,h=height);
        translate([0,0,-1]) cylinder (d=3, h=height+2,$fn=90);
        translate ([0,0,-1]) cylinder(r=3.35,h=height-3,$fn=6);       
    }
}


// pcb bottom edge holder
module pcb_holder(size,wallthick) {
    
    adjust=.01;
    $fn = 90;    
    difference() {
        union() {
            translate([-1.85,-1.75,0]) cube([size[0]+3.5,5,6]);
                translate([size[0]+1.65,-5.75,1]) 
                    rotate([0,-90,0]) 
                    linear_extrude(height = size[0]+3.5) 
                        polygon(points = [ [-wallthick/2,-wallthick/2],
                            [2,wallthick], 
                            [4,4], 
                            [-wallthick/2,4]]);
                translate([-1.85,4,1]) 
                    rotate([0,-90,180]) 
                    linear_extrude(height = size[0]+3.5) 
                        polygon(points = [ [-wallthick/2,-wallthick/2],
                            [2,wallthick], 
                            [2,2], 
                            [-wallthick/2,2]]);
        }
        translate([-.5,0,2]) cube([size[0]+1,size[2],5]);
        translate([6,-adjust-5-1.75,-adjust]) cube([size[0]-12,14,8]);
    }   
}


/* odroid rtc battery holder */
module batt_holder(tolerance) {
    
    $fn = 90;
    difference () {
        cylinder(d=25.5,h=6);
        translate ([0,0,-1]) cylinder(d=20.4+tolerance,h=8);
        cube([14,26,13], true);
    }
    cylinder(r=12.75, h=2);
}


/* odroid uart module holder */
module uart_holder() {

    rotate([0,0,0]) 
    translate ([0,0,0])
        union () {
            difference () {
                translate ([0,0,0]) cube([18,24,9]);
                translate ([2,-2,3]) cube([14,27,7]);
                //pin slot
                translate ([3.5,16,-1]) cube([11,1,5]);
                //component bed
                translate ([3.5,1.5,2]) cube ([11,14,2]);
                //side trim
                translate ([-1,-1,6]) cube([20,18,4]);
            }    
            difference (){
                translate ([-1.5,20,0]) cylinder(r=3,h=9, $fn=90);
                translate ([-1.5,20,-1]) cylinder (r=1.375, h=11, $fn=90);
            }    
            difference (){
                translate ([19.5,20,0]) cylinder(r=3,h=9, $fn=90);
                translate ([19.5,20,-1]) cylinder (r=1.375, h=11,$fn=90);
            }  
        }
    }

    
/* odroid uart strap for holder */
module uart_strap() { 
    difference () {
        translate ([-4.5,17,9]) cube([27,6,3]);
        translate ([-1.5,20,8]) cylinder (r=1.6, h=5, $fn=90);
        translate ([19.5,20,8]) cylinder (r=1.6, h=5, $fn=90);
    }   
    difference (){
        translate ([-1.5,20,12]) cylinder(r=3,h=1, $fn=90);
        translate ([-1.5,20,11]) cylinder (r=1.6, h=7, $fn=90);
    }  
    difference (){
        translate ([19.5,20,12]) cylinder(r=3,h=1, $fn=90);
        translate ([19.5,20,11]) cylinder (r=1.6, h=7, $fn=90);
    }    
}

/* fan cover */
module fan_cover(size, thick) {
    difference() {
        color("grey",1) slab([size,size,thick],3);
        color("grey",1) fan_mask(size, thick, 2);
    }
}


module hk_wb2() {
    difference () {
        union() {
        color("tan") cube([16.5,16.5,1]);
        translate([1.75,15.75,.75]) rotate([180,0,0]) header_f(6,9);
        color("silver") translate([11.5,11.5,1]) cube([2,3,.5]);
        color("silver") translate([11.5,3,1]) cube([2,3,.5]);
        }
    translate([9.6,8.33,-1])
        color("tan") hull() {
            cylinder(d=1, h=3);
            translate([5,0,0]) cylinder(d=1, h=3);
        }
    translate([7.36,2,-1]) rotate([0,0,90])
        color("tan") hull() {
            cylinder(d=1, h=3);
            translate([5,0,0]) cylinder(d=1, h=3);
        }
    }
}


/* odroid-hc4 oled holder */
module hc4_oled_holder(side,wallthick) {
    
    adjust=.01;
    $fn = 90;    
    difference() {
        union() {
            if(side == "top") {
                translate([-1.85,-1.75,-4]) cube([32,5,4]);
                translate([30.15,-3.75,1]) 
                    rotate([0,-90,0]) 
                    linear_extrude(height = 32) 
                        polygon(points = [ [-wallthick/2,-wallthick/2],
                            [-4,wallthick], 
                            [-4,2], 
                            [-wallthick/2,2]]);
                        translate([-1.85,4,1]) 
                            rotate([0,-90,180]) 
                            linear_extrude(height = 32) 
                                polygon(points = [ [-wallthick/2,-wallthick/2],
                                    [-4,wallthick], 
                                    [-4,2], 
                                    [-wallthick/2,2]]);
            }
            if(side == "bottom") {
                translate([-1.85,-1.75,0]) cube([32,5,4]);
                    translate([30.15,-3.75,1]) 
                        rotate([0,-90,0]) 
                        linear_extrude(height = 32) 
                            polygon(points = [ [-wallthick/2,-wallthick/2],
                                [2,wallthick], 
                                [2,2], 
                                [-wallthick/2,2]]);
                    translate([-1.85,4,1]) 
                        rotate([0,-90,180]) 
                        linear_extrude(height = 32) 
                            polygon(points = [ [-wallthick/2,-wallthick/2],
                                [2,wallthick], 
                                [2,2], 
                                [-wallthick/2,2]]);
            }
        }
        if(side == "top") {
            translate([-.5,0,wallthick-8]) cube([29.5,1.9,5]);
            translate([(32.75/2-(15/2))-1.85,-adjust-3-1.75,-wallthick-2.5]) cube([15,12,wallthick+3]);
        }
        if(side == "bottom") {
            translate([-.5,0,-adjust]) cube([29.5,1.42,5]);
            translate([(32.75/2-(15/2))-1.85,-adjust-3-1.75,-adjust]) cube([15,12,8]);
            translate([2.5,-adjust-3-1.75,-adjust]) cube([6,3,8]);
            translate([12.5,adjust,10]) rotate([90,0,0]) cylinder(d=21, h=2);
        }
    }   
}


module hd_mount(hd,orientation,position,side) {

    adjust = .01;
    $fn = 90;
    if(hd == 2.5) {
        if(orientation == "portrait") {
            if(position == "vertical") {
                if(side == "left") {
                    translate([0,14,0]) rotate([0,0,0]) hd25_vtab("right");
                    translate([0,90.6,0]) rotate([0,0,0]) hd25_vtab("right");
                }
                else {  // right
                    translate([0,14,0]) rotate([0,0,0]) hd25_vtab("left");
                    translate([0,90.6,0]) rotate([0,0,0]) hd25_vtab("left");
                }
            }
            else {
                translate([-.5,14,0]) hd25_tab("left");
                translate([-.5,90.6,0]) hd25_tab("left");
                translate([70.35,14,0]) hd25_tab("right");
                translate([70.35,90.6,0]) hd25_tab("right");
            }
        }
        if(orientation == "landscape") {
            if(position == "vertical") {
                if(side == "left") {
                    translate([9.4,0,0]) rotate([0,0,90]) hd25_vtab("right");
                    translate([86,0,0])  rotate([0,0,90]) hd25_vtab("right");
                }
                else {  // right
                    translate([9.4,0,0]) rotate([0,0,90]) hd25_vtab("left");
                    translate([86,0,0])  rotate([0,0,90]) hd25_vtab("left");
                }
            }
            else {
                translate([9.4,4.07-4.5,0]) rotate([0,0,90]) hd25_tab("left");
                translate([86,4.07-4.5,0])  rotate([0,0,90]) hd25_tab("left");
                translate([86,65.79+4.5,0]) rotate([0,0,90]) hd25_tab("right");
                translate([9.4,65.79+4.5,0]) rotate([0,0,90]) hd25_tab("right");
            }
        }
    }
    if(hd == 3.5) {
        if(orientation == "portrait") {
            translate([-.5,28.5,0]) hd35_tab("left");
            translate([-.5,69.75,0]) hd35_tab("left");
            translate([-.5,130.1,0]) hd35_tab("left");
            translate([101.6+.5,28.5,0]) hd35_tab("right");
            translate([101.6+.5,69.75,0]) hd35_tab("right");
            translate([101.6+.5,130.1,0]) hd35_tab("right");
        }
        if(orientation == "landscape") {
            translate([16.9,-.5,0]) rotate([0,0,90]) hd35_tab("left");
            translate([76.6,-.5,0])  rotate([0,0,90]) hd35_tab("left");
            translate([118.5,-.5,0]) rotate([0,0,90]) hd35_tab("left");
            translate([16.9,101.6-.5,0]) rotate([0,0,90]) hd35_tab("right");
            translate([76.6,101.6-.5,0]) rotate([0,0,90]) hd35_tab("right");
            translate([118.5,101.6-.5,0]) rotate([0,0,90]) hd35_tab("right");
        }
    }
}


module hd25_tab(side) {

    width = 15;
    l_width = 26;
    depth = 15;
    height = 4;
    fillet = 2;
    hole = 3.6;
    length = 3;
    
    adjust = .01;
    $fn = 90;
    if(side == "left") {
        difference() {
            union() {
                translate([0,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([-height,-depth/2,0]) cube([height,depth,height]);
                translate([adjust,-5.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adjust,7.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([4.07,0,-adjust]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-height-adjust,(width/2)-(length/2)-depth/2,3]) rotate([90,0,90]) slot(hole,length,height+(2*adjust));
            translate([-height-adjust,(width/2)-(length/2)-depth/2,21]) rotate([90,0,90]) slot(hole,length,height+(2*adjust));
        }
    }
    if(side == "right") {
        difference() {
            union() {
                translate([height,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([0,-depth/2,0]) cube([height,depth,height]);
                translate([adjust,-7.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adjust,5.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([-4.07,0,-adjust]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-adjust,(width/2)-(length/2)-depth/2,3]) rotate([90,0,90]) slot(hole,length,height+(2*adjust));
            translate([-adjust,(width/2)-(length/2)-depth/2,21]) rotate([90,0,90]) slot(hole,length,height+(2*adjust));
        }
    }
}


module hd25_vtab(side) {
    
    width = 15;
    l_width = 16;
    depth = 15;
    height = 4;
    fillet = 2;
    hole = 3.6;
    length = 3;
    
    adjust = .01;
    $fn = 90;
    if(side == "left") {
        difference() {
            union() {
                translate([0,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([-height,-depth/2,0]) cube([height,depth,height]);
                translate([adjust,-5.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adjust,7.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([3,0,-adjust]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-height-adjust,1.5+(width/2)-(length/2)-depth/2,5.57]) rotate([90,90,90]) slot(hole,length,height+(2*adjust));
        }
    }
    if(side == "right") {
        difference() {
            union() {
                translate([height,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([0,-depth/2,0]) cube([height,depth,height]);
                translate([adjust,-7.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adjust,5.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([-3,0,-adjust]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-adjust,1.5+(width/2)-(length/2)-depth/2,5.57]) rotate([90,90,90]) slot(hole,length,height+(2*adjust));
        }
    }
}


module hd35_tab(side) {

    width = 15;
    l_width = 46;
    depth = 15;
    height = 4;
    fillet = 2;
    hole = 3.6;
    length = 3;
    
    adjust = .01;
    $fn = 90;    
    if(side == "left") {
        difference() {
            union() {
                translate([0,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([-height,-depth/2,0]) cube([height,depth,height]);

                translate([adjust,-5.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height+20],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adjust,7.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height+20],
                                [-depth+4,-depth], 
                                [-height,-depth]]);

            }
            translate([3.18,0,-adjust]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-height-adjust,(width/2)-(length/2)-depth/2,6.35]) rotate([90,0,90]) slot(hole,length,height+(2*adjust));
            translate([-height-adjust,(width/2)-(length/2)-depth/2,38.35]) rotate([90,0,90]) slot(hole,length,height+(2*adjust));
        }
    }
    if(side == "right") {
        difference() {
            union() {
                translate([height,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([0,-depth/2,0]) cube([height,depth,height]);

                translate([adjust,-7.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height+20],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adjust,5.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height+20],
                                [-depth+4,-depth], 
                                [-height,-depth]]);

            }
            translate([-3.18,0,-adjust]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-adjust,(width/2)-(length/2)-depth/2,6.35]) rotate([90,0,90]) slot(hole,length,height+(2*adjust));
            translate([-adjust,(width/2)-(length/2)-depth/2,38.35]) rotate([90,0,90]) slot(hole,length,height+(2*adjust));
        }
    }
}


module hd_bottom_holes(hd,orientation,position,side,thick) {

    adjust = .01;
    $fn = 90;
    if(hd == 2.5) {
        if(orientation == "portrait") {
            if(position == "vertical") {
                if(side == "left") {
                    translate([-3,14,0]) cylinder(d=3.6,h=thick+(adjust*2));
                    translate([-3,90.6,0]) cylinder(d=3.6,h=thick+(adjust*2));
                }
                else {
                    // portrait 2.5" bottom screw holes
                    translate([3,14,0]) cylinder(d=3.6,h=thick+(adjust*2));
                    translate([3,90.6,0]) cylinder(d=3.6,h=thick+(adjust*2));
                }
            }
            else {
                // portrait 2.5" bottom screw holes
                translate([4.07,14,0]) cylinder(d=3.6,h=thick+(adjust*2));
                translate([4.07,90.6,0]) cylinder(d=3.6,h=thick+(adjust*2));
                translate([65.79,90.6,0]) cylinder(d=3.6,h=thick+(adjust*2));
                translate([65.79,14,0]) cylinder(d=3.6,h=thick+(adjust*2));
            
            }
        }
        if(orientation == "landscape") {
            if(position == "vertical") {
                if(side == "left") {
                    translate([9.4,-3,0]) cylinder(d=3.6,h=thick+(adjust*2));
                    translate([86,-3,0]) cylinder(d=3.6,h=thick+(adjust*2));
                }
                else {
                    echo(side);
                    translate([9.4,3,0]) cylinder(d=3.6,h=thick+(adjust*2));
                    translate([86,3,0]) cylinder(d=3.6,h=thick+(adjust*2));
                }
            }
            else {
                // landscape 2.5" bottom screw holes
                translate([9.4,4.07,0]) cylinder(d=3.6,h=thick+(adjust*2));
                translate([86,4.07,0]) cylinder(d=3.6,h=thick+(adjust*2));
                translate([86,65.79,0]) cylinder(d=3.6,h=thick+(adjust*2));
                translate([9.4,65.79,0]) cylinder(d=3.6,h=thick+(adjust*2));
            }
        }
    }
    if(hd == 3.5) {
        if(orientation == "portrait") {
            // portrait 3.5" bottom screw holes
            translate([3.18,41.28,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([3.18,85.73,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([3.18,117.48,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([98.43,41.28,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([98.43,85.73,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([98.43,117.48,0]) cylinder(d=3.6,h=thick+(adjust*2));
        }
        if(orientation == "landscape") {
            // landscape 3.5" bottom screw holes
            translate([29.52,3.18,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([61.27,3.18,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([105.72,3.18,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([29.52,98.43,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([61.27,98.43,0]) cylinder(d=3.6,h=thick+(adjust*2));
            translate([105.72,98.43,0]) cylinder(d=3.6,h=thick+(adjust*2));
        }
    }
}


/* hard drive 2.5", height=drive height */
module hd25(height) {
    
    hd25_x = 100;
    hd25_y = 69.85;
    hd25_z = height;
    
    adjust = .01;
    $fn=90;
    
    difference() {
        color("LightGrey",.6) cube([hd25_x,hd25_y,hd25_z]);
        
        // bottom screw holes
        color("Black",.6) translate([9.4,4.07,-adjust]) cylinder(d=3,h=3);
        color("Black",.6) translate([86,4.07,-adjust]) cylinder(d=3,h=3);
        color("Black",.6) translate([86,65.79,-adjust]) cylinder(d=3,h=4);
        color("Black",.6) translate([9.4,65.79,-adjust]) cylinder(d=3,h=4);

        // side screw holes
        color("Black",.6) translate([9.4,-adjust,3]) rotate([-90,0,0]) cylinder(d=3,h=3);
        color("Black",.6) translate([86,-adjust,3]) rotate([-90,0,0])  cylinder(d=3,h=3);
        color("Black",.6) translate([86,hd25_y+adjust,3]) rotate([90,0,0])  cylinder(d=3,h=3);
        color("Black",.6) translate([9.4,hd25_y+adjust,3]) rotate([90,0,0])  cylinder(d=3,h=3);

        // connector opening
        color("LightSlateGray",.6) translate([hd25_x-5,11,-1]) cube([5+adjust,32,5+adjust]);
    }
}


/* hard drive 3.5" */
module hd35() {
    
    hd35_x = 147;
    hd35_y = 101.6;
    hd35_z = 26.1;
    
    adjust = .01;    
    $fn=90;
    
    difference() {
        color("LightGrey",.6) cube([hd35_x,hd35_y,hd35_z]);
        
        // bottom screw holes
        color("Black",.6) translate([29.52,3.18,-adjust]) cylinder(d=3,h=3+adjust);
        color("Black",.6) translate([61.27,3.18,-adjust]) cylinder(d=3,h=3+adjust);
        color("Black",.6) translate([105.72,3.18,-adjust]) cylinder(d=3,h=3+adjust);
        color("Black",.6) translate([29.52,98.43,-adjust]) cylinder(d=3,h=3+adjust);
        color("Black",.6) translate([61.27,98.43,-adjust]) cylinder(d=3,h=3+adjust);
        color("Black",.6) translate([105.72,98.43,-adjust]) cylinder(d=3,h=3+adjust);
        
        // side screw holes
        color("Black",.6) translate([16.9,-adjust,6.35]) rotate([-90,0,0]) cylinder(d=3,h=3);
        color("Black",.6) translate([76.6,-adjust,6.35]) rotate([-90,0,0])  cylinder(d=3,h=3);
        color("Black",.6) translate([118.5,-adjust,6.35]) rotate([-90,0,0])  cylinder(d=3,h=3);
        color("Black",.6) translate([118.5,hd35_y+adjust,6.35]) rotate([90,0,0])  cylinder(d=3,h=3);
        color("Black",.6) translate([76.6,hd35_y+adjust,6.35]) rotate([90,0,0])  cylinder(d=3,h=3);
        color("Black",.6) translate([16.9,hd35_y+adjust,6.35]) rotate([90,0,0])  cylinder(d=3,h=3);

        // connector opening
        color("LightSlateGray",.6) translate([hd35_x-5,11,-1]) cube([5+adjust,32,5+adjust]);

    }
}


/* 3.5" hdd to 2.5" hdd holder */
module hdd35_25holder(length) {
    wallthick = 3;
    floorthick = 2;
    hd35_x = length;                    // 145mm for 3.5" drive
    hd35_y = 101.6;
    hd35_z = 12;
    hd25_x = 100;
    hd25_y = 69.85;
    hd25_z = 9.5;
    hd25_xloc = 2;                     // or (hd35_x-hd25_x)/2
    hd25_yloc = (hd35_y-hd25_y)/2;
    hd25_zloc = 9.5;
    adjust = .1;    
    $fn=90;
    difference() {
        union() {
            difference() {
                translate([(hd35_x/2),(hd35_y/2),(hd35_z/2)])         
                    cube_fillet_inside([hd35_x,hd35_y,hd35_z], 
                        vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);      
                translate([(hd35_x/2),(hd35_y/2),(hd35_z/2)+floorthick])           
                    cube_fillet_inside([hd35_x-(wallthick*2),hd35_y-(wallthick*2),hd35_z], 
                        vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                   
                // end trim
                translate([-adjust,5,wallthick+2]) cube([wallthick+(adjust*2),hd35_y-10,10]);
                translate([hd35_x-wallthick-adjust,5,wallthick+2]) cube([wallthick+(adjust*2),hd35_y-10,10]);
                
                // bottom vents
                for ( r=[15:40:hd35_x-40]) {
                    for (c=[25:4:75]) {
                        translate ([r,c,-adjust]) cube([35,2,wallthick+(adjust*2)]);
                    }
                }       
            }
            // 2.5 hdd bottom support
            translate([9.4+hd25_xloc,4.07+hd25_yloc,floorthick-adjust]) cylinder(d=8,h=4);
            translate([86+hd25_xloc,4.07+hd25_yloc,floorthick-adjust]) cylinder(d=8,h=4);
            translate([86+hd25_xloc,65.79+hd25_yloc,floorthick-adjust]) cylinder(d=8,h=4);
            translate([9.4+hd25_xloc,65.79+hd25_yloc,floorthick-adjust]) cylinder(d=8,h=4);
        
        // side nut holder support    
        translate([16,wallthick-adjust,7]) rotate([-90,0,0]) cylinder(d=10,h=3);
        translate([76,wallthick-adjust,7]) rotate([-90,0,0])  cylinder(d=10,h=3);
            if(length >= 120) {
                translate([117.5,wallthick-adjust,7]) rotate([-90,0,0])  cylinder(d=10,h=3);
                translate([117.5,hd35_y-wallthick-adjust,7]) rotate([90,0,0])  cylinder(d=10,h=3);
            }
        translate([76,hd35_y-wallthick-adjust,7]) rotate([90,0,0])  cylinder(d=10,h=3);
        translate([16,hd35_y-wallthick-adjust,7]) rotate([90,0,0])  cylinder(d=10,h=3);
        
        // bottom-side support
        translate([wallthick,wallthick,floorthick-2]) rotate([45,0,0]) cube([hd35_x-(wallthick*2),3,3]);
        translate([wallthick,hd35_y-wallthick+adjust,floorthick-2]) rotate([45,0,0]) cube([hd35_x-(wallthick*2),3,3]);
         
        }
        // bottom screw holes
        translate([9.4+hd25_xloc,4.07+hd25_yloc,-adjust]) cylinder(d=3,h=(floorthick*3)+(adjust*2));
        translate([86+hd25_xloc,4.07+hd25_yloc,-adjust]) cylinder(d=3,h=(floorthick*3)+(adjust*2));
        translate([86+hd25_xloc,65.79+hd25_yloc,-adjust]) cylinder(d=3,h=(floorthick*3)+(adjust*2));
        translate([9.4+hd25_xloc,65.79+hd25_yloc,-adjust]) cylinder(d=3,h=(floorthick*3)+(adjust*2));
        
         // countersink holes
        translate([9.4+hd25_xloc,4.07+hd25_yloc,-adjust]) cylinder(d1=6.5, d2=3, h=3);
        translate([86+hd25_xloc,4.07+hd25_yloc,-adjust]) cylinder(d1=6.5, d2=3, h=3);
        translate([86+hd25_xloc,65.79+hd25_yloc,-adjust]) cylinder(d1=6.5, d2=3, h=3);
        translate([9.4+hd25_xloc,65.79+hd25_yloc,-adjust]) cylinder(d1=6.5, d2=3, h=3);
       
        // side screw holes
        translate([16,-adjust,7]) rotate([-90,0,0]) cylinder(d=3.6,h=7);
        translate([76,-adjust,7]) rotate([-90,0,0])  cylinder(d=3.6,h=7);
        translate([117.5,-adjust,7]) rotate([-90,0,0])  cylinder(d=3.6,h=7);
        translate([117.5,hd35_y+adjust,7]) rotate([90,0,0])  cylinder(d=3.6,h=7);
        translate([76,hd35_y+adjust,7]) rotate([90,0,0])  cylinder(d=3.6,h=7);
        translate([16,hd35_y+adjust,7]) rotate([90,0,0])  cylinder(d=3.6,h=7);
        
        // side nut trap    
        translate([16,wallthick-adjust,7]) rotate([-90,0,0]) cylinder(r=3.30,h=5,$fn=6);
        translate([76,wallthick-adjust,7]) rotate([-90,0,0])  cylinder(r=3.30,h=5,$fn=6);
        translate([117.5,wallthick-adjust,7]) rotate([-90,0,0])  cylinder(r=3.30,h=5,$fn=6);
        translate([117.5,hd35_y-wallthick-adjust,7]) rotate([90,0,0])  cylinder(r=3.30,h=5,$fn=6);
        translate([76,hd35_y-wallthick-adjust,7]) rotate([90,0,0])  cylinder(r=3.30,h=5,$fn=6);
        translate([16,hd35_y-wallthick-adjust,7]) rotate([90,0,0])  cylinder(r=3.30,h=5,$fn=6);
    }
}


/* odroid-hc4 oled */
module hc4_oled() {
    
adjust = .01;
$fn=90;

oled_x = 28.5;
oled_y = 1.25;
oled_z = 48.6;

oled_open_x = 29;
oled_open_y = 1.5;
    difference() {
        union() {
            // pcb board
            color("Tan", 1) translate([0,0,0]) cube([oled_x,oled_y,oled_z]);
            // oled
            color("Black", 1) translate([.5,1.25,25.5]) cube([oled_x-1,.625,15]);
            color("DarkGrey", 1) translate([.5,1.25,40.5]) cube([oled_x-1,.625,4]);
        }
        translate([2.8,0,46.7]) {
            translate([-.6,1.26,0]) rotate([90,0,0])
                hull() {
                translate([1.2,0,0]) cylinder(d=1.8, h=1.25+(adjust*2));
                cylinder(d=1.8, h=1.25+(adjust*2));
                }
        }
        translate([25.7,0,46.7]) {
            translate([-.6,1.26,0]) rotate([90,0,0])
                hull() {
                translate([1.2,0,0]) cylinder(d=1.8, h=1.25+(adjust*2));
                cylinder(d=1.8, h=1.25+(adjust*2));
                }
        }
        
    }
}


/* h2 network card */
module h2_netcard() {
    
    adjust = .01;
    $fn = 90;
    difference() {
        union() {
            color("tan") translate ([0,0,0]) linear_extrude(height = 1) import("./dxf/hk-network-card.dxf");
            color("goldenrod") translate([3.75,17.85,1-adjust]) cylinder(d=6,h=3);
            color("goldenrod") translate([106,24.85,1-adjust]) cylinder(d=6,h=3);
        }
        translate([20.85,3.85,-adjust]) cylinder(d=3,h=4);
        translate([3.75,17.85,-adjust]) cylinder(d=3,h=6);
        translate([3.75,51.1,-adjust]) cylinder(d=3,h=4);
        translate([20.15,43.85,-adjust]) cylinder(d=3,h=4);
        translate([106,24.85,-adjust]) cylinder(d=3,h=6);
        translate([96.5,3.85,-adjust]) cylinder(d=3,h=4);
    }
    rj45(26,-1,0,"bottom",1);
    rj45(43,-1,0,"bottom",1);
    rj45(60,-1,0,"bottom",1);
    rj45(77,-1,0,"bottom",1);
    place(30,25,0,6,6,0,"bottom") color("dimgray") translate([0,0,0]) cube([6,6,.8]);
    place(47,25,0,6,6,0,"bottom") color("dimgray") translate([0,0,0]) cube([6,6,.8]);
    place(64,25,0,6,6,0,"bottom") color("dimgray") translate([0,0,0]) cube([6,6,.8]);
    place(79,25,0,6,6,0,"bottom") color("dimgray") translate([0,0,0]) cube([6,6,.8]);
    place(56.5,41,0,5,9.75,0,"bottom") color("dimgray") translate([0,0,0]) cube([5,9.75,.8]);
    for (i=[34.65:.5:48.5]) {
        color("gold") translate([98,i,1]) cube([2,.25,.25]);
        color("gold") translate([98,i,-.24]) cube([2,.25,.25]);
    }
    for (i=[51:.5:53]) {
        color("gold") translate([98,i,1]) cube([2,.25,.25]);
        color("gold") translate([98,i,-.24]) cube([2,.25,.25]);
    }

}


/* hk 3.5 lcd */
module hk35_lcd() {
    
    adjust = .01;
    $fn = 90;
    difference() {
        union() {
            color("tan") translate ([0,0,0]) slab([95,56,1.7],3.5);
            color("black",1) translate([10.5,0,1.7]) cube([74.75,54.5,4]);
            color("white",1) translate([8.5,0,5.7-adjust]) cube([82.75,54.5,2]);
            color("grey",1) translate([8.5,0,7.7-adjust]) cube([82.75,54.5,.8]);
            color("dimgrey",1) translate([15,2,8.5-adjust]) cube([75.5,51,.25]);
        }
        translate([3.5,3.5,-adjust]) cylinder(d=3,h=6);
        translate([3.5,52.5,-adjust]) cylinder(d=3,h=4);
    }
    translate([3,8.75,1.70-adjust]) momentary45x15();
    translate([3,19.75,1.70-adjust]) momentary45x15();
    translate([3,30.75,1.70-adjust]) momentary45x15();
    translate([3,41.75,1.70-adjust]) momentary45x15();
    color("black") translate([7.375,.8,-9+adjust]) cube([51.5,5,9]);
    translate([92.5,4,adjust]) rotate([0,180,0]) header(5);
    }


// hk console uart model
module hk_uart() {
    
    size = [22,13,1.25];
    adjust = .01;
    $fn = 90;
    color("tan") cube([size[0],size[1],size[2]]);
    translate([6.5,.25,6.25-adjust]) rotate([90,180,-90]) uart_micro();
    translate([6.75,3,-2+adjust])cylinder(d=1, 2);
    translate([6.75,5.25,-2+adjust])cylinder(d=1, 2);
    translate([6.75,7.5,-2+adjust])cylinder(d=1, 2);
    translate([6.75,9.75,-2+adjust])cylinder(d=1, 2);
    translate([23,2.75,1.25]) rotate([0,0,90]) usb_micro();
    translate([13,4.5,1.25]) rotate([0,0,90]) ic([4,4,1]);
}


// hk vu7c lcd display
module hk_vu7c(gpio_ext, tabs) {
    
    lcd_size = [164.85,100,5.48];
    pcb_size = [184.6,75,1.6];
    view_size = [155,88.5,.125];        // 154.21 x 85.92
    hole = 3.2;
    length = 24-hole;
    depth = 2;    
    adjust = .1;
    $fn = 90;    
    difference() {
        union() {
            color("lightgray") translate([0,0,pcb_size[2]+3.12]) cube(lcd_size);
            if(tabs == true) {
                color("black") translate([-(pcb_size[0]-lcd_size[0])/2,lcd_size[1]-pcb_size[1]-1,0]) 
                    cube(pcb_size);
            }
            else {
                color("black") translate([0,lcd_size[1]-pcb_size[1]-1,0]) 
                    cube([pcb_size[0]-20,pcb_size[1],pcb_size[2]]);
            }
            color("black") translate([3,7.5,pcb_size[2]+3.12+lcd_size[2]-adjust]) cube(view_size);
            // tabs
            color("black") translate([51.8,99,0]) slab_r([8,8,1.6],[.1,4,4,.1]);
            color("black") translate([104.8,99,0]) slab_r([8,8,1.6],[.1,4,4,.1]);
        }
        // slots
        color("dimgray") translate([-(pcb_size[0]-lcd_size[0])/4,lcd_size[1]-1-7,-adjust]) 
            rotate([0,0,-90]) slot(hole,length,depth);
        color("dimgray") translate([-(pcb_size[0]-lcd_size[0])/4,lcd_size[1]-1-46,-adjust]) 
            rotate([0,0,-90]) slot(hole,length,depth);
        color("dimgray") translate([(pcb_size[0]-(pcb_size[0]-lcd_size[0])/2)-(pcb_size[0]-lcd_size[0])/4,
            lcd_size[1]-1-7,-adjust]) rotate([0,0,-90]) slot(hole,length,depth);
        color("dimgray") translate([(pcb_size[0]-(pcb_size[0]-lcd_size[0])/2)-(pcb_size[0]-lcd_size[0])/4,
            lcd_size[1]-1-46,-adjust]) rotate([0,0,-90]) slot(hole,length,depth);
        // holes
        color("dimgray") translate([55.8,103.5,-adjust]) cylinder(d=hole, h=3);
        color("dimgray") translate([108.8,103.5,-adjust]) cylinder(d=hole, h=3);
        // pcb cuts
        color("dimgray") translate([66,97.5,-adjust]) slab_r([20.3,4,2],[1,1,1,1]);
        color("dimgray") translate([17.8,lcd_size[1]-pcb_size[1]-2,-adjust]) slab_r([78.8,6,2],[1,1,1,1]);
    }
    // components
    translate([70+14.5,28.58,0]) rotate([180,0,180]) hdmi_a();
    translate([47.49-1,42.09-.75,0]) rotate([180,0,90]) header_f(7,15);
    translate([39.5,80.19-1,0]) rotate([180,0,90]) header_f(20,15);
    translate([39.5,82.73-1,0]) rotate([180,0,90]) header_f(20,15);
    translate([13.15+2.75-.25,36.71-1.25,0]) rotate([180,0,180]) header(7);
    translate([23.58+2.5,74.42-1.25,0]) rotate([180,0,180]) header(5);
    translate([98+2,26.04-2,0]) rotate([180,0,180]) pcb_pad(7);
    color("dimgray") translate([16.25,69.4,-1.99]) cube([4,4,2]);
    translate([18.5,58,-1.99]) cube([25,5.5,2]);
    translate([80.5,52.5,-1.99]) cube([4.5,3.5,2]);
    // gpio extension
    if(gpio_ext == true) {
        translate([57.37-1.25,94.93-1.25,0]) rotate([180,0,90]) header(20);
        translate([57.37-1.25,92.39-1.25,0]) rotate([180,0,90]) header(20);
    }
    else {
        translate([57.37-2,94.93-2,0]) rotate([180,0,90]) pcb_pad(20);
        translate([57.37-2,92.39-2,0]) rotate([180,0,90]) pcb_pad(20);        
    }
    translate([59,52.69,-1.59]) ic(9);
}


// hk vu8m lcd display
module hk_vu8m(brackets) {
    $fn = 90;    
    
    m1_screw_spacing = 72;

    body_size  = [    198,     133,                1.93];
    glass_size = [ 195.73,  131.14,                1.60];
    lcd_size   = [ 184.63,  114.94, body_size[2] + 0.40];
    view_size  = [ 173.23,  108.64,                  .1];

    rb = 5.25;   // body edge radius

    lcd_clearance = [0.15, 0.1, 0];
    pcb_size = [14,24,1.6];
    hole = 4.31;
    spacer_size = [5.5, 6, 2.5, 5.5, 1, 0, 1, 1, 0, 0, 0];

    // "body"
    color([0.1,0.1,0.1])
    difference(){
        slab(body_size, rb); 
        lcd_space = lcd_size + 2*lcd_clearance;
        translate([3.76               , 9               ,    -1]) cube(lcd_space);
        translate([3.76               , 9               ,    -1]) cylinder(r=1.3, h=5);
        translate([3.76 + lcd_space[0], 9               ,    -1]) cylinder(r=1.3, h=5);
        translate([3.76               , 9 + lcd_space[1],    -1]) cylinder(r=1.3, h=5);
        translate([3.76 + lcd_space[0], 9 + lcd_space[1],    -1]) cylinder(r=1.3, h=5);
    // 8x holes in body
        translate([  44.5,              4.5, -1]) cylinder(d=hole, h=5);
        translate([  51.5,              4.5, -1]) cylinder(d=hole, h=5);
        translate([ 183.5,              4.5, -1]) cylinder(d=hole, h=5);
        translate([ 190.5,              4.5, -1]) cylinder(d=hole, h=5);
        translate([  44.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);
        translate([  51.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);
        translate([ 183.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);
        translate([ 190.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);

    }
    // 4x standoffs
        color([0.6,0.6,0.6]) {
            translate([  44.5,              4.5, 0]) standoff(spacer_size);
            translate([ 183.5,              4.5, 0]) standoff(spacer_size);
            translate([  44.5, body_size[1]-4.5, 0]) standoff(spacer_size);
            translate([ 183.5, body_size[1]-4.5, 0]) standoff(spacer_size);
        }
    // LCD panel
    color([0.6, 0.6, 0.65])
        translate([3.76, 9, body_size[2]-lcd_size[2]]+lcd_clearance)
            cube(lcd_size); 

    // Front glass
    // It's actually thinner and glued, but for the sake of simplicity...
    color([0.2, 0.2, 0.2], 0.9)
        translate([0.86, 1.38, body_size[2] + 0.01])
            slab(glass_size, rb);

    // view area
    color("dimgrey", 0.9)
        translate([(glass_size[0]-view_size[0])/2, (glass_size[1]-view_size[1])/2, body_size[2] + glass_size[2]- 0.01])
            slab(view_size, .1);

    // PCB stub
    color([0.1,0.1,0.1])
        translate([20.5, 24.5, -3])
            cube(pcb_size);
    color("dimgrey")
        translate([22.5, 26.5, -2])
            cube([8,16,3]);
    color([0.1,0.1,0.1])
        translate([12, 21, -2])
            cube([7,7,1.6]);
    color([0.1,0.1,0.1])
        translate([10, 34, -2])
            cube([4,10,1.6]);

    //Brackets
    if(brackets) {
        translate([44.5 - 7.5,   body_size[1]/2 + m1_screw_spacing/2 - 7.5, - spacer_size[1] - 2]) u_bracket();
        translate([44.5 - 7.5,   body_size[1]/2 - m1_screw_spacing/2 + 7.5, - spacer_size[1] - 2 + 1.93]) rotate([180,0,0]) u_bracket();

    //Screws
        color([0.1,0.1,0.1]) {
            translate([  44.5,              4.5, -8]) rotate([180,0,0]) screw([3,7,0]);
            translate([ 183.5,              4.5, -8]) rotate([180,0,0]) screw([3,7,0]);
            translate([  44.5, body_size[1]-4.5, -8]) rotate([180,0,0]) screw([3,7,0]);
            translate([ 183.5, body_size[1]-4.5, -8]) rotate([180,0,0]) screw([3,7,0]);
        }
    }
}

// Vu8M LCD U-BRACKET
module u_bracket() {
    $fn= 30;
    xi = 124;
    xo = 154;
    yi = 42;
    yo = 42 + 12;   // Outer vertical dimension 
    z  = 1.93;
    rlo = 21.3;     // Lower outer corner radii
    rli = 1;        // Lower inner corner radii
    ruo = 5.7;      // Upper outer corner radii
    rui = 5.7;      // Upper inner corner radii

    color([0.2,0.2,0.2])
    difference() {
        union() {
            hull() {
                translate([          rlo,      rlo,0]) cylinder(r=rlo, h=z, $fn=100);     
                translate([xo -      rlo,      rlo,0]) cylinder(r=rlo, h=z, $fn=100);     
            }
            hull() {
                translate([          ruo, yo - ruo,0]) cylinder(r=ruo, h=z);     
                translate([     15 - rui, yo - rui,0]) cylinder(r=rui, h=z);     
                translate([            0,      rlo,0]) cube([15,$fs,z]);
            }
            hull() {
                translate([xo -      ruo, yo - ruo,0]) cylinder(r=ruo, h=z);     
                translate([xo - 15 + rui, yo - rui,0]) cylinder(r=rui, h=z);     
                translate([xo - 15      ,      rlo,0]) cube([15,$fs,z]);
            }
        }
        hull() {
            translate([     15 + rli, yo - yi + rli,-1]) cylinder(r=rli, h=z+2);     
            translate([xo - 15 - rli, yo - yi + rli,-1]) cylinder(r=rli, h=z+2);     
            translate([           15,            yo,-1]) cube([xi,$fs,z+2]);
        }    
        translate([     7.5, yo - 4, -1]) cylinder(d=3.21, h=z+2);
        translate([xo - 7.5, yo - 4, -1]) cylinder(d=3.21, h=z+2);
        hull() {
            translate([     7.5, yo -  9.6, -1]) cylinder(d=3.21, h=z+2);
            translate([     7.5, yo - 29.4, -1]) cylinder(d=3.21, h=z+2);
        }
        hull() {
            translate([xo - 7.5, yo -  9.6, -1]) cylinder(d=3.21, h=z+2);
            translate([xo - 7.5, yo - 29.4, -1]) cylinder(d=3.21, h=z+2);
        }
        translate([     15 +   5.00, 8.25, -1]) cylinder(d=4.11, h=z+2);
        translate([xo - 15 -  30.00, 8.25, -1]) cylinder(d=4.11, h=z+2);
        translate([     15 +  10.75, 2.50, -1]) cylinder(d=4.11, h=z+2);
        translate([     15 +  41.75, 2.50, -1]) cylinder(d=4.11, h=z+2);
        translate([     15 +  82.25, 2.50, -1]) cylinder(d=4.11, h=z+2);
        translate([     15 + 113.25, 2.50, -1]) cylinder(d=4.11, h=z+2);
    }
}

// ODROID M1 2.5" SATA HDD mounting kit
module m1_hdmount() {
    $fn   = 30;
    dims  = [89.6,   38.5,  2.0];
    holes = 4;
    slots = [4.15,    3.3];
    standoff_style = [5, 16, 0, 3, 25, 0, 0, 1, 0, 0, 0];

    color([0.2,0.2,0.2])
    difference() {
        slab(dims, 4.0);
        translate([     3.1,   28.3, -1]) cylinder(d = holes, h = 4);
        translate([    86.5,   28.3, -1]) cylinder(d = holes, h = 4);
        hull() {
            translate([   14.75,     10.15, -1]) cylinder(d=3.30, h=4);
            translate([   15.60,     10.15, -1]) cylinder(d=3.30, h=4);
        }
        hull() {
            translate([   75.60,     10.15, -1]) cylinder(d=3.30, h=4);
            translate([   76.45,     10.15, -1]) cylinder(d=3.30, h=4);
        }
    }

    color([0.6,0.6,0.6]) {
        translate ([   3.1,  28.3 ,  0]) rotate([  0,0,0]) standoff(standoff_style);
        translate ([  86.5,  28.3 ,  0]) rotate([  0,0,0]) standoff(standoff_style);
    }
    color([0.1,0.1,0.1]) {
        translate ([   3.1,  28.3 ,  2]) rotate([  0,0,0]) screw([3, 7, 0]);
        translate ([  86.5,  28.3 ,  2]) rotate([  0,0,0]) screw([3, 7, 0]);

        translate ([  15.1,  10.15,  0]) rotate([180,0,0]) screw([3, 7, 0]);
        translate ([    76,  10.15,  0]) rotate([180,0,0]) screw([3, 7, 0]);
    }

    // "HDD HOLDER"
    color([0.9, 0.9, 0.9])
    translate([67,8,0]) rotate([180,0,180])
    linear_extrude(height=0.01) text("HDD HOLDER",5);
}


// hdmi a female 
module hdmi_a() {
    size_x = 14.5;
    size_y = 11.5;        

    translate([0,0,.75])
    union() { 
        difference() {
            color("silver") translate([0,0,0]) cube([size_x, size_y, 5.5]);
            color("dimgray") translate([.5,-.1,.5]) cube([13.5, 11, 4.5]);
            color("silver") translate([0,-.1,0]) rotate ([-90,0,0]) 
                cylinder(d=4, h=13.5,$fn=30);
            color("silver") translate([14.5,-.1,0]) rotate ([-90,0,0]) 
                cylinder(d=4, h=13.5,$fn=30);
        }
        difference() {
            union() {
                color("silver") translate([0,-.1,0]) rotate ([-90,0,0]) 
                cylinder(d=4, h=11.5,$fn=30);
                color("silver") translate([14.5,-.1,0]) rotate ([-90,0,0]) 
                cylinder(d=4, h=11.5,$fn=30);
            }               
            color("silver") translate([0,-.2,0]) rotate ([-90,0,0]) 
                cylinder(d=3, h=13.5,$fn=30);
            color("silver") translate([14.5,-.2,0]) rotate ([-90,0,0]) 
                cylinder(d=3, h=13.5,$fn=30);
            color("silver") translate([-3,-1,-3]) cube([3,13.5,7.5]);
            color("silver") translate([14.5,-1,-3]) cube([3,13.5,7.5]);
            color("silver") translate([-1,-1,-3]) cube([16.5,13.5,3]);
            }
        color("black") translate([2.5,.5,2.25]) cube([9.25,10.5,1.5]);
        }
}


// single row female headers
module header_f(pins, height) {

    adjust = .01;
    $fn = 90;
    size_x = 2.5;
    size_y = 2.5 * pins;                
    union() {
        color("black") cube([size_x, size_y, height]);
        for (i=[1:2.5:size_y]) {
            color("dimgray") translate ([1,i,height-5+adjust]) cube([.64,.64,5]);
        }
    }
}       


// single row pcb pad
module pcb_pad(pads) {

    adjust = .01;
    $fn = 90;
    size_x = 2.5;
    size_y = 2.5 * pads;                
    union() {
        for (i=[1:2.5:size_y]) {
            difference() {
                color("goldenrod") translate ([2,i+1,0]) cylinder(d=1.25, h=.125);
                color("dimgray") translate([2,i+1,.01]) cylinder(d=.625, h=2);
            }
        }
    }
}


// uart micro connector type
module uart_micro() {
    size_x = 12.5;
    size_y = 5;        
    union() {
        difference() {
            union() {
            
                difference () {
                    color("white") translate([0,0,0]) cube([size_x,size_y,6]);
                    color("darkgray") translate([.5,.5,2]) cube([11.5,4,6]);
                }
            }
            color("white") translate([12.5,0,-.5]) cube([2,6,7]);
            color("white") translate([-1,0,-.5]) cube([1,6,7]);
            color("white") translate([-1,5,-.5]) cube([14,2,7]);
            color("darkgray") translate([-1,1.5,2]) cube([14,1,7]);
        }
        for (i=[2.5:2.5:10]) {
            color("silver") translate ([i,3,.5]) cube([.6,.6,5]);
        }
    }
}


// usb2 micro otg
module usb_micro() {
        size_x = 7;
        size_y = 4.5;
        union() {    
            difference () {
                color("silver") translate([0,0,0]) cube([size_x, size_y, 3.5]);
                color("dimgray") translate([.5,-.1,.5]) cube([6, 3.5, 2.5]);
                color("silver") translate([0,-.1,0]) rotate ([-90,0,0]) 
                    cylinder(d=2.5, h=6.5,$fn=30);
                color("silver") translate([7,-.1,0]) rotate ([-90,0,0]) 
                    cylinder(d=2.5, h=6.5,$fn=30);

            }
            difference() {
                union() {
                    color("silver") translate([0,-.1,0]) rotate ([-90,0,0]) 
                    cylinder(d=2.5, h=4.5,$fn=30);
                    color("silver") translate([7,-.1,0]) rotate ([-90,0,0]) 
                    cylinder(d=2.5, h=4.5,$fn=30);
                }               
                color("silver") translate([0,-.2,0]) rotate ([-90,0,0]) 
                    cylinder(d=1.25, h=6.5,$fn=30);
                color("silver") translate([7,-.2,0]) rotate ([-90,0,0]) 
                    cylinder(d=1.25, h=6.5,$fn=30);
                
                color("silver") translate([-3,-1,-3]) cube([3,6.5,7.5]);
                color("silver") translate([7,-1,-3]) cube([3,6.5,7.5]);
                color("silver") translate([0,-1,-3]) cube([9,6.5,3]);
                color("silver") translate([-1,-1,-3]) cube([9,6.5,3]);
                }
            color("black") translate([1.5,.5,1.25]) cube([4,3.5,1]);
        }
    }


// rj45 single socket
module rj45(x,y,rotation,side,pcbsize_z) {
    size_x = 15.9;
    size_y = 21.3;
    place(x,y,0,size_x,size_y,rotation,side) 
    union() {
        difference () {
            color("lightgray") translate([0,0,0]) cube([size_x, size_y, 13.5]);
            color("darkgray") translate([1.5,-1,1.5]) cube([13, 19.5, 8]);
            color("darkgray") translate([5.5,-2,7]) cube([5, 19.5, 5]);
        }
        color("green") translate([2,-.1,10]) cube([3, 2, 2]);
        color("orange") translate([11,-.1,10]) cube([3, 2, 2]);
    }
}


// momentary_4.5x4.5x1.5 button
module momentary45x15() {

    adjust = .01;
    $fn = 90;
    size_x = 4.5;
    size_y = 4.5;        
    size_z = 3.1;        
    union() {
        color("black") translate([0,0,0]) cube([size_x,size_y,3]);
        color("silver") translate([0,0,3-adjust]) cube([size_x,size_y,.1]);
        color("black") translate([2.25,2.25,3.1-adjust]) cylinder(d=2.35,h=1.50);
        color("black") translate([.75,.75,3]) sphere(d=.75);
        color("black") translate([.75,3.75,3]) sphere(d=.75);
        color("black") translate([3.75,.75,3]) sphere(d=.75);
        color("black") translate([3.75,3.75,3]) sphere(d=.75);
    }
}


// single row headers
module header(pins) {

    adjust = .01;
    $fn = 90;
    size_x = 2.5;
    size_y = 2.5 * pins;                
    union() {
        color("black") translate([0,0,0]) cube([size_x, size_y, 2.5]);
        for (i=[1:2.5:size_y]) {
            color("silver") translate ([1,i,2.5]) cube([.64,.64,5]);
        }
    }
}       


// gpio 12 enclosed header
module encl_header_12() {
    size_x = 19.5;
    size_y = 5.5;                
    union() {                
        difference () {
            color("black") translate([0,0,0]) cube([size_x,size_y,6.25]);
            color ("dimgray") translate ([.5,.5,.6]) cube([18.5,4.5,5.75]);
        }
        for (i=[4.5:2:16]) {
            color("silver") translate ([i,1.5,1]) cube([.5,.5,5]);
            color("silver") translate ([i,3.5,1]) cube([.5,.5,5]);
        }
    }
}

    
// micro connector type
module micro2pin() {
    size_x = 7.5;
    size_y = 3.75;        
    union() {  
        difference () {
            color("white") translate([0,0,0]) cube([size_x,size_y,4.75]);
            color("darkgray") translate([1.5,.5,1]) cube([4.5,2.75,6]);
            color("white") translate([-.5,.75,-.5]) cube([1,2.5,6]);
            color("white") translate([7,.75,-.5]) cube([1,2.5,6]);
            color("darkgray") translate([2.25,-.5,1]) cube([3,2,6]);
        }
        color("silver") translate ([2.75,2,.5]) cube([.6,.6,4]);
        color("silver") translate ([4.5,2,.5]) cube([.6,.6,4]);
    }
}


// 3.5mm audio plug
module audio_jack35() {
    
    adjust = .01;
    $fn = 90;
    size_x = 6.5;
    size_y = 13.5;        
        difference () {
            union() {  
                color("dimgray") cube([size_x,size_y,3]);
                color("dimgray") cube([size_x,5.6,4]);
                color("dimgray") translate([size_x/2,0,2.25]) rotate([-90,0,0]) cylinder(d=4, h=size_y);
            }
            color("gray") translate([size_x/2,0,2.25]) rotate([-90,0,0]) cylinder(d=3, h=size_y+adjust);
        }    
}


// can capacitor
module capacitor(diameter, height) {
    adjust = .01;
    $fn = 90;
    color("dimgray") rotate([0,0,0]) cylinder(d=diameter+.5, h=.5);
    color("silver") translate([0,0,.5]) cylinder(d=diameter+.5, h=.5);
    color("silver") translate([0,0,1]) cylinder(d=diameter, h=height-1);
}


// ic 
module ic(size) {
    color("dimgray") cube(size);
}


/* hk speakers */
module hk_speaker() {
    
    spk_x = 44;
    spk_y = 20;
    spk_z = 98;
    c_hole = 6;
    i_dia = c_hole+3;
    adjust = .1;
    
    difference() {
        translate([spk_x/2,spk_y/2,spk_z/2]) cube_fillet_inside([spk_x,spk_y,spk_z], 
            vertical=[0,0,0,0,0], top=[0,c_hole,0,c_hole], bottom=[0,c_hole,0,c_hole], $fn=90);
        // speaker cone
        translate([spk_x/2,-adjust,spk_z-72]) rotate([-90,0,0]) cylinder(d=36, h=.5);
        
        // corner holes
        translate([(c_hole/2)+2,-adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adjust));
        translate([(c_hole/2)+2,-adjust,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adjust));
        translate([spk_x-(c_hole/2)-2,-adjust,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adjust));
        translate([spk_x-(c_hole/2)-2,-adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adjust));
        
        // lower left corner indent
        translate([(c_hole/2)+2,-adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([-adjust-1,-adjust,-adjust]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([adjust+.5,-adjust,-(i_dia/2)+adjust]) cube([i_dia+adjust,10+adjust,i_dia+adjust+.5]);        
        translate([(c_hole/2)+2,-adjust+12+adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([-adjust-1,-adjust+12+adjust,-adjust]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([adjust+.5,-adjust+12+adjust,-(i_dia/2)+adjust]) cube([i_dia+adjust,10+adjust,i_dia+adjust+.5]);
 
        // upper left corner corner indent
        translate([(c_hole/2)+2,-adjust,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([-adjust-1,-adjust,spk_z-i_dia-.5]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([-adjust+.5,-adjust,spk_z-(i_dia/2)+adjust-.5]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
        translate([(c_hole/2)+2,-adjust+12,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([-adjust-1,-adjust+12,spk_z-i_dia-.5]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([-adjust+.5,-adjust+12,spk_z-(i_dia/2)+adjust-.5]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
        
        // upper right corner corner indent
        translate([spk_x-(c_hole/2)-2,-adjust,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([spk_x-1-(i_dia/2),-adjust,spk_z-i_dia+adjust-.5]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-.5-i_dia,-adjust,spk_z-(i_dia/2)+adjust-.5]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-(c_hole/2)-2,-adjust+12,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([spk_x-1-(i_dia/2),-adjust+12,spk_z-i_dia+adjust-.5]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-.5-i_dia,-adjust+12,spk_z-(i_dia/2)+adjust-.5]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
      
        // lower right corner corner indent
        translate([spk_x-(c_hole/2)-2,-adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([spk_x-1-(i_dia/2),-adjust,-adjust]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-.5-i_dia,-adjust,-(i_dia/2)+adjust]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-(c_hole/2)-2,-adjust+12,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([spk_x-1-(i_dia/2),-adjust+12,-adjust]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-.5-i_dia,-adjust+12,-(i_dia/2)+adjust]) cube([i_dia,10+adjust,i_dia+adjust+.5]);            
        }
        // speaker cone
        translate([spk_x/2,-adjust+46,spk_z-72]) {
            difference() {
                translate([0,0,0]) sphere(d=96, $fn=180);
                translate([-50,-46,-50]) cube([100,100,100]);
            }
        }

    }

    
/* hk boom bonnet */
module hk_boom(speakers,orientation) {
    
    adjust = .01;
    $fn = 90;
    difference() {
        union() {
            color("tan") translate ([0,0,0]) slab([60,35,1.6],.5);
            if(speakers == true) {
                color("tan") translate ([-31.5,0,0]) slab([31.5,35,1.6],.5);
                color("white") translate ([-0.25,0,0]) cube([.5,35,1.6]);
                color("tan") translate ([60,0,0]) slab([31.5,35,1.6],.5);                
                color("white") translate ([60,0,0]) cube([.5,35,1.6]);
            }
        }
        // pcb holes
        color("tan") translate([3.5,3.5,-adjust]) cylinder(d=3,h=6);
        color("tan") translate([3.5,31.5,-adjust]) cylinder(d=3,h=6);
        color("tan") translate([56.5,3.5,-adjust]) cylinder(d=3,h=4);
        color("tan") translate([56.5,31.5,-adjust]) cylinder(d=3,h=4);
        if(speakers == true) {
            // left
            color("tan") translate([-28,3.5,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([-28,31.5,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([-3.5,3.5,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([-3.5,31.5,-adjust]) cylinder(d=3,h=6);
            // right
            color("tan") translate([64.5,3.5,-adjust]) cylinder(d=3,h=4);
            color("tan") translate([64.5,31.5,-adjust]) cylinder(d=3,h=4);
            color("tan") translate([88,3.5,-adjust]) cylinder(d=3,h=4);
            color("tan") translate([88,31.5,-adjust]) cylinder(d=3,h=4);
            // left speaker openings
            color("tan") translate([-31.5/2,35/2,-adjust]) cylinder(d=23.5, h=3);
            color("tan") translate([-4-31.5/2,35/2+(23.5/2)-.5,-adjust]) cube([6,3,3]);
            color("tan") translate([-4-31.5/2,35/2-(23.5/2)-2.5,-adjust]) cube([6,3,3]);
            color("tan") translate([-4-31.5/2+(23.5/2)+1,-2+35/2,-adjust]) cube([6,3,3]);
            // right speaker openings
            color("tan") translate([60+(31.5/2),35/2,-adjust]) cylinder(d=23.5, h=3);
            color("tan") translate([60-3+31.5/2,35/2+(23.5/2)-.5,-adjust]) cube([6,3,3]);
            color("tan") translate([60-3+31.5/2,35/2-(23.5/2)-2.5,-adjust]) cube([6,3,3]);
            color("tan") translate([60+1.25,-2+35/2,-adjust]) cube([6,3,3]);
        }
    }
    // headers
    translate([7.5,3.5,1.6-adjust]) rotate([0,0,-90]) header(3);
    translate([16,3.5,1.6-adjust]) rotate([0,0,-90]) header(7);
    translate([34,2,1.6-adjust]) rotate([0,0,0]) encl_header_12();
    translate([40,13.5,1.6-adjust]) rotate([0,0,-90]) header(2);
    translate([45.5,13.5,1.6-adjust]) rotate([0,0,-90]) header(2);
    difference() {
        union() {
            color("dimgray", 1) translate([44.5,27,1.6+2]) rotate([0,0,0]) cylinder(d=16, h=3);
            color("dimgray", 1) translate([44.5,27,1.6]) rotate([0,0,0]) cylinder(d=8, h=2);
        }
        color("dimgray", 1) translate([44.5,27,1.6+4]) rotate([0,0,0]) cylinder(d=12, h=3);     
        for(d=[5:10:360]) {
            color("dimgray") translate([44.5+(16/2)*cos(d),27+(16/2)*sin(d),1.6+2-adjust]) cylinder(d=.75, h=3+2*adjust);
        }  
    }
    color("gray", 1) translate([45,27,1.6+4-adjust]) rotate([0,0,0]) cylinder(d=1.5, h=.25);
    translate([3.75,13,1.6-adjust]) rotate([0,0,90]) micro2pin();
    translate([56.5,20.5,1.6-adjust]) rotate([0,0,-90]) micro2pin();
    translate([7.75,21.75,1.6-adjust]) audio_jack35();
    translate([20,30,1.6-adjust]) capacitor(6.25,6.5);
    translate([30,30,1.6-adjust]) capacitor(6.25,6.5);
    translate([22,16,1.6-adjust]) ic([6.5,4.5,1]);
    translate([10,12,1.6-adjust]) ic([4,4,1]);
    translate([32.5,9,1.6-adjust]) ic([3.5,3,1]);
    if(speakers == true && orientation == "rear") {
        translate([-31.5/2,35/2,1.6]) boom_speaker();
        translate([60+(31.5/2),35/2,1.6]) boom_speaker();
    }
    if(speakers == true && orientation == "front") {
        translate([-31.5/2,35/2,0]) rotate([0,180,0]) boom_speaker();
        translate([60+(31.5/2),35/2,0]) rotate([0,180,0]) boom_speaker();
    }
}


// hk stero boom bonnet speaker with board
module hk_boom_speaker(side,speaker,pcb) {

    adjust = .01;
    $fn = 90;

    if(pcb == true) {
        difference() {
            color("tan") slab([31.5,35,1.6],.5);
            color("tan") translate([27.5,4,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([27.5,31,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([4,4,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([4,31,-adjust]) cylinder(d=3,h=6);
            
            // speaker openings
            color("tan") translate([(31.5/2),35/2,-adjust]) cylinder(d=23.5, h=3);
            color("tan") translate([-3+31.5/2,35/2+(23.5/2)-.5,-adjust]) cube([6,3,3]);
            color("tan") translate([-3+31.5/2,35/2-(23.5/2)-2.5,-adjust]) cube([6,3,3]);
            if(side == "right") {
                color("tan") translate([.5,-2+35/2,-adjust]) cube([6,3,3]);
            }
            if(side == "left") {
                color("tan") translate([31.5/2+(23.5/2)-2.5,-2+35/2,-adjust]) cube([6,3,3]);
            }
        }
    }
    if(speaker == true && pcb == true) {
        translate([(31.5/2),35/2,1.6]) boom_speaker();        
    }
    if(speaker == true && pcb == false) {
        boom_speaker();        
    }
}


// hk stero boom bonnet speakers
module boom_speaker() {

    adjust = .01;
    $fn = 90;
    difference() {
        union() {
            color("silver") translate([0,0,-8.5]) cylinder_fillet_inside(h=6.5, r=21.4/2, 
                top=0, bottom=2, $fn=90, fillet_fn=30, center=false);
            color("dimgray") translate([0,0,2.5-adjust]) cylinder_fillet_inside(h=1, r=21.75/2, 
                top=1, bottom=0, $fn=90, fillet_fn=30, center=true);
  
            difference() {                
                color("black") translate([0,0,-5-adjust]) cylinder(d=23.7, h=5);
                for(d=[30:60:360]) {
                    color("dimgray") translate([(23.7/2)*cos(d),(23.7/2)*sin(d),-6-adjust]) cylinder(d=6, h=5+2*adjust);
                }
            }                
            color("black") translate([0,0,-adjust]) cylinder(d=27.8, h=2);
            color("dimgray") translate([0,0,1]) cylinder(d=22.8, h=1);
            color("dimgray") translate([0,0,1]) cylinder(d=17.5, h=1.25);
        }
        color("darkgray") translate([0,0,10.5]) sphere(d=23);
    }  
}


// hk boom bonnet speaker grill
module hk_boom_grill(style,thick) {

    adjust = .01;
    $fn = 90;
    if(style == "dome" || style == "frame") {
        difference() {
            union() {
                difference() {
                    translate([0,0,-23]) sphere(d=52.5);
                    translate([0,0,-25]) sphere(d=52.5);
                    translate([-30,-30,-60.5]) cube([60,60,60]);
                    for(c=[-14.5:3:24]) {
                        for(r=[-14.5:3:24]) {
                            translate([r,c,-1]) cube([2,2,40]);
                        }
                    }
                }
                if(style == "frame") {
                    difference() {
                        translate([0,0,-1.25]) cylinder(d=30.5, h=thick);
                        translate([0,0,-1.25-adjust]) cylinder(d=24, h=thick+2*adjust);      
                    }
                }
            }
        }
    }
    if(style == "flat") {
        difference() {
            translate([0,0,0]) cylinder(d=24.5, h=thick);
            for(c=[-14.5:3:24]) {
                for(r=[-14.5:3:24]) {
                    translate([r,c,-1]) cube([2,2,thick+2]);
                }
            }
        }
    }
}


// hk stero boom bonnet speaker holder
module boom_speaker_holder(style, tolerance) {

    adjust = .01;
    $fn = 90;

    if(style == "friction") {
        difference() {
            translate([0,0,0]) cylinder(d=31, h=4);
            translate([0,0,-adjust]) cylinder(d=28+tolerance, h=4+2*adjust);
            translate([0,-1,-adjust]) cube([15,40,10], center=true);
        }  
        difference() {
            translate([0,0,0]) cylinder(d=28+tolerance, h=2);
            translate([0,0,-adjust]) cylinder(d=28+tolerance-2, h=4+2*adjust);                
            translate([0,-1,-adjust]) cube([15,40,10], center=true);
        }
    }

    if(style == "clamp") {
        // bottom clamp
        topthick = 2;
        top_height = 14;
        difference() {
            cube([10.5,29,top_height-topthick]);
            // speaker holders
                translate([-1,14.5,14]) rotate([0,90,0]) cylinder(d=28, h=4.5);
                translate([2,14.5,14]) rotate([0,90,0]) cylinder(d=24, h=6);
                translate([4,14.5,14]) rotate([0,90,0]) cylinder(d=21.9, h=7.8);
        }        
    }
}


// hk stero boom bonnet speaker clamp holder top
module boom_speaker_strap(side) {

    topthick = 2;
    top_height = 14;
    adjust = .01;
    $fn = 90;
    // top clamp
    difference() {
        difference() {
            union() {
                translate([-3,14.5,top_height]) rotate([0,90,0]) cylinder(d=35,h=13.75);
                if(side == "left") {
                    translate([5.4,16.5,top_height+(topthick/2)-1]) cube_fillet_inside([16.75,55,topthick], 
                    vertical=[6,1,6,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                }        
                if(side == "right") {
                    translate([5.4,13,top_height+(topthick/2)-1]) cube_fillet_inside([16.75,55,topthick], 
                        vertical=[1,6,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                }        
            translate([10.75-adjust,14.5,top_height]) rotate([0,90,0]) cylinder(d=35,h=3);
            }
            translate([-9.25,0,top_height-topthick-adjust]) cube([20,29,topthick]);
            difference() {
                translate([-4.25,14.5,14]) rotate([0,90,0]) cylinder(d=28, h=15);
                translate([-5.25,0,19]) cube([20,30,19.5]);
            }
        }
        // speaker holders
        translate([-3-adjust,14.5,14]) rotate([0,90,0]) cylinder(d=30.8, h=4.5);
        translate([-3-adjust,14.5,14]) rotate([0,90,0]) cylinder(d=32.8, h=2);
        translate([-2.75,14.5,14]) rotate([0,90,0]) cylinder(d=28, h=14.5);
        translate([-4.55,-4,-4]) cube([20,37,topthick+15]);

        if(side == "left") {
            translate([4.15,-3.4,-adjust]) cylinder(d=3.2, h=50);
            translate([4.15,-3.4,15]) cylinder(d=6, h=10);
            translate([5.75,40,-adjust]) cylinder(d=3.2, h=50);
        }
        if(side == "right") {
            translate([4.5,32.5,-adjust]) cylinder(d=3.2, h=50);
            translate([4.5,32.5,15]) cylinder(d=6, h=10);
            translate([10.5,-11,-adjust]) cylinder(d=3.2, h=50);
        }
    }
}


// hk stero boom bonnet volume ring 
module boom_vring(tolerance) {

    out_dia = 22;
    in_dia = 16.15 + tolerance;
    thick = 3;
    nub = 1.25;
    adjust = .01;
    $fn = 90;
    difference() {
        color("black") translate([0,0,0])cylinder(d=out_dia, h=thick);
        color("dimgray") translate([0,0,-adjust]) cylinder(d=in_dia, h=thick+2*adjust);
        for(d=[5:10:360]) {
            color("dimgray") translate([(out_dia/2)*cos(d),(out_dia/2)*sin(d),-adjust]) cylinder(d=nub, h=thick+2*adjust);
        }
    }  
}


/* access port and support */
module access_port(size,orientation) {
    
    floorthick = size[2];
    adjust = .01;
    $fn = 90;
    if(orientation == "portrait") {
        difference() {
            union() {
                translate([0,0,0]) cube([size[0],size[1],size[2]]);
                // access panel support
                translate([(size[0]/2)+.25,size[1]-6.5,0]) cylinder(d=9,h=floorthick+(adjust*2)+5);
                translate([(size[0]/2)-10,size[1]-11,floorthick-adjust]) cube([20,9.5,floorthick]);
                translate([1,0,floorthick-adjust]) cube([size[0]-2,5,4.5]);
                }
            // access opening
            translate([.5,6,-adjust]) cube([size[0]-1.15,size[1]-17,floorthick+(adjust*2)]);
            translate([(size[0]/2)-5,size[1]-12,-adjust]) slab([10.5,5.5,floorthick],5.5);
            translate([(size[0]/2)+.25,size[1]-6.5,floorthick+2])
                cylinder(r=3.3,h=floorthick+(adjust*2)+5,$fn=6);
            translate([(size[0]/2)+.25,size[1]-6.5,-adjust]) 
                cylinder(d=3.2,h=floorthick+(adjust*2)+5);
            translate([4,2+adjust,floorthick]) cube([7.75,3,2.75]);
            translate([size[0]-13,2+adjust,floorthick]) cube([7.75,3,2.75]);
            if(size[0] > 100) {
                translate([(size[0]/2),2+adjust,floorthick]) cube([7.75,3,2.75]);
            }
        }
    }
    if(orientation == "landscape") {
        difference() {
            union() {
                translate([0,-1,0]) cube([size[0],size[1],size[2]]);
                // access panel support
                translate([size[0]-6.5,(size[1]/2)-.75,0]) cylinder(d=9,h=floorthick+(adjust*2)+5);
                translate([size[0]-11,(size[1]/2)-10,floorthick-adjust]) cube([9.5,20,floorthick]);
                translate([0,0,floorthick-adjust]) cube([5,size[1]-2,4.5]);
            }
            // access opening
            translate([6,-.5,-adjust]) cube([size[0]-17,size[1]-1.15,floorthick+(adjust*3)]);
            translate([size[0]-12,(size[1]/2)-6,-adjust]) slab([5.5,10.5,floorthick],5.5);
            translate([size[0]-6.5,(size[1]/2)-.5,floorthick+2]) rotate([0,0,30])
                cylinder(r=3.3,h=floorthick+(adjust*2)+5,$fn=6);
            translate([size[0]-6.5,(size[1]/2)-.5,-adjust]) 
                cylinder(d=3.2,h=floorthick+(adjust*2)+5);
            translate([2+adjust,3,floorthick]) cube([3,8.25,2.75]);
            translate([2+adjust,size[1]-13,floorthick]) cube([3,8.25,2.75]);
            if(size[1] > 100) {
                translate([2+adjust,(size[1]/2)-(7.75/2)-1.25,floorthick]) cube([3,7.75,2.5]);
            }
        }
    }
}


/* access cover and support */        
module access_cover(size,orientation) {
    
    floorthick = size[2];
    adjust = .01;
    $fn = 90;
    if(orientation == "portrait") {
        difference() {
            union() {
                translate([1,6.25,0]) cube([size[0]-2.15,size[1]-17.5,floorthick]);
                translate([(size[0]/2)-4.75,size[1]-12.25,0]) slab([10,5,floorthick], 5);
                translate([1,6.25,floorthick-adjust]) cube([size[0]-2.15,6,floorthick]);
                translate([4.25,3,floorthick]) cube([7.25,4,2]);
                translate([size[0]-12.75,3,floorthick]) cube([7.25,4,2]);
                if(size[0] > 100) {
                    translate([(size[0]/2)+.25,3,floorthick]) cube([7.25,4,2]);
                }
            }
            translate([(size[0]/2)+.25,size[1]-6.5,-floorthick-adjust]) 
                cylinder(d=3.2,h=(floorthick*2)+(adjust*2));
            translate([(size[0]/2)+.25,size[1]-6.5,-floorthick-adjust+floorthick]) 
                cylinder(d1=6, d2=3.2, h=floorthick);
        }
    }
    if(orientation == "landscape") {
        difference() {
            union() {
                translate([6.25,-.25,0]) cube([size[0]-17.5,size[1]-2,floorthick]);
                translate([size[0]-12.25,(size[1]/2)-6,0]) slab([5,10,floorthick], 5);
                translate([6.25,0,floorthick-adjust]) cube([6,size[1]-2.15,floorthick]);
                translate([3.5+adjust,3.25,floorthick]) cube([4,7.25,2]);
                translate([3.5+adjust,size[1]-12.75,floorthick]) cube([4,7.25,2]);
                if(size[1] > 100) {
                    translate([3.5+adjust,(size[1]/2)-(7.75/2)-1,floorthick]) cube([4,7.25,2]);
                }
            }
            translate([size[0]-6.5,(size[1]/2)-.75,-floorthick-adjust]) 
                cylinder(d=3.2,h=(floorthick*2)+(adjust*2));
            translate([size[0]-6.5,(size[1]/2)-.75,-floorthick-adjust+floorthick]) 
                cylinder(d1=6, d2=3.2, h=floorthick);
        }
    }
}


/* hdmi opening */
module hdmi_open() {
    
    union() { 
        difference() {
            translate([.25,-5,1]) cube([15, 8, 5.5]);
            translate([0.5,-5.2,.5]) rotate ([-90,0,0]) cylinder(d=3, h=13.5,$fn=30);
            translate([15,-5.2,.5]) rotate ([-90,0,0]) cylinder(d=3, h=13.5,$fn=30);
            }
        translate([2,-5,.5]) cube([11.5, 8, .5]);
        }
    }       

/* micro-usb opening */
module microusb_open() {
    
    translate([0,0,.5])rotate([90,0,0])
    hull() {
        translate([6,1.5,-5]) cylinder(d=3.5,h=8);
        translate([1,1.5,-5]) cylinder(d=3.5,h=8);
    }
}


/* fan mask to create opening */
module fan_mask(size, thick, style) {

$fn=90;

    if(style == 1) {
        translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-2);
        // mount holes
        translate ([size-4,size-4,-1]) cylinder(h=thick+2, d=3);
        translate ([size-4,4,-1]) cylinder(h=thick+2, d=3);
        translate ([4,size-4,-1]) cylinder(h=thick+2, d=3);
        translate ([4,4,-1]) cylinder(h=thick+2, d=3);
    }
    if(style == 2 && size == 40) {
        difference() {
            union () {
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-2);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-6);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-10);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-14);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-18);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-22);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-26);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-30);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-34);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-38);
                }
//                translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-34);
                // mount holes
                translate ([size-4,size-4,-1]) cylinder(h=thick+2, d=3);
                translate ([size-4,4,-1]) cylinder(h=thick+2, d=3);
                translate ([4,size-4,-1]) cylinder(h=thick+2, d=3);
                translate ([4,4,-1]) cylinder(h=thick+2, d=3);
            }
            translate([6.5,5,-2]) rotate([0,0,45]) cube([size,2,thick+4]);
            translate([4.5,size-6,-2]) rotate([0,0,-45]) cube([size,2,thick+4]);
        }    
    }
    if(style == 2 && size >= 80) {
        difference() {
            union () {
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-2);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-8);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-14);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-20);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-26);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-32);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-38);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-44);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-50);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-56);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-62);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-68);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-74);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-79);
                }
                // mount holes
                translate ([size-4,size-4,-1]) cylinder(h=thick+2, d=3);
                translate ([size-4,4,-1]) cylinder(h=thick+2, d=3);
                translate ([4,size-4,-1]) cylinder(h=thick+2, d=3);
                translate ([4,4,-1]) cylinder(h=thick+2, d=3);
            }
            translate([6.5,4.25,-2]) rotate([0,0,45]) cube([size*1.2,3,thick+4]);
            translate([4.25,size-6.5,-2]) rotate([0,0,-45]) cube([size*1.2,3,thick+4]);
        }    
    }
}


/* mask module */
module mask(loc_x,loc_y,loc_z,rotation,side,class,type,wallthick,gap,floorthick,pcb_z) {
    
    adjust = .01;
    $fn=90;
    
    // hdmi opening
    if(type == "hdmi_a" && side == "bottom") {
        place(loc_x,loc_y-1,loc_z-pcb_z,15,11.5,rotation,side) hdmi_open();
    }
    if(type == "hdmi_a" && side == "top" && rotation == 0) {
        place(loc_x-.5,loc_y-1,loc_z,15,11.5,rotation,side) hdmi_open();
    }
    if(type == "hdmi_a" && side == "top" && rotation == 90) {
        place(loc_x-1,loc_y,loc_z,15,11.5,rotation,side) hdmi_open();
    }
    if(type == "hdmi_a" && side == "top" && rotation == 180) {
        place(loc_x,loc_y+1,loc_z,15,11.5,rotation,side) hdmi_open();
    }
    if(type == "hdmi_a" && side == "top" && rotation == 270) {
        place(loc_x+1,loc_y-.5,loc_z,15,11.5,rotation,side) hdmi_open();
    }
    // micro usb opening
    if(class == "usb2" && type == "micro" && rotation == 0) {
        place(loc_x,loc_y-3,loc_z,8,3,rotation,side) microusb_open();
    }
    if(class == "usb2" && type == "micro" && rotation == 90) {
        place(loc_x-3,loc_y-1,loc_z,8,3,rotation,side) microusb_open();
    }
    if(class == "usb2" && type == "micro" && rotation == 180) {
        place(loc_x-1,loc_y+4.5,loc_z,8,3,rotation,side) microusb_open();
    }
    if(class == "usb2" && type == "micro" && rotation == 270) {
        place(loc_x+4.5,loc_y,loc_z,8,3,rotation,side) microusb_open();
    }
    // power plug openings
    if(type == "pwr5.5_7.5x11.5" && rotation == 0) {
        place(loc_x,loc_y,loc_z,7,7,rotation,side) 
            translate([3.5,2,6.5]) rotate([90,0,0]) cylinder(d=7, h=8);
    }
    if(type == "pwr5.5_7.5x11.5" && rotation == 90) {
        place(loc_x,loc_y,loc_z,7,7,rotation,side) 
            translate([3.5,2,6.5]) rotate([90,0,0]) cylinder(d=7, h=8);
    }
    if(type == "pwr5.5_7.5x11.5" && rotation == 180) {
        place(loc_x,loc_y,loc_z,7,7,rotation,side) 
            translate([3.5,-2.5,6.5]) rotate([90,0,0]) cylinder(d=7, h=8);
    }
    if(type == "pwr5.5_7.5x11.5" && rotation == 270) {
        place(loc_x-2,loc_y,loc_z,7,7,rotation,side) 
            translate([3.5,-4.5,6.5]) rotate([90,0,0]) cylinder(d=7, h=8);
    }
    if(type == "pwr2.5_5x7.5" && rotation == 0) {
        place(loc_x,loc_y,loc_z,3,3,rotation,side) 
            translate([2.75,2,2]) rotate([90,0,0]) cylinder(d=3, h=8);
    }
    if(type == "pwr2.5_5x7.5" && rotation == 90) {
        place(loc_x,loc_y,loc_z,3,3,rotation,side) 
            translate([.25,2,2]) rotate([90,0,0]) cylinder(d=3, h=8);
    }
    if(type == "pwr2.5_5x7.5" && rotation == 180) {
        place(loc_x,loc_y,loc_z,3,3,rotation,side) 
            translate([.5,-2.5,2]) rotate([90,0,0]) cylinder(d=3, h=8);
    }
    if(type == "pwr2.5_5x7.5" && rotation == 270) {
        place(loc_x,loc_y,loc_z,3,3,rotation,side) 
            translate([2.75,-2.5,2]) rotate([90,0,0]) cylinder(d=3, h=8);
    }
    // pwr5.5_10x10 opening
    if(type == "pwr5.5_10x10" && rotation == 0) {
        place(loc_x-.25,loc_y-6,loc_z,10.5,13.5,rotation,side)
            cube([10.5,8,10.5]);
    }
    // pwr5.5_10x10 opening
    if(type == "pwr5.5_10x10" && rotation == 90) {
        place(loc_x-6,loc_y-.25,loc_z,10.5,13.5,rotation,side)
            cube([10.5,8,10.5]);
    }
    // pwr5.5_10x10 opening
    if(type == "pwr5.5_10x10" && rotation == 180) {
        place(loc_x-.25,loc_y+6,loc_z,10.5,13.5,rotation,side)
            cube([10.5,8,10.5]);
    }
    // pwr5.5_10x10 opening
    if(type == "pwr5.5_10x10" && rotation == 270) {
        place(loc_x+6,loc_y-.25,loc_z,10.5,13.5,rotation,side)
            cube([10.5,8,10.5]);
    }
    // emmc storage
    if(type == "emmc" && side == "bottom" && rotation == 0) {
        place(loc_x-.5,loc_y,floorthick+adjust,14.5,19,rotation,side) 
            cube([14.5,19,floorthick+(2*adjust)]);
    }
    if(type == "emmc" && side == "bottom" && rotation == 90) {
        place(loc_x,loc_y-.5,floorthick+adjust,14.5,19,rotation,side) 
            cube([14.5,19,floorthick+(2*adjust)]);
    }
    // sd storage
    if(type == "sdcard" && side == "bottom" && rotation == 0) {
        place(loc_x,loc_y,loc_z,12,15.5,rotation,side)
            translate([-1,-10,3.5]) cube([13,15.5,2]);
    }
    if(type == "sdcard" && side == "bottom" && rotation == 90) {
        place(loc_x+(2*(wallthick+gap+adjust)),loc_y,loc_z-2.75,12,15.5,rotation,side)
            cube([12,15.5,2]);
    }
    if(type == "sdcard" && side == "bottom" && rotation == 180) {
        place(loc_x,loc_y+(2*(wallthick+gap+adjust)),loc_z-2.75,12,15.5,rotation,side)
            cube([12,15.5,2]);
    }
    if(type == "sdcard_i" && side == "bottom" && rotation == 180) {
        place(loc_x,loc_y+(2*(wallthick+gap+adjust)),floorthick+adjust+4,12,18.5,rotation,side)
            cube([12,18.5,floorthick+(2*adjust)+4]);
    }
    if(type == "sdcard" && side == "bottom" && rotation == 270) {
        place(loc_x,loc_y,loc_z,12,15.5,rotation,side)
            translate([0,-18,2.75]) cube([12,15.5,2]);
    }
    if(type == "sdcard" && side == "top" && rotation == 0) {
        place(loc_x,loc_y-17,loc_z,12,15.5,rotation,side)
            translate([0,0,1.75]) cube([12,15.5,2]);
    }
    if(type == "sdcard" && side == "top" && rotation == 180) {
        place(loc_x,loc_y+4,loc_z,12,15.5,rotation,side)
            translate([0,0,1.75]) cube([12,15.5,2]);
    }
    // rj45 opening
    if(type == "rj45_single" && rotation == 0) {
        place(loc_x,loc_y-6,loc_z,16,17.5,rotation,side) 
            cube([16,8,14]);
        }
    if(type == "rj45_single" && rotation == 90) {
        place(loc_x-6,loc_y,loc_z,16,17.5,rotation,side) 
            cube([16,8,14]);
        }
    if(type == "rj45_single" && rotation == 180) {
        place(loc_x,loc_y+10,loc_z,16,17.5,rotation,side) 
            cube([16,8,14]);
        }
    if(type == "rj45_single" && rotation == 270) {
        place(loc_x+10,loc_y,loc_z,16,17.5,rotation,side) 
            cube([16.5,8,14]);
    }
    // double stack usb opening
    if(type == "double_stacked_a" && rotation == 0) {
        place(loc_x-1,loc_y-6,loc_z,15.5,16,rotation,side)
            cube([15.5,8,16.5]);
    }
    if(type == "double_stacked_a" && rotation == 90) {
        place(loc_x-6,loc_y-1.25,loc_z,15.5,16,rotation,side)
            cube([15.5,8,16.5]);
    }
    if(type == "double_stacked_a" && rotation == 180) {
        place(loc_x-1,loc_y+7.5,loc_z,15.5,16,rotation,side)
            cube([15.5,8,16.5]);
    }
    if(type == "double_stacked_a" && rotation == 270) {
        place(loc_x+7.5,loc_y-1,loc_z,15.5,16,rotation,side)
            cube([15.5,8,16.5]);
    }
    // single vert usb2 opening
    if(type == "single_vert_a" && rotation == 0) {
        place(loc_x-.5,loc_y-6,loc_z,6.5,19.5,rotation,side)
            cube([6.5,8,15]);
    }
    if(type == "single_vert_a" && rotation == 90) {
        place(loc_x-6,loc_y-.25,loc_z,6.5,19.5,rotation,side)
            cube([6.5,8,15]);
    }
    if(type == "single_vert_a" && rotation == 180) {
        place(loc_x-.5,loc_y+6,loc_z,6.5,19.5,rotation,side)
            cube([6.5,8,15]);
    }
    if(type == "single_vert_a" && rotation == 270) {
        place(loc_x+6.5,loc_y,loc_z,6.5,19.5,rotation,side)
            cube([6.5,8,15]);
    }
    // ir opening
    if(type == "ir_1") {
        place(loc_x,loc_y,loc_z,6,6,rotation,side)
            translate([2.5,wallthick+gap,7.5]) rotate([90,0,0]) cylinder(d=6, h=9);
    }
    // switch opening
    if(type == "slide_4x9" && rotation == 0) {
        place(loc_x+(wallthick+gap+adjust),loc_y,loc_z,4,9.1,rotation,side)
            translate([0,0,.5]) cube([15.75,9.1,4]);
    }
    if(type == "slide_4x9" && rotation == 270) {
        place(loc_x,loc_y,loc_z,4,9.1,rotation,side)
            translate([0,0,.5]) cube([15.75,9.1,4]);
    }
    // rj45-usb2_double opening
    if(type == "rj45-usb2_double" && rotation == 0) {
        place(loc_x,loc_y-2*(wallthick+gap)-adjust,loc_z,19,28,rotation,side)
            cube([19,28,31]);
    }
    // rj45-usb3_double opening
    if(type == "rj45-usb3_double" && rotation == 0) {
        place(loc_x,loc_y-2*(wallthick+gap)-adjust,loc_z,19.5,28,rotation,side)
            cube([19.5,28,31]);
    }
    // out-in-spdif opening
    if(type == "out-in-spdif" && rotation == 0) {
        place(loc_x,loc_y-2*(wallthick+gap)-adjust,loc_z,13,21.65,rotation,side)
            cube([13,21.65,35.5]);
    }
    // dp-hdmi_a opening
    if(type == "dp-hdmi_a" && rotation == 0) {
        place(loc_x-.5,loc_y-2*(wallthick+gap)-adjust,loc_z,19,18,rotation,side)
            cube([19,18,19]);
    }
    // sata_encl_power opening
    if(type == "sata_encl_power" && rotation == 0) {
        place(loc_x,loc_y,loc_z,38.5,7.5,rotation,side)
            translate([1,9.5+adjust,3]) rotate([90,0,0]) slot(7.5,38.5,wallthick+2*adjust);
    }
    // audio jack opening
    if(type == "jack_3.5" && rotation == 180) {
        place(loc_x,loc_y+wallthick+gap,loc_z,7.5,7.5,rotation,side) 
            translate([4,0,2.25]) rotate([90,0,0]) cylinder(d=5, h=9);
    }
    if(type == "jack_3.5" && rotation == 270) {
        place(loc_x,loc_y+wallthick+gap,loc_z,5,5,rotation,side) 
            translate([-.5,-6,2]) rotate([90,0,0]) cylinder(d=5, h=9);
    }
    // button opening
    if(type == "momentary_6x6x4") {
        place(loc_x,loc_y,loc_z,6,6,rotation,side) 
            translate([3,3,5]) rotate([0,0,0]) cylinder(d=5, h=50);
    }    
    if(type == "momentary_6x6x4_90" && rotation == 270) {
        place(loc_x,loc_y,loc_z,6,6,rotation,side) 
            translate([3,-3,3]) rotate([90,0,0]) cylinder(d=5, h=10);
    }    
}


// punchout opening
module punchout(width,depth,gap,thick,fillet,shape) {
    
    adjust = .01;
    $fn=90;

    // slot punchout
    if(shape == "slot") {
        difference() {
            translate([0,0,0]) slot(depth,width,thick);
            translate([0,0,-adjust]) slot(depth-gap,width,thick+(2*adjust));
            // cross ties    
            translate([2,-(depth/2)-1,-adjust]) cube([2,depth+2,thick+(2*adjust)]);
            translate([(width/2)-1-(width/4)+4,-(depth/2)-1,-adjust]) cube([2,depth+2,thick+(2*adjust)]);
            translate([(width/2)-1+(width/4)-4,-(depth/2)-1,-adjust]) cube([2,depth+2,thick+(2*adjust)]);
            translate([width-4,-(depth/2)-1,-adjust]) cube([2,depth+2,thick+(2*adjust)]);
            }
        }
    if(shape == "rectangle") {
        difference() {
            translate([(width/2),(depth/2),thick/2]) 
                cube_fillet_inside([width,depth,thick], 
                    vertical=[fillet,fillet,fillet,fillet], 
                        top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
            translate([(width/2),(depth/2),(thick/2)-adjust]) 
                cube_fillet_inside([width-gap,depth-gap,thick+(3*adjust)], 
                    vertical=[fillet,fillet,fillet,fillet], 
                        top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
            // cross ties    
            translate([-1,(depth/2)-1,-adjust]) cube([gap+2,2,thick+(2*adjust)]);
            translate([(width/2)-1,depth-gap-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            translate([width-gap-1,(depth/2)-1,-adjust]) cube([gap+2,2,thick+(2*adjust)]);
            translate([(width/2)-1,-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            }
        }
    if(shape == "round") {
        difference() {
            translate([(width/2),(width/2),0]) 
                cylinder(d=width, h=thick); 
            translate([(width/2),(width/2),-adjust]) 
                cylinder(d=width-gap, h=thick+2*adjust); 
            // cross ties    
            translate([-1,(depth/2)-1,-adjust]) cube([gap+2,2,thick+(2*adjust)]);
            translate([(width/2)-1,depth-gap-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            translate([width-gap-1,(depth/2)-1,-adjust]) cube([gap+2,2,thick+(2*adjust)]);
            translate([(width/2)-1,-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            }
        }
    }


// vent opening
module vent(width,length,height,gap,rows,columns,orientation) {
    
    fillet = width/2;
    adjust = .01;
    $fn=90;
    
    // vertical orientation
    if(orientation == "vertical") { rotate([90,0,0])
        for (r=[0:length+gap:rows*(length+gap)-1]) {
            for (c=[0:width+(2*gap):(columns*(width+(2*gap)))-1]) {
                translate ([c,r,-1]) cube([width,length,height]);
            }
        }        
    }
    // horizontal orientation
    if(orientation == "horizontal") {
        for (r=[0:length+(2*gap):rows*(length+gap)]) {
            for (c=[0:width+(2*gap):(columns*(width+(2*gap)))-1]) {
                translate ([c,r,-1]) cube([width,length,height]);
            }
        }
    }
}
