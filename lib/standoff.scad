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

           NAME: standoff
    DESCRIPTION: create standoffs
           TODO: none

          USAGE: standoff(stand_off)

                          stand_off[radius, height, supportsize, supportheight, sink, pillarstyle, pillarsupport, reverse, insert_e, i_dia, i_depth])
                                    radius = pillar radius
                                    height = total height
                                    holesize = hole diameter
                                    supportsize = support size for sink
                                    supportheight = height of support for sink
                                    sink = none, countersunk, recessed, nut holder, blind
                                    pillarstyle = hex, round style of pillar
                                    pillarsupport = none, left, rear, front, right
                                    reverse = true or false
                                    insert_e = true or false
                                    i_dia = insert diameter
                                    i_depth = insert hole depth

*/

module standoff(stand_off){

    radius = stand_off[0];
    height = stand_off[1];
    holesize = stand_off[2];
    supportsize = stand_off[3];
    supportheight = stand_off[4];
    sink = stand_off[5];
    pillarstyle = stand_off[6];
    pillarsupport = stand_off[7];
    reverse = stand_off[8];
    insert_e = stand_off[9];
    i_dia = stand_off[10];
    i_depth = stand_off[11];

    adj = 0.1;

    difference (){ 
        union () { 
            if(pillarstyle == "hex" && reverse == false) {
                rotate([0,0,30]) cylinder(d=radius*2/sqrt(3),h=height,$fn=6);
            }
            if(pillarstyle == "hex" && reverse == true) {
                translate([0,0,-height]) rotate([0,0,30]) cylinder(d=radius*2/sqrt(3),h=height,$fn=6);
            }
            if(pillarstyle == "round" && reverse == false) {
                cylinder(d=radius,h=height,$fn=90);
            }
            if(pillarstyle == "round" && reverse == true) {
                translate([0,0,-height]) cylinder(d=radius,h=height,$fn=90);
            }
            if(reverse == true) {
                translate([0,0,-supportheight]) cylinder(d=(supportsize),h=supportheight,$fn=60);
            }
            else {
                cylinder(d=(supportsize),h=supportheight,$fn=60);
            }
            if(pillarsupport == "rear" && reverse == true) {
                translate([-1,-supportsize/2,-height]) cube([2,supportsize/2,height]);
            }
            if(pillarsupport == "rear" && reverse == false) {
                translate([-1,-supportsize/2,0]) cube([2,supportsize/2,height]);
            }
            if(pillarsupport == "front" && reverse == true) {
                translate([-1,0,-height]) cube([2,supportsize/2,height]);
            }
            if(pillarsupport == "front" && reverse == false) {
                translate([-1,0,0]) cube([2,supportsize/2,height]);
            }
            if(pillarsupport == "left" && reverse == true) {
                translate([-supportsize/2,-1,-height]) cube([supportsize/2,2,height]);
            }
            if(pillarsupport == "left" && reverse == false) {
                translate([-supportsize/2,-1,0]) cube([supportsize/2,2,height]);
            }
            if(pillarsupport == "right" && reverse == true) {
                translate([0,-1,-height]) cube([supportsize/2,2,height]);
            }
            if(pillarsupport == "right" && reverse == false) {
                translate([0,-1,0]) cube([supportsize/2,2,height]);
            }
        }
        // hole
        if(sink != "blind"  && reverse == false) {
                translate([0,0,-adj]) cylinder(d=holesize, h=height+(adj*2),$fn=90);
        }
        if(sink != "blind"  && reverse == true) {
                translate([0,0,-adj-height]) cylinder(d=holesize, h=height+(adj*2),$fn=90);
        }
        // countersink hole
        if(sink == "countersunk" && reverse == false) {
            translate([0,0,-adj]) cylinder(d1=6.5, d2=(holesize), h=3);
        }
        if(sink == "countersunk" && reverse == true) {
            translate([0,0,+adj-2.5]) cylinder(d1=(holesize), d2=6.5, h=3);
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
            translate([0,0,-adj]) cylinder(r=3.3,h=3,$fn=6);     
        }
        if(sink == "nut holder" && reverse == true) {
            translate([0,0,+adj-3]) cylinder(r=3.3,h=3,$fn=6);     
        }
        // blind hole
        if(sink == "blind" && reverse == false) {
            translate([0,0,2]) cylinder(d=holesize, h=height,$fn=90);
        }
        if(sink == "blind" && reverse == true) {
            translate([0,0,-height-2-adj]) cylinder(d=holesize, h=height,$fn=90);
        }
        if(insert_e == true && reverse == false) {
            translate([0,0,height-i_depth]) cylinder(d=i_dia, h=i_depth+adj,$fn=90);
        }
        if(insert_e == true && reverse == true) {
            translate([0,0,-height-adj]) cylinder(d=i_dia, h=i_depth+adj,$fn=90);
        }
    }
}
