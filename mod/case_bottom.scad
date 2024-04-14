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


           NAME: case_bottom
    DESCRIPTION: creates case bottom for supported designs
           TODO: none

          USAGE: case_bottom(case_design)

*/

module case_bottom(case_design) {

    lip = 5;
    vu_rotation = [15,0,0];
    case_fn = 360;     // circle segments for round cases
    case_ffn = 90;     // circle segments for fillet of round cases

    difference() {
        union() {
            difference() {
                union() {
                    if(case_design == "shell") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,bottom_height/2]) 
                                cube_fillet_inside([width,depth,bottom_height], 
                                    vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                        top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,(bottom_height/2)+floorthick]) 
                                    cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),bottom_height], 
                                        vertical=[corner_fillet-1,corner_fillet-1,corner_fillet-1,corner_fillet-1],
                                            top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                        }
                    }
                    if(case_design == "panel") {
                       union() {
                           translate([-gap,-gap,0]) 
                                cube([width-(2*wallthick),depth-(2*wallthick),floorthick]);
                            translate([(width*(1/5))-8-(wallthick+gap),depth-(2*wallthick)-gap-adj,0]) 
                                    cube([8,wallthick+2*adj,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),depth-(2*wallthick)-gap-adj,0])
                                    cube([8,wallthick+2*adj,floorthick]);
                            translate([(width*(1/5))-8-(wallthick+gap),-wallthick-gap+adj,0])
                                    cube([8,wallthick+2*adj,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),-wallthick-gap+adj,0])
                                    cube([8,wallthick+2*adj,floorthick]);
                        }
                    }
                    if(case_design == "stacked") {
                        translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,floorthick/2]) 
                            cube_fillet_inside([width-(2*wallthick),depth-(2*wallthick),floorthick], 
                                vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                    top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                    }
                    if(case_design == "tray" || case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(bottom_height)/2]) 
                                cube_fillet_inside([width,depth,bottom_height], 
                                    vertical=[0,0,0,0], top=[0,0,0,0], 
                                        bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(bottom_height/2)+floorthick]) 
                                cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),bottom_height+adj], 
                                    vertical=[corner_fillet-1,corner_fillet-1,corner_fillet-1,corner_fillet-1],
                                        top=[0,0,0,0],bottom=[2,2,2,2], $fn=90);
                        }
                        // case nut placement
                        for (i=[1:11:len(sbc_data[s[0]])-2]) {
                            class = sbc_data[s[0]][i+1];
                            type = sbc_data[s[0]][i+2];
                            id = sbc_data[s[0]][i+3];
                            pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                            pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                            pcbhole_z = sbc_data[s[0]][i+6];
                            pcbhole_size = sbc_data[s[0]][i+9][0];
                            pcbhole_pos = sbc_data[s[0]][i+10][4];

                            if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "left_rear") {
                                if((pcbhole_y <= 10 && pcbhole_x <= 10) || (ext_bottom_standoffs == true && ext_bottom_rear_left_enable == true)) {
                                    translate([-adj-gap,wallthick+gap+10,floorthick+3.4]) rotate([90,0,90]) 
                                        cylinder(d=10, h=4, $fn=6);
                                }
                                else {
                                    translate([-adj-gap,wallthick+gap+2,floorthick+3.4]) rotate([90,0,90]) 
                                        cylinder(d=10, h=4, $fn=6);
                                }
                            }
                            if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "left_front") {
                                if((pcbhole_y >= pcb_depth+case_offset_y-10 && pcbhole_x <= 10) || (ext_bottom_standoffs == true && ext_bottom_front_left_enable == true)) {
                                    translate([-adj-gap,wallthick-gap+pcb_depth+case_offset_y-14,floorthick+3.4]) 
                                        rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                                }
                                else {
                                    translate([-adj-gap,wallthick+gap+pcb_depth-8,floorthick+3.4]) 
                                        rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                                }
                            }
                            if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "right_rear") {
                                if((pcbhole_y <= 10 && pcbhole_x >= pcb_width-10) || (ext_bottom_standoffs == true && ext_bottom_rear_right_enable == true)) {
                                    translate([width-wallthick-gap-wallthick-4+adj,wallthick+gap+10,floorthick+3.4])
                                        rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                                }
                                else {
                                    translate([width-wallthick-gap-wallthick-4+adj,wallthick+gap+2,floorthick+3.4])
                                        rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                                }
                            }
                            if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "right_front") {
                                if((pcbhole_y >= pcb_depth+case_offset_y-10 && pcbhole_x >= width-10) || (ext_bottom_standoffs == true && ext_bottom_front_right_enable == true)) {
                                    translate([width-wallthick-gap-wallthick-4+adj,wallthick-gap+pcb_depth+case_offset_y-14,floorthick+3.4]) 
                                        rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                                }
                                else {
                                    translate([width-wallthick-gap-wallthick-4+adj,wallthick+gap+pcb_depth-8,floorthick+3.4]) 
                                        rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                                }
                            }
                        }   
                        
                        // front panel
                        if(case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
                            translate([-wallthick-gap,depth-(2*wallthick)-gap,bottom_height-adj]) 
                                rotate([0,0,0]) cube([width,wallthick,top_height]);
                        }
                        else {
                            translate([-wallthick-gap,depth-(2*wallthick)-gap,bottom_height-adj]) 
                                rotate([0,0,0]) cube([width,wallthick,top_height-floorthick]);
                        }
                        
                        // rear panel
                        translate([-wallthick-gap,-wallthick-gap,bottom_height-adj]) 
                            cube([width,wallthick,top_height-floorthick]);
                        
                    }
                    if(case_design == "round") {
                        difference() {
                            translate([pcb_width/2,pcb_depth/2,bottom_height/2]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=bottom_height, r=case_diameter/2, 
                                    top=0, bottom=edge_fillet, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+floorthick]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=bottom_height+adj, r=(case_diameter/2)-lip/2, 
                                    top=0, bottom=edge_fillet-1, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,30]) 
                                    cylinder(h=lip+adj, r=(case_diameter/2)+1, $fn=case_fn);
                                translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,30]) 
                                    cylinder(h=lip+2*adj, r=(case_diameter/2)-lip/4, $fn=case_fn);
                            }
                        }
                        difference() {
                            translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+2*floorthick]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=bottom_height+adj+floorthick+lip,
                                    r=(case_diameter/2)-lip/2,top=0,bottom=edge_fillet-1, $fn=case_fn, 
                                        fillet_fn=case_ffn, center=true);
                            if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                               sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                    sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                                translate([-16,(depth/2)-150,-adj])
                                    cube([width+10,300,case_z-2*floorthick-2]); 
                                translate([width-9,(depth/2)-62.5,bottom_height-2*adj])
                                    cube([20,110,top_height-2*floorthick-2]);
                            }
                            else {
                                translate([-width/2,0,-adj])
                                    cube([300,depth+100,case_z-2*floorthick-2]); 
                                translate([(-width+50)/2,-50,bottom_height-2*adj])
                                    cube([width+50,50+adj,top_height-2*floorthick-2]);
                            }
                        }
                    }
                    if(case_design == "hex") {
                        if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                            sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height/2]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=bottom_height, r=case_diameter/2, 
                                        top=0, bottom=edge_fillet, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+floorthick]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=bottom_height+adj,r=(case_diameter/2)-lip/2,top=0, 
                                        bottom=edge_fillet-1,$fn=6,fillet_fn=case_ffn, center=true);
                                difference() {
                                    translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,30]) 
                                        cylinder(h=lip+adj,r=(case_diameter/2)+1, $fn=6);
                                    translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,30]) 
                                        cylinder(h=lip+2*adj,r=(case_diameter/2)-lip/4, $fn=6);
                                }
                            }
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+2*floorthick]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=bottom_height+adj+floorthick+lip,
                                        r=(case_diameter/2)-lip/2,top=0, bottom=edge_fillet-1, $fn=6, 
                                            fillet_fn=case_ffn, center=true);
                                translate([-16,(depth/2)-150,-adj])
                                    cube([width+10,300,case_z-2*floorthick-2]); 
                                translate([width-9,(depth/2)-62.5,bottom_height-2*adj])
                                    cube([20,110,top_height-2*floorthick-2]); 
                            }
                        }
                        else {
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height/2]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=bottom_height, r=hex_diameter/2, 
                                        top=0, bottom=edge_fillet, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+floorthick]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=bottom_height+adj,r=(hex_diameter/2)-lip/2,top=0, 
                                        bottom=edge_fillet-1,$fn=6,fillet_fn=case_ffn, center=true);
                                difference() {
                                    translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,0]) 
                                        cylinder(h=lip+adj,r=(hex_diameter/2)+1, $fn=6);
                                    translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,0]) 
                                        cylinder(h=lip+2*adj,r=(hex_diameter/2)-lip/4, $fn=6);
                                }
                            }
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+2*floorthick]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=bottom_height+adj+floorthick+lip,
                                        r=(hex_diameter/2)-lip/2,top=0, bottom=edge_fillet-1, $fn=6, 
                                            fillet_fn=case_ffn, center=true);
                                translate([-width/2,0,-adj])
                                    cube([300,depth+100,case_z-2*floorthick-2]); 
                                translate([(-width+50)/2,-50,bottom_height-2*adj])
                                    cube([width+50,50+adj,top_height-2*floorthick-2]);
                            }
                        }
                    }
                    if(case_design == "snap") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(floorthick+case_z)/2]) 
                                cube_fillet_inside([width,depth,floorthick+case_z], 
                                    vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                        top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,floorthick+(floorthick+case_z)/2]) 
                                cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),case_z+floorthick], 
                                        vertical=[corner_fillet-1,corner_fillet-1,corner_fillet-1,corner_fillet-1],
                                            top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                            // snap top indent
                            translate([-gap-wallthick+.75,(depth/2)-(depth*.75)/2-gap-wallthick,case_z-.5]) 
                                rotate([0,45,0]) cube([4,depth*.75,4]);
                            translate([width-wallthick-gap-6.25,(depth/2)-(depth*.75)/2-gap-wallthick,case_z-.5])
                                rotate([0,45,0]) cube([4,depth*.75,4]);
                        }
                    }
                    if(case_design == "fitted") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z/2]) 
                                cube_fillet_inside([width,depth,case_z], 
                                    vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                        top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,(case_z/2)+floorthick]) 
                                    cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),case_z], 
                                        vertical=[corner_fillet-1,corner_fillet-1,corner_fillet-1,corner_fillet-1],
                                            top=[0,0,0,0], bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                            difference() {
                                translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-lip/2]) 
                                    cube_fillet_inside([width+adj,depth+adj,lip+adj], 
                                        vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                            top=[0,0,0,0],bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                                
                                translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-lip/2]) 
                                    cube_fillet_inside([width-wallthick,depth-wallthick,lip+adj], 
                                        vertical=[corner_fillet-1,corner_fillet-1,corner_fillet-1,corner_fillet-1],top=[0,0,0,0],
                                            bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
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

                            if(class == "add1" && face == "bottom") {
                                parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric, size, data, [false,mask[1],mask[2],mask[3]]);
                            }
                        }
                    }
                }
                // tray side attachment holes
                if(case_design == "tray" || case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
                    for (i=[1:11:len(sbc_data[s[0]])-2]) {
                        class = sbc_data[s[0]][i+1];
                        type = sbc_data[s[0]][i+2];
                        id = sbc_data[s[0]][i+3];
                        pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                        pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                        pcbhole_z = sbc_data[s[0]][i+6];
                        pcbhole_size = sbc_data[s[0]][i+9][0];
                        pcbhole_pos = sbc_data[s[0]][i+10][4];

                        if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "left_rear") {
                            if((pcbhole_y <= 10 && pcbhole_x <= 10) || (ext_bottom_standoffs == true && ext_bottom_rear_left_enable == true)) {
                                translate([-wallthick-gap-adj-6,wallthick+gap+10,floorthick+3.4]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                                translate([-gap+.6,wallthick+gap+10,floorthick+3.4]) rotate([90,0,90]) 
                                    cylinder(d=6.6, h=3.5, $fn=6);
                            }
                            else {
                                translate([-wallthick-gap-adj-6,wallthick+gap+2,floorthick+3.4]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                                translate([-gap+.6,wallthick+gap+2,floorthick+3.4]) rotate([90,0,90]) 
                                    cylinder(d=6.6, h=3.5, $fn=6);
                            }
                        }
                        if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "left_front") {
                            if((pcbhole_y >= pcb_depth+case_offset_y-10 && pcbhole_x <= 10) || (ext_bottom_standoffs == true && ext_bottom_front_left_enable == true)) {
                                translate([-wallthick-gap-adj-6,wallthick-gap+pcb_depth+case_offset_y-14,
                                    floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                translate([-gap+.6,wallthick-gap+pcb_depth+case_offset_y-14,floorthick+3.4]) 
                                    rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                            }
                            else {
                                translate([-wallthick-gap-adj-6,wallthick+gap+pcb_depth+case_offset_y-8,
                                    floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                translate([-gap+.6,wallthick+gap+pcb_depth+case_offset_y-8,floorthick+3.4]) 
                                    rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                            }
                        }
                        if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "right_rear") {
                            if((pcbhole_y <= 10 && pcbhole_x >= pcb_width-10) || (ext_bottom_standoffs == true && ext_bottom_rear_right_enable == true)) {
                                translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+10,floorthick+3.4]) 
                                    rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                translate([width-3.5-(2*wallthick)-gap-.6,wallthick+gap+10,floorthick+3.4]) 
                                    rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                            }
                            else {
                                translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+2,floorthick+3.4]) 
                                    rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                translate([width-3.5-(2*wallthick)-gap-.6,wallthick+gap+2,floorthick+3.4]) 
                                    rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                            }
                        }
                        if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "right_front") {
                            if((pcbhole_y >= pcb_depth+case_offset_y-10 && pcbhole_x >= width-10) || (ext_bottom_standoffs == true && ext_bottom_front_right_enable == true)) {
                                translate([width-3*(wallthick+gap)-adj,wallthick-gap+pcb_depth+case_offset_y-14,
                                    floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                translate([width-3.5-(2*wallthick)-gap-.6,wallthick-gap+pcb_depth+case_offset_y-14,
                                    floorthick+3.4])rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                            }
                            else {
                                translate([width-3*(wallthick+gap)-adj,wallthick-gap+pcb_depth+case_offset_y-8,
                                    floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                translate([width-3.5-(2*wallthick)-gap-.6,wallthick-gap+pcb_depth+case_offset_y-8,
                                    floorthick+3.4])rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                            }
                        }
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
                // extended standoff holes
                if(ext_bottom_standoffs == true) {
                    // right-rear standoff
                    if(((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= 10 || pcb_loc_y >= 10)) && 
                            ext_bottom_rear_right_enable == true && ext_bottom_standoff[5] != "blind") {
                        translate([width-ext_bottom_standoff_support_size/4-(2*(wallthick+gap))-(corner_fillet/2),
                            (corner_fillet/2)+ext_bottom_standoff_support_size/4,-1]) cylinder(d=6.5, h=bottom_height);
                    }
                    // right-front standoff
                    if(((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || 
                        (width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= 10 && depth-pcb_loc_y-pcb_depth <= 10) ||
                            (width-pcb_loc_x-pcb_width-(gap+2*wallthick) <= 10 && depth-pcb_loc_y-pcb_depth >= 10)) &&
                                ext_bottom_front_right_enable == true && ext_bottom_standoff[5] != "blind") {
                        translate([width-ext_bottom_standoff_support_size/4-(corner_fillet/2)-(2*(wallthick+gap)),
                            depth-ext_bottom_standoff_support_size/4-(corner_fillet/2)-(2*(wallthick+gap)),-1]) 
                                cylinder(d=6.5, h=bottom_height);
                    }
                    // left-rear standoff
                    if((pcb_loc_x >= 10 || pcb_loc_y >= 10) && ext_bottom_rear_left_enable == true && ext_bottom_standoff[5] != "blind") {
                        translate([(corner_fillet/2)+ext_bottom_standoff_support_size/4,
                            (corner_fillet/2)+ext_bottom_standoff_support_size/4,-1]) cylinder(d=6.5, h=bottom_height);
                    }
                    // left-front standoff
                    if(((pcb_loc_x >= 10 && (depth-(pcb_loc_y+pcb_depth)) >= 10) || 
                        (pcb_loc_x <= 10 && (depth-(pcb_loc_y+pcb_depth)) >= 10) || 
                            (pcb_loc_x >= 10 && (depth-(pcb_loc_y+pcb_depth)) <= 10)) &&
                                ext_bottom_front_left_enable == true && ext_bottom_standoff[5] != "blind") {
                        translate([(corner_fillet/2)+ext_bottom_standoff_support_size/4,
                            depth-ext_bottom_standoff_support_size/4-(corner_fillet/2)-(2*(wallthick+gap)),-1]) 
                                cylinder(d=6.5, h=bottom_height);
                    }
                }
                // bottom cover pattern
                if(bottom_cover_pattern != "solid") {
                    if(bottom_cover_pattern == "hex_5mm") {
                        translate([1,0,-2]) vent_hex((width)/3.75,(depth)/6,floorthick+4,5,1.5,"horizontal");
                    }
                    if(bottom_cover_pattern == "hex_8mm") {
                        translate([1,2,-2]) vent_hex((width)/5.5,(depth)/9.5,floorthick+4,8,1.5,"horizontal");
                    }
                    if(bottom_cover_pattern == "linear_vertical") {
                        translate([0,-gap,-2]) vent(wallthick,depth-2*wallthick-gap,floorthick+4,1,1,(width-2*wallthick-gap)/4,"horizontal");
                    }
                    if(bottom_cover_pattern == "linear_horizontal") {
                        translate([-gap,-gap,-2]) vent(width-2*wallthick-gap,wallthick,floorthick+4,1,(depth-2*wallthick-gap)/3,1,"horizontal");
                    }
                    if(bottom_cover_pattern == "astroid") {
                        for(c=[3:12:depth-8]) {
                            for(r=[4:12:width-8]) {
                                translate([r,c,-4]) linear_extrude(floorthick+5) import("./dxf/astroid_8mm.dxf");
                            }
                        }   
                    }
                }
                // rear io plate opening for standard form motherboards
                if(rear_io_plate == true) {
                    if(sbc_model == "mini-stx") {
                        translate([6.2+pcb_loc_x,-4.5,-2+bottom_height-case_offset_bz-pcb_z+pcb_loc_z]) cube([123.95, 10+pcb_loc_y, 40]);
                    }
                    else {
                        translate([-2.62+pcb_loc_x,-4.5,-2+bottom_height-case_offset_bz-pcb_z+pcb_loc_z]) cube([158.75, 10+pcb_loc_y, 44]);
                    }
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
                                                bottom_height-case_offset_bz-pcb_z+pcb_loc_z+bottom_rear_left_adjust,
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
                                                bottom_height-case_offset_bz-pcb_z+pcb_loc_z+bottom_front_left_adjust,
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
                                                bottom_height-case_offset_bz-pcb_z+pcb_loc_z+bottom_rear_right_adjust,
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
                                                bottom_height-case_offset_bz-pcb_z+pcb_loc_z+bottom_front_right_adjust,
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

            // extended standoffs
            if(ext_bottom_standoffs == true) {
                // extended right-rear standoff
                if((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= 10 || pcb_loc_y >= 10) && ext_bottom_rear_right_enable == true) {
                    normal_standoff = [ext_bottom_standoff[0],
                                        bottom_height+ext_bottom_rear_right_adjust,
                                        ext_bottom_standoff[2],
                                        ext_bottom_standoff[3],
                                        ext_bottom_standoff[4],
                                        ext_bottom_standoff[5],
                                        ext_bottom_standoff[6],
                                        ext_bottom_rear_right_support,
                                        ext_bottom_standoff[8],
                                        ext_bottom_standoff[9],
                                        ext_bottom_standoff[10],
                                        ext_bottom_standoff[11]];
                    translate([width-ext_top_standoff_support_size/4-(2*(wallthick+gap))-(corner_fillet/2),
                        (corner_fillet/2)+ext_top_standoff_support_size/4,0]) standoff(normal_standoff,[false,10,2,"default"]);
                }
                // extended right-front standoff
                if(((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || 
                    (width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= 10 && depth-pcb_loc_y-pcb_depth <= 10) ||
                        (width-pcb_loc_x-pcb_width-(gap+2*wallthick) <= 10 && depth-pcb_loc_y-pcb_depth >= 10)) &&
                            ext_bottom_front_right_enable == true) {
                    normal_standoff = [ext_bottom_standoff[0],
                                        bottom_height+ext_bottom_front_right_adjust,
                                        ext_bottom_standoff[2],
                                        ext_bottom_standoff[3],
                                        ext_bottom_standoff[4],
                                        ext_bottom_standoff[5],
                                        ext_bottom_standoff[6],
                                        ext_bottom_front_right_support,
                                        ext_bottom_standoff[8],
                                        ext_bottom_standoff[9],
                                        ext_bottom_standoff[10],
                                        ext_bottom_standoff[11]];
                    translate([width-ext_top_standoff_support_size/4-(corner_fillet/2)-(2*(wallthick+gap)),
                        depth-ext_top_standoff_support_size/4-(corner_fillet/2)-(2*(wallthick+gap)),0]) standoff(normal_standoff,[false,10,2,"default"]);
                }
                // extended left-rear standoff
                if((pcb_loc_x >= 10 || pcb_loc_y >= 10) && ext_bottom_rear_left_enable == true) {
                    normal_standoff = [ext_bottom_standoff[0],
                                        bottom_height+ext_bottom_rear_left_adjust,
                                        ext_bottom_standoff[2],
                                        ext_bottom_standoff[3],
                                        ext_bottom_standoff[4],
                                        ext_bottom_standoff[5],
                                        ext_bottom_standoff[6],
                                        ext_bottom_rear_left_support,
                                        ext_bottom_standoff[8],
                                        ext_bottom_standoff[9],
                                        ext_bottom_standoff[10],
                                        ext_bottom_standoff[11]];
                    translate([(corner_fillet/2)+ext_top_standoff_support_size/4,
                        (corner_fillet/2)+ext_top_standoff_support_size/4,0]) standoff(normal_standoff,[false,10,2,"default"]);
                }
                // extended left-front standoff
                if(((pcb_loc_x >= 10 && depth-(pcb_loc_y+pcb_depth) >= 10) || 
                        (pcb_loc_x <= 10 && depth-(pcb_loc_y+pcb_depth) >= 10) || 
                            (pcb_loc_x >= 10 && depth-(pcb_loc_y+pcb_depth) <= 10)) && 
                                ext_bottom_front_left_enable == true) {
                    normal_standoff = [ext_bottom_standoff[0],
                                        bottom_height+ext_bottom_front_left_adjust,
                                        ext_bottom_standoff[2],
                                        ext_bottom_standoff[3],
                                        ext_bottom_standoff[4],
                                        ext_bottom_standoff[5],
                                        ext_bottom_standoff[6],
                                        ext_bottom_front_left_support,
                                        ext_bottom_standoff[8],
                                        ext_bottom_standoff[9],
                                        ext_bottom_standoff[10],
                                        ext_bottom_standoff[11]];
                    translate([(corner_fillet/2)+ext_top_standoff_support_size/4,
                        depth-ext_top_standoff_support_size/4-(corner_fillet/2)-(2*(wallthick+gap)),0]) 
                            standoff(normal_standoff,[false,10,2,"default"]);
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
                translate([access_panel_location[0]+access_panel_size[0],access_panel_location[1]+access_panel_size[1],0]) rotate([0,0,access_panel_rotation]) 
                    access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [true,10,2,"default"]);
            }
            if(access_panel_rotation == 270) {
                translate([access_panel_location[0],access_panel_location[1]+access_panel_size[0], 0]) rotate([0,0,access_panel_rotation]) 
                    access_panel([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation, [true,10,2,"default"]);
            }
        }
        // sbc openings
        if(sbc_highlight == true) {
            #translate([pcb_loc_x ,pcb_loc_y,bottom_height-case_offset_bz-pcb_z+pcb_loc_z-adj]) 
                sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
        }
        else {
            translate([pcb_loc_x ,pcb_loc_y,bottom_height-case_offset_bz-pcb_z+pcb_loc_z-adj]) 
                sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
        }
        // indents
        if(indents == true) {

            for (i=[1:11:len(sbc_data[s[0]])-2]) {
                class = sbc_data[s[0]][i+1];
                type = sbc_data[s[0]][i+2];
                id = sbc_data[s[0]][i+3];
                loc_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                loc_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                loc_z = sbc_data[s[0]][i+6]+pcb_loc_z;
                side = sbc_data[s[0]][i+7];
                rotation = sbc_data[s[0]][i+8];

                indent(loc_x, loc_y, bottom_height+pcb_loc_z-adj, rotation[2], side, class, type, wallthick, gap, floorthick, pcb_z);
            }   
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
