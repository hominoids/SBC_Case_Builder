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

    fans(style, mask)
    fan_cover(size, thick)
    fan_mask(size, thick, style)

*/


/*
           NAME: fans
    DESCRIPTION: creates different fan styles and sizes
           TODO: add efficient vanes

          USAGE: fans(style, mask)

                      style = "box",
                    mask[0] = true enables component mask
                    mask[1] = mask length
                    mask[2] = mask setback
                    mask[3] = mstyle "default", "fan_open", "fan_1", "fan_2", "fan_hex"
*/

module fans(style, mask) {

    // size, thick, hole-spacing, hole-size, hub-size
    fan_data = [
                ["box140x25", 140, 25, 124.5, 4.3, 40, "#353535"],
                ["box120x25", 120, 25, 105, 4.3, 40, "#353535"],
                ["box92x25", 92, 25, 82.5, 4.3, 40, "#353535"],
                ["box92x10", 92, 10, 82.5, 4.3, 40, "#353535"],
                ["box80x25", 80, 25, 72.5, 4.3, 35, "#353535"],
                ["box80x10", 80, 10, 72.5, 4.3, 35, "#353535"],
                ["box60x25", 60, 25, 50, 4.3, 30, "#353535"],
                ["box60x10", 60, 10, 50, 4.3, 30, "#353535"],
                ["box50x10", 60, 10, 40, 4.3, 20, "#353535"],
                ["box40x10", 40, 10, 32, 4.3, 18, "#353535"],
                ["box30x10", 30, 10, 24, 3.2, 12, "#353535"],
                ["box25x10", 25, 10, 20, 3, 12, "#353535"]
               ];

    f = search([style],fan_data);

    diameter = fan_data[f[0]][1];
    thickness = fan_data[f[0]][2];
    hole_space = fan_data[f[0]][3];
    hole_size = fan_data[f[0]][4];
    hole_offset = (diameter-hole_space)/2;
    hub_size = fan_data[f[0]][5];
    fan_color = fan_data[f[0]][6];
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];


    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        if(mstyle == "fan_open") {
            translate([0, 0, thickness-msetback+1]) fan_mask(diameter, mlength, "fan_open");
        }
        if(mstyle == "default" || mstyle == "fan_1") {
            translate([0, 0, thickness-msetback+1]) fan_mask(diameter, mlength, "fan_1");
        }
        if(mstyle == "fan_2") {
            translate([0, 0, thickness-msetback+1]) fan_mask(diameter, mlength, "fan_2");
        }
        if(mstyle == "fan_hex") {
            translate([0, 0, thickness-msetback+1]) fan_mask(diameter, mlength, "fan_hex");
        }
    }
    if(enablemask == false) {
        difference() {
            union() {
                color(fan_color) slab([diameter, diameter, 3], 4);
                color(fan_color) translate([0, 0, thickness-3]) slab([diameter, diameter, 3], 4);
                color(fan_color) translate([diameter/2, diameter/2, 0]) cylinder(d=diameter+2, h=thickness);

            }
            // holes
            color(fan_color) translate([diameter/2, diameter/2, -1]) cylinder(d=diameter-2, h=thickness+2);
            color(fan_color) translate([hole_offset,hole_offset,-1]) cylinder(d=hole_size, h=thickness+2);
            color(fan_color) translate([hole_offset,diameter-hole_offset,-1]) cylinder(d=hole_size, h=thickness+2);
            color(fan_color) translate([diameter-hole_offset,hole_offset,-1]) cylinder(d=hole_size, h=thickness+2);
            color(fan_color) translate([diameter-hole_offset,diameter-hole_offset,-1]) cylinder(d=hole_size, h=thickness+2);
            // trim sides
            color(fan_color) translate([-4,-4, -1]) cube([4, diameter+8, thickness+2]);
            color(fan_color) translate([diameter,-4, -1]) cube([4, diameter+8, thickness+2]);
            color(fan_color) translate([-4,-4, -1]) cube([diameter+8, 4, thickness+2]);
            color(fan_color) translate([-4,diameter, -1]) cube([diameter+8, 4, thickness+2]);
        }
        color(fan_color) translate([diameter/2, diameter/2, thickness/2]) rotate([0,0,30]) 
            cylinder_fillet_inside(h=thickness, r=hub_size/2, top=1, bottom=1, $fn=90, fillet_fn=90, center=true);
    }
}


/*
           NAME: fan_cover
    DESCRIPTION: creates fan covers for fan openings
           TODO: none

          USAGE: fan_cover(size, thick, style)

                           size = size of fan
                          thick = thickness of cover
                          style = "fan_open", "fan_1", "fan_2", "fan_hex"
*/

module fan_cover(size, thick, style) {
    difference() {
        color("grey", 1) slab([size, size, thick], 3);
        color("grey", 1) fan_mask(size, thick, style);
    }
}


/*
    DESCRIPTION: creates fan masks for openings
           TODO: 

          USAGE: fan_mask(size, thick, style)

                          size = size of fan
                         thick = thickness of cover
                         style = "fan_open", "fan_1", "fan_2", "fan_hex"
*/

module fan_mask(size, thick, style) {

    hole_pos = size == 25 ? 2.5 :
        size == 30 ? 3 :
        size == 40 ? 4 :
        size == 50 || size == 60 || size == 70 ? 5 :
        size >= 80 ? 3.75 : 3.75;
    $fn = 90;
    adj = .01;

    if(style == "fan_open") {
        
        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-1);
        // mount holes
        translate([size-hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
        translate([size-hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
        translate([hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
        translate([hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
    }
    if(style == "fan_1" && size == 25) {
        
        union() {
            difference() {
                union () {
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-2);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-8);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-11);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-17);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-20);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-25);
                    }
                    // mount holes
                    translate([size-hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([size-hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                }
                translate([4, 3, -2]) rotate([0, 0, 45]) cube([size, 1.5, thick+4]);
                translate([3, size-4, -2]) rotate([0, 0, -45]) cube([size, 1.5, thick+4]);
            }
        }
    }
    if(style == "fan_1" && size == 30) {
        
        union() {
            difference() {
                union () {
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-2);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-8);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-11);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-17);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-20);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-25);
                    }
                    // mount holes
                    translate([size-hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([size-hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                }
                translate([5, 4, -2]) rotate([0, 0, 45]) cube([size, 1.5, thick+4]);
                translate([4, size-5, -2]) rotate([0, 0, -45]) cube([size, 1.5, thick+4]);
            }
        }
    }
    if(style == "fan_1" && size == 40) {
        
        union() {
            difference() {
                union () {
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-2);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-8);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-11);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-17);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-20);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-25);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-28);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-35);
                    }
                    // mount holes
                    translate([size-hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([size-hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                }
                translate([6.5, 5.5, -2]) rotate([0, 0, 45]) cube([size, 1.5, thick+4]);
                translate([5, size-6, -2]) rotate([0, 0, -45]) cube([size, 1.5, thick+4]);
            }
        }
    }
    if(style == "fan_1" && (size == 50 || size == 60 || size == 70)) {

        union() {
            difference() {
                union () {
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-2);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-14);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-18);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-30);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-34);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-46);
                    }
                    if(size > 50) {
                        difference() {
                            translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-50);
                            translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-59);
                        }
                    }
                    // mount holes
                    translate([size-hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([size-hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                }
                translate([8.5, 7, -2]) rotate([0, 0, 45]) cube([size > 60 ? size+4 : size+1, 2, thick+4]);
                translate([6.5, size-8, -2]) rotate([0, 0, -45]) cube([size > 60 ? size+4 : size+1, 2, thick+4]);
            } 
        }
    }
    if(style == "fan_1" && size >= 80) {

        union() {
            difference() {
                union () {
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-2);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-9);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-14);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-21);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-26);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-33);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-38);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-45);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-50);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-57);
                    }
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-62);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-68);
                    }
                    if(size == 92) {
                    difference() {
                        translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-74);
                        translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-80);
                    }
                        difference() {
                            translate([size/2, size/2, -1]) cylinder(h=thick+2, d=size-85);
                            translate([size/2, size/2, -2]) cylinder(h=thick+4, d=size-91);
                        }
                    }
                    // mount holes
                    translate([size-hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([size-hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
                    translate([hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
                }
                translate([6.5, 4.25, -2]) rotate([0, 0, 45]) cube([size*1.2, 3, thick+4]);
                translate([4.25, size-6.5, -2]) rotate([0, 0, -45]) cube([size*1.2, 3, thick+4]);
            }
        }
    }
    if(style == "fan_2") {

        inner = size == 25 ? 20 :
            size == 30 ? 24 :
            size == 40 ? 32 :
            size == 50 ? 40 :
                size == 60 ? 50 :
                size == 70 ? 61.9 :
                    size == 80 ? 71.5 :
                    size * 0.8; // Use 80% as default

        rings = size <= 40 ? 4 : 6;
        bar_size = size <= 40 ? 2 : 3;

        screw_offset = inner / 2;
        center_point = size * 0.5;
        base_ring_size = size * 0.95;
        rings_spacing = size / rings;

        translate([size/2, size/2, -1])
        union() {
            translate([screw_offset, screw_offset, (thick+2)/2]) cylinder(d=3, h=thick+2, center=true);
            translate([-screw_offset, screw_offset, (thick+2)/2]) cylinder(d=3, h=thick+2, center=true);
            translate([screw_offset, -screw_offset, (thick+2)/2]) cylinder(d=3, h=thick+2, center=true);
            translate([-screw_offset, -screw_offset, (thick+2)/2]) cylinder(d=3, h=thick+2, center=true);

            difference() {
                union() {
                    for(i=[inner:-rings_spacing:0]) {
                        difference() {
                            cylinder(d=base_ring_size - i, h=thick+2);
                            translate([0, 0, -1]) cylinder(d=base_ring_size - i - (rings_spacing/2), h=thick+4);
                        }
                    }
                }
                union() {
                    cylinder(d=bar_size*3+0.1, thick+2); // Add a circle to prevent any tiny holes around cross bar
                    #translate([0,0,1+thick/2]) rotate([0, 0, 45]) cube([size, bar_size, thick+2], center=true);
                    #translate([0,0,1+thick/2]) rotate([0, 0, 45]) cube([bar_size, size, thick+2], center=true);
                }
            }
        }
    }
    if(style == "fan_hex") {
        
        hex_pos = size == 25 ? [-14.25, -7, 0] :
            size == 30 ? [-11.75, -4.5, 0] :
            size == 40 ? [-14, -11.25, 0] :
            size == 50 ? [-16, -6.5, 0] : 
            size == 60 ? [-11, -1.5, 0] : 
            size == 70 ? [-13, -3.5, 0] :
            size >= 80 ? [-8.25, -3.5, 0] : [-9, -4, 0];

        union() {
            difference () {
                translate([1+(size-2)/2, 1+(size-2)/2, -1]) cylinder(h=thick+2, d=size-2);
                union() {
                    difference() {
                        translate([1+(size-2)/2, 1+(size-2)/2, -1-adj]) cylinder(h=thick+3, d=size-2);
                        translate(hex_pos) vent_hex(15, 8, thick+4, 12, 2, "horizontal");
                    }
                }
            }
        }
        // mount holes
        translate([size-hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
        translate([size-hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
        translate([hole_pos, size-hole_pos, -1]) cylinder(h=thick+2, d=3);
        translate([hole_pos, hole_pos, -1]) cylinder(h=thick+2, d=3);
    }
}
