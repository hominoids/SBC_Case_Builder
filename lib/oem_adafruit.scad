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


           NAME: adafruit_lcd
    DESCRIPTION: adafruit 4311 2in TFT IPS Display model
           TODO: none

          USAGE: adafruit_lcd(enablemask, mask[])

                              enablemask = true produces mask, false produces model
                                 mask[0] = true enables component mask
                                 mask[1] = mask length
                                 mask[2] = mask setback
                                 mask[3] = mstyle "default"

*/

module adafruit_lcd(enablemask=false, mask) {

    size_x = 35.5;
    size_y = 59;
    size_z = 1.6;
    size_xm = size_x+1;
    size_ym = size_y+1;
    lcd_size = [34.75,48,2];
    corner_radius = 2;
    hole_size = 2.5;
    cmask = mask[0];
    mlen = mask[1];
    back = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true && cmask == true && mstyle == "default") {
        translate([2.25, 11, size_z+2.5-back]) cube([lcd_size[0]-4, lcd_size[1]-7, mlen]);
        storage("microsdcard", 11, 44, 0, "bottom", 180, [size_x, size_z, size_y], [0], size_z, enablemask, [true, 20, 0, "default"]);
        fpc("fh19", .5, 22, 0, "bottom", 270, [18,0,0], ["smt","side","white","black"], size_z, enablemask, [true,10,2,"default"]);
    }
    if(enablemask == false) {
        difference() {
            union() {
                color("#252525") slab([size_x, size_y, size_z], corner_radius);
                color("black",1) translate([0.375, 5.75, size_z-adj]) cube([lcd_size[0], lcd_size[1], 2.5]);
                color("#353535",1) translate([.375, 9.25, size_z+2.5-adj]) cube([lcd_size[0], lcd_size[1]-4, .1]);
                color("dimgrey",1) translate([2.25, 11, size_z+2.5-adj]) cube([lcd_size[0]-4, lcd_size[1]-7, .2]);
            }
            color("#252525") translate([hole_size, size_y-hole_size, -adj]) cylinder(d=hole_size,h=6);
            color("#252525") translate([size_x-hole_size, size_y-hole_size, -adj]) cylinder(d=hole_size, h=4);
            for(i=[5:2.54:31]) {
                color("#fee5a6",1) translate([i, 2.5, -adj]) cylinder(d=.8, h=6);
            }
        }
        storage("microsdcard", 11, 44, 0, "bottom", 180, [size_x, size_z, size_y], [0], size_z, enablemask, [true, 20, 0, "default"]);
        ic("generic", 13.25, 9, 0, "bottom", 0, [4, 10, 1.75], ["dimgrey"], size_z, enablemask, [false, 20, 0, "default"]);
        fpc("fh19", .5, 22, 0, "bottom", 270, [18,0,0], ["smt","side","white","black"], size_z, enablemask, [true,10,2,"default"]);

        for(i=[5:2.54:31]) {
            pcbpad("round", i, 2.5, 0, "top", 0, [1, 1, 0], [.8, "#fee5a6", 1.2], size_z, enablemask, [false, 20, 0, "default"]);
        }
        pcbpad("round", hole_size, size_y-hole_size, 0, "top", 0, [1, 1, 0], 
                [hole_size, "#fee5a6", hole_size+1], size_z, enablemask, [false, 20, 0, "default"]);
        pcbpad("round", size_x-hole_size, size_y-hole_size, 0, "top", 0, [1, 1, 0], 
                [hole_size, "#fee5a6", hole_size+1], size_z, enablemask, [false, 20, 0, "default"]);
    }
}



