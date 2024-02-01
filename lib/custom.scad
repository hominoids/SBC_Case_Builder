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

    h3_port_extender(style, mask = false)
    h3_port_extender_holder(part, offset)

*/

/*
           NAME: h3_port_extender
    DESCRIPTION: @mctom's odroid-h3 gpio port extender
           TODO: none

          USAGE: h3_port_extender(style, mask = false)

                                  style = "header", "remote"
                                   mask = true or false, mask for openings
*/

module h3_port_extender(style, mask = false) {

    adjust=.01;
    $fn = 90;

    if(style == "header") {
        if(mask == true) {
            translate([-20, 6.25, 15]) cube([12, 7.5, 14.75]);
            translate([-20, 15.875, 15]) cube([12, 7.5, 14.75]);
            translate([-20, 25.375, 15]) cube([12, 7.5, 14.75]);
            translate([-20, 17, 32.2]) rotate([0, 90, 0]) cylinder(d=3.5, h=12);
        }
        else {
            // gpio 24 pin front position
            color("silver") translate([1.6, 188.5, 84]) rotate([90, 0, 270]) import("stl/h3_port_extender.stl");
//            color("dimgrey") translate([-3, 15.75, 0.25]) rotate([90, 180, 180]) import("stl/header_f_2x12_90.stl");
            translate([0, 2, 8.25]) rotate([0, 180, 0]) header_f(12,8);
            translate([-2.54, 2, 8.25]) rotate([0, 180, 0]) header_f(12,8);
            color("dimgrey") translate([-2.5, 0, 29.5]) rotate([270, 0, 90]) import("stl/header_2x2_90.stl");
        }
    }
    if(style == "remote") {
        if(mask == true) {
            translate([-19, 6.25, 15]) cube([12,7.5,14.75]);
            translate([-19, 15.875, 15]) cube([12,7.5,14.75]);
            translate([-19, 25.375, 15]) cube([12,7.5,14.75]);
            translate([-19, 17, 32.2]) rotate([0,90,0]) cylinder(d=2.5, h=12);
            translate([-19, 17, 4.6]) rotate([0,90,0]) cylinder(d=2.5, h=12);
        }
        else {
            // gpio 24 pin front position
            color("silver") translate([1.6, 188.5, 84]) rotate([90, 0, 270]) import("stl/h3_port_extender.stl");
            color("dimgrey") translate([-2.5, 0, 29.5]) rotate([270, 0, 90]) import("stl/header_2x2_90.stl");
            color("dimgrey")translate([9,-.5,12.75]) rotate([0,270,90]) import("stl/header_encl_2x5_90.stl");
            translate([2, 2, 14.08]) rotate([0, 90, 0]) header(12);
            translate([2, 2, 11.54]) rotate([0, 90, 0]) header(12);
        }
    }
}


/*
           NAME: h3_port_extender
    DESCRIPTION: holder for the @mctom's remote h3 port extender
           TODO: none

          USAGE: h3_port_extender_holder(part, offset)

                                         part = "top","bottom","both"
                                         mask = true or false, mask for openings
*/

module h3_port_extender_holder(part,offset=2) {

    size = [16-offset,40,5.5];
    adjust = .01;

    if(part == "bottom" || part == "both") {
        difference() {
            translate([-10+offset,-3.5,2]) cube(size);
            translate([-.25,-.25,-adjust]) cube([2.5, 33.25, 12]);
            translate([2, 2, -adjust]) cube([10, 28, 12]);
            translate([-12,(33.25/2)+.25,4.5]) rotate([0,90,0]) cylinder(d=2.7, h=20, $fn=60);
//            translate([-7,-1.,-adjust]) cylinder(d=4.25, h=20);
        }
    }
    if(part == "top" || part == "both") {
        difference() {
            translate([-10+offset,-3.5,29.5]) cube(size);
            translate([-.25,-.25,28]) cube([2.5, 33.25, 12]);
            translate([1.5, 2, 27.5-adjust]) cube([10, 28.5, 12]);
            translate([-12, -4, 28]) cube([20, 13, 10]);
            translate([1.35, 20, 25.5]) cube([10, 13, 5]);
            translate([-12,(33.25/2)+.25,32]) rotate([0,90,0]) cylinder(d=2.7, h=20, $fn=60);
        }
    }
}

