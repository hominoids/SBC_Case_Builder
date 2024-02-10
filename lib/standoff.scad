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

                          stand_off[radius, height, supportsize, supportheight, sink, style, reverse, insert_e, i_dia, i_depth])
                                    radius = pillar radius
                                    height = total height
                                    holesize = hole diameter
                                    supportsize = support size for sink
                                    supportheight = height of support
                                    sink = none, countersunk, recessed, nut holder, blind
                                    style = hex, round style of pillar
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
    style = stand_off[6];
    reverse = stand_off[7];
    insert_e = stand_off[8];
    i_dia = stand_off[9];
    i_depth = stand_off[10];

    adj = 0.1;

    difference (){ 
        union () { 
            if(style != "none" && reverse == false) {
                rotate([0,0,30]) cylinder(d=radius*2/sqrt(3),h=height,$fn=6);
            }
            if(style != "none" && reverse == true) {
                translate([0,0,-height]) rotate([0,0,30]) cylinder(d=radius*2/sqrt(3),h=height,$fn=6);
            }
            if(style == "countersunk" && reverse == false) {
                cylinder(d=radius,h=height,$fn=90);
            }
            if(style == "countersunk" && reverse == true) {
                translate([0,0,-height]) cylinder(d=radius,h=height,$fn=90);
            }
            if(reverse == true) {
                translate([0,0,-supportheight]) cylinder(d=(supportsize),h=supportheight,$fn=60);
            }
            else {
                cylinder(d=(supportsize),h=supportheight,$fn=60);
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
            translate([0,0,-adj]) cylinder(d=6.5, h=3);
        }
        if(sink == "recessed" && reverse == true) {
            translate([0,0,+adj-3]) cylinder(d=6.5, h=3);
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
