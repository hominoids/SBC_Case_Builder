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


           NAME: case_rack
    DESCRIPTION: creates a U1-U4 rack case
           TODO: none

          USAGE: case_rack(case_design,side)

*/

module case_rack(case_design,side) {

rack_asm_gap = .25;
rack_asm_size = 5;
rack_asm_hole = 2.25;

if(side == "bottom") {
    difference() {
        union() {
            difference() {
                union() {
                    if(case_design == "rack") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(case_z-floorthick)/2]) 
                                cube_fillet_inside([width,depth,case_z-floorthick], 
                                    vertical=[corner_fillet,corner_fillet,0,0], 
                                        top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,floorthick+(floorthick+case_z)/2]) 
                                cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),case_z+floorthick], 
                                        vertical=[corner_fillet-wallthick,corner_fillet-wallthick,-wallthick,-wallthick],
                                            top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                        }
                        // rack ears
                        translate([-gap-wallthick, -gap+(sidethick-wallthick), 0]) 
                            rack_end_bracket("left", rack_u_size, sidethick);
                        translate([width-wallthick-gap, -gap+(sidethick-wallthick), 0]) 
                            rack_end_bracket("right", rack_u_size, sidethick);

                        // case upper panel clamp
                        translate([150-gap-wallthick,-gap-adj-.5,case_z-13]) 
                            panel_clamp("rear", "m2", "sloped", 6, 18, 5, [false,10,2,"default"]);
                        translate([300-gap-wallthick,-gap-adj-.5,case_z-13]) 
                            panel_clamp("rear", "m2", "sloped", 6, 18, 5, [false,10,2,"default"]);
                        translate([150-gap-wallthick,depth-gap-(2*wallthick)+adj+.5,
                            case_z-13]) panel_clamp("front", "m2", "sloped", 6, 18, 5, [false,10,2,"default"]);
                        translate([300-gap-wallthick,depth-gap-(2*wallthick)+adj+.5,
                            case_z-13]) panel_clamp("front", "m2", "sloped", 6, 18, 5, [false,10,2,"default"]);

                        // case lower assembly blocks
                        // rear left - left side
                        translate([150-gap-wallthick-rack_asm_size,-gap-adj,floorthick-adj]) 
                            cube([rack_asm_size,rack_asm_size,rack_asm_size]);
                        // rear right - left side
                        translate([300-gap-wallthick-rack_asm_size,-gap-adj,floorthick-adj]) 
                            cube([rack_asm_size,rack_asm_size,rack_asm_size]);
                        // rear left - right side
                        translate([150-gap-wallthick+rack_asm_gap,-gap-adj,floorthick-adj]) 
                            cube([rack_asm_size,rack_asm_size,rack_asm_size]);
                        // rear right - right
                        translate([300-gap-wallthick+rack_asm_gap,-gap-adj,floorthick-adj]) 
                            cube([rack_asm_size,rack_asm_size,rack_asm_size]);

                        // front left - left
                        translate([150-gap-wallthick-rack_asm_size,depth-gap-(2*wallthick)-rack_asm_size+adj,
                            floorthick-adj]) cube([rack_asm_size,rack_asm_size,rack_asm_size]);
                        // front right - left
                        translate([300-gap-wallthick-rack_asm_size,depth-gap-(2*wallthick)-rack_asm_size+adj,
                            floorthick-adj]) cube([rack_asm_size,rack_asm_size,rack_asm_size]);
                        // front left - right
                        translate([150-gap-wallthick+rack_asm_gap,
                            depth-gap-(2*wallthick)-rack_asm_size+adj,floorthick-adj]) 
                                cube([rack_asm_size,rack_asm_size,rack_asm_size]);
                        // front right - right
                        translate([300-gap-wallthick+rack_asm_gap,
                            depth-gap-(2*wallthick)-rack_asm_size+adj,floorthick-adj]) 
                                cube([rack_asm_size,rack_asm_size,rack_asm_size]);
                    }

                    // additive accessories
                    if(accessory_name != "none") {
                        for (i=[1:11:len(accessory_data[a[0]])-1]) {
                            class = accessory_data[a[0]][i];
                            type = accessory_data[a[0]][i+1];
                            loc_x = accessory_data[a[0]][i+2];
                            loc_y = accessory_data[a[0]][i+3];
                            loc_z = accessory_data[a[0]][i+4];
                            face = accessory_data[a[0]][i+5];
                            rotation = accessory_data[a[0]][i+6];
                            parametric = accessory_data[a[0]][i+7];
                            size = accessory_data[a[0]][i+8];
                            data = accessory_data[a[0]][i+9];
                            mask = accessory_data[a[0]][i+10];

                            if(class == "add1" && face == "bottom") {
                                parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric, size, data, [false,mask[1],mask[2],mask[3]]);
                            }
                        }
                    }
                }
                // case lower block assembly holes
                // rear left
                translate([150-gap-wallthick-rack_asm_size-adj,-gap-adj+(rack_asm_size/2),
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=rack_asm_hole, h=rack_asm_gap+(2*rack_asm_size)+(2*adj));
                // rear left nut
                translate([150-gap-wallthick-rack_asm_size-adj,-gap-adj+(rack_asm_size/2),
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=4*2/sqrt(3), h=2, $fn=6);
                // rear left recess
                translate([150-gap-wallthick+rack_asm_size+adj+rack_asm_gap-2,-gap-adj+(rack_asm_size/2),
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=4*2/sqrt(3), h=2);
                // rear right
                translate([300-gap-wallthick-rack_asm_size-adj,-gap-adj+(rack_asm_size/2),
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=rack_asm_hole, h=rack_asm_gap+(2*rack_asm_size)+(2*adj));
                // rear right nut
                translate([300-gap-wallthick-rack_asm_size-adj,-gap-adj+(rack_asm_size/2),
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=4*2/sqrt(3), h=2, $fn=6);
                // rear right recess
                translate([300-gap-wallthick+rack_asm_size+adj+rack_asm_gap-2,-gap-adj+(rack_asm_size/2),
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=4*2/sqrt(3), h=2);
                // front left
                translate([150-gap-wallthick-rack_asm_size-adj,depth-gap-(2*wallthick)-(rack_asm_size/2)+adj,
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=rack_asm_hole, h=rack_asm_gap+(2*rack_asm_size)+(2*adj));
                // front left nut
                translate([150-gap-wallthick-rack_asm_size-adj,depth-gap-(2*wallthick)-(rack_asm_size/2)+adj,
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=4*2/sqrt(3), h=2, $fn=6);
                // front left recess
                translate([150-gap-wallthick+rack_asm_size+adj+rack_asm_gap-2,depth-gap-(2*wallthick)-(rack_asm_size/2)+adj,
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=4*2/sqrt(3), h=2);
                // front right
                translate([300-gap-wallthick-rack_asm_size-adj,depth-gap-(2*wallthick)+adj-(rack_asm_size/2),
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=rack_asm_hole, h=rack_asm_gap+(2*rack_asm_size)+(2*adj));
                // front right nut
                translate([300-gap-wallthick-rack_asm_size-adj,depth-gap-(2*wallthick)-(rack_asm_size/2)+adj,
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=4*2/sqrt(3), h=2, $fn=6);
                // front right recess
                translate([300-gap-wallthick+rack_asm_size+adj+rack_asm_gap-2,depth-gap-(2*wallthick)-(rack_asm_size/2)+adj,
                    floorthick-adj+(rack_asm_size/2)]) rotate([0,90,0]) 
                        cylinder(d=4*2/sqrt(3), h=2);

                for(r = [0:len(rack_bay_sbc)-1]) {
                    s = search([rack_bay_sbc[r]],sbc_data);
                    pcb_id = sbc_data[s[0]][4];
                    pcb_width = sbc_data[s[0]][10][0];
                    pcb_depth = sbc_data[s[0]][10][1];
                    pcb_z_orig = sbc_data[s[0]][10][2];
                    pcb_tmaxz = sbc_data[s[0]][11][5];
                    pcb_bmaxz = sbc_data[s[0]][11][6];
                    pcb_color = sbc_data[s[0]][11][1];
                    pcb_radius = sbc_data[s[0]][11][0];

                    pcb_loc_x = rack_bay_rotation[r] == 90 ? rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_rotation[r] == 180 ? rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_xyz_loc[r][0];
                    pcb_loc_y = rack_bay_rotation[r] == 270 ? rack_bay_xyz_loc[r][1]+pcb_width : rack_bay_rotation[r] == 180 ? rack_bay_xyz_loc[r][1]+pcb_depth : rack_bay_xyz_loc[r][1];
                    pcb_loc_z = rack_bay_xyz_loc[r][2];
                    translate([pcb_loc_x,pcb_loc_y,pcb_loc_z]) rotate([0,0,rack_bay_rotation[r]]) union() {
                    // pcb standoff holes
                    if(sbc_bottom_standoffs == true && rack_bay_sbc[r] != "empty") {
                        for (i=[1:11:len(sbc_data[s[0]])-2]) {
                            class = sbc_data[s[0]][i+1];
                            type = sbc_data[s[0]][i+2];
                            id = sbc_data[s[0]][i+3];
                            pcbhole_x = sbc_data[s[0]][i+4];
                            pcbhole_y = sbc_data[s[0]][i+5];
                            pcbhole_z = sbc_data[s[0]][i+6];
                            pcbhole_size = sbc_data[s[0]][i+9][0];
                            pcbhole_pos = sbc_data[s[0]][i+10][4];

                            if (class == "pcbhole" && id == 0 && pcbhole_pos == "left_rear" && 
                                bottom_rear_left_enable == true && bottom_standoff[6] != "blind") {
                                    translate([pcbhole_x,pcbhole_y,-adj]) 
                                        cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                            }
                            if (class == "pcbhole" && id == 0 && pcbhole_pos == "left_front" && 
                                bottom_front_left_enable == true && bottom_standoff[6] != "blind") {
                                    translate([pcbhole_x,pcbhole_y,-adj]) 
                                        cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                            }
                            if (class == "pcbhole" && id == 0 && pcbhole_pos == "right_rear" && 
                                bottom_rear_right_enable == true && bottom_standoff[6] != "blind") {
                                    translate([pcbhole_x,pcbhole_y,-adj]) 
                                        cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                            }
                            if (class == "pcbhole" && id == 0 && pcbhole_pos == "right_front" && 
                                bottom_front_right_enable == true && bottom_standoff[6] != "blind") {
                                    translate([pcbhole_x,pcbhole_y,-adj]) 
                                        cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                            }

                        }
                    }
                    // multi-pcb standoff holes
                    if(multipcb_bottom_standoffs == true && rack_bay_sbc[r] != "empty") {
                        for (i=[1:11:len(sbc_data[s[0]])-2]) {
                            class = sbc_data[s[0]][i+1];
                            type = sbc_data[s[0]][i+2];
                            pcbid = sbc_data[s[0]][i+3];
                            pcbloc_x = sbc_data[s[0]][i+4];
                            pcbloc_y = sbc_data[s[0]][i+5];
                            pcbloc_z = sbc_data[s[0]][i+6];
                            if(class == "pcb") {
                                for (i=[1:11:len(sbc_data[s[0]])-2]) {
                                    pcbclass = sbc_data[s[0]][i+1];
                                    pcbtype = sbc_data[s[0]][i+2];
                                    id = sbc_data[s[0]][i+3];
                                    pcbhole_x = sbc_data[s[0]][i+4]+pcbloc_x;
                                    pcbhole_y = sbc_data[s[0]][i+5]+pcbloc_y;
                                    pcbhole_z = sbc_data[s[0]][i+6];
                                    pcbhole_size = sbc_data[s[0]][i+9][0];
                                    pcbhole_state = sbc_data[s[0]][i+10][0];
                                    pcbhole_pos = sbc_data[s[0]][i+10][4];
                                    if(id == pcbid && id != 0 && pcbclass == "pcbhole") {
                                        if (pcbclass == "pcbhole" && pcbhole_pos == "left_rear" && 
                                            multipcb_bottom_rear_left_enable == true && 
                                                (pcbhole_state == "bottom" || pcbhole_state == "both")) {
                                            translate([pcbhole_x,pcbhole_y,-adj]) 
                                                cylinder(d=multipcb_bottom_standoff[4]-.2, h=floorthick+(2*adj));
                                        }
                                        if (pcbclass == "pcbhole" && pcbhole_pos == "left_front" && 
                                            multipcb_bottom_front_left_enable == true && 
                                                (pcbhole_state == "bottom" || pcbhole_state == "both")) {
                                            translate([pcbhole_x,pcbhole_y,-adj]) 
                                                cylinder(d=multipcb_bottom_standoff[4]-.2, h=floorthick+(2*adj));
                                        }
                                        if (pcbclass == "pcbhole" && pcbhole_pos == "right_rear" && 
                                            multipcb_bottom_rear_right_enable == true && 
                                                (pcbhole_state == "bottom" || pcbhole_state == "both")) {
                                            translate([pcbhole_x,pcbhole_y,-adj]) 
                                                cylinder(d=multipcb_bottom_standoff[4]-.2, h=floorthick+(2*adj));
                                        }
                                        if (pcbclass == "pcbhole" && pcbhole_pos == "right_front" && 
                                            multipcb_bottom_front_right_enable == true && 
                                                (pcbhole_state == "bottom" || pcbhole_state == "both")) {
                                            translate([pcbhole_x,pcbhole_y,-adj]) 
                                                cylinder(d=multipcb_bottom_standoff[4]-.2, h=floorthick+(2*adj));
                                        }
                                    }
                                }
                            }
                        }
                    }
                } }
                // extended standoff holes
                if(ext_bottom_standoffs == true) {
                    // right-rear standoff
                    if(((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_bottom_standoff_support_size 
                        || pcb_loc_y >= ext_bottom_standoff_support_size)) && 
                            ext_bottom_rear_right_enable == true && ext_bottom_standoff[6] != "blind") {
                        translate([width-ext_bottom_standoff_support_size/4-(2*(wallthick+gap)),
                            ext_bottom_standoff_support_size/4,-adj]) 
                                cylinder(d=ext_bottom_standoff[4]-.2, h=floorthick+(2+adj));
                    }
                    // right-front standoff
                    if(((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_bottom_standoff_support_size && 
                        depth-pcb_loc_y-pcb_depth >= ext_bottom_standoff_support_size) || 
                            (width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_bottom_standoff_support_size && 
                                depth-pcb_loc_y-pcb_depth <= ext_bottom_standoff_support_size) ||
                                    (width-pcb_loc_x-pcb_width-(gap+2*wallthick) <= ext_bottom_standoff_support_size && 
                                        depth-pcb_loc_y-pcb_depth >= ext_bottom_standoff_support_size)) &&
                                            ext_bottom_front_right_enable == true && ext_bottom_standoff[6] != "blind") {
                        translate([width-ext_bottom_standoff_support_size/4-(2*(wallthick+gap)),
                            depth-ext_bottom_standoff_support_size/4-(2*(wallthick+gap)),-adj]) 
                                cylinder(d=ext_bottom_standoff[4]-.2, h=floorthick+(2*adj));
                    }
                    // left-rear standoff
                    if((pcb_loc_x >= ext_bottom_standoff_support_size || pcb_loc_y >= ext_bottom_standoff_support_size) &&
                        ext_bottom_rear_left_enable == true && ext_bottom_standoff[6] != "blind") {
                        translate([ext_bottom_standoff_support_size/4,
                            ext_bottom_standoff_support_size/4,-adj]) 
                                cylinder(d=ext_bottom_standoff[4]-.2, h=floorthick+(2*adj));
                    }
                    // left-front standoff
                    if(((pcb_loc_x >= ext_bottom_standoff_support_size && 
                        (depth-(pcb_loc_y+pcb_depth)) >= ext_bottom_standoff_support_size) || 
                            (pcb_loc_x <= ext_bottom_standoff_support_size && 
                                (depth-(pcb_loc_y+pcb_depth)) >= ext_bottom_standoff_support_size) || 
                                    (pcb_loc_x >= ext_bottom_standoff_support_size && 
                                        (depth-(pcb_loc_y+pcb_depth)) <= ext_bottom_standoff_support_size)) &&
                                            ext_bottom_front_left_enable == true && ext_bottom_standoff[6] != "blind") {
                        translate([ext_bottom_standoff_support_size/4,
                            depth-(ext_bottom_standoff_support_size/4)-(2*(wallthick+gap)),-adj]) 
                                cylinder(d=ext_bottom_standoff[4]-.2, h=floorthick+(2*adj));
                    }
                }
                // bottom cover pattern
                if(bottom_cover_pattern != "solid") {
                    if(bottom_cover_pattern == "hex_5mm") {
                        translate([1,0,-floorthick+adj]) vent_hex(width/3.75,depth/6,floorthick+4,5,1.5,"horizontal");
                    }
                    if(bottom_cover_pattern == "hex_8mm") {
                        translate([1,2,-floorthick+adj]) vent_hex(width/5.5,depth/9.5,floorthick+4,8,1.5,"horizontal");
                    }
                    if(bottom_cover_pattern == "linear_vertical") {
                        translate([0,-gap,-floorthick+adj])
                            vent(wallthick,depth-2*wallthick-gap,floorthick+4,1,1,(width-2*wallthick-gap)/4,"horizontal");
                    }
                    if(bottom_cover_pattern == "linear_horizontal") {
                        translate([-gap,-gap,-floorthick+adj]) 
                            vent(width-2*(wallthick+gap),wallthick,floorthick+4,1,(depth-2*wallthick-gap)/3,1,"horizontal");
                    }
                    if(bottom_cover_pattern == "astroid") {
                        for(c=[3:12:depth-8]) {
                            for(r=[4:12:width-8]) {
                                translate([r,c,-(2*floorthick)]) linear_extrude(floorthick+5) import("./dxf/astroid_8mm.dxf");
                            }
                        }
                    }
                }
            }
            for(r = [0:len(rack_bay_sbc)-1]) {
                s = search([rack_bay_sbc[r]],sbc_data);
                pcb_id = sbc_data[s[0]][4];
                pcb_width = sbc_data[s[0]][10][0];
                pcb_depth = sbc_data[s[0]][10][1];
                pcb_z_orig = sbc_data[s[0]][10][2];
                pcb_tmaxz = sbc_data[s[0]][11][5];
                pcb_bmaxz = sbc_data[s[0]][11][6];
                pcb_color = sbc_data[s[0]][11][1];
                pcb_radius = sbc_data[s[0]][11][0];

                pcb_loc_x = rack_bay_rotation[r] == 90 ? rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_rotation[r] == 180 ? rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_xyz_loc[r][0];
                pcb_loc_y = rack_bay_rotation[r] == 270 ? rack_bay_xyz_loc[r][1]+pcb_width : rack_bay_rotation[r] == 180 ? rack_bay_xyz_loc[r][1]+pcb_depth : rack_bay_xyz_loc[r][1];
                pcb_loc_z = rack_bay_xyz_loc[r][2];
                translate([pcb_loc_x,pcb_loc_y,pcb_loc_z]) rotate([0,0,rack_bay_rotation[r]]) union() {
                // primary pcb standoffs
                if(sbc_bottom_standoffs  == true && rack_bay_sbc[r] != "empty") {
                        for (i=[1:11:len(sbc_data[s[0]])-2]) {
                            class = sbc_data[s[0]][i+1];
                            type = sbc_data[s[0]][i+2];
                            id = sbc_data[s[0]][i+3];
                            pcbhole_x = sbc_data[s[0]][i+4];
                            pcbhole_y = sbc_data[s[0]][i+5];
                            pcbhole_z = sbc_data[s[0]][i+6];
                            pcbhole_size = sbc_data[s[0]][i+9][0];
                            pcbhole_pos = sbc_data[s[0]][i+10][4];

                        if(class == "pcbhole" && id == pcb_id) {
                            if (pcbhole_pos == "left_rear" && bottom_rear_left_enable == true) {
                                bottom_support = bottom_sidewall_support == true ? bottom_rear_left_support : "none";
                                pcb_standoff = [bottom_standoff[0],
                                                    bottom_standoff[1],
                                                    bottom_height-pcb_z+pcb_loc_z+bottom_rear_left_adjust,
                                                    bottom_standoff[3],
                                                    bottom_standoff[4],
                                                    bottom_standoff[5],
                                                    bottom_standoff[6],
                                                    bottom_standoff[7],
                                                    bottom_support,
                                                    bottom_standoff[9],
                                                    bottom_standoff[10],
                                                    bottom_standoff[11],
                                                    bottom_standoff[12]];
                                translate([pcbhole_x,pcbhole_y,0]) 
                                    standoff(pcb_standoff,[false,10,2,"default"]);
                            }
                            if (pcbhole_pos == "left_front" && bottom_front_left_enable == true) {
                                bottom_support = bottom_sidewall_support == true ? bottom_front_left_support : "none";
                                pcb_standoff = [bottom_standoff[0],
                                                    bottom_standoff[1],
                                                    bottom_height-pcb_z+pcb_loc_z+bottom_front_left_adjust,
                                                    bottom_standoff[3],
                                                    bottom_standoff[4],
                                                    bottom_standoff[5],
                                                    bottom_standoff[6],
                                                    bottom_standoff[7],
                                                    bottom_support,
                                                    bottom_standoff[9],
                                                    bottom_standoff[10],
                                                    bottom_standoff[11],
                                                    bottom_standoff[12]];
                                translate([pcbhole_x,pcbhole_y,0])
                                    standoff(pcb_standoff,[false,10,2,"default"]);
                            }
                            if (pcbhole_pos == "right_rear" && bottom_rear_right_enable == true) {
                                bottom_support = bottom_sidewall_support == true ? bottom_rear_right_support : "none";
                                pcb_standoff = [bottom_standoff[0],
                                                    bottom_standoff[1],
                                                    bottom_height-pcb_z+pcb_loc_z+bottom_rear_right_adjust,
                                                    bottom_standoff[3],
                                                    bottom_standoff[4],
                                                    bottom_standoff[5],
                                                    bottom_standoff[6],
                                                    bottom_standoff[7],
                                                    bottom_support,
                                                    bottom_standoff[9],
                                                    bottom_standoff[10],
                                                    bottom_standoff[11],
                                                    bottom_standoff[12]];
                                translate([pcbhole_x,pcbhole_y,0])
                                    standoff(pcb_standoff,[false,10,2,"default"]);
                            }
                            if (pcbhole_pos == "right_front" && bottom_front_right_enable == true) {
                                bottom_support = bottom_sidewall_support == true ? bottom_front_right_support : "none";
                                pcb_standoff = [bottom_standoff[0],
                                                    bottom_standoff[1],
                                                    bottom_height-pcb_z+pcb_loc_z+bottom_front_right_adjust,
                                                    bottom_standoff[3],
                                                    bottom_standoff[4],
                                                    bottom_standoff[5],
                                                    bottom_standoff[6],
                                                    bottom_standoff[7],
                                                    bottom_support,
                                                    bottom_standoff[9],
                                                    bottom_standoff[10],
                                                    bottom_standoff[11],
                                                    bottom_standoff[12]];
                                translate([pcbhole_x,pcbhole_y,0])
                                    standoff(pcb_standoff,[false,10,2,"default"]);
                            }
                        }
                    }
                }
                // multi-pcb standoffs
                if(multipcb_bottom_standoffs == true && rack_bay_sbc[r] != "empty") {
                    for (i=[1:11:len(sbc_data[s[0]])-2]) {
                        class = sbc_data[s[0]][i+1];
                        type = sbc_data[s[0]][i+2];
                        pcbid = sbc_data[s[0]][i+3];
                        pcbloc_x = sbc_data[s[0]][i+4];
                        pcbloc_y = sbc_data[s[0]][i+5];
                        pcbloc_z = sbc_data[s[0]][i+6];
                        if(class == "pcb") {
                            for (i=[1:11:len(sbc_data[s[0]])-2]) {
                                pcbclass = sbc_data[s[0]][i+1];
                                pcbtype = sbc_data[s[0]][i+2];
                                id = sbc_data[s[0]][i+3];
                                pcbhole_x = sbc_data[s[0]][i+4]+pcbloc_x;
                                pcbhole_y = sbc_data[s[0]][i+5]+pcbloc_y;
                                pcbhole_z = sbc_data[s[0]][i+6];
                                pcbhole_size = sbc_data[s[0]][i+9][0];
                                pcbhole_state = sbc_data[s[0]][i+10][0];
                                pcbhole_pos = sbc_data[s[0]][i+10][4];

                                if(pcbclass == "pcbhole" && pcbid == id && id != 0) {
                                    if (pcbhole_pos == "left_rear" && multipcb_bottom_rear_left_enable == true && 
                                        (pcbhole_state == "bottom" || pcbhole_state == "both")) {
                                        bottom_support = multipcb_bottom_sidewall_support == true ? multipcb_bottom_rear_left_support : "none";
                                        pcb_standoff = [multipcb_bottom_standoff[0],
                                                            multipcb_bottom_standoff[1],
                                                            bottom_height-pcb_z+pcb_loc_z+multipcb_bottom_rear_left_adjust,
                                                            multipcb_bottom_standoff[3],
                                                            multipcb_bottom_standoff[4],
                                                            multipcb_bottom_standoff[5],
                                                            multipcb_bottom_standoff[6],
                                                            multipcb_bottom_standoff[7],
                                                            bottom_support,
                                                            multipcb_bottom_standoff[9],
                                                            multipcb_bottom_standoff[10],
                                                            multipcb_bottom_standoff[11],
                                                            multipcb_bottom_standoff[12]];
                                        translate([pcbhole_x,pcbhole_y,0]) 
                                            standoff(pcb_standoff,[false,10,2,"default"]);
                                    }
                                    if (pcbhole_pos == "left_front" && multipcb_bottom_front_left_enable == true && 
                                        (pcbhole_state == "bottom" || pcbhole_state == "both")) {
                                        bottom_support = multipcb_bottom_sidewall_support == true ? multipcb_bottom_front_left_support : "none";
                                        pcb_standoff = [multipcb_bottom_standoff[0],
                                                            multipcb_bottom_standoff[1],
                                                            bottom_height-pcb_z+pcb_loc_z+multipcb_bottom_front_left_adjust,
                                                            multipcb_bottom_standoff[3],
                                                            multipcb_bottom_standoff[4],
                                                            multipcb_bottom_standoff[5],
                                                            multipcb_bottom_standoff[6],
                                                            multipcb_bottom_standoff[7],
                                                            bottom_support,
                                                            multipcb_bottom_standoff[9],
                                                            multipcb_bottom_standoff[10],
                                                            multipcb_bottom_standoff[11],
                                                            multipcb_bottom_standoff[12]];
                                        translate([pcbhole_x,pcbhole_y,0])
                                            standoff(pcb_standoff,[false,10,2,"default"]);
                                    }
                                    if (pcbhole_pos == "right_rear" && multipcb_bottom_rear_right_enable == true && 
                                        (pcbhole_state == "bottom" || pcbhole_state == "both")) {
                                        bottom_support = multipcb_bottom_sidewall_support == true ? multipcb_bottom_rear_right_support : "none";
                                        pcb_standoff = [multipcb_bottom_standoff[0],
                                                            multipcb_bottom_standoff[1],
                                                            bottom_height-pcb_z+pcb_loc_z+multipcb_bottom_rear_right_adjust,
                                                            multipcb_bottom_standoff[3],
                                                            multipcb_bottom_standoff[4],
                                                            multipcb_bottom_standoff[5],
                                                            multipcb_bottom_standoff[6],
                                                            multipcb_bottom_standoff[7],
                                                            bottom_support,
                                                            multipcb_bottom_standoff[9],
                                                            multipcb_bottom_standoff[10],
                                                            multipcb_bottom_standoff[11],
                                                            multipcb_bottom_standoff[12]];
                                        translate([pcbhole_x,pcbhole_y,0])
                                            standoff(pcb_standoff,[false,10,2,"default"]);
                                    }
                                    if (pcbhole_pos == "right_front" && multipcb_bottom_front_right_enable == true && 
                                        (pcbhole_state == "bottom" || pcbhole_state == "both")) {
                                        bottom_support = multipcb_bottom_sidewall_support == true ? multipcb_bottom_front_right_support : "none";
                                        pcb_standoff = [multipcb_bottom_standoff[0],
                                                            multipcb_bottom_standoff[1],
                                                            bottom_height-pcb_z+pcb_loc_z+multipcb_bottom_front_right_adjust,
                                                            multipcb_bottom_standoff[3],
                                                            multipcb_bottom_standoff[4],
                                                            multipcb_bottom_standoff[5],
                                                            multipcb_bottom_standoff[6],
                                                            multipcb_bottom_standoff[7],
                                                            bottom_support,
                                                            multipcb_bottom_standoff[9],
                                                            multipcb_bottom_standoff[10],
                                                            multipcb_bottom_standoff[11],
                                                            multipcb_bottom_standoff[12]];
                                        translate([pcbhole_x,pcbhole_y,0]) 
                                            standoff(pcb_standoff,[false,10,2,"default"]);
                                    }
                                }
                            }
                        }
                    }
                }
            } }
            // extended standoffs
            if(ext_bottom_standoffs == true) {
                // extended right-rear standoff
                if((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_bottom_standoff_support_size || 
                    pcb_loc_y >= ext_bottom_standoff_support_size) && ext_bottom_rear_right_enable == true) {
                    extended_standoff = [ext_bottom_standoff[0],
                                        ext_bottom_standoff[1],
                                        bottom_height+ext_bottom_rear_right_adjust,
                                        ext_bottom_standoff[3],
                                        ext_bottom_standoff[4],
                                        ext_bottom_standoff[5],
                                        ext_bottom_standoff[6],
                                        ext_bottom_standoff[7],
                                        ext_bottom_rear_right_support,
                                        ext_bottom_standoff[9],
                                        ext_bottom_standoff[10],
                                        ext_bottom_standoff[11],
                                        ext_bottom_standoff[12]];
                    translate([width-ext_bottom_standoff_support_size/4-(2*(wallthick+gap)),
                        ext_bottom_standoff_support_size/4,0]) 
                            standoff(extended_standoff,[false,10,2,"default"]);
                }
                // extended right-front standoff
                if(((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_bottom_standoff_support_size && 
                    depth-pcb_loc_y-pcb_depth >= ext_bottom_standoff_support_size) || 
                        (width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_bottom_standoff_support_size && 
                            depth-pcb_loc_y-pcb_depth <= ext_bottom_standoff_support_size) ||
                                (width-pcb_loc_x-pcb_width-(gap+2*wallthick) <= ext_bottom_standoff_support_size && 
                                    depth-pcb_loc_y-pcb_depth >= ext_bottom_standoff_support_size)) &&
                                        ext_bottom_front_right_enable == true) {
                    extended_standoff = [ext_bottom_standoff[0],
                                        ext_bottom_standoff[1],
                                        bottom_height+ext_bottom_front_right_adjust,
                                        ext_bottom_standoff[3],
                                        ext_bottom_standoff[4],
                                        ext_bottom_standoff[5],
                                        ext_bottom_standoff[6],
                                        ext_bottom_standoff[7],
                                        ext_bottom_front_right_support,
                                        ext_bottom_standoff[9],
                                        ext_bottom_standoff[10],
                                        ext_bottom_standoff[11],
                                        ext_bottom_standoff[12]];
                    translate([width-ext_bottom_standoff_support_size/4-(2*(wallthick+gap)),
                        depth-ext_bottom_standoff_support_size/4-(2*(wallthick+gap)),0]) 
                            standoff(extended_standoff,[false,10,2,"default"]);
                }
                // extended left-rear standoff
                if((pcb_loc_x >= ext_bottom_standoff_support_size || pcb_loc_y >= ext_bottom_standoff_support_size)
                    && ext_bottom_rear_left_enable == true) {
                    extended_standoff = [ext_bottom_standoff[0],
                                        ext_bottom_standoff[1],
                                        bottom_height+ext_bottom_rear_left_adjust,
                                        ext_bottom_standoff[3],
                                        ext_bottom_standoff[4],
                                        ext_bottom_standoff[5],
                                        ext_bottom_standoff[6],
                                        ext_bottom_standoff[7],
                                        ext_bottom_rear_left_support,
                                        ext_bottom_standoff[9],
                                        ext_bottom_standoff[10],
                                        ext_bottom_standoff[11],
                                        ext_bottom_standoff[12]];
                    translate([ext_bottom_standoff_support_size/4, ext_bottom_standoff_support_size/4,0]) 
                            standoff(extended_standoff,[false,10,2,"default"]);
                }
                // extended left-front standoff
                if(((pcb_loc_x >= ext_bottom_standoff_support_size && 
                    depth-(pcb_loc_y+pcb_depth) >= ext_bottom_standoff_support_size) || 
                        (pcb_loc_x <= ext_bottom_standoff_support_size && 
                            depth-(pcb_loc_y+pcb_depth) >= ext_bottom_standoff_support_size) || 
                                (pcb_loc_x >= ext_bottom_standoff_support_size && 
                                    depth-(pcb_loc_y+pcb_depth) <= ext_bottom_standoff_support_size)) && 
                                        ext_bottom_front_left_enable == true) {
                    extended_standoff = [ext_bottom_standoff[0],
                                        ext_bottom_standoff[1],
                                        bottom_height+ext_bottom_front_left_adjust,
                                        ext_bottom_standoff[3],
                                        ext_bottom_standoff[4],
                                        ext_bottom_standoff[5],
                                        ext_bottom_standoff[6],
                                        ext_bottom_standoff[7],
                                        ext_bottom_front_left_support,
                                        ext_bottom_standoff[9],
                                        ext_bottom_standoff[10],
                                        ext_bottom_standoff[11],
                                        ext_bottom_standoff[12]];
                    translate([ext_bottom_standoff_support_size/4,
                        depth-(ext_bottom_standoff_support_size/4)-(2*(wallthick+gap)),0]) 
                            standoff(extended_standoff,[false,10,2,"default"]);
                }
            }
        }
        // subtractive accessories
        if(accessory_name != "none") {
            for (i=[1:11:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size_x = accessory_data[a[0]][i+8][0];
                size_y = accessory_data[a[0]][i+8][1];
                size_z = accessory_data[a[0]][i+8][2];
                data = accessory_data[a[0]][i+9];
                mask = accessory_data[a[0]][i+10];

                if ((class == "sub" && face == "bottom") || class == "suball") {
                    if(accessory_highlight == false) {
                        parametric_move_sub(type, loc_x, loc_y, loc_z, face, rotation, parametric,
                            [size_x,size_y,size_z],data, mask);
                    }
                    else {
                        #parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            [size_x,size_y,size_z],data, mask);

                    }
                }

                // create openings for additive 
                if ((class == "add1" || class == "add2" || class == "model") && mask[0] == true) {
                    if(accessory_highlight == false) {
                            parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,[size_x,size_y,size_z],data,[true,mask[1],mask[2],mask[3]]);
                    }
                    else {
                            #parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,[size_x,size_y,size_z],data,[true,mask[1],mask[2],mask[3]]);
                    }
                }
            }

        }
        // ui access panel
        if(bottom_access_panel_enable == true) {
            if(access_panel_rotation == 0) {
                translate([access_panel_location[0],access_panel_location[1], 0]) rotate([0,0,access_panel_rotation]) 
                    access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [true,10,2,"default"]);
            }
            if(access_panel_rotation == 90) {
                translate([access_panel_location[0]+access_panel_size[1],access_panel_location[1], 0]) rotate([0,0,access_panel_rotation]) 
                    access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [true,10,2,"default"]);
            }
            if(access_panel_rotation == 180) {
                translate([access_panel_location[0]+access_panel_size[0],access_panel_location[1]+access_panel_size[1],0]) 
                    rotate([0,0,access_panel_rotation]) 
                    access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [true,10,2,"default"]);
            }
            if(access_panel_rotation == 270) {
                translate([access_panel_location[0],access_panel_location[1]+access_panel_size[0], 0]) rotate([0,0,access_panel_rotation]) 
                    access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [true,10,2,"default"]);
            }
        }
        for(i = [0:len(rack_bay_sbc)-1]) {
            s = search([rack_bay_sbc[i]],sbc_data);
            pcb_id = sbc_data[s[0]][4];
            pcb_width = sbc_data[s[0]][10][0];
            pcb_depth = sbc_data[s[0]][10][1];
            pcb_z_orig = sbc_data[s[0]][10][2];
            pcb_tmaxz = sbc_data[s[0]][11][5];
            pcb_bmaxz = sbc_data[s[0]][11][6];
            pcb_color = sbc_data[s[0]][11][1];
            pcb_radius = sbc_data[s[0]][11][0];

            pcb_loc_x = rack_bay_rotation[i] == 90 ? rack_bay_xyz_loc[i][0] + pcb_width : rack_bay_rotation[i] == 180 ?
                rack_bay_xyz_loc[i][0] + pcb_width : rack_bay_xyz_loc[i][0];
            pcb_loc_y = rack_bay_rotation[i] == 270 ? rack_bay_xyz_loc[i][1]+pcb_width : rack_bay_rotation[i] == 180 ?
                rack_bay_xyz_loc[i][1]+pcb_depth : rack_bay_xyz_loc[i][1];
            pcb_loc_z = rack_bay_xyz_loc[i][2];

            // sbc openings
            if(sbc_highlight == true && rack_bay_sbc[i] != "empty") {
                #translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj]) rotate([0,0,rack_bay_rotation[i]])
                    sbc(rack_bay_sbc[i], cooling, fan_size, gpio_opening, uart_opening, true);
            }
            if(sbc_highlight != true && rack_bay_sbc[i] != "empty") {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj])  rotate([0,0,rack_bay_rotation[i]])
                    sbc(rack_bay_sbc[i], cooling, fan_size, gpio_opening, uart_opening, true);
            }
            // indents
            if(indents == true) {
                for (i=[1:11:len(sbc_data[s[0]])-2]) {
                    class = sbc_data[s[0]][i+1];
                    type = sbc_data[s[0]][i+2];
                    pcbid = sbc_data[s[0]][i+3];
                    pcbloc_x = sbc_data[s[0]][i+4];
                    pcbloc_y = sbc_data[s[0]][i+5];
                    pcbloc_z = sbc_data[s[0]][i+6];
                    if(class == "pcb") {
                        for (i=[1:11:len(sbc_data[s[0]])-2]) {
                            class = sbc_data[s[0]][i+1];
                            type = sbc_data[s[0]][i+2];
                            id = sbc_data[s[0]][i+3];
                            loc_x = sbc_data[s[0]][i+4]+pcb_loc_x+pcbloc_x;
                            loc_y = sbc_data[s[0]][i+5]+pcb_loc_y+pcbloc_y;
                            loc_z = sbc_data[s[0]][i+6]+pcb_loc_z+pcbloc_z;
                            side = sbc_data[s[0]][i+7];
                            rotation = sbc_data[s[0]][i+8];
                            if(id == pcbid) {
                                indent(loc_x, loc_y, bottom_height+loc_z-adj, rotation[2], side, class, type, wallthick, gap, floorthick, pcb_z);
                            }
                        }
                    }
                }
            }
            // case divide
            translate([150-gap-wallthick,-gap-wallthick,-adj]) cube([rack_asm_gap,depth,case_z+2*adj]);
            translate([300-gap-wallthick,-gap-wallthick,-adj]) cube([rack_asm_gap,depth,case_z+2*adj]);
        }
        // clean fillets
        if(case_design == "shell") {
            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,bottom_height/2]) 
                cube_negative_fillet([width,depth,bottom_height], radius=-1,
                    vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], top=[0,0,0,0], 
                            bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
        }
    }
    // additive accessories
    if(accessory_name != "none") {
        for (i=[1:11:len(accessory_data[a[0]])-1]) {
            class = accessory_data[a[0]][i];
            type = accessory_data[a[0]][i+1];
            loc_x = accessory_data[a[0]][i+2];
            loc_y = accessory_data[a[0]][i+3];
            loc_z = accessory_data[a[0]][i+4];
            face = accessory_data[a[0]][i+5];
            rotation = accessory_data[a[0]][i+6];
            parametric = accessory_data[a[0]][i+7];
            size = accessory_data[a[0]][i+8];
            data = accessory_data[a[0]][i+9];
            mask = accessory_data[a[0]][i+10];

            if(class == "add2" && face == "bottom") {
                parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric, size, data, [false,mask[1],mask[2],mask[3]]);
            }
        }
    }
    // ui access port
    if(bottom_access_panel_enable == true) {
        if(access_panel_rotation == 0) {
            translate([access_panel_location[0],access_panel_location[1], 0]) rotate([0,0,access_panel_rotation]) 
                access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [false,10,2,"default"]);
        }
        if(access_panel_rotation == 90) {
            translate([access_panel_location[0]+access_panel_size[1],access_panel_location[1], 0]) rotate([0,0,access_panel_rotation]) 
                access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [false,10,2,"default"]);
        }
        if(access_panel_rotation == 180) {
            translate([access_panel_location[0]+access_panel_size[0],access_panel_location[1]+access_panel_size[1],0]) rotate([0,0,access_panel_rotation]) 
                access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [false,10,2,"default"]);
        }
        if(access_panel_rotation == 270) {
            translate([access_panel_location[0],access_panel_location[1]+access_panel_size[0], 0]) rotate([0,0,access_panel_rotation]) 
                access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [false,10,2,"default"]);
        }
    }
}
}
