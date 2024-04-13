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


           NAME: fans
    DESCRIPTION: creates different fan styles and sizes
           TODO: add vans

          USAGE: buttons(style, size, mask)

                        style = "box",
                      size[0] = size of fan
                      size[2] = thickness of fan
                      mask[0] = true enables component mask
                      mask[1] = mask length
                      mask[2] = mask setback
                      mask[3] = mstyle "default"
*/

module fans(style, mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    // size, thick, hole-spacing, hole-size, hub-size
    fan_data = [
                ["box140x25", 140, 25, 124.5, 4.3, 40, "#353535"],
                ["box120x25", 120, 25, 105, 4.3, 40, "#353535"],
                ["box92x25", 92, 25, 82.5, 4.3, 40, "#353535"],
                ["box80x25", 80, 25, 72.5, 4.3, 35, "#353535"],
                ["box60x10", 60, 10, 50, 4.3, 35, "#353535"],
                ["box50x10", 60, 10, 40, 4.3, 20, "#353535"],
                ["box40x10", 40, 10, 32, 4.3, 18, "#353535"],
                ["box30x10", 30, 10, 24, 3.2, 12, "#353535"]
               ];

    f = search([style],fan_data);

    diameter = fan_data[f[0]][1];
    thickness = fan_data[f[0]][2];
    hole_space = fan_data[f[0]][3];
    hole_size = fan_data[f[0]][4];
    hole_offset = (diameter-hole_space)/2;
    hub_size = fan_data[f[0]][5];
    fan_color = fan_data[f[0]][6];

    adj = .01;
    $fn = 90;

    if(enablemask == true && mstyle == "default") {
        if(style == "box") {
            translate([0, 0, -adj-msetback]) cylinder(d = diameter-2*adj, h = mlength);
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