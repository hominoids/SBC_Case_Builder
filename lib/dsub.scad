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

    dsub(style, gender, mask)

*/


/*
           NAME: dsub
    DESCRIPTION: creates dsub connectors
           TODO: 9db male, 25db male and female

          USAGE: dsub(style, gender, mask)

                      style = "db9"
                     gender = "female","male"
                     mask[0] = true enables component mask
                     mask[1] = mask length
                     mask[2] = mask setback
                     mask[3] = mstyle "default"
*/

module dsub(style, gender, mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true && mstyle == "default") {
        translate([0,0,-msetback]) union() {
            hull() {
                translate([-7,3,-5]) cylinder(d=3, h=11+mlength);
                translate([7,3,-5]) cylinder(d=3, h=11+mlength);
                translate([-6.25,-3,-5]) cylinder(d=3, h=11+mlength);
                translate([6.25,-3,-5]) cylinder(d=3, h=11+mlength);
            }
            // mount holes
            translate([-12.5,0,-5]) cylinder(d=3.5, h=11+mlength);
            translate([12.5,0,-5]) cylinder(d=3.5, h=11+mlength);
        }
    }
    if(enablemask == false) {
        if(style == "db9" && gender =="female") {
            difference() {
                union() {
                    color("silver") hull() {
                        translate([-6.5,2.5,-5]) cylinder(d=3, h=11);
                        translate([6.5,2.5,-5]) cylinder(d=3, h=11);
                        translate([-5.75,-2.5,-5]) cylinder(d=3, h=11);
                        translate([5.75,-2.5,-5]) cylinder(d=3, h=11);
                    }
                    color("black") hull() {
                        translate([-6,2.25,-6]) cylinder(d=3, h=12.25);
                        translate([6,2.25,-6]) cylinder(d=3, h=12.25);
                        translate([-5.25,-2.25,-6]) cylinder(d=3, h=12.25);
                        translate([5.25,-2.25,-6]) cylinder(d=3, h=12.25);
                    }
                // mount plate
                translate([-15.5,-6.5,-.25]) slab([31,13,.5], 2);
                // rear pins
                color("silver") translate([-5.48,1.4,-8]) cylinder(d=1.5, h=9);
                color("silver") translate([-2.74,1.4,-8]) cylinder(d=1.5, h=9);
                color("silver") translate([0,1.4,-8]) cylinder(d=1.5, h=9);
                color("silver") translate([2.74,1.4,-8]) cylinder(d=1.5, h=9);
                color("silver") translate([5.48,1.4,-8]) cylinder(d=1.5, h=9);
                color("silver") translate([-4.12,-1.4,-8]) cylinder(d=1.5, h=9);
                color("silver") translate([-1.38,-1.4,-8]) cylinder(d=1.5, h=9);
                color("silver") translate([1.36,-1.4,-8]) cylinder(d=1.5, h=9);
                color("silver") translate([4,-1.4,-8]) cylinder(d=1.5, h=9);

                }
                // mount holes
                color("silver") translate([-12.5,0,-3]) cylinder(d=3.2, h=6);
                color("silver") translate([12.5,0,-3]) cylinder(d=3.2, h=6);
                // pin holes
                color("silver") translate([-5.48,1.4,-9]) cylinder(d=1, h=16);
                color("silver") translate([-2.74,1.4,-9]) cylinder(d=1, h=16);
                color("silver") translate([0,1.4,-9]) cylinder(d=1, h=16);
                color("silver") translate([2.74,1.4,-9]) cylinder(d=1, h=16);
                color("silver") translate([5.48,1.4,-9]) cylinder(d=1, h=16);
                color("silver") translate([-4.12,-1.4,-9]) cylinder(d=1, h=16);
                color("silver") translate([-1.38,-1.4,-9]) cylinder(d=1, h=16);
                color("silver") translate([1.36,-1.4,-9]) cylinder(d=1, h=16);
                color("silver") translate([4,-1.4,-9]) cylinder(d=1, h=16);
            }
        }
    }
}