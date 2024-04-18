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

    access_cover(size, orientation)
    access_panel(size, orientation, mask)

*/


/*
           NAME: access_cover
    DESCRIPTION: creates covers for access port openings
           TODO: none

          USAGE: access_panel(size[], orientation)

                        size[0] = size_x
                        size[1] = size_y
                        size[2] = floor thickness
                    orientation = "landscape", "portrait"
*/

module access_cover(size, orientation) {

    size_x = size[0];
    size_y = size[1];
    floorthick = size[2];
    adj = .01;
    $fn = 90;
    if(orientation == "portrait") {
        difference() {
            union() {
                translate([1, 6.25, 0]) cube([size_x-2.15, size_y-17.5, floorthick]);
                translate([(size_x/2)-4.75, size_y-12.25, 0]) slab([10, 5, floorthick], 5);
                translate([1, 6.25, floorthick-adj]) cube([size_x-2.15, 6, floorthick]);
                translate([4.25, 3, floorthick]) cube([7.25, 4, 2]);
                translate([size_x-12.75, 3, floorthick]) cube([7.25, 4, 2]);
                if(size_x > 100) {
                    translate([(size_x/2)+.25, 3, floorthick]) cube([7.25, 4, 2]);
                }
            }
            translate([(size_x/2)+.25, size_y-6.5, -floorthick-adj]) 
                cylinder(d=3.2, h=(floorthick*2)+(adj*2));
            translate([(size_x/2)+.25, size_y-6.5, -adj]) 
                cylinder(d1=6, d2=3.2, h=floorthick);
        }
    }
    if(orientation == "landscape") {
        difference() {
            union() {
                translate([6.25, 0, 0]) cube([size_x-17.75, size_y-2, floorthick]);
                translate([size_x-12.25, (size_y/2)-5.75, 0]) slab([5, 10, floorthick], 5);
                translate([6.25, 0, floorthick-adj]) cube([6,size_y-2.15, floorthick]);
                translate([3.5+adj, 3.25, floorthick]) cube([4, 7.25, 2]);
                translate([3.5+adj, size_y-12.75, floorthick]) cube([4, 7.25, 2]);
                if(size_y > 100) {
                    translate([3.5+adj, (size_y/2)-(7.75/2)-1,  floorthick]) cube([4, 7.25, 2]);
                }
            }
            translate([size_x-6.5, (size_y/2)-.75, -floorthick-adj]) 
                cylinder(d=3.2, h=(floorthick*2)+(adj*2));
            translate([size_x-6.5, (size_y/2)-.75, -adj]) 
                cylinder(d1=6, d2=3.2, h=floorthick);
        }
    }
}


/*
           NAME: access_panel
    DESCRIPTION: creates opening and structure for access openings
           TODO: none

          USAGE: access_panel(size[], orientation, mask)

                        size[0] = size_x
                        size[1] = size_y
                        size[2] = floor thickness
                    orientation = "landscape", "portrait"
                        mask[0] = true enables component mask
                        mask[1] = mask length
                        mask[2] = mask setback
                        mask[3] = mstyle "default"

*/

module access_panel(size, orientation, mask) {

    size_x = size[0];
    size_y = size[1];
    floorthick = size[2];
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true && mstyle == "default") {
        if(orientation == "portrait") {
            translate([0,0,floorthick+adj-mlength+msetback]) cube([size_x, size_y, mlength]);
        }
        if(orientation == "landscape") {
            translate([0, -1, floorthick+adj-mlength+msetback]) cube([size_x-1, size_y, mlength]);
        }
    }
    if(enablemask == false) {
        if(orientation == "portrait") {
            difference() {
                union() {
                    cube([size_x, size_y, floorthick]);
                    // access panel support
                    translate([(size_x/2)+.25, size_y-6.5, 0]) cylinder(d=9, h=floorthick+(adj*2)+5);
                    translate([(size_x/2)-10, size_y-11, floorthick-adj]) cube([20, 9.5, floorthick]);
                    translate([1, 0, floorthick-adj]) cube([size_x-2, 5, 4.5]);
                }
                // access opening
                translate([.5, 6, -adj]) cube([size_x-1.15, size_y-17, floorthick+(adj*2)]);
                translate([(size_x/2)-5, size_y-12, -adj]) slab([10.5, 5.5, floorthick], 5.5);
                translate([(size_x/2)+.25, size_y-6.5, floorthick+2])
                    cylinder(r=3.2, h=floorthick+(adj*2)+5, $fn=6);
                translate([(size_x/2)+.25, size_y-6.5, -adj]) 
                    cylinder(d=3.2, h=floorthick+(adj*2)+5);
                translate([4, 2+adj, floorthick]) cube([7.75, 3, 2.75]);
                translate([size_x-13, 2+adj, floorthick]) cube([7.75, 3, 2.75]);
                if(size_x > 100) {
                    translate([(size_x/2), 2+adj, floorthick]) cube([7.75, 3, 2.75]);
                }
            }
        }
        if(orientation == "landscape") {
            difference() {
                union() {
                    translate([0, -1, 0]) cube([size_x, size_y, floorthick]);
                    // access panel support
                    translate([size_x-6.5, (size_y/2)-.5, 0]) cylinder(d=9, h=floorthick+(adj*2)+5);
                    translate([size_x-11, (size_y/2)-10.5, floorthick-adj]) cube([9.5, 20, floorthick]);
                    translate([0, 0, floorthick-adj]) cube([5, size_y-2, 4.5]);
                }
                // access opening
                translate([6, -.5, -adj]) cube([size_x-17, size_y-1.15, floorthick+(adj*3)]);
                translate([size_x-12, (size_y/2)-6, -adj]) slab([5.5, 10.5, floorthick], 5.5);
                translate([size_x-6.5, (size_y/2)-.5, floorthick+2]) rotate([0, 0, 30])
                    cylinder(r=3.2, h=floorthick+(adj*2)+5, $fn=6);
                translate([size_x-6.5, (size_y/2)-.5, -adj]) 
                    cylinder(d=3.2, h=floorthick+(adj*2)+5);
                translate([2+adj, 3, floorthick]) cube([3, 8.25, 2.75]);
                translate([2+adj, size_y-13, floorthick]) cube([3, 8.25, 2.75]);
                if(size_y > 100) {
                    translate([2+adj, (size_y/2)-(7.75/2)-1.25, floorthick]) cube([3, 7.75, 2.5]);
                }
            }
        }
    }
}