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


           NAME: case_adapter
    DESCRIPTION: creates adapters for legacy cases footprints
           TODO: verify mini-stx and nano-itx hole locations

          USAGE: case_adapter(case_design)

*/

module case_adapter(case_design) {

mb_adapters=[
            ["adapter_atx", 304.8, 243.84, ["left_rear", 6.35, 33.02], ["middle_rear", 163.83, 10.16], ["right_rear", 288.29, 10.16], 
                                           ["left_middle", 6.35, 165.1], ["middle_middle", 163.83, 165.1], ["right_middle", 288.29, 165.1],
                                           ["left_front", 6.35, 237.49], ["middle_front", 163.83, 237.49], ["right_front", 288.29, 237.49]],
            ["adapter_micro-atx", 243.84, 243.84, ["left_rear", 6.35, 33.02], ["middle_rear", 163.83, 10.16], ["right_rear", 211.99, 10.16], 
                                                  ["left_middle", 6.35, 165.1], ["middle_middle", 163.83, 165.1], 
                                                  ["middle2_middle", 209.55, 165.1], ["right_middle", 229.87, 165.1],
                                                  ["left_front", 6.35, 237.49], ["right_front", 163.83, 237.49]], 
            ["adapter_dtx", 230.2, 243.84, ["left_rear", 6.35, 33.02], ["middle_rear", 163.83, 10.16], ["right_rear", 211.99, 10.16], 
                                           ["left_middle", 6.35, 165.1], ["middle_middle", 163.83, 165.1], ["right_middle", 209.55, 165.1],
                                           ["left_front", 6.35, 237.49], ["right_front", 163.83, 237.49]], 
            ["adapter_flex-atx", 228.6, 190.5, ["left_rear", 6.35, 33.02], ["middle_rear", 163.83, 10.16], ["right_rear", 211.99, 10.16], 
                                               ["left_front", 6.35, 165.1], ["middle_front", 163.83, 165.1], 
                                               ["right_front", 209.55, 165.1]],
            ["adapter_mini-dtx", 203.2, 170.18, ["left_rear", 6.35, 33.02], ["right_rear", 163.83, 10.16], 
                                                ["left_front", 6.35, 165.1], ["right_front", 163.83, 165.1]], 
            ["adapter_mini-itx", 170, 170, ["left_rear", 6.35, 33.02], ["right_rear", 163.83, 10.16], 
                                           ["left_front", 6.35, 165.1], ["right_front", 163.83, 165.1]],
                                           ];

    mb = search([case_design],mb_adapters);
    mba_x = mb_adapters[mb[0]][1];
    mba_y = mb_adapters[mb[0]][2];
    mba_z = floorthick;
    mba_offset_x = -6.35;
    mba_offset_y = 0;
    mba_radius = 5;
    mba_standoff = [6.75, floorthick, 4, 7, floorthick, "none", "round", "none", true, false, 0, 0];
    io_offset = 6.35;
    adj = .01;

    difference() {
        union() {
            difference() {
                translate([mba_offset_x,mba_offset_y,0]) slab([mba_x,mba_y,mba_z], mba_radius);
                translate([mba_offset_x+8,mba_offset_y+8,0]) vent_hex((mba_x-16)/6,(mba_y-16)/10,floorthick+4,10,1.5,"horizontal");
                // adapter standoff holes
                for (i=[2:len(mb_adapters[mb[0]])-3:len(mb_adapters[mb[0]])-3]) {
                    for (c=[1:1:len(mb_adapters[mb[0]])-3]) {
                        mbhole_pos = mb_adapters[mb[0]][i+c][0];
                        mbhole_x = mb_adapters[mb[0]][i+c][1]+mba_offset_x;
                        mbhole_y = mb_adapters[mb[0]][i+c][2]+mba_offset_y;
                        mbhole_z = -floorthick;
                        translate([mbhole_x,mbhole_y,-1]) cylinder(d=6.5, h=mba_z+2);
                    }
                }

                // pcb standoff holes
                if(sbc_bottom_standoffs == true) {
                    for (i=[1:11:len(sbc_data[s[0]])-2]) {
                        class = sbc_data[s[0]][i+1];
                        type = sbc_data[s[0]][i+2];
                        id = sbc_data[s[0]][i+3];
                        pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                        pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                        pcbhole_z = sbc_data[s[0]][i+6];
                        pcbhole_size = sbc_data[s[0]][i+9][0];
                        pcbhole_pos = sbc_data[s[0]][i+10][4];

                        if (class == "pcbhole" && id == pcb_id && pcbhole_pos == "left_rear" && 
                            bottom_rear_left_enable == true && bottom_standoff[5] != "blind") {
                                translate([pcbhole_x,pcbhole_y,-1]) cylinder(d=6.5, h=bottom_height);
                        }
                        if (class == "pcbhole" && id == pcb_id && pcbhole_pos == "left_front" && 
                            bottom_front_left_enable == true && bottom_standoff[5] != "blind") {
                                translate([pcbhole_x,pcbhole_y,-1]) cylinder(d=6.5, h=bottom_height);
                        }
                        if (class == "pcbhole" && id == pcb_id && pcbhole_pos == "right_rear" && 
                            bottom_rear_right_enable == true && bottom_standoff[5] != "blind") {
                                translate([pcbhole_x,pcbhole_y,-1]) cylinder(d=6.5, h=bottom_height);
                        }
                        if (class == "pcbhole" && id == pcb_id && pcbhole_pos == "right_front" && 
                            bottom_front_right_enable == true && bottom_standoff[5] != "blind") {
                                translate([pcbhole_x,pcbhole_y,-1]) cylinder(d=6.5, h=bottom_height);
                        }
                    }
                }
            }
            // adapter standoffs
            for (i=[2:len(mb_adapters[mb[0]])-3:len(mb_adapters[mb[0]])-3]) {
                for (c=[1:1:len(mb_adapters[mb[0]])-3]) {
                    mbhole_pos = mb_adapters[mb[0]][i+c][0];
                    mbhole_x = mb_adapters[mb[0]][i+c][1]+mba_offset_x;
                    mbhole_y = mb_adapters[mb[0]][i+c][2]+mba_offset_y;
                    mbhole_z = -floorthick;
                    translate([mbhole_x,mbhole_y,floorthick]) standoff(mba_standoff,[false,10,2,"default"]);
                }
            }
            // pcb standoffs
            if(sbc_bottom_standoffs  == true) {
                    for (i=[1:11:len(sbc_data[s[0]])-2]) {
                        class = sbc_data[s[0]][i+1];
                        type = sbc_data[s[0]][i+2];
                        id = sbc_data[s[0]][i+3];
                        pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                        pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                        pcbhole_z = sbc_data[s[0]][i+6];
                        pcbhole_size = sbc_data[s[0]][i+9][0];
                        pcbhole_pos = sbc_data[s[0]][i+10][4];

                    if(class == "pcbhole" && id == pcb_id && 
                        (pcbhole_pos == "left_rear" || pcbhole_pos == "left_front" || pcbhole_pos == "right_rear" || pcbhole_pos == "right_front")) {
                        if (pcbhole_pos == "left_rear" && bottom_rear_left_enable == true) {
                            bottom_support = bottom_sidewall_support == true ? bottom_rear_left_support : "none";
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_rear_left_adjust,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_support,
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10],
                                                bottom_standoff[11]];
                            translate([pcbhole_x,pcbhole_y,0]) standoff(normal_standoff,[false,10,2,"default"]);
                        }
                        if (pcbhole_pos == "left_front" && bottom_front_left_enable == true) {
                            bottom_support = bottom_sidewall_support == true ? bottom_front_left_support : "none";
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_front_left_adjust,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_support,
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10],
                                                bottom_standoff[11]];
                            translate([pcbhole_x,pcbhole_y,0]) standoff(normal_standoff,[false,10,2,"default"]);
                        }
                        if (pcbhole_pos == "right_rear" && bottom_rear_right_enable == true) {
                            bottom_support = bottom_sidewall_support == true ? bottom_rear_right_support : "none";
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_rear_right_adjust,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_support,
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10],
                                                bottom_standoff[11]];
                            translate([pcbhole_x,pcbhole_y,0]) standoff(normal_standoff,[false,10,2,"default"]);
                        }
                        if (pcbhole_pos == "right_front" && bottom_front_right_enable == true) {
                            bottom_support = bottom_sidewall_support == true ? bottom_front_right_support : "none";
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_front_right_adjust,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_support,
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10],
                                                bottom_standoff[11]];
                            translate([pcbhole_x,pcbhole_y,0]) standoff(normal_standoff,[false,10,2,"default"]);
                        }
                    }
                }
            }
        }
    translate([mba_offset_x-10, -10, -1]) cube([mba_x+20, 10, floorthick+10]);
//    translate([mba_offset_x-10, mba_y, -1]) cube([mba_x+20, 10, floorthick+4]);
//    translate([mba_offset_x-10, -10, -1]) cube([10, mba_y+20, floorthick+4]);
//    translate([mba_x+mba_offset_x, -10, -1]) cube([10, mba_y+20, floorthick+4]);
    }
}


/*
           NAME: io_panel
    DESCRIPTION: creates rear io panel for legacy cases
           TODO: none

          USAGE: io_panel()

*/
module io_panel() {

    io_window_x = 158.75;
    io_window_y = 4;
    io_window_z = 44;
    io_offset = 6.35;

    difference() {
        union() {
            translate([-1,io_window_y-1,-1]) cube([io_window_x+2,1,io_window_z+2]);
            translate([0,0,0]) cube([io_window_x,4,io_window_z]);
        }
        translate([2,-2,2]) cube([io_window_x-4,5,io_window_z-4]);
        translate([8.79 ,6,bottom_height-pcb_z+pcb_loc_z+2]) 
            sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
    }
}

