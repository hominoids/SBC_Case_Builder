/*
    This file is part of SBC Case Builder https://github.com/hominoids/SBC_Case_Builder
    Copyright 2022,2023,2024,2025 Edward A. Kisiel hominoid@cablemi.com

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

    grommet(face, style, od, id, wall, assembly, mask)
    grommet_clip(style, od, id, wall)

*/


/*
           NAME: grommet
    DESCRIPTION: creates different groumet styles
           TODO: none

          USAGE: grommet(face, style, od, id, wall, assembly, mask)

                      data[0] = "top","bottom","front","rear","left","right"
                      data[1] = "sleeve"
                      size[0] = od outside diameter of grommet body
                      size[1] = id inside hole diameter of grommet body
                      size[2] = wall thickness of installation
                      data[3] = assembled true, false
                      mask[0] = true enables component mask
                      mask[1] = mask length
                      mask[2] = mask setback
                      mask[3] = mstyle "default"
*/


module grommet(face = "bottom", style = "sleeve", od, id, wall, assembly, mask) {

    height = 4.5+(2*wall);
    enablemask = mask[0];
    mlength = height+mask[1];
    msetback = mask[2];
    mstyle = mask[3];
    cut = .25;
    lip_od = od+4;
    lip_thick = 2.5;

    adj = .01;
    $fn = 90;

    rotx = face == "rear" ? 270 : face == "front" || face == "left"  || face == "right" ? 90 : face == "top" ? 180 : 0;
    roty = 0;
    rotz = face == "left" ? 90 : face == "right" ? 270 : 0;

    rx = face == "left" ? -lip_thick : face == "right" ? lip_thick : 0;
    ry = face == "front" ? lip_thick : face == "rear" ? -lip_thick : 0;
    rz = face == "bottom" ? -lip_thick : face == "top" ? lip_thick : 0;

    translate([rx,ry,rz]) rotate([rotx,roty,rotz]) {
        if(enablemask == true && mstyle == "default") {
            if(style == "sleeve") {
                translate([0, 0, -adj-msetback]) cylinder(d = od+.5, h = mlength);
            }
        }
        if(enablemask == false) {
            if(style == "sleeve") {
                difference() {
                    union() {
                        cylinder(d=od, h=height);
                        cylinder(d=lip_od, h=2.5);
                    }
                    translate([0,0,-adj]) cylinder(d=id, h=height+(2*adj));
                    translate([-lip_od/2,-cut/2,-adj]) cube([lip_od+(2*adj),cut,height+(2*adj)]);
                    translate([0,0,2.75+wall]) grommet_clip(style,od,id,wall);
                }
                if(assembly == true) {
                    translate([0,0,2.5+wall]) grommet_clip(style,od,id,wall);
                }
            }
        }
    }
}

module grommet_clip(style,od,id,wall) {

    height = 2.5+wall;
    lip_od = od+4;
    adj = .01;
    $fn = 90;

    if(style == "sleeve") {
        difference() {
            cylinder(d=lip_od, h=2.5);
            difference() {
                translate([0,0,-adj]) cylinder(d=od, h=wall+2.5);
                translate([-lip_od/2,-od/2,-adj]) cube([lip_od+(2*adj),2,height-2]);
                translate([-lip_od/2,-2+od/2,-adj]) cube([lip_od+(2*adj),2,height-2]);
            }
            translate([-lip_od,-(od-6)/2,-adj]) cube([lip_od+(2*adj),od-6,wall+2.5]);
        }
    }
}
