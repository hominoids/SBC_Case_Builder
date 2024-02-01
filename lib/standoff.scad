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

                          stand_off[radius,
                                    height,
                                    holesize,
                                    supportsize,
                                    supportheight,
                                    sink,
                                        0 = none
                                        1 = countersink
                                        2 = recessed hole
                                        3 = nut holder
                                        4 = blind hole
                                    style,
                                        0 = hex shape
                                        1 = cylinder
                                    reverse,
                                    insert_e,
                                    i_dia,
                                    i_depth]
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
            if(style == 0 && reverse == 0) {
                rotate([0,0,30]) cylinder(d=radius*2/sqrt(3),h=height,$fn=6);
            }
            if(style == 0 && reverse == 1) {
                translate([0,0,-height]) rotate([0,0,30]) cylinder(d=radius*2/sqrt(3),h=height,$fn=6);
            }
            if(style == 1 && reverse == 0) {
                cylinder(d=radius,h=height,$fn=90);
            }
            if(style == 1 && reverse == 1) {
                translate([0,0,-height]) cylinder(d=radius,h=height,$fn=90);
            }
            if(reverse == 1) {
                translate([0,0,-supportheight]) cylinder(d=(supportsize),h=supportheight,$fn=60);
            }
            else {
                cylinder(d=(supportsize),h=supportheight,$fn=60);
            }
        }
        // hole
        if(sink <= 3  && reverse == 0) {
                translate([0,0,-adj]) cylinder(d=holesize, h=height+(adj*2),$fn=90);
        }
        if(sink <= 3  && reverse == 1) {
                translate([0,0,-adj-height]) cylinder(d=holesize, h=height+(adj*2),$fn=90);
        }
        // countersink hole
        if(sink == 1 && reverse == 0) {
            translate([0,0,-adj]) cylinder(d1=6.5, d2=(holesize), h=3);
        }
        if(sink == 1 && reverse == 1) {
            translate([0,0,+adj-2.5]) cylinder(d1=(holesize), d2=6.5, h=3);
        }
        // recessed hole
        if(sink == 2 && reverse == 0) {
            translate([0,0,-adj]) cylinder(d=6.5, h=3);
        }
        if(sink == 2 && reverse == 1) {
            translate([0,0,+adj-3]) cylinder(d=6.5, h=3);
        }
        // nut holder
        if(sink == 3 && reverse == 0) {
            translate([0,0,-adj]) cylinder(r=3.3,h=3,$fn=6);     
        }
        if(sink == 3 && reverse == 1) {
            translate([0,0,+adj-3]) cylinder(r=3.3,h=3,$fn=6);     
        }
        // blind hole
        if(sink == 4 && reverse == 0) {
            translate([0,0,2]) cylinder(d=holesize, h=height,$fn=90);
        }
        if(sink == 4 && reverse == 1) {
            translate([0,0,-height-2-adj]) cylinder(d=holesize, h=height,$fn=90);
        }
        if(insert_e > 0 && reverse == 0) {
            translate([0,0,height-i_depth]) cylinder(d=i_dia, h=i_depth+adj,$fn=90);
        }
        if(insert_e > 0 && reverse == 1) {
            translate([0,0,-height-adj]) cylinder(d=i_dia, h=i_depth+adj,$fn=90);
        }
    }
}
