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
           NAME: standoff
    DESCRIPTION: create standoffs
           TODO: none

          USAGE: standoff(stand_off, mask)

                 stand_off[size, diameter, height, holesize, supportsize, supportheight, sink, pillarstyle, 
                            pillarsupport, reverse, insert_e, i_dia, i_depth], mask)

                           size = "m2_tap","m2","m2+","m2.5_tap","m2.5","m2.5+","m3_tap","m3","m3+","m4_tap","m4","m4+","custom" 
                           diameter = pillar diameter
                           height = total height
                           holesize = hole diameter
                           supportsize = support size for sink
                           supportheight = height of support for sink
                           sink = none, countersunk, recessed, nut holder, blind
                           pillarstyle = hex, round
                           pillarsupport = none, left, rear, front, right
                           reverse = true or false
                           insert_e = true or false
                           i_dia = insert diameter
                           i_depth = insert hole depth

                           mask[0] = enablemask
                           mask[1] = mlength
                           mask[2] = msetback
                           mask[3] = mstyle

*/

module standoff(stand_off, mask){

    size = stand_off[0];
    diameter = size == "m2_tap" || size == "m2" || size == "m2+" ? 4 : 
                size == "m2.5_tap" || size == "m2.5" || size == "m2.5+" ? 4 : 
                    size == "m3_tap" || size == "m3" || size == "m3+" ? 5 : 
                        size == "m4_tap" || size == "m4" || size == "m4+" ? 6 : stand_off[1];
    height = stand_off[2];
    holesize = size == "m2_tap" ? 1.6 : size == "m2" ? 2 : size == "m2+" ? 2.26 : 
                    size == "m2.5_tap" ? 2.05 : size == "m2.5" ? 2.5 : size == "m2.5+" ? 2.83 : 
                        size == "m3_tap" ? 2.5 : size == "m3" ? 3 : size == "m3+" ? 3.4 : 
                            size == "m4_tap" ? 3.3 : size == "m4" ? 4 : size == "m4+" ? 4.4 : stand_off[3];
    supportsize = stand_off[4];
    supportheight = stand_off[5];
    sink = stand_off[6];
    pillarstyle = stand_off[7];
    pillarsupport = stand_off[8];
    reverse = stand_off[9];
    insert_e = stand_off[10];
    i_dia = stand_off[11];
    i_depth = stand_off[12];
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    ps = size == "m2_tap" || size == "m2" || size == "m2+" ? 4 : 
            size == "m2.5_tap" || size == "m2.5" || size == "m2.5+" ? 5.375 : 
                size == "m3_tap" || size == "m3" || size == "m3+" ? 6.72 : 
                    size == "m4_tap" || size == "m4" || size == "m4+" ? 8.96 : (2*holesize)+.5;
    ds = size == "m2_tap" || size == "m2" || size == "m2+" ? 1.2 : 
            size == "m2.5_tap" || size == "m2.5" || size == "m2.5+" ? 1.5 : 
                size == "m3_tap" || size == "m3" || size == "m3+" ? 1.86 : 
                    size == "m4_tap" || size == "m4" || size == "m4+" ? 2.48 : holesize*.465;

    adj = 0.1;
    $fn = 90;

    if(enablemask == true && mstyle == "default") {
        if(reverse == true) {
            translate([0,0,-msetback-adj]) cylinder(d=supportsize-2*adj,h=mlength);
        }
        else {
            translate([0,0,-mlength+msetback+adj]) cylinder(d=supportsize-2*adj,h=mlength);
        }
    }
    if(enablemask == false) {
        difference (){ 
            union () { 
                if(pillarstyle == "hex" && reverse == false) {
                    rotate([0,0,30]) cylinder(d=diameter*2/sqrt(3), h=height, $fn=6);
                }
                if(pillarstyle == "hex" && reverse == true) {
                    translate([0,0,-height]) rotate([0,0,30]) cylinder(d=diameter*2/sqrt(3), h=height, $fn=6);
                }
                if(pillarstyle == "round" && reverse == false) {
                    cylinder(d=diameter, h=height);
                }
                if(pillarstyle == "round" && reverse == true) {
                    translate([0,0,-height]) cylinder(d=diameter, h=height);
                }
                if(reverse == true) {
                    translate([0,0,-supportheight]) cylinder(d=supportsize, h=supportheight);
                }
                else {
                    cylinder(d=(supportsize),h=supportheight);
                }
                if(pillarsupport == "rear" && reverse == true) {
                    translate([-1,-supportsize/2,-height]) cube([2, supportsize/2, height]);
                }
                if(pillarsupport == "rear" && reverse == false) {
                    translate([-1,-supportsize/2,0]) cube([2, supportsize/2, height]);
                }
                if(pillarsupport == "front" && reverse == true) {
                    translate([-1,0,-height]) cube([2, supportsize/2, height]);
                }
                if(pillarsupport == "front" && reverse == false) {
                    translate([-1,0,0]) cube([2, supportsize/2, height]);
                }
                if(pillarsupport == "left" && reverse == true) {
                    translate([-supportsize/2,-1,-height]) cube([supportsize/2, 2, height]);
                }
                if(pillarsupport == "left" && reverse == false) {
                    translate([-supportsize/2,-1,0]) cube([supportsize/2, 2, height]);
                }
                if(pillarsupport == "right" && reverse == true) {
                    translate([0,-1,-height]) cube([supportsize/2, 2, height]);
                }
                if(pillarsupport == "right" && reverse == false) {
                    translate([0,-1,0]) cube([supportsize/2, 2, height]);
                }
            }
            // hole
            if(sink == "none" && reverse == false) {
                translate([0,0,-adj]) cylinder(d=holesize, h=height+(adj*2));
            }
            if(sink != "blind"  && reverse == false) {
                translate([0,0,-adj]) cylinder(d=holesize, h=height+(adj*2));
            }
            if(sink != "blind"  && reverse == true) {
                translate([0,0,-adj-height]) cylinder(d=holesize, h=height+(adj*2));
            }
            // countersink hole
            if(sink == "countersunk" && reverse == false) {
                translate([0,0,-adj]) cylinder(d1=ps, d2=holesize, h=ds);
            }
            if(sink == "countersunk" && reverse == true) {
                translate([0,0,+adj-ds]) cylinder(d1=holesize, d2=ps, h=ds);
            }
            // recessed hole
            if(sink == "recessed" && reverse == false) {
                translate([0,0,-adj]) cylinder(d=6.5, h=supportheight-2);
            }
            if(sink == "recessed" && reverse == true) {
                translate([0,0,+adj-supportheight+2]) cylinder(d=6.5, h=supportheight-2);
            }
            // nut holder
            if(sink == "nut holder" && reverse == false) {
                translate([0,0,-adj]) cylinder(d=ps*2/sqrt(3),h=ds,$fn=6);     
            }
            if(sink == "nut holder" && reverse == true) {
                translate([0,0,+adj-ds]) cylinder(d=ps*2/sqrt(3),h=ds,$fn=6);     
            }
            // blind hole
            if(sink == "blind" && reverse == false) {
                translate([0,0,2]) cylinder(d=holesize, h=height);
            }
            if(sink == "blind" && reverse == true) {
                translate([0,0,-height-2-adj]) cylinder(d=holesize, h=height);
            }
            if(insert_e == true && reverse == false) {
                translate([0,0,height-i_depth]) cylinder(d=i_dia, h=i_depth+adj);
            }
            if(insert_e == true && reverse == true) {
                translate([0,0,-height-adj]) cylinder(d=i_dia, h=i_depth+adj);
            }
        }
    }
}