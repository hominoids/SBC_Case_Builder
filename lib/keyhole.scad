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

*/


/*
           NAME: keyhole
    DESCRIPTION: enclosed keyhole
           TODO: none

          USAGE: keyhole(keysize, mask)

                         keysize[0] = size_x
                         keysize[1] = size_y
                         keysize[2] = size_z
                            mask[0] = true enables component mask
                            mask[1] = mask length
                            mask[2] = mask setback
                            mask[3] = mstyle "default"
*/

module keyhole(keysize, mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];
    adj=.01;
    $fn = 90;

    if(enablemask == true && mstyle == "default") {
        union() {
            translate([0, 0, -adj]) cylinder(h=keysize[3]+2*adj, d=keysize[0]);
            translate([-keysize[1]/2, 0, -adj]) cube([keysize[1], keysize[2]+keysize[0]/2, keysize[3]+2*adj]);
            translate([0, -keysize[1]/2, -adj]) cube([keysize[2]+keysize[0]/2, keysize[1], keysize[3]+2*adj]);
        }
    }
    else {
        difference() {
            union() {
                translate([0, 0, -adj]) 
                difference() {
                    difference() {
                        translate([-keysize[2], -keysize[2], keysize[3]]) cube([keysize[2]*3, keysize[2]*3, 4.5]);
                        translate([0, -10, 0]) rotate([0, 0, 135]) cube([20, 10, 10]);
                        translate([keysize[2], keysize[2], -adj]) cube([keysize[2]*3, keysize[2]*3, keysize[3]+5]);
                    }
                    difference() {
                        translate([-keysize[2]+2, -keysize[2]+2, keysize[3]-adj]) 
                            cube([-4+keysize[2]*3, -4+keysize[2]*3, 3.5]);
                        translate([2, -10, 0]) rotate([0, 0, 135]) cube([20, 10, 10]);
                        translate([+keysize[2]-2, keysize[2]-2, -adj]) 
                            cube([keysize[2]*3, keysize[2]*3, keysize[3]+5]);
                    }
                }
                difference() {
                    translate([-keysize[2], -keysize[2], 0]) cube([keysize[2]*3, keysize[2]*3, keysize[3]]);
                    translate([0, -10, -adj]) rotate([0, 0, 135]) cube([20, 10, 10]);
                }
            }
            translate([keysize[2], keysize[2], -adj]) cube([keysize[2]*3, keysize[2]*3, keysize[3]+2*adj]);
            union() {
                translate([0, 0, -adj]) cylinder(h=keysize[3]+2*adj, d=keysize[0]);
                translate([-keysize[1]/2, 0, -adj]) cube([keysize[1], keysize[2]+keysize[0]/2, keysize[3]+2*adj]);
                translate([0, -keysize[1]/2, -adj]) cube([keysize[2]+keysize[0]/2, keysize[1], keysize[3]+2*adj]);
            }
        }
    }
}