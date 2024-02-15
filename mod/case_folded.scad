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


           NAME: case_folded
    DESCRIPTION: creates folded case flat blank for supported designs
           TODO: none

          USAGE: case_folded(case_design)

*/

module case_folded(case_design) {

    section_position = 2;
    ba = 1;
    slit_len = pcb_depth < pcb_width ? pcb_depth/10 : pcb_width/10;
    slit_width = .25;
    slit_offset = pcb_depth < pcb_width ? pcb_depth/10 : pcb_width/10;
    flap_y = 12;

    if(case_design == "paper_split-top") {
//        projection(cut = true) {
            // rear
            difference() {
                union() {
                    translate([0, -pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba, 0]) 
                        cube([pcb_width, pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba, .1]);
                    translate([0, -pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba-(pcb_depth/2), 0]) 
                        cube([pcb_width, pcb_depth/2, .1]);
                }
                // folding slits
                translate([slit_offset, -pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba, -adj]) 
                    cube([slit_len, slit_width, .2]);
                translate([pcb_width/2-slit_len/2, -pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba, -adj]) 
                    cube([slit_len, slit_width, .2]);
                translate([pcb_width-slit_offset-slit_len, -pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba, -adj]) 
                    cube([slit_len, slit_width, .2]);

                translate([0, -pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba, pcb_tmaxz+2]) rotate([180, 0, 0]) 
                    sbc(sbc_model, cooling, 0, "disable", "disable", true);

                translate([0, -pcb_bmaxz-case_offset_bz, section_position]) rotate([90, 0, 0]) 
                    sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
            }
            // left side
            difference() {
                union() {
                    translate([-pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba, 0, 0]) 
                        cube([pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba, pcb_depth, .1]);
                    translate([-pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba-flap_y, 0, 0]) 
                        cube([flap_y, pcb_depth, .1]);
                }
                // folding slits
                translate([-pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba, (pcb_depth/2)+4, -adj]) 
                    cube([slit_width, flap_y, .2]);

                translate([-pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba, (pcb_depth/2)-flap_y-4, -adj]) 
                    cube([slit_width, flap_y, .2]);

                translate([-pcb_bmaxz-case_offset_bz, 0, section_position]) rotate([0, -90, 0]) 
                    sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);

            }    
            // front
            difference() {
                union() {
                    translate([0, pcb_depth, 0]) cube([pcb_width, pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba, .1]);
                    translate([0, pcb_depth+pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba, 0]) cube([pcb_width, pcb_depth/2, .1]);
                }
                // folding slits
                translate([slit_offset, pcb_depth+pcb_tmaxz+case_offset_bz+pcb_z+pcb_bmaxz+ba, -adj]) 
                    cube([slit_len, slit_width, .2]);
                translate([pcb_width/2-slit_len/2, pcb_depth+pcb_tmaxz+case_offset_bz+pcb_z+pcb_bmaxz+ba, -adj]) 
                    cube([slit_len, slit_width, .2]);
                translate([pcb_width-slit_offset-slit_len, pcb_depth+pcb_tmaxz+case_offset_bz+pcb_z+pcb_bmaxz+ba, -adj]) 
                    cube([slit_len, slit_width, .2]);

                translate([0, 2*pcb_depth+pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba, pcb_tmaxz+2]) rotate([180, 0, 0]) 
                    sbc(sbc_model, cooling, 0, "disable", "disable", true);

                translate([0, pcb_depth+case_offset_bz+pcb_bmaxz, pcb_depth+section_position]) rotate([-90, 0, 0]) 
                    sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
            }
            // right side
            difference() {
                union() {
                    translate([pcb_width, 0, 0]) cube([pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba, pcb_depth, .1]);
                    translate([pcb_width+pcb_tmaxz+case_offset_bz+pcb_z+pcb_bmaxz+ba, 0, 0]) 
                        cube([flap_y, pcb_depth, .1]);
                }
                // folding slits
                translate([pcb_width+pcb_tmaxz+case_offset_bz+pcb_z+pcb_bmaxz+ba, (pcb_depth/2)+4, -adj]) 
                    cube([slit_width, flap_y, .2]);
                translate([pcb_width+pcb_tmaxz+case_offset_bz+pcb_z+pcb_bmaxz+ba, (pcb_depth/2)-flap_y-4, -adj]) 
                    cube([slit_width, flap_y, .2]);

                translate([pcb_width+pcb_bmaxz+case_offset_bz, 0, pcb_width+section_position]) rotate([0, 90, 0]) 
                    sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
            } 
            // pcb section
            difference() {
                cube([pcb_width, pcb_depth, .1]);
                translate([0, 0, 1]) sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
                // pcb folding slits rear
                translate([slit_offset, 0, -adj]) cube([slit_len, slit_width, .2]);
                translate([pcb_width/2-slit_len/2, 0, -adj]) cube([slit_len, slit_width, .2]);
                translate([pcb_width-slit_offset-slit_len, 0, -adj]) cube([slit_len, slit_width, .2]);

                // pcb folding slits left
                translate([0, slit_offset, -adj]) cube([slit_width, slit_len, .2]);
                translate([0, pcb_depth/2-slit_len/2, -adj]) cube([slit_width, slit_len, .2]);
                translate([0, pcb_depth-slit_offset-slit_len, -adj]) cube([slit_width, slit_len, .2]);

                // pcb folding slits front
                translate([slit_offset, pcb_depth-slit_width, -adj]) cube([slit_len, slit_width, .2]);
                translate([pcb_width/2-slit_len/2, pcb_depth-slit_width, -adj]) cube([slit_len, slit_width, .2]);
                translate([pcb_width-slit_offset-slit_len, pcb_depth-slit_width, -adj]) cube([slit_len, slit_width, .2]);

                // pcb folding slits right
                translate([pcb_width-slit_width, slit_offset, -adj]) cube([slit_width, slit_len, .2]);
                translate([pcb_width-slit_width, pcb_depth/2-slit_len/2, -adj]) cube([slit_width, slit_len, .2]);
                translate([pcb_width-slit_width, pcb_depth-slit_offset-slit_len, -adj]) cube([slit_width, slit_len, .2]);
            }
            // flaps rear left
            translate([(-pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba)/2, -pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba+4-(pcb_depth/2), 0]) 
                cube([(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba)/2, pcb_depth/4, .1]);

            // flaps rear right
            translate([pcb_width, -pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba-(pcb_depth/2)+4, 0]) 
                cube([(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba)/2, pcb_depth/4, .1]);

            // flaps front left
            translate([(-pcb_tmaxz-case_offset_bz-pcb_z-pcb_bmaxz-ba)/2, 
                pcb_depth+pcb_tmaxz+case_offset_bz+pcb_z+pcb_bmaxz+ba-4+pcb_depth/4, 0]) 
                cube([(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba)/2, pcb_depth/4, .1]);

            // flaps front right
            translate([pcb_width, pcb_depth+pcb_tmaxz+case_offset_bz+pcb_z+pcb_bmaxz+ba-4+pcb_depth/4, 0]) 
                cube([(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba)/2, pcb_depth/4, .1]);

            // flaps left rear
            difference() {
                translate([-(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba), 0, 0]) 
                    linear_extrude(.1) polygon([[0, 0], 
                        [1, (-pcb_depth/4)],
                        [(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba)-2, (-pcb_depth/4)],
                        [(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba), 0],
                        [0, 0]]);
                translate([-pcb_bmaxz-case_offset_bz, 0, section_position]) rotate([90, 0, 270]) 
                    sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
            }
            // flaps left front
            difference() {
                translate([-(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba), pcb_depth, 0]) 
                    linear_extrude(.1) polygon([[0, 0], 
                        [1, (pcb_depth/4)],
                        [(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba)-2, (pcb_depth/4)],
                        [(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba), 0],
                        [0, 0]]);
                    translate([-pcb_bmaxz-case_offset_bz, pcb_depth, pcb_depth+section_position]) rotate([-90, 0, 90]) 
                    sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
            }
            // flaps right rear
            difference() {
                translate([pcb_width, 0, 0]) 
                    linear_extrude(.1) polygon([[0, 0], 
                        [2, (-pcb_depth/4)],
                        [(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba)-1, (-pcb_depth/4)],
                        [(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba), 0],
                        [0, 0]]);
                translate([pcb_bmaxz+case_offset_bz+pcb_width, -pcb_width, section_position]) rotate([90, 0, 90]) 
                    sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
            }

            // flaps right front
            difference() {
            translate([pcb_width, pcb_depth, 0]) 
                linear_extrude(.1) polygon([[0, 0], 
                    [2, (pcb_depth/4)],
                    [(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba)-1, (pcb_depth/4)],
                    [(pcb_tmaxz+pcb_bmaxz+case_offset_bz+pcb_z+ba), 0],
                    [0, 0]]);
                translate([pcb_bmaxz+case_offset_bz+pcb_width, pcb_width+pcb_depth, section_position+pcb_depth])
                    rotate([270, 0, 270]) sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
            }
        }
//    }
}