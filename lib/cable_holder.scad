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

    cableholder_spacer()
*/


/*
           NAME: cableholder_spacer
    DESCRIPTION: creates spacer and cable holder for drive mounts
           TODO: none

          USAGE: cableholder_spacer()

*/

module cableholder_spacer(size = [9.4,20,6]) {
    
//    size = [9.4,16,6];
    $fn = 90;
    translate([0,size[2]/2,-5]) rotate([90,0,0])
    difference() {
        translate([size[0]/2,size[0]/2,0]) rotate([0,0,90]) slot(size[0],size[1],size[2]);
        #translate([-1,5,3]) rotate([0,90,0]) cylinder(d=3.2, h=12);
        translate([-1,7.5,-1]) cube([2,20,9]);
        translate([5,9.5,-1]) rotate([0,0,90]) slot(4.5,13,9);
        translate([3,20,-1]) rotate([0,0,45]) cube([2,6,9]);
    }
}
