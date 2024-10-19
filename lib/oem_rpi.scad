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

    rpi_m2hat(mask)

*/


/*
           NAME: rpi_m2hat
    DESCRIPTION: Raspberry Pi M.2 HAT+ M Key model
           TODO: none

          USAGE: rpim2-hat(mask[])

                              mask[0] = true enables mask
                              mask[1] = mask length
                              mask[2] = mask setback
                              mask[3] = mstyle "default"

*/

module rpi_m2hat(mask) {

    size_x = 65;
    size_y = 56.5;
    size_z = 1.6;
    corner_radius = 3.5;
    hole_size = 3.5;
    enablemask = mask[0];
    mlen = mask[1];
    back = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true && mstyle == "default") {
        translate([6, 49, 0]) slab([52.8, 7, mlen],1);
    }
    if(enablemask == false) {
        difference() {
            color("#008066") slab([size_x, size_y, size_z], corner_radius);
            color("#008066") translate([hole_size, size_y-hole_size, -adj]) cylinder(d=hole_size,h=6);
            color("#008066") translate([size_x-hole_size, size_y-hole_size, -adj]) cylinder(d=hole_size, h=4);
            color("#008066") translate([hole_size, hole_size, -adj]) cylinder(d=hole_size,h=6);
            color("#008066") translate([size_x-hole_size, hole_size, -adj]) cylinder(d=hole_size, h=4);
            color("#008066") translate([-3, 21, -adj]) slab([8,18,6],2);
            color("#008066") translate([47.5, -2, -adj]) slab([10,18,6],2);
        }
        header("open",7,50,0,"top",0,[20,2,4],["smt","black","female",2.54,"#fee5a6"], size_z, enablemask, [false,10,-2,"none"]);
        fpc("fh19", 6.5, 25, 0, "top", 90, [16,0,0], ["smt","side","grey","white"], size_z, enablemask, [true,10,2,"default"]);
        storage("m.2_header",15,17,0,"top",270,[0,0,0],[0], size_z, enablemask, [true,10,2,"default"]);

        pcbpad("round", hole_size, size_y-hole_size, 0, "top", 0, [1, 1, 0], 
                [hole_size, "#fee5a6", hole_size+1], size_z, enablemask, [false, 20, 0, "default"]);
        pcbpad("round", size_x-hole_size, size_y-hole_size, 0, "top", 0, [1, 1, 0], 
                [hole_size, "#fee5a6", hole_size+1], size_z, enablemask, [false, 20, 0, "default"]);
        pcbpad("round", hole_size, hole_size, 0, "top", 0, [1, 1, 0], 
                [hole_size, "#fee5a6", hole_size+1], size_z, enablemask, [false, 20, 0, "default"]);
        pcbpad("round", size_x-hole_size, hole_size, 0, "top", 0, [1, 1, 0], 
                [hole_size, "#fee5a6", hole_size+1], size_z, enablemask, [false, 20, 0, "default"]);
//        pillar("hex", hole_size-4, size_y-hole_size, 0, "bottom", 0, [4, 3, 16], 
//                [0, "#fee5a6"], size_z, enablemask, [false, 20, 0, "default"]);
//        pillar("hex", size_x-hole_size-4, size_y-hole_size, 0, "bottom", 0, [4, 3, 16], 
//                [0, "#fee5a6"], size_z, enablemask, [false, 20, 0, "default"]);
//        pillar("hex", hole_size-4, hole_size, 0, "bottom", 0, [4, 3, 16], 
//                [0, "#fee5a6"], size_z, enablemask, [false, 20, 0, "default"]);
//        pillar("hex", size_x-hole_size-4, hole_size, 0, "bottom", 0, [4, 3, 16], 
//                [0, "#fee5a6"], size_z, enablemask, [false, 20, 0, "default"]);
    }
}