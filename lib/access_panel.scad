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


           NAME: access_port
    DESCRIPTION: creates opening and structure for access openings
           TODO: none

          USAGE: access_port(size[], orientation)

                        size[0] = size_x
                        size[1] = size_y
                        size[2] = floor thickness
                    orientation = "landscape", "portrait"
*/

module access_port(size, orientation) {
    
    floorthick = size[2];
    adj = .01;
    $fn = 90;

    if(orientation == "portrait") {
        difference() {
            union() {
                cube([size[0], size[1], size[2]]);
                // access panel support
                translate([(size[0]/2)+.25, size[1]-6.5, 0]) cylinder(d=9, h=floorthick+(adj*2)+5);
                translate([(size[0]/2)-10, size[1]-11, floorthick-adj]) cube([20, 9.5, floorthick]);
                translate([1, 0, floorthick-adj]) cube([size[0]-2, 5, 4.5]);
                }
            // access opening
            translate([.5, 6, -adj]) cube([size[0]-1.15, size[1]-17, floorthick+(adj*2)]);
            translate([(size[0]/2)-5, size[1]-12, -adj]) slab([10.5, 5.5, floorthick], 5.5);
            translate([(size[0]/2)+.25, size[1]-6.5, floorthick+2])
                cylinder(r=3.2, h=floorthick+(adj*2)+5, $fn=6);
            translate([(size[0]/2)+.25, size[1]-6.5, -adj]) 
                cylinder(d=3.2, h=floorthick+(adj*2)+5);
            translate([4, 2+adj, floorthick]) cube([7.75, 3, 2.75]);
            translate([size[0]-13, 2+adj, floorthick]) cube([7.75, 3, 2.75]);
            if(size[0] > 100) {
                translate([(size[0]/2), 2+adj, floorthick]) cube([7.75, 3, 2.75]);
            }
        }
    }
    if(orientation == "landscape") {
        difference() {
            union() {
                translate([0, -1, 0]) cube([size[0], size[1], size[2]]);
                // access panel support
                translate([size[0]-6.5, (size[1]/2)-.5, 0]) cylinder(d=9, h=floorthick+(adj*2)+5);
                translate([size[0]-11, (size[1]/2)-10.5, floorthick-adj]) cube([9.5, 20, floorthick]);
                translate([0, 0, floorthick-adj]) cube([5, size[1]-2, 4.5]);
            }
            // access opening
            translate([6, -.5, -adj]) cube([size[0]-17, size[1]-1.15, floorthick+(adj*3)]);
            translate([size[0]-12, (size[1]/2)-6, -adj]) slab([5.5, 10.5, floorthick], 5.5);
            translate([size[0]-6.5, (size[1]/2)-.5, floorthick+2]) rotate([0, 0, 30])
                cylinder(r=3.2, h=floorthick+(adj*2)+5, $fn=6);
            translate([size[0]-6.5, (size[1]/2)-.5, -adj]) 
                cylinder(d=3.2, h=floorthick+(adj*2)+5);
            translate([2+adj, 3, floorthick]) cube([3, 8.25, 2.75]);
            translate([2+adj, size[1]-13, floorthick]) cube([3, 8.25, 2.75]);
            if(size[1] > 100) {
                translate([2+adj, (size[1]/2)-(7.75/2)-1.25, floorthick]) cube([3, 7.75, 2.5]);
            }
        }
    }
}


/*
           NAME: access_cover
    DESCRIPTION: creates covers for access port openings
           TODO: none

          USAGE: access_port(size[], orientation)

                        size[0] = size_x
                        size[1] = size_y
                        size[2] = floor thickness
                    orientation = "landscape", "portrait"
*/

module access_cover(size, orientation) {
    
    floorthick = size[2];
    adj = .01;
    $fn = 90;
    if(orientation == "portrait") {
        difference() {
            union() {
                translate([1, 6.25, 0]) cube([size[0]-2.15, size[1]-17.5, floorthick]);
                translate([(size[0]/2)-4.75, size[1]-12.25, 0]) slab([10, 5, floorthick], 5);
                translate([1, 6.25, floorthick-adj]) cube([size[0]-2.15, 6, floorthick]);
                translate([4.25, 3, floorthick]) cube([7.25, 4, 2]);
                translate([size[0]-12.75, 3, floorthick]) cube([7.25, 4, 2]);
                if(size[0] > 100) {
                    translate([(size[0]/2)+.25, 3, floorthick]) cube([7.25, 4, 2]);
                }
            }
            translate([(size[0]/2)+.25, size[1]-6.5, -floorthick-adj]) 
                cylinder(d=3.2, h=(floorthick*2)+(adj*2));
            translate([(size[0]/2)+.25, size[1]-6.5, -adj]) 
                cylinder(d1=6, d2=3.2, h=floorthick);
        }
    }
    if(orientation == "landscape") {
        difference() {
            union() {
                translate([6.25, 0, 0]) cube([size[0]-17.75, size[1]-2, floorthick]);
                translate([size[0]-12.25, (size[1]/2)-5.75, 0]) slab([5, 10, floorthick], 5);
                translate([6.25, 0, floorthick-adj]) cube([6,size[1]-2.15, floorthick]);
                translate([3.5+adj, 3.25, floorthick]) cube([4, 7.25, 2]);
                translate([3.5+adj, size[1]-12.75, floorthick]) cube([4, 7.25, 2]);
                if(size[1] > 100) {
                    translate([3.5+adj, (size[1]/2)-(7.75/2)-1,  floorthick]) cube([4, 7.25, 2]);
                }
            }
            translate([size[0]-6.5, (size[1]/2)-.75, -floorthick-adj]) 
                cylinder(d=3.2, h=(floorthick*2)+(adj*2));
            translate([size[0]-6.5, (size[1]/2)-.75, -adj]) 
                cylinder(d1=6, d2=3.2, h=floorthick);
        }
    }
}
