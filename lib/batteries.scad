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

    battery(type)
    battery_clip(bat_dia = 18.4)
    batt_holder(tolerance)

*/


/*
           NAME: battery
    DESCRIPTION: creates 18650 and 21700 batteries
           TODO: none

          USAGE: battery(type)

                         type = "18650", "18650_convex", "21700"
*/

module battery(type) {

    adj = .01;

    if(type == "18650") {
        difference() {
            color("#73bc73") cylinder(d=18.4, h=65);
            translate([0,0,65-4]) difference() {
                cylinder(d=18.5, h=2);
                cylinder(d=17.5, h=3);
            }
        }
    }
    if(type == "18650_convex") {
        difference() {
            color("#73bc73") cylinder(d=18.4, h=68);
            translate([0,0,65-4]) difference() {
                color("#73bc73") cylinder(d=18.5, h=2);
                color("#73bc73") cylinder(d=17.5, h=3);
            }
            translate([0,0,65-adj]) difference() {
                color("silver") cylinder(d=18.5, h=3+2*adj);
                color("silver") cylinder(d=14.4, h=3+2*adj);
            }
            color("silver") translate([0,0,68-adj]) cylinder(d=14.4, h=.1);
        }
    }
    if(type == "21700") {
        difference() {
            color("#73bc73") cylinder(d=21, h=70);
            translate([0,0,70-4]) difference() {
                cylinder(d=21.1, h=2);
                cylinder(d=20.1, h=3);
            }
        }
    }
}


/*
           NAME: battery_clip
    DESCRIPTION: creates 18650 and 21700 batteries
           TODO: none

          USAGE: battery_clip(bat_dia = 18.4)
*/

module battery_clip(bat_dia = 18.4) {
    
    mat = .38;
    width = 9.5;
    tab = 8.9;
    bat_holder = bat_dia+2*mat;
    adj = .1;

    translate([-5.5,0,10.5]) {
        difference() {
            translate([0,width,0]) rotate([90,0,0]) cylinder(d=bat_holder, h=9.5);
            translate([0,width+adj,0]) rotate([90,0,0]) cylinder(d=bat_dia, h=10.5);
            translate([mat/2-11.1/2,-adj,mat-1.3-bat_dia/2]) cube([11.1-mat,width+2*adj,3]);
            translate([0,width+adj,0]) rotate([90,-45,0]) cube([bat_dia,bat_dia,bat_holder]);
        }
        difference() {
            translate([-11.1/2,0,-1.3-bat_dia/2]) cube([11.1,width,3]);
            translate([mat-11.1/2,-adj,mat/2-1.3-bat_dia/2]) cube([11.1-2*mat,width+2*adj,3]);
        }
        difference() {
            translate([-(tab/2),-3.5,-1-bat_dia/2]) rotate([-5,0,0]) cube([tab,3.5,10]);
            translate([-(tab/2)-adj,-3.5+mat,mat-1-bat_dia/2]) rotate([-5,0,0]) cube([tab+2*adj,3.5+mat,10]);
        }    
        translate([0,-2.225,0]) rotate([85,0,0]) cylinder(d=tab, h=mat);
        difference() {
            translate([0,-2.75,0]) sphere(d=3);
            translate([-5,-2.75,-5]) rotate([85,0,0]) cube([tab,10,10]);
        }
    }
}


/*
           NAME: battery_holder
    DESCRIPTION: creates cr2032 friction fit coinstyle holder
           TODO: none

          USAGE: batt_holder(tolerance)
*/

module batt_holder(tolerance) {
    
    $fn = 90;
    difference () {
        cylinder(d=25.5,h=6);
        translate ([0,0,-1]) cylinder(d=20.4+tolerance,h=8);
        cube([14,26,13], true);
    }
    cylinder(r=12.75, h=2);
}

