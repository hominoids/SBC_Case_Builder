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
    DESCRIPTION: creates folded case flat blanks for supported designs
           TODO: none

          USAGE: case_folded(case_design)

                             case_design = paper_full-top, paper_split-top
*/

module case_folded(case_design) {

section_position = 2;
ba = bend_allowance;
slit_len = pcb_depth < pcb_width ? pcb_depth/10 : pcb_width/10;
slit_width = material_thickness;
slit_offset = pcb_depth < pcb_width ? pcb_depth/10 : pcb_width/10;
fold_height = pcb_tmaxz+bottom_clearence+pcb_z+ba;
flap_y = 12;
tab_x = pcb_depth/4;
tab_y = fold_height/2;
tab_inset = 6;

    if(case_design == "paper_split-top") {
        // rear
        difference() {
            union() {
                folded_base(fold_height, ba, flap_y, tab_x, tab_y, tab_inset, slit_len, slit_width, slit_offset);
                translate([0, -fold_height-(pcb_depth/2)-ba, 0]) 
                    cube([pcb_width, (pcb_depth/2)+ba, material_thickness]);
                translate([0, pcb_depth+fold_height, 0]) 
                    cube([pcb_width, (pcb_depth/2)+ba, material_thickness]);

                // flaps rear left
                translate([-tab_y, -fold_height+tab_inset-(pcb_depth/2), 0]) 
                    slab_r([tab_y, tab_x, material_thickness], [tab_x/2,tab_x/2,.1,.1]);

                // flaps rear right
                translate([pcb_width, -fold_height-(pcb_depth/2)+tab_inset, 0]) 
                    slab_r([tab_y, tab_x, material_thickness], [.1,.1,tab_x/2,tab_x/2]);

                // flaps front left
                translate([-tab_y, pcb_depth+fold_height-tab_inset+tab_x, 0]) 
                    slab_r([tab_y, tab_x, material_thickness], [tab_x/2,tab_x/2,.1,.1]);

                // flaps front right
                translate([pcb_width, pcb_depth+fold_height-tab_inset+tab_x, 0]) 
                    slab_r([tab_y, tab_x, material_thickness], [.1,.1,tab_x/2,tab_x/2]);

                // flaps left rear
                difference() {
                    translate([-(fold_height), 0, 0]) 
                        linear_extrude(material_thickness) polygon([[0, 0], 
                            [1, (-pcb_depth/4)],
                            [(fold_height)-2, (-pcb_depth/4)],
                            [(fold_height), 0],
                            [0, 0]]);
                    translate([-bottom_clearence, 0, section_position]) rotate([90, 0, 270]) 
                        sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
                }
                // flaps left front
                difference() {
                    translate([-(fold_height), pcb_depth, 0]) 
                        linear_extrude(material_thickness) polygon([[0, 0], 
                            [1, (pcb_depth/4)],
                            [(fold_height)-2, (pcb_depth/4)],
                            [(fold_height), 0],
                            [0, 0]]);
                        translate([-bottom_clearence, pcb_depth, pcb_depth+section_position]) rotate([-90, 0, 90]) 
                        sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
                }
                // flaps right rear
                difference() {
                    translate([pcb_width, 0, 0]) 
                        linear_extrude(material_thickness) polygon([[0, 0], 
                            [2, (-pcb_depth/4)],
                            [(fold_height)-1, (-pcb_depth/4)],
                            [(fold_height), 0],
                            [0, 0]]);
                    translate([bottom_clearence+pcb_width, -pcb_width, section_position]) rotate([90, 0, 90]) 
                        sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
                }

                // flaps right front
                difference() {
                translate([pcb_width, pcb_depth, 0]) 
                    linear_extrude(material_thickness) polygon([[0, 0], 
                        [2, (pcb_depth/4)],
                        [(fold_height)-1, (pcb_depth/4)],
                        [(fold_height), 0],
                        [0, 0]]);
                    translate([bottom_clearence+pcb_width, pcb_width+pcb_depth, section_position+pcb_depth])
                        rotate([270, 0, 270]) sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
                }
            }

            translate([0, -fold_height, pcb_tmaxz+2+material_thickness]) rotate([180, 0, 0]) 
                sbc(sbc_model, cooling, 0, "disable", "disable", true);
            translate([0, 2*pcb_depth+fold_height, pcb_tmaxz+2+material_thickness]) rotate([180, 0, 0]) 
                sbc(sbc_model, cooling, 0, "disable", "disable", true);
        }
        translate([0, -fold_height-(pcb_depth/2)-ba, 0]) cube([pcb_width, 2, material_thickness]);
        translate([0, pcb_depth+fold_height+(pcb_depth/2)-ba, 0]) cube([pcb_width, 2, material_thickness]);
    }

    if(case_design == "paper_full-top") {
        // rear
        difference() {
            union() {
                folded_base(fold_height, ba, flap_y, tab_x, tab_y, tab_inset, slit_len, slit_width, slit_offset);
                translate([0, -fold_height-pcb_depth-ba, 0]) 
                    cube([pcb_width, pcb_depth+ba, material_thickness]);
                translate([0, pcb_depth+fold_height, 0]) 
                    cube([pcb_width, (pcb_depth/4)+ba, material_thickness]);

                // flaps rear left
                translate([tab_inset, -fold_height-pcb_depth-tab_y, 0]) 
                    slab_r([tab_x, tab_y, material_thickness], [tab_x/2,.1,.1,tab_x/2]);

                // flaps rear right
                translate([pcb_width-tab_x-tab_inset, -fold_height-pcb_depth-tab_y, 0]) 
                    slab_r([tab_x, tab_y, material_thickness], [tab_x/2,.1,.1,tab_x/2]);

                // flaps left rear
                difference() {
                    translate([-(fold_height), 0, 0]) 
                        linear_extrude(material_thickness) polygon([[0, 0], 
                            [1, (-pcb_depth/4)],
                            [(fold_height)-2, (-pcb_depth/4)],
                            [(fold_height), 0],
                            [0, 0]]);
                    translate([-bottom_clearence, 0, section_position]) rotate([90, 0, 270]) 
                        sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
                }
                // flaps left front
                difference() {
                    translate([-(fold_height), pcb_depth, 0]) 
                        linear_extrude(material_thickness) polygon([[0, 0], 
                            [1, (pcb_depth/4)],
                            [(fold_height)-2, (pcb_depth/4)],
                            [(fold_height), 0],
                            [0, 0]]);
                        translate([-bottom_clearence, pcb_depth, pcb_depth+section_position]) rotate([-90, 0, 90]) 
                        sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
                }
                // flaps right rear
                difference() {
                    translate([pcb_width, 0, 0]) 
                        linear_extrude(material_thickness) polygon([[0, 0], 
                            [2, (-pcb_depth/4)],
                            [(fold_height)-1, (-pcb_depth/4)],
                            [(fold_height), 0],
                            [0, 0]]);
                    translate([bottom_clearence+pcb_width, -pcb_width, section_position]) rotate([90, 0, 90]) 
                        sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
                }

                // flaps right front
                difference() {
                translate([pcb_width, pcb_depth, 0]) 
                    linear_extrude(material_thickness) polygon([[0, 0], 
                        [2, (pcb_depth/4)],
                        [(fold_height)-1, (pcb_depth/4)],
                        [(fold_height), 0],
                        [0, 0]]);
                    translate([bottom_clearence+pcb_width, pcb_width+pcb_depth, section_position+pcb_depth])
                        rotate([270, 0, 270]) sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
                }
            }
            // top closure tab slits
            translate([tab_inset, pcb_depth+fold_height, 0]) cube([tab_x, slit_width, material_thickness+(2*adj)]);
            translate([pcb_width-tab_x-tab_inset, pcb_depth+fold_height, 0]) 
                cube([tab_x, slit_width, material_thickness+2*adj]);

            translate([0, -fold_height, pcb_tmaxz+2+material_thickness]) rotate([180, 0, 0]) 
                sbc(sbc_model, cooling, 0, "disable", "disable", true);
            translate([0, 2*pcb_depth+fold_height, pcb_tmaxz+2+material_thickness]) rotate([180, 0, 0]) 
                sbc(sbc_model, cooling, 0, "disable", "disable", true);
        }
    }
}


// base folding case
module folded_base(fold_height, ba, flap_y, tab_x, tab_y, tab_inset, slit_len, slit_width, slit_offset) {

section_position = 2;

    // rear
    difference() {
        translate([0, -fold_height, 0]) cube([pcb_width, fold_height, material_thickness]);
        // folding slits
        translate([slit_offset, -fold_height, -adj]) 
            cube([slit_len, slit_width, material_thickness+(2*adj)]);
        translate([pcb_width/2-slit_len/2, -fold_height, -adj]) 
            cube([slit_len, slit_width, material_thickness+(2*adj)]);
        translate([pcb_width-slit_offset-slit_len, -fold_height, -adj]) 
            cube([slit_len, slit_width, material_thickness+(2*adj)]);

        translate([0, -bottom_clearence, section_position]) rotate([90, 0, 0]) 
            sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
    }
    // left side
    difference() {
        union() {
            translate([-fold_height, 0, 0]) 
                cube([fold_height, pcb_depth, material_thickness]);
            translate([-fold_height-flap_y, 0, 0]) cube([flap_y, pcb_depth, material_thickness]);
        }
        // folding slits
        translate([-fold_height, (pcb_depth/2)+tab_inset, -adj]) 
            cube([slit_width, tab_x, material_thickness+(2*adj)]);

        translate([-fold_height, (pcb_depth/2)-tab_x-tab_inset, -adj]) 
            cube([slit_width, tab_x, material_thickness+(2*adj)]);

        translate([-bottom_clearence, 0, section_position]) rotate([0, -90, 0]) 
            sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);

    }    
    // front
    difference() {
        translate([0, pcb_depth, 0]) cube([pcb_width, fold_height, material_thickness]);
        // folding slits
        translate([slit_offset, pcb_depth+fold_height-slit_width, -adj]) 
            cube([slit_len, slit_width, material_thickness+(2*adj)]);
        translate([pcb_width/2-slit_len/2, pcb_depth+fold_height-slit_width, -adj]) 
            cube([slit_len, slit_width, material_thickness+(2*adj)]);
        translate([pcb_width-slit_offset-slit_len, pcb_depth+fold_height-slit_width, -adj]) 
            cube([slit_len, slit_width, material_thickness+(2*adj)]);

        translate([0, pcb_depth+bottom_clearence, pcb_depth+section_position]) rotate([-90, 0, 0]) 
            sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
    }
    // right side
    difference() {
        union() {
            translate([pcb_width, 0, 0]) cube([fold_height, pcb_depth, material_thickness]);
            translate([pcb_width+fold_height, 0, 0]) 
                cube([flap_y, pcb_depth, material_thickness]);
        }
        // folding slits
        translate([pcb_width+fold_height, (pcb_depth/2)+tab_inset, -adj]) 
            cube([slit_width, tab_x, material_thickness+(2*adj)]);
        translate([pcb_width+fold_height, (pcb_depth/2)-tab_x-tab_inset, -adj]) 
            cube([slit_width, tab_x, material_thickness+(2*adj)]);

        translate([pcb_width+bottom_clearence, 0, pcb_width+section_position]) rotate([0, 90, 0]) 
            sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
    }
    // pcb section
    difference() {
        cube([pcb_width, pcb_depth, material_thickness]);
        translate([0, 0, 1+material_thickness]) sbc(sbc_model, "disable", 0, gpio_opening, uart_opening, true);
        // pcb folding slits rear
        translate([slit_offset, 0, -adj]) cube([slit_len, slit_width, material_thickness+(2*adj)]);
        translate([pcb_width/2-slit_len/2, 0, -adj]) cube([slit_len, slit_width, material_thickness+(2*adj)]);
        translate([pcb_width-slit_offset-slit_len, 0, -adj]) cube([slit_len, slit_width, material_thickness+(2*adj)]);

        // pcb folding slits left
        translate([0, slit_offset, -adj]) cube([slit_width, slit_len, material_thickness+(2*adj)]);
        translate([0, pcb_depth/2-slit_len/2, -adj]) cube([slit_width, slit_len, material_thickness+(2*adj)]);
        translate([0, pcb_depth-slit_offset-slit_len, -adj]) cube([slit_width, slit_len, material_thickness+(2*adj)]);

        // pcb folding slits front
        translate([slit_offset, pcb_depth-slit_width, -adj]) cube([slit_len, slit_width, material_thickness+(2*adj)]);
        translate([pcb_width/2-slit_len/2, pcb_depth-slit_width, -adj]) cube([slit_len, slit_width, material_thickness+(2*adj)]);
        translate([pcb_width-slit_offset-slit_len, pcb_depth-slit_width, -adj]) cube([slit_len, slit_width, material_thickness+(2*adj)]);

        // pcb folding slits right
        translate([pcb_width-slit_width, slit_offset, -adj]) cube([slit_width, slit_len, material_thickness+(2*adj)]);
        translate([pcb_width-slit_width, pcb_depth/2-slit_len/2, -adj]) cube([slit_width, slit_len, material_thickness+(2*adj)]);
        translate([pcb_width-slit_width, pcb_depth-slit_offset-slit_len, -adj]) cube([slit_width, slit_len, material_thickness+(2*adj)]);
    }
}