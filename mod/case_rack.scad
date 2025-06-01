/*
    This file is part of SBC Case Builder https://github.com/hominoids/SBC_Case_Builder
    Copyright 2025 Edward A. Kisiel hominoid@cablemi.com

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

    case_rack(case_design,side)


           NAME: case_rack
    DESCRIPTION: creates 1u-2u rack cases
           TODO: none

          USAGE: case_rack(case_design,side)

*/

module case_rack(case_design,side) {

rack_asm_gap = .25;
rack_asm_size = 5;
rack_asm_hole = 2.25;

if(case_design == "rack" && side == "bottom") {
    difference() {
        union() {
            difference() {
                union() {
                    difference() {
                        translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(case_z-floorthick)/2]) 
                            cube_fillet_inside([width,depth,case_z-floorthick], 
                                vertical=[corner_fillet,corner_fillet,0,0], 
                                    top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                        translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,floorthick+(floorthick+case_z)/2]) 
                            cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),case_z+floorthick], 
                                    vertical=[corner_fillet-wallthick,corner_fillet-wallthick,-wallthick,-wallthick],
                                        top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                        // case upper panel clamp holes
                        translate([150-gap-wallthick,-gap-adj,case_z-13+4]) 
                            panel_clamp("rear", "sloped", "m2", 6, 18, 5, [true,10,2,"default"]);
                        translate([150-gap-wallthick,depth-gap-(2*wallthick)+adj,
                            case_z-13+4]) panel_clamp("front", "sloped", "m2", 6, 18, 5, [true,10,2,"default"]);
                        if(rack_width == 19) { 
                            translate([300-gap-wallthick,-gap-adj,case_z-13+4]) 
                                panel_clamp("rear", "sloped", "m2", 6, 18, 5, [true,10,2,"default"]);
                            translate([300-gap-wallthick,depth-gap-(2*wallthick)+adj,
                                case_z-13+4]) panel_clamp("front", "sloped", "m2", 6, 18, 5, [true,10,2,"default"]);
                        }

                    }
                    // rack mounting tabs
                    translate([-gap-wallthick, -gap+(sidethick-wallthick), 0]) 
                        rack_end_bracket("left", rack_size, sidethick);
                    translate([width-wallthick-gap, -gap+(sidethick-wallthick), 0]) 
                        rack_end_bracket("right", rack_size, sidethick);

                    // bay divider walls
                    for(r = [0:len(rack_bay_sbc)-1]) {
                        if(rack_bay_wall[r] == true) {
                            translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1),-gap-wallthick-adj,0]) 
                                cube([2,depth,case_z-floorthick-2]);
                        }
                    }
                    // case upper panel clamps
                    translate([150-gap-wallthick,-gap-adj,case_z-13+4]) 
                        panel_clamp("rear", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
                    translate([150-gap-wallthick,depth-gap-(2*wallthick)+adj,
                        case_z-13+4]) panel_clamp("front", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
                    if(rack_width == 19) { 
                        translate([300-gap-wallthick,depth-gap-(2*wallthick)+adj,
                            case_z-13+4]) panel_clamp("front", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
                        translate([300-gap-wallthick,-gap-adj,case_z-13+4]) 
                            panel_clamp("rear", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
                    }

                    // case floor panel clamps
                    translate([150-gap-wallthick,(depth/2)-gap-wallthick,floorthick-adj-.5]) 
                        panel_clamp("bottom", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
                    if(rack_width == 19) { 
                        translate([300-gap-wallthick,(depth/2)-gap-wallthick,floorthick-adj-.5]) 
                            panel_clamp("bottom", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
                    }
                    // top support
                    translate([-gap,depth-gap-wallthick-18,case_z-floorthick]) rotate([0,0,270])
                        panel_clamp("rear", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
                    translate([width-gap-(2*wallthick),depth-gap-wallthick-18,case_z-floorthick])  rotate([0,0,270])
                        panel_clamp("front", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
    
                    translate([-gap,18-gap,case_z-floorthick]) rotate([0,0,270])
                        panel_clamp("rear", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
                    translate([width-gap-(2*wallthick),18-gap,case_z-floorthick])  rotate([0,0,270])
                        panel_clamp("front", "sloped", "m2", 6, 18, 5, [false,10,2,"default"]);
    
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
                                parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric, 
                                    size, data, [false,mask[1],mask[2],mask[3]]);
                            }
                        }
                    }
                }
                // pcb and multi-pcb standoff holes 
                for(r = [0:len(rack_bay_sbc)-1]) {
                    if(rack_bay_sbc[r] != "none" && rack_bay_face[r] != "removable") {
                        s = search([rack_bay_sbc[r]],sbc_data);
                        pcb_id = sbc_data[s[0]][4];
                        pcb_width = sbc_data[s[0]][10][0];
                        pcb_depth = sbc_data[s[0]][10][1];
                        pcb_z_orig = sbc_data[s[0]][10][2];
                        pcb_tmaxz = sbc_data[s[0]][11][5];
                        pcb_bmaxz = sbc_data[s[0]][11][6];
                        pcb_color = sbc_data[s[0]][11][1];
                        pcb_radius = sbc_data[s[0]][11][0];

                        pcb_loc_x = rack_bay_rotation[r] == 90 ? rack_bay_xyz_loc[r][0] + pcb_width : 
                            rack_bay_rotation[r] == 180 ? rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_xyz_loc[r][0];
                        pcb_loc_y = rack_bay_rotation[r] == 270 ? rack_bay_xyz_loc[r][1]+pcb_width : 
                            rack_bay_rotation[r] == 180 ? rack_bay_xyz_loc[r][1]+pcb_depth : rack_bay_xyz_loc[r][1];

                        translate([pcb_loc_x,pcb_loc_y,0]) rotate([0,0,rack_bay_rotation[r]]) union() {
                            // pcb standoff holes
                            if(sbc_bottom_standoffs == true) {
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
                                        ahpx = rack_bay_sbc[r] == "n2" ? 7 : rack_bay_sbc[r] == "n2+" ? 9.25 : 
                                            rack_bay_sbc[r] == "m1" ? 9.25 : pcbhole_x; 
                                        ahpy = rack_bay_sbc[r] == "n2" ? 15 : rack_bay_sbc[r] == "n2+" ? 9.25 : 
                                            rack_bay_sbc[r] == "m1" ? 9.25 : pcbhole_y; 
                                        translate([ahpx,ahpy,-adj]) 
                                            cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                                    }
                                    if (class == "pcbhole" && id == 0 && pcbhole_pos == "left_front" && 
                                        bottom_front_left_enable == true && bottom_standoff[6] != "blind") {
                                        ahpx = rack_bay_sbc[r] == "n2" ? 8 : rack_bay_sbc[r] == "n2+" ? 9.25 : 
                                            rack_bay_sbc[r] == "m1" ? 9.25 : pcbhole_x; 
                                        ahpy = rack_bay_sbc[r] == "n2" ? 75 : rack_bay_sbc[r] == "n2+" ? 80.75 : 
                                            rack_bay_sbc[r] == "m1" ? 112.75 : pcbhole_y; 
                                        translate([ahpx,ahpy,-adj]) 
                                            cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                                    }
                                    if (class == "pcbhole" && id == 0 && pcbhole_pos == "right_rear" && 
                                        bottom_rear_right_enable == true && bottom_standoff[6] != "blind") {
                                        ahpx = rack_bay_sbc[r] == "n2" ? 82 : rack_bay_sbc[r] == "n2+" ? 80.75 : 
                                            rack_bay_sbc[r] == "m1" ? 80.75 : pcbhole_x; 
                                        ahpy = rack_bay_sbc[r] == "n2" ? 6 : rack_bay_sbc[r] == "n2+" ? 9.25 : 
                                            rack_bay_sbc[r] == "m1" ? 9.25 : pcbhole_y; 
                                        translate([ahpx,ahpy,-adj]) 
                                            cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                                    }
                                    if (class == "pcbhole" && id == 0 && pcbhole_pos == "right_front" && 
                                        bottom_front_right_enable == true && bottom_standoff[6] != "blind") {
                                        ahpx = rack_bay_sbc[r] == "n2" ? 82 : rack_bay_sbc[r] == "n2+" ? 80.75 : 
                                            rack_bay_sbc[r] == "m1" ? 80.75 : pcbhole_x; 
                                        ahpy = rack_bay_sbc[r] == "n2" ? 75 : rack_bay_sbc[r] == "n2+" ? 80.75 : 
                                            rack_bay_sbc[r] == "m1" ? 112.75 : pcbhole_y; 
                                        translate([ahpx,ahpy,-adj]) 
                                                cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                                    }

                                }
                            }
                            // multi-pcb standoff holes
                            if(multipcb_bottom_standoffs == true) {
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
                        } 
                    }
                }
                // bottom cover pattern
                for(r = [0:len(rack_bay_sbc)-1]) {
                    vent_offset = -75+32;
                    if(bottom_cover_pattern != "solid") {
                        if(bottom_cover_pattern == "hex_5mm") {
                            translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+vent_offset,rack_bay_xyz_loc[r][1]+10,-floorthick+adj]) 
                                vent_hex(15/3.75,(depth-40)/6,floorthick+4,5,1.5,"horizontal");
                        }
                        if(bottom_cover_pattern == "hex_8mm") {
                            translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+vent_offset-10,rack_bay_xyz_loc[r][1]+5,-floorthick+adj]) 
                                vent_hex(35/5.5,(depth-10)/9.5,floorthick+4,8,1.5,"horizontal");
                        }
                        if(bottom_cover_pattern == "linear_vertical") {
                            translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+vent_offset,rack_bay_xyz_loc[r][1]+10,-floorthick+adj])
                                vent(2,25,floorthick+4,1,1,9,"horizontal");
                            translate([rack_bay_xyz_loc[r][0]+10,rack_bay_xyz_loc[r][1]+55,-floorthick+adj])
                                vent(2,25,floorthick+4,1,1,9,"horizontal");
                        }
                        if(bottom_cover_pattern == "linear_horizontal") {
                            translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+vent_offset-10,rack_bay_xyz_loc[r][1]+10,-floorthick+adj])
                                vent(35-2*(wallthick+gap),wallthick,floorthick+4,1,(depth-2*wallthick-gap)/4,1,"horizontal");
                        }
                        if(bottom_cover_pattern == "astroid") {
                            for(c=[rack_bay_xyz_loc[r][1]+10:12:85+rack_bay_xyz_loc[r][1]]) {
                                for(r=[rack_bay_xyz_loc[r][0]:12:55+rack_bay_xyz_loc[r][0]]) {
                                    translate([r,c,-floorthick-adj]) linear_extrude(floorthick+5) import("./dxf/astroid_8mm.dxf");
                                }
                            }
                        }
                    }
                }
                // case floor panel clamp holes
                translate([150-gap-wallthick,(depth/2)-gap-wallthick,floorthick-adj-.5]) 
                    panel_clamp("bottom", "sloped", "m2", 6, 18, 5, [true,10,2,"holes"]);
                if(rack_width == 19) { 
                    translate([300-gap-wallthick,(depth/2)-gap-wallthick,floorthick-adj-.5]) 
                        panel_clamp("bottom", "sloped", "m2", 6, 18, 5, [true,10,2,"holes"]);
                }
                // case upper panel clamp holes
                translate([150-gap-wallthick,-gap-adj,case_z-13+4]) 
                    panel_clamp("rear", "sloped", "m2", 6, 18, 5, [true,10,2,"holes"]);
                translate([150-gap-wallthick,depth-gap-(2*wallthick)+adj,
                    case_z-13+4]) panel_clamp("front", "sloped", "m2", 6, 18, 5, [true,10,2,"holes"]);
                if(rack_width == 19) { 
                    translate([300-gap-wallthick,-gap-adj,case_z-13+4]) 
                        panel_clamp("rear", "sloped", "m2", 6, 18, 5, [true,10,2,"holes"]);
                    translate([300-gap-wallthick,depth-gap-(2*wallthick)+adj,
                        case_z-13+4]) panel_clamp("front", "sloped", "m2", 6, 18, 5, [true,10,2,"holes"]);
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
            }

            // pcb and multi-pcb standoffs
            for(r = [0:len(rack_bay_sbc)-1]) {
                if(rack_bay_sbc[r] != "none" && rack_bay_face[r] != "removable") {
                    s = search([rack_bay_sbc[r]],sbc_data);
                    pcb_id = sbc_data[s[0]][4];
                    pcb_width = sbc_data[s[0]][10][0];
                    pcb_depth = sbc_data[s[0]][10][1];
                    pcb_z_orig = sbc_data[s[0]][10][2];
                    pcb_tmaxz = sbc_data[s[0]][11][5];
                    pcb_bmaxz = sbc_data[s[0]][11][6];

                    pcb_loc_x = rack_bay_rotation[r] == 90 ? rack_bay_xyz_loc[r][0] + pcb_width : 
                        rack_bay_rotation[r] == 180 ? rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_xyz_loc[r][0];
                    pcb_loc_y = rack_bay_rotation[r] == 270 ? rack_bay_xyz_loc[r][1]+pcb_width : 
                        rack_bay_rotation[r] == 180 ? rack_bay_xyz_loc[r][1]+pcb_depth : rack_bay_xyz_loc[r][1];
                    pcb_loc_z = rack_bay_sbc[r] == "n2" || rack_bay_sbc[r] == "m1" ? rack_bay_xyz_loc[r][2]-6 : 
                        rack_bay_sbc[r] == "n2+" ? rack_bay_xyz_loc[r][2]-4.5 : rack_bay_xyz_loc[r][2];

                    translate([pcb_loc_x,pcb_loc_y,0]) rotate([0,0,rack_bay_rotation[r]]) union() {
                        // primary pcb standoffs
                        if(sbc_bottom_standoffs  == true) {
                                for (i=[1:11:len(sbc_data[s[0]])-2]) {
                                    class = sbc_data[s[0]][i+1];
                                    type = sbc_data[s[0]][i+2];
                                    id = sbc_data[s[0]][i+3];
                                    pcbhole_x = sbc_data[s[0]][i+4];
                                    pcbhole_y = sbc_data[s[0]][i+5];
                                    pcbhole_z = sbc_data[s[0]][i+6];
                                    pcbhole_size = sbc_data[s[0]][i+9][0];
                                    pcbhole_pos = sbc_data[s[0]][i+10][4];
                                    pcb_bmaxz = sbc_data[s[0]][11][6];

                                if(class == "pcbhole" && id == pcb_id) {
                                    if (pcbhole_pos == "left_rear" && bottom_rear_left_enable == true) {
                                        bottom_support = bottom_sidewall_support == true ? bottom_rear_left_support : "none";
                                        pcb_standoff = [bottom_standoff[0],
                                                            bottom_standoff[1],
                                                            pcb_bmaxz+floorthick+case_offset_bz+pcb_loc_z+bottom_rear_left_adjust,
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
                                        ahpx = rack_bay_sbc[r] == "n2" ? 7 : rack_bay_sbc[r] == "n2+" ? 9.25 : 
                                            rack_bay_sbc[r] == "m1" ? 9.25 : pcbhole_x; 
                                        ahpy = rack_bay_sbc[r] == "n2" ? 15 : rack_bay_sbc[r] == "n2+" ? 9.25 : 
                                            rack_bay_sbc[r]== "m1" ? 9.25 : pcbhole_y; 
                                        translate([ahpx,ahpy,0]) 
                                            standoff(pcb_standoff,[false,10,2,"default"]);
                                    }
                                    if (pcbhole_pos == "left_front" && bottom_front_left_enable == true) {
                                        bottom_support = bottom_sidewall_support == true ? bottom_front_left_support : "none";
                                        pcb_standoff = [bottom_standoff[0],
                                                            bottom_standoff[1],
                                                            pcb_bmaxz+floorthick+case_offset_bz+pcb_loc_z+bottom_front_left_adjust,
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
                                        ahpx = rack_bay_sbc[r] == "n2" ? 8 : rack_bay_sbc[r] == "n2+" ? 9.25 : 
                                            rack_bay_sbc[r] == "m1" ? 9.25 : pcbhole_x; 
                                        ahpy = rack_bay_sbc[r] == "n2" ? 75 : rack_bay_sbc[r] == "n2+" ? 80.75 : 
                                            rack_bay_sbc[r] == "m1" ? 112.75 : pcbhole_y; 
                                        translate([ahpx,ahpy,0]) 
                                            standoff(pcb_standoff,[false,10,2,"default"]);
                                    }
                                    if (pcbhole_pos == "right_rear" && bottom_rear_right_enable == true) {
                                        bottom_support = bottom_sidewall_support == true ? bottom_rear_right_support : "none";
                                        pcb_standoff = [bottom_standoff[0],
                                                            bottom_standoff[1],
                                                            pcb_bmaxz+floorthick+case_offset_bz+pcb_loc_z+bottom_rear_right_adjust,
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
                                        ahpx = rack_bay_sbc[r] == "n2" ? 82 : rack_bay_sbc[r] == "n2+" ? 80.75 : 
                                            rack_bay_sbc[r] == "m1" ? 80.75 : pcbhole_x; 
                                        ahpy = rack_bay_sbc[r] == "n2" ? 6 : rack_bay_sbc[r] == "n2+" ? 9.25 : 
                                            rack_bay_sbc[r] == "m1" ? 9.25 : pcbhole_y; 
                                        translate([ahpx,ahpy,0]) 
                                            standoff(pcb_standoff,[false,10,2,"default"]);
                                    }
                                    if (pcbhole_pos == "right_front" && bottom_front_right_enable == true) {
                                        bottom_support = bottom_sidewall_support == true ? 
                                            bottom_front_right_support : "none";
                                        pcb_standoff = [bottom_standoff[0],
                                                            bottom_standoff[1],
                                                            pcb_bmaxz+floorthick+case_offset_bz+pcb_loc_z+bottom_front_right_adjust,
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
                                        ahpx = rack_bay_sbc[r] == "n2" ? 82 : rack_bay_sbc[r] == "n2+" ? 80.75 : 
                                            rack_bay_sbc[r] == "m1" ? 80.75 : pcbhole_x; 
                                        ahpy = rack_bay_sbc[r] == "n2" ? 75 : rack_bay_sbc[r] == "n2+" ? 80.75 : 
                                            rack_bay_sbc[r] == "m1" ? 112.75 : pcbhole_y; 
                                        translate([ahpx,ahpy,0]) 
                                            standoff(pcb_standoff,[false,10,2,"default"]);
                                    }
                                }
                            }
                        }
                        // multi-pcb standoffs
                        if(multipcb_bottom_standoffs == true) {
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
                                                bottom_support = multipcb_bottom_sidewall_support == true ? 
                                                    multipcb_bottom_rear_left_support : "none";
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
                                                bottom_support = multipcb_bottom_sidewall_support == true ? 
                                                    multipcb_bottom_front_left_support : "none";
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
                                                bottom_support = multipcb_bottom_sidewall_support == true ? 
                                                    multipcb_bottom_rear_right_support : "none";
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
                                                bottom_support = multipcb_bottom_sidewall_support == true ? 
                                                    multipcb_bottom_front_right_support : "none";
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
                    }
                }
            }
        }
        // rear fan, rear conduit and front bay openings
        for(r = [0:len(rack_bay_sbc)-1]) {
            // rear fan openings
            fan_offset = -75+(75-rear_fan_size)/2;
            if(rack_bay_rear_fan[r] == true) {
                translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+fan_offset+8,depth-gap-wallthick-adj,
                    (case_z-rear_fan_size)/2]) rotate([90,0,0]) fan_mask(rear_fan_size, wallthick, "fan_open");
            }
            // rear grommet openings
            grommet_offset = -75+11;
            if(rack_bay_rear_conduit[r] == "grommet" || rack_bay_rear_conduit[r] == "grommets-vertical") {
                translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+grommet_offset+4,depth-wallthick-gap,13])
                    grommet("front", "sleeve", 10, 4, wallthick, true, [true,10,0,"default"]);
            }
            if(rack_bay_rear_conduit[r] == "grommets-vertical") {
                translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+grommet_offset+4,depth-wallthick-gap,30])
                    grommet("front", "sleeve", 10, 4, wallthick, true, [true,10,0,"default"]);
            }
            if(rack_bay_rear_conduit[r] == "conduit") {
                translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+grommet_offset+1.5,depth-gap-wallthick+adj,5])
                    rotate([90,0,0]) slab([5,30,wallthick+2*adj],2.5);
                translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+grommet_offset+4,depth-gap-wallthick+adj,30])
                    rotate([90,0,0]) cylinder(d=15, h=2*(wallthick+adj));
            }
            // front vent
            if(rack_bay_face[r] == "vent") {
                translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)-75+14,-gap-adj,case_z-16])
                    vent(2,10,wallthick+4,2,1,9,"vertical");
            }
            // open front
            if(rack_bay_face[r] == "open" || rack_bay_face[r] == "removable") {
                open_radius = rack_bay_face[r] == "removable" ? 1 : 6;
                open_height = rack_bay_face[r] == "removable" ? 2 : 6;

                open_offset = r == 0 && rack_bay_wall[r] == true ? wallthick : 
                    r == 0 && rack_bay_wall[r] == false && rack_bay_sbc[r+1] == "none" ? wallthick+gap+.5 : 
                    r == 2 && rack_width == 10 ? 3 :
                    r >= 1 && r < 5 && rack_bay_wall[r] == true ? 2.5 : 
                    r >= 1 && r < 5 && rack_bay_wall[r] == false && rack_bay_sbc[r+1] == "none" ? 2.5 : 
                    r == 5 ? 3 : 3;

                open_size = r == 0 && rack_bay_wall[r] == true ? 75-wallthick-gap-2 : 
                    r == 0 && rack_bay_wall[r] == false && rack_bay_sbc[r+1] == "none" ? 75-wallthick-gap-2.5+baysize : 
                    r == 1 && rack_width == 10 && rack_bay_wall[r] == false && rack_bay_sbc[r+1] == "none" ? 70-wallthick-gap+baysize :
                    r == 2 && rack_width == 10 ? 65.25 :
                    r >= 1 && r < 5 && rack_bay_wall[r] == true ? 75-wallthick-gap-2 : 
                    r >= 1 && r < 5 && rack_bay_wall[r] == false && rack_bay_sbc[r+1] == "none" ||
                        (r != 2 && rack_width == 10) ? 75-wallthick-gap+baysize-.5 : 
                    r == 5 ? 74.75-wallthick-sidethick : 69;

                translate([open_offset-wallthick-gap+rack_asm_gap/2+75*(r+1)-75,
                    -wallthick-gap-adj,floorthick+case_z+open_height]) 
                        rotate([270,0,0]) slab([open_size,case_z,2*wallthick+8],open_radius);
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
                            parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                                [size_x,size_y,size_z],data,[true,mask[1],mask[2],mask[3]]);
                    }
                    else {
                            #parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                                [size_x,size_y,size_z],data,[true,mask[1],mask[2],mask[3]]);
                    }
                }
            }
        }
        for(r = [0:len(rack_bay_sbc)-1]) {
            if(rack_bay_sbc[r] != "none" && rack_bay_face[r] != "removable") {
                s = search([rack_bay_sbc[r]],sbc_data);
                pcb_id = sbc_data[s[0]][4];
                pcb_width = sbc_data[s[0]][10][0];
                pcb_depth = sbc_data[s[0]][10][1];
                pcb_z_orig = sbc_data[s[0]][10][2];
                pcb_tmaxz = sbc_data[s[0]][11][5];
                pcb_bmaxz = sbc_data[s[0]][11][6];

                pcb_loc_x = rack_bay_rotation[r] == 90 ? rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_rotation[r] == 180 ?
                    rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_xyz_loc[r][0];
                pcb_loc_y = rack_bay_rotation[r] == 270 ? rack_bay_xyz_loc[r][1]+pcb_width : rack_bay_rotation[r] == 180 ?
                    rack_bay_xyz_loc[r][1]+pcb_depth : rack_bay_xyz_loc[r][1];
                pcb_loc_z = rack_bay_sbc[r] == "n2+" ? rack_bay_xyz_loc[r][2]+1.5 : rack_bay_xyz_loc[r][2];

                // sbc openings
                if(sbc_highlight == true && rack_bay_sbc[r] != "none") {
                    #translate([pcb_loc_x ,pcb_loc_y,pcb_bmaxz+floorthick+case_offset_bz+pcb_loc_z-adj]) rotate([0,0,rack_bay_rotation[r]])
                        sbc(rack_bay_sbc[r], cooling, fan_size, gpio_opening, uart_opening, true);
                }
                if(sbc_highlight != true && rack_bay_sbc[r] != "none") {
                    translate([pcb_loc_x ,pcb_loc_y,pcb_bmaxz+floorthick+case_offset_bz+pcb_loc_z-adj])  rotate([0,0,rack_bay_rotation[r]])
                        sbc(rack_bay_sbc[r], cooling, fan_size, gpio_opening, uart_opening, true);
                }
            } 
            // case divide
            translate([150-gap-wallthick,-gap-wallthick-1,-adj]) cube([rack_asm_gap,depth+2,case_z+2*adj]);
            translate([300-gap-wallthick,-gap-wallthick-1,-adj]) cube([rack_asm_gap,depth+2,case_z+2*adj]);
        }
        // clean fillets
        if(case_design == "shell") {
            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,bottom_height/2]) 
                cube_negative_fillet([width,depth,bottom_height], radius=-1,
                    vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], top=[0,0,0,0], 
                            bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
        }
        // cleanup for recessed top
        translate([-gap,-gap,case_z-floorthick-2]) 
            slab([width-(2*wallthick),depth-(2*wallthick),2+adj],corner_fillet);
        translate([-gap-wallthick-adj,-gap-wallthick,case_z-floorthick]) 
            slab([width,depth+adj,20],corner_fillet);

        // case exterior support holes
        translate([-gap-wallthick+10,depth-2*(wallthick+gap)-5,-adj]) cylinder(d=3, h=floorthick+(2*adj));
        translate([450/2-gap-wallthick,depth-2*(wallthick+gap)-5,-adj]) cylinder(d=3, h=floorthick+(2*adj));
        translate([450-gap-wallthick-10,depth-2*(wallthick+gap)-5,-adj]) cylinder(d=3, h=floorthick+(2*adj));
        translate([-gap-wallthick+10,5,-adj]) cylinder(d=3, h=floorthick+(2*adj));
        translate([450/2-gap-wallthick,5,-adj]) cylinder(d=3, h=floorthick+(2*adj));
        translate([450-gap-wallthick-10,5,-adj]) cylinder(d=3, h=floorthick+(2*adj));
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
                parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric, size, data,
                    [false,mask[1],mask[2],mask[3]]);
            }
        }
    }
    // case lower assembly blocks
    difference() {
        union() {
            // rear left - left side
            translate([150-gap-wallthick-rack_asm_size,-gap-adj,floorthick-adj]) 
                cube([rack_asm_size,rack_asm_size,rack_asm_size]);
            // rear left - right side
            translate([150-gap-wallthick+rack_asm_gap,-gap-adj,floorthick-adj]) 
                cube([rack_asm_size,rack_asm_size,rack_asm_size]);
            if(rack_width == 19) { 
                // rear right - right
                translate([300-gap-wallthick+rack_asm_gap,-gap-adj,floorthick-adj]) 
                    cube([rack_asm_size,rack_asm_size,rack_asm_size]);
                // rear right - left side
                translate([300-gap-wallthick-rack_asm_size,-gap-adj,floorthick-adj]) 
                    cube([rack_asm_size,rack_asm_size,rack_asm_size]);
            }
            // front left - left
            translate([150-gap-wallthick-rack_asm_size,depth-gap-(2*wallthick)-rack_asm_size+adj,
                floorthick-adj]) cube([rack_asm_size,rack_asm_size,rack_asm_size]);
            // front left - right
            translate([150-gap-wallthick+rack_asm_gap,
                depth-gap-(2*wallthick)-rack_asm_size+adj,floorthick-adj]) 
                    cube([rack_asm_size,rack_asm_size,rack_asm_size]);
            if(rack_width == 19) { 
                // front right - right
                translate([300-gap-wallthick+rack_asm_gap,
                    depth-gap-(2*wallthick)-rack_asm_size+adj,floorthick-adj]) 
                        cube([rack_asm_size,rack_asm_size,rack_asm_size]);
                // front right - left
                translate([300-gap-wallthick-rack_asm_size,depth-gap-(2*wallthick)-rack_asm_size+adj,
                    floorthick-adj]) cube([rack_asm_size,rack_asm_size,rack_asm_size]);
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
    }
}
if(case_design == "rack" && side == "top") {
    difference() {
        union() {
            difference() {
                translate([-gap,-gap,case_z-floorthick-2]) 
                    slab([width-(2*wallthick),depth-(2*wallthick),2],corner_fillet);
                // case divide
                translate([150-gap-wallthick,-gap-wallthick-1,-adj]) cube([rack_asm_gap,depth+2,case_z+2*adj]);
                translate([300-gap-wallthick,-gap-wallthick-1,-adj]) cube([rack_asm_gap,depth+2,case_z+2*adj]);
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

                    if(class == "add1" && face == "top") {
                        parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric, 
                            size, data, [false,mask[1],mask[2],mask[3]]);
                    }
                }
            }
        }
        // top cover pattern
        for(r = [0:len(rack_bay_sbc)-1]) {
            vent_offset = -75+32;
            if(top_cover_pattern != "solid") {
                if(top_cover_pattern == "hex_5mm") {
                    translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+vent_offset,rack_bay_xyz_loc[r][1]+10,case_z-floorthick-2+adj]) 
                        vent_hex(15/3.75,(depth-40)/6,floorthick+4,5,1.5,"horizontal");
                }
                if(top_cover_pattern == "hex_8mm") {
                    translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+vent_offset-10,rack_bay_xyz_loc[r][1]+5,case_z-floorthick-2+adj]) 
                        vent_hex(35/5.5,(depth-10)/9.5,floorthick+4,8,1.5,"horizontal");
                }
                if(top_cover_pattern == "linear_vertical") {
                    translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+vent_offset,rack_bay_xyz_loc[r][1]+10,case_z-floorthick-2+adj])
                        vent(2,25,floorthick+4,1,1,9,"horizontal");
                    translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+vent_offset,rack_bay_xyz_loc[r][1]+55,case_z-floorthick-2+adj])
                        vent(2,25,floorthick+4,1,1,9,"horizontal");
                }
                if(top_cover_pattern == "linear_horizontal") {
                    translate([-gap-wallthick-1+rack_asm_gap/2+75*(r+1)+vent_offset-10,rack_bay_xyz_loc[r][1]+10,case_z-floorthick-2+adj])
                        vent(35-2*(wallthick+gap),wallthick,floorthick+4,1,(depth-2*wallthick-gap)/4,1,"horizontal");
                }
                if(top_cover_pattern == "astroid") {
                    for(c=[rack_bay_xyz_loc[r][1]+10:12:85+rack_bay_xyz_loc[r][1]]) {
                        for(r=[rack_bay_xyz_loc[r][0]:12:55+rack_bay_xyz_loc[r][0]]) {
                            translate([r,c,case_z-floorthick-4+adj]) linear_extrude(floorthick+5) import("./dxf/astroid_8mm.dxf");
                        }
                    }
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

                if ((class == "sub" && face == "top") || class == "suball") {
                    if(accessory_highlight == false) {
                        parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,
                            parametric,[size_x,size_y,size_z],data,mask);
                    }
                    else {
                        #parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,
                            parametric,[size_x,size_y,size_z],data,mask);
                    }
                }

                // create openings for additive 
                if((class == "add1" || class == "add2" || class == "model") && mask[0] == true) {
                    if(accessory_highlight == false) {
                            parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,
                                parametric,[size_x,size_y,size_z],data,mask);
                    }
                    else {
                            #parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,
                                parametric,[size_x,size_y,size_z],data,mask);
                    }
                }
            }
        }
        // sbc openings
        for(r = [0:len(rack_bay_sbc)-1]) {
            if(rack_bay_sbc[r] != "none" && rack_bay_face[r] != "removable") {
                s = search([rack_bay_sbc[r]],sbc_data);
                pcb_id = sbc_data[s[0]][4];
                pcb_width = sbc_data[s[0]][10][0];
                pcb_depth = sbc_data[s[0]][10][1];
                pcb_z_orig = sbc_data[s[0]][10][2];
                pcb_tmaxz = sbc_data[s[0]][11][5];
                pcb_bmaxz = sbc_data[s[0]][11][6];
                pcb_color = sbc_data[s[0]][11][1];
                pcb_radius = sbc_data[s[0]][11][0];

                pcb_loc_x = rack_bay_rotation[r] == 90 ? rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_rotation[r] == 180 ?
                    rack_bay_xyz_loc[r][0] + pcb_width : rack_bay_xyz_loc[r][0];
                pcb_loc_y = rack_bay_rotation[r] == 270 ? rack_bay_xyz_loc[r][1] + pcb_width : rack_bay_rotation[r] == 180 ?
                    rack_bay_xyz_loc[r][1]+pcb_depth : rack_bay_xyz_loc[r][1];
                pcb_loc_z = rack_bay_xyz_loc[r][2];

                // sbc openings
                if(sbc_highlight == true && rack_bay_sbc[r] != "none") {
                    #translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj]) rotate([0,0,rack_bay_rotation[r]])
                        sbc(rack_bay_sbc[r], cooling, fan_size, gpio_opening, uart_opening, true);
                }
                if(sbc_highlight != true && rack_bay_sbc[r] != "none") {
                    translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj])  rotate([0,0,rack_bay_rotation[r]])
                        sbc(rack_bay_sbc[r], cooling, fan_size, gpio_opening, uart_opening, true);
                }
            } 
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

            if(class == "add2" && face == "top") {
                parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric, size, data,
                    [false,mask[1],mask[2],mask[3]]);
            }
        }
    }
}
}

module bay_tray(depth, bay) {

    rack_asm_gap = .25;
    rack_asm_size = 5;
    reminsert = rack_bay_wall[bay] == false && bay == 0 && rack_bay_sbc[bay+1] == "none" ? 74+baysize :
                rack_width == 10 && bay == 1  && rack_bay_wall[bay] == false && 
                    rack_bay_sbc[bay+1] == "none" ? 70+baysize : 
                rack_width == 10 && bay == 2 ? 70 : 
                rack_bay_wall[bay] == false && bay != 0 && rack_bay_sbc[bay+1] == "none" ? 75+baysize : baysize;

    difference() {
        union() {
                slab([reminsert-wallthick-gap-2,depth-.5,1],.5);
                translate([0, 1.5, 0]) rotate([90,0,0]) 
                    slab([reminsert-wallthick-gap-2,bay_height-3+removable_bay_height,1.5],.5);
        }
        // case floor panel clamp holes
        translate([baysize-2.5,(depth/2)-gap-wallthick+3,-adj]) 
            cylinder(d=20, h=7);
        translate([-gap-wallthick+.5,(depth/2)-gap-wallthick+3,-adj]) 
            cylinder(d=20, h=7);
        if(reminsert/9 > 10) {
            translate([reminsert-4,(depth/2)-gap-wallthick+3,-adj]) 
                cylinder(d=20, h=7);
        }
        // rear assembly block opening
        // rear left
        translate([-rack_asm_size,depth-wallthick-gap-1.25,-adj]) 
            cube([.125+(2*rack_asm_size),rack_asm_size,rack_asm_size+.25]);
        // rear middle
        translate([1+baysize-2*rack_asm_size,depth-wallthick-gap-1.25,-adj]) 
            cube([.125+(2*rack_asm_size)+2,rack_asm_size,rack_asm_size+.25]);
        // rear right
        translate([2*baysize-2*rack_asm_size-1.25,depth-wallthick-gap-1.25,-adj]) 
            cube([.125+(2*rack_asm_size),rack_asm_size,rack_asm_size+.25]);
        // front assembly block opening
        // front left
        translate([-rack_asm_size,-adj,-adj]) 
            cube([.25+(2*rack_asm_size),rack_asm_size,rack_asm_size+.25]);
        // front middle
        if((bay == 1 || bay == 3) && reminsert/9 > 10)
            translate([1+baysize-2*rack_asm_size,-gap,-adj]) 
                cube([.125+(2*rack_asm_size)+2,rack_asm_size,rack_asm_size+1.25]);
        // front right
        if(reminsert/9 > 10) {
            translate([2*baysize-2*rack_asm_size-1.25,-adj,-adj]) 
                cube([.125+(2*rack_asm_size),rack_asm_size,rack_asm_size+.25]);
        }
         else {
            translate([baysize-2*rack_asm_size,-gap,-adj]) 
                cube([.125+(2*rack_asm_size),rack_asm_size,rack_asm_size+1.25]);
        }

        // front vent
        if(rack_bay_face[bay] == "removable") {
            vadj = reminsert/9 > 10 ? 36 : 0;
//            translate([-gap-wallthick-1+(rack_asm_gap/2)+14,gap+wallthick-adj,bay_height-13])
//                vent(2,5,wallthick+4,2,1,(reminsert+vadj)/9,"vertical");
            translate([-gap-wallthick-1+(rack_asm_gap/2)+14,gap+wallthick-adj,2])
                vent(2,5,wallthick+4,2,1,(reminsert+vadj)/9,"vertical");
        }
        // pcb and multi-pcb standoff holes 
        if(rack_bay_sbc[bay] != "none") {
            s = search([rack_bay_sbc[bay]],sbc_data);
            pcb_id = sbc_data[s[0]][4];
            pcb_width = sbc_data[s[0]][10][0];
            pcb_depth = sbc_data[s[0]][10][1];
            pcb_z_orig = sbc_data[s[0]][10][2];
            pcb_tmaxz = sbc_data[s[0]][11][5];
            pcb_bmaxz = sbc_data[s[0]][11][6];

            pcb_loc_x = rack_bay_rotation[bay] == 90 ? rack_bay_xyz_loc[bay][0] + pcb_width : 
                rack_bay_rotation[bay] == 180 ? rack_bay_xyz_loc[bay][0] + pcb_width : rack_bay_xyz_loc[bay][0];
            pcb_loc_y = rack_bay_rotation[bay] == 270 ? rack_bay_xyz_loc[bay][1]+pcb_width : 
                rack_bay_rotation[bay] == 180 ? rack_bay_xyz_loc[bay][1]+pcb_depth : rack_bay_xyz_loc[bay][1];
            pcb_loc_z = rack_bay_xyz_loc[bay][2];
            translate([pcb_loc_x,pcb_loc_y+wallthick+gap,0]) rotate([0,0,rack_bay_rotation[bay]]) union() {
                // pcb standoff holes
                if(sbc_bottom_standoffs == true) {
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
                            ahpx = rack_bay_sbc[bay] == "n2" ? 7 : rack_bay_sbc[bay] == "n2+" ? 9.25 : 
                                rack_bay_sbc[bay] == "m1" ? 9.25 : pcbhole_x; 
                            ahpy = rack_bay_sbc[bay] == "n2" ? 15 : rack_bay_sbc[bay] == "n2+" ? 9.25 : 
                                rack_bay_sbc[bay] == "m1" ? 9.25 : pcbhole_y; 
                            translate([ahpx,ahpy,-adj]) 
                                cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                        }
                        if (class == "pcbhole" && id == 0 && pcbhole_pos == "left_front" && 
                            bottom_front_left_enable == true && bottom_standoff[6] != "blind") {
                            ahpx = rack_bay_sbc[bay] == "n2" ? 8 : rack_bay_sbc[bay] == "n2+" ? 9.25 : 
                                rack_bay_sbc[bay] == "m1" ? 9.25 : pcbhole_x; 
                            ahpy = rack_bay_sbc[bay] == "n2" ? 75 : rack_bay_sbc[bay] == "n2+" ? 80.75 : 
                                rack_bay_sbc[bay] == "m1" ? 112.75 : pcbhole_y; 
                            translate([ahpx,ahpy,-adj]) 
                                cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                        }
                        if (class == "pcbhole" && id == 0 && pcbhole_pos == "right_rear" && 
                            bottom_rear_right_enable == true && bottom_standoff[6] != "blind") {
                            ahpx = rack_bay_sbc[bay] == "n2" ? 82 : rack_bay_sbc[bay] == "n2+" ? 80.75 : 
                                rack_bay_sbc[bay] == "m1" ? 80.75 : pcbhole_x; 
                            ahpy = rack_bay_sbc[bay] == "n2" ? 6 : rack_bay_sbc[bay] == "n2+" ? 9.25 : 
                                rack_bay_sbc[bay] == "m1" ? 9.25 : pcbhole_y; 
                            translate([ahpx,ahpy,-adj]) 
                                cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                        }
                        if (class == "pcbhole" && id == 0 && pcbhole_pos == "right_front" && 
                            bottom_front_right_enable == true && bottom_standoff[6] != "blind") {
                            ahpx = rack_bay_sbc[bay] == "n2" ? 82 : rack_bay_sbc[bay] == "n2+" ? 80.75 : 
                                rack_bay_sbc[bay] == "m1" ? 80.75 : pcbhole_x; 
                            ahpy = rack_bay_sbc[bay] == "n2" ? 75 : rack_bay_sbc[bay] == "n2+" ? 80.75 : 
                                rack_bay_sbc[bay] == "m1" ? 112.75 : pcbhole_y; 
                            translate([ahpx,ahpy,-adj]) 
                                cylinder(d=bottom_standoff[4]-.2, h=floorthick+(2*adj));
                        }

                    }
                }
                // multi-pcb standoff holes
                if(multipcb_bottom_standoffs == true) {
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
            }
            // sbc openings
            if(sbc_highlight == true && rack_bay_sbc[bay] != "none") {
                #translate([pcb_loc_x, pcb_loc_y+gap+1.5,pcb_bmaxz+case_offset_bz+pcb_loc_z+1-adj]) 
                    rotate([0,0,rack_bay_rotation[bay]])
                        sbc(rack_bay_sbc[bay], cooling, fan_size, gpio_opening, uart_opening, true);
            }
            if(sbc_highlight != true && rack_bay_sbc[bay] != "none") {
                translate([pcb_loc_x, pcb_loc_y+gap+1.5,pcb_bmaxz+case_offset_bz+pcb_loc_z+1-adj]) 
                    rotate([0,0,rack_bay_rotation[bay]])
                        sbc(rack_bay_sbc[bay], cooling, fan_size, gpio_opening, uart_opening, true);
            }
        }
    }

    // pcb and multi-pcb standoffs
    if(rack_bay_sbc[bay] != "none") {
        s = search([rack_bay_sbc[bay]],sbc_data);
        pcb_id = sbc_data[s[0]][4];
        pcb_width = sbc_data[s[0]][10][0];
        pcb_depth = sbc_data[s[0]][10][1];
        pcb_z_orig = sbc_data[s[0]][10][2];
        pcb_tmaxz = sbc_data[s[0]][11][5];
        pcb_bmaxz = sbc_data[s[0]][11][6];
        pcb_color = sbc_data[s[0]][11][1];
        pcb_radius = sbc_data[s[0]][11][0];

        pcb_loc_x = rack_bay_rotation[bay] == 90 ? rack_bay_xyz_loc[bay][0] + pcb_width : 
            rack_bay_rotation[bay] == 180 ? rack_bay_xyz_loc[bay][0] + pcb_width : rack_bay_xyz_loc[bay][0];
        pcb_loc_y = rack_bay_rotation[bay] == 270 ? rack_bay_xyz_loc[bay][1]+pcb_width : 
            rack_bay_rotation[bay] == 180 ? rack_bay_xyz_loc[bay][1]+pcb_depth : rack_bay_xyz_loc[bay][1];
        pcb_loc_z = rack_bay_sbc[bay] == "n2" || rack_bay_sbc[bay] == "m1" ? rack_bay_xyz_loc[bay][2]-6 : 
            rack_bay_sbc[bay] == "n2+" ? rack_bay_xyz_loc[bay][2]-4.5 : rack_bay_xyz_loc[bay][2];

        translate([pcb_loc_x,pcb_loc_y+wallthick+gap,0]) rotate([0,0,rack_bay_rotation[bay]]) union() {
            // primary pcb standoffs
            if(sbc_bottom_standoffs  == true) {
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
                                                pcb_bmaxz+1+case_offset_bz+pcb_loc_z+bottom_rear_left_adjust,
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
                            ahpx = rack_bay_sbc[bay] == "n2" ? 7 : rack_bay_sbc[bay] == "n2+" ? 9.25 : 
                                rack_bay_sbc[bay] == "m1" ? 9.25 : pcbhole_x; 
                            ahpy = rack_bay_sbc[bay] == "n2" ? 15 : rack_bay_sbc[bay] == "n2+" ? 9.25 : 
                                rack_bay_sbc[bay]== "m1" ? 9.25 : pcbhole_y; 
                            translate([ahpx,ahpy,0]) 
                                standoff(pcb_standoff,[false,10,2,"default"]);
                        }
                        if (pcbhole_pos == "left_front" && bottom_front_left_enable == true) {
                            bottom_support = bottom_sidewall_support == true ? bottom_front_left_support : "none";
                            pcb_standoff = [bottom_standoff[0],
                                                bottom_standoff[1],
                                                pcb_bmaxz+1+case_offset_bz+pcb_loc_z+bottom_front_left_adjust,
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
                            ahpx = rack_bay_sbc[bay] == "n2" ? 8 : rack_bay_sbc[bay] == "n2+" ? 9.25 : 
                                rack_bay_sbc[bay] == "m1" ? 9.25 : pcbhole_x; 
                            ahpy = rack_bay_sbc[bay] == "n2" ? 75 : rack_bay_sbc[bay] == "n2+" ? 80.75 : 
                                rack_bay_sbc[bay] == "m1" ? 112.75 : pcbhole_y; 
                            translate([ahpx,ahpy,0]) 
                                standoff(pcb_standoff,[false,10,2,"default"]);
                        }
                        if (pcbhole_pos == "right_rear" && bottom_rear_right_enable == true) {
                            bottom_support = bottom_sidewall_support == true ? bottom_rear_right_support : "none";
                            pcb_standoff = [bottom_standoff[0],
                                                bottom_standoff[1],
                                                pcb_bmaxz+1+case_offset_bz+pcb_loc_z+bottom_rear_right_adjust,
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
                            ahpx = rack_bay_sbc[bay] == "n2" ? 82 : rack_bay_sbc[bay] == "n2+" ? 80.75 : 
                                rack_bay_sbc[bay] == "m1" ? 80.75 : pcbhole_x; 
                            ahpy = rack_bay_sbc[bay] == "n2" ? 6 : rack_bay_sbc[bay] == "n2+" ? 9.25 : 
                                rack_bay_sbc[bay] == "m1" ? 9.25 : pcbhole_y; 
                            translate([ahpx,ahpy,0]) 
                                standoff(pcb_standoff,[false,10,2,"default"]);
                        }
                        if (pcbhole_pos == "right_front" && bottom_front_right_enable == true) {
                            bottom_support = bottom_sidewall_support == true ? bottom_front_right_support : "none";
                            pcb_standoff = [bottom_standoff[0],
                                                bottom_standoff[1],
                                                pcb_bmaxz+1+case_offset_bz+pcb_loc_z+bottom_front_right_adjust,
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
                            ahpx = rack_bay_sbc[bay] == "n2" ? 82 : rack_bay_sbc[bay] == "n2+" ? 80.75 : 
                                rack_bay_sbc[bay] == "m1" ? 80.75 : pcbhole_x; 
                            ahpy = rack_bay_sbc[bay] == "n2" ? 75 : rack_bay_sbc[bay] == "n2+" ? 80.75 : 
                                rack_bay_sbc[bay] == "m1" ? 112.75 : pcbhole_y; 
                            translate([ahpx,ahpy,0]) 
                                standoff(pcb_standoff,[false,10,2,"default"]);
                        }
                    }
                }
            }
            // multi-pcb standoffs
            if(multipcb_bottom_standoffs == true) {
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
                                    bottom_support = multipcb_bottom_sidewall_support == true ? 
                                        multipcb_bottom_rear_left_support : "none";
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
                                    bottom_support = multipcb_bottom_sidewall_support == true ? 
                                        multipcb_bottom_front_left_support : "none";
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
                                    bottom_support = multipcb_bottom_sidewall_support == true ? 
                                        multipcb_bottom_rear_right_support : "none";
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
                                    bottom_support = multipcb_bottom_sidewall_support == true ? 
                                        multipcb_bottom_front_right_support : "none";
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
        }
    }
}
