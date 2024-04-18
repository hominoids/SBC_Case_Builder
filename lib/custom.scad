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

    hk_h3_port_extender(style, mask)
    hk_h3_port_extender_holder(part, offset)

*/


/*
           NAME: hk_h3_port_extender
    DESCRIPTION: @mctom's odroid-h3 gpio port extender
           TODO: none

          USAGE: hk_h3_port_extender(style, mask)

                                     style = "header", "remote"
                                   mask[0] = true enables component mask
                                   mask[1] = mask length
                                   mask[2] = mask setback
                                   mask[3] = mstyle "default"
*/

module hk_h3_port_extender(style, mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj=.01;
    $fn = 90;

    if(style == "header") {
        if(enablemask == true && mstyle == "default") {
            translate([0, 14.5, 12-msetback]) cube([7.75, 15.75, mlength]);
            translate([9.5, 14.5, 12-msetback]) cube([7.75, 15.75, mlength]);
            translate([19, 14.5, 12-msetback]) cube([7.75, 15.75, mlength]);
            translate([16, 32.2, 12-msetback]) cylinder(d=3, h=12);
        }
        if(enablemask == false) {
            // gpio 24 pin front position
            header("angled", -1.75, .1, 0, "top", 0, [12,2,8], ["thruhole","black","female",2.54,"silver"], 
                1.6, false, [true,10,2,"default"]);
            difference() {
                color("#008066") slab([33,35.25,1.6], .25);
                color("#008066") translate([15.95,4.6,-1]) cylinder(d=3, h=6);
                color("#008066") translate([15.95,32.15,-1]) cylinder(d=3, h=6);
            }
            header("angled", 27.65, 29.6, 0, "bottom", 90, [2,2,6], ["thruhole","black","male",2.54,"silver"], 
                1.6, false, [true,10,2,"default"]);
            header("angled", 30.5, 16.5, 0, "bottom", 90, [5,2,6], ["thruhole","black","male",2.54,"silver"], 
                1.6, false, [true,10,2,"default"]);
            usb2("single_up_a", .925, 15.375, 0, "top", 180, [0,10.5,0], [0], 1.6, false, [true,10,2,"default"]);
            usb2("single_up_a", 10.395, 15.375, 0, "top", 180, [0,10.5,0], [0], 1.6, false, [true,10,2,"default"]);
            usb2("single_up_a", 19.925, 15.375, 0, "top", 180, [0,10.5,0], [0], 1.6, false, [true,10,2,"default"]);
        }
    }
    if(style == "remote") {
        if(enablemask == true && mstyle == "default") {
            translate([0, 14.5, 12-msetback]) cube([7.75, 15.75, mlength]);
            translate([9.5, 14.5, 12-msetback]) cube([7.75, 15.75, mlength]);
            translate([19, 14.5, 12-msetback]) cube([7.75, 15.75, mlength]);
            translate([16, 32.2, 12-msetback]) cylinder(d=3, h=12);
            translate([16, 4.6, 12-msetback]) cylinder(d=3, h=mlength);
        }
        if(enablemask == false) {
            difference() {
                color("#008066") slab([33,35.25,1.6], .25);
                color("#008066") translate([15.95,4.6,-1]) cylinder(d=3, h=6);
                color("#008066") translate([15.95,32.15,-1]) cylinder(d=3, h=6);
            }
            // gpio 24 pin front position
            header("open", .75, 9, 0, "bottom", 0, [12,2,6], ["thruhole","black","male",2.54,"silver"], 
                1.6, false, [true,10,2,"default"]);
            header("angled", 27.65, 29.6, 0, "bottom", 90, [2,2,6], ["thruhole","black","male",2.54,"silver"], 
                1.6, false, [true,10,2,"default"]);
            header("angled", 30.5, 16.5, 0, "bottom", 90, [5,2,6], ["thruhole","black","male",2.54,"silver"], 
                1.6, false, [true,10,2,"default"]);
            usb2("single_up_a", .925, 15.375, 0, "top", 180, [0,10.5,0], [0], 1.6, false, [true,10,2,"default"]);
            usb2("single_up_a", 10.395, 15.375, 0, "top", 180, [0,10.5,0], [0], 1.6, false, [true,10,2,"default"]);
            usb2("single_up_a", 19.925, 15.375, 0, "top", 180, [0,10.5,0], [0], 1.6, false, [true,10,2,"default"]);
        }
    }
}


/*
           NAME: hk_h3_port_extender_holder
    DESCRIPTION: holder for the @mctom's remote h3 port extender
           TODO: none

          USAGE: hk_h3_port_extender_holder(part, offset)

                                            part = "top","bottom","both"
                                          offset = distance from mount face
*/

module hk_h3_port_extender_holder(part,offset=2) {

    size = [16-offset,40,5.5];
    adj = .01;

    if(part == "bottom" || part == "both") {
        difference() {
            translate([-10+offset,-3.5,2]) cube(size);
            translate([-.25,-.25,-adj]) cube([2.5, 33.25, 12]);
            translate([2, 2, -adj]) cube([10, 28, 12]);
            translate([-12,(33.25/2)+.25,4.5]) rotate([0,90,0]) cylinder(d=2.7, h=20, $fn=60);
//            translate([-7,-1.,-adj]) cylinder(d=4.25, h=20);
        }
    }
    if(part == "top" || part == "both") {
        difference() {
            translate([-10+offset,-3.5,29.5]) cube(size);
            translate([-.25,-.25,28]) cube([2.5, 33.25, 12]);
            translate([1.5, 2, 27.5-adj]) cube([10, 28.5, 12]);
            translate([-12, -4, 28]) cube([20, 13, 10]);
            translate([1.35, 20, 25.5]) cube([10, 13, 5]);
            translate([-12,(33.25/2)+.25,32]) rotate([0,90,0]) cylinder(d=2.7, h=20, $fn=60);
        }
    }
}

