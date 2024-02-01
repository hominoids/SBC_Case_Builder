/*
    This file is part of SBC Case Builder https://github.com/hominoids/SBC_Case_Builder
    Copyright 2022,2023,2024 Edward A. Kisiel hominoid@cablemi.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>
    Code released under GPLv3: http://www.gnu.org/licenses/gpl.html

    dsub(dsubsize, mask = false)
    hdmi_a()
    header_f(pins, height)
    usb_micro()
    uart_micro()
    rj45()
    header(pins)
    encl_header_12()
    micro2pin()
    audio_jack35()
    capacitor(diameter, height)
    ic(size)
    led(ledcolor = "red")
    usbc()

*/

/*
           NAME: hdmi_a
    DESCRIPTION: hdmi-a female model
           TODO: none

          USAGE: hdmi_a()
*/

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

    adj = .01;
    $fn = 90;
    size_x = 2.5;
    size_y = 2.5 * pins;                
    union() {
        color("black") cube([size_x, size_y, height]);
        for (i=[1:2.5:size_y]) {
            color("dimgray") translate ([1,i,height-5+adj]) cube([.64,.64,5]);
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

    adj = .01;
    $fn = 90;
    size_x = 4.5;
    size_y = 4.5;        
    size_z = 3.1;        
    union() {
        color("black") translate([0,0,0]) cube([size_x,size_y,3]);
        color("silver") translate([0,0,3-adj]) cube([size_x,size_y,.1]);
        color("black") translate([2.25,2.25,3.1-adj]) cylinder(d=2.35,h=1.50);
        color("black") translate([.75,.75,3]) sphere(d=.75);
        color("black") translate([.75,3.75,3]) sphere(d=.75);
        color("black") translate([3.75,.75,3]) sphere(d=.75);
        color("black") translate([3.75,3.75,3]) sphere(d=.75);
    }
}


// single row headers
module header(pins) {

    adj = .01;
    $fn = 90;
    size_x = 2.54;
    size_y = 2.54 * pins;                
    union() {
        color("black") translate([0,0,0]) cube([size_x, size_y, 2.5]);
        for (i=[1:2.54:size_y]) {
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
    
    adj = .01;
    $fn = 90;
    size_x = 6.5;
    size_y = 13.5;        
        difference () {
            union() {  
                color("dimgray") cube([size_x,size_y,3]);
                color("dimgray") cube([size_x,5.6,4]);
                color("dimgray") translate([size_x/2,0,2.25]) rotate([-90,0,0]) cylinder(d=6, h=size_y);
            }
            color("gray") translate([size_x/2,0,2.25]) rotate([-90,0,0]) cylinder(d=3, h=size_y+adj);
        }    
}


// can capacitor
module capacitor(diameter, height) {
    adj = .01;
    $fn = 90;
    color("dimgray") rotate([0,0,0]) cylinder(d=diameter+.5, h=.5);
    color("silver") translate([0,0,.5]) cylinder(d=diameter+.5, h=.5);
    color("silver") translate([0,0,1]) cylinder(d=diameter, h=height-1);
}


// ic 
module ic(size) {
    color("dimgray") cube(size);
}


// d-sub connector
module dsub(dsubsize, mask = false) {
    
    adj=.01;
    $fn = 90;

    if(mask == true) {
        union() {
            translate([-1, 1, -.75]) rotate([90,0,0]) slab_r([19,10.5,10], [4,4,4,4]);
            translate([-4, 1, 4.5]) rotate([90,0,0]) cylinder(h=10, d=3);
            translate([21, 1, 4.5]) rotate([90,0,0]) cylinder(h=10, d=3);
        }
    }
    else {
        if(dsubsize[0] == 9 && dsubsize[1] == "female") {
            translate([8.5,0.4,4.5]) rotate([90,0,0]) import("./stl/db9_f.stl");
        }
        if(dsubsize[0] == 9 && dsubsize[1] == "male") {
            translate([8.5,0.4,4.5]) rotate([90,0,0]) import("./stl/db9_m.stl");
        }
    }
}


module led(ledcolor = "red") {
    
    color(ledcolor) cube([3,1.5,.4]);
    color("silver") cube([.5,1.5,.5]);
    color("silver") translate([2.5,0,0]) cube([.5,1.5,.5]);
}


module usbc() {
    
    $fn=90;
    adj = .01;
    
    // usbc horizontal type
        
        size_x = 9;
        size_y = 7;
        dia = 3.5;
        diam = 3.75;

        rotate([90, 0, 0])  translate([dia/2, dia/2, -size_y]) union() {    
            difference () {
                color("silver")
                hull() {
                    translate([0,0,0]) cylinder(d=dia,h=size_y);
                    translate([size_x-dia,0,0]) cylinder(d=dia,h=size_y);        
                    }
                color("silver") translate([0,0,1])
                hull() {
                    translate([0,0,0]) cylinder(d=3,h=size_y+.2);
                    translate([size_x-dia,0,0]) cylinder(d=3,h=size_y+.2);        
                    }
            }
            color("black") translate([0,-1.2/2,.1]) cube([5.5,1.2,6]);
        }
    }
