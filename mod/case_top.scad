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


           NAME: case_top
    DESCRIPTION: creates case top for supported designs
           TODO: none

          USAGE: case_top(case_design)

*/

module case_top(case_design) {

    lip = 5;
    vu_rotation = [15,0,0];
    case_fn = 360;     // circle segments for round cases
    case_ffn = 90;     // circle segments for fillet of round cases
    adj = .01;

    difference() {
        union() {
            difference() {
                union() {
                    if(case_design == "shell") {
                        difference() {
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,bottom_height+(top_height/2)]) 
                                    cube_fillet_inside([width,depth,top_height], 
                                        vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                            top=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], 
                                                bottom=[0,0,0,0], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,
                                bottom_height+(top_height/2)-floorthick]) 
                                    cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),top_height], 
                                        vertical=[corner_fillet-wallthick,corner_fillet-wallthick,corner_fillet-wallthick,corner_fillet-wallthick],
                                            top=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet],
                                                bottom=[0,0,0,0], $fn=90);
                        }
                    }
                    if(case_design == "panel") {
                        union() {
                           translate([-gap,-gap,case_z-floorthick]) 
                                cube([width-(2*wallthick),depth-(2*wallthick),floorthick]);
                            translate([(width*(1/5))-8-(wallthick+gap),depth-(2*wallthick)-gap-adj,
                                case_z-floorthick]) 
                                    cube([8,wallthick+2*adj,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),depth-(2*wallthick)-gap-adj,
                                case_z-floorthick]) 
                                    cube([8,wallthick+2*adj,floorthick]);
                            translate([(width*(1/5))-8-(wallthick+gap),-wallthick-gap+adj,
                                case_z-floorthick]) 
                                    cube([8,wallthick+2*adj,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),-wallthick-gap+adj,
                                case_z-floorthick]) 
                                    cube([8,wallthick+2*adj,floorthick]);
                        }
                    }
                    if(case_design == "panel_nas") {
                        x_adj = pcb_width > 100 ? width-2*sidethick : 101.6+case_offset_x;
                        xtab_adj = pcb_width > 100 ? width-gap-2*sidethick-adj : 101.6-gap+case_offset_x-adj;
                        union() {
                           translate([-gap,-wallthick,case_z-2*floorthick]) 
                                cube([x_adj,depth-(2*wallthick),floorthick]);
                            translate([-gap-sidethick+(2*adj),depth-(3*wallthick)-gap-adj-20,
                                case_z-2*floorthick]) 
                                    cube([sidethick+(2*adj),10,floorthick]);
                            translate([xtab_adj,depth-(3*wallthick)-gap-adj-20,
                                case_z-2*floorthick]) 
                                    cube([sidethick+2*adj,10,floorthick]);
                            translate([-gap-sidethick+(2*adj),40-wallthick-gap+adj,
                                case_z-2*floorthick])
                                    cube([sidethick+2*adj,10,floorthick]);
                            translate([xtab_adj,40-wallthick-gap+adj,
                                case_z-2*floorthick])
                                    cube([sidethick+2*adj,10,floorthick]);
                        }
                    }
                    if(case_design == "stacked") {
                        translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,
                            case_z-(floorthick/2)]) 
                             cube_fillet_inside([width-(2*wallthick),depth-(2*wallthick),floorthick], 
                                 vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                     top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                        }
                    if(case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
                        translate([-wallthick-gap+.5,-wallthick-gap,case_z])
                            cube([width-1,depth,floorthick]);
                        translate([-wallthick-gap+.5,-wallthick-gap,
                            case_z-floorthick+adj]) cube([width-1,wallthick,wallthick]);
                    }
                    if(case_design == "tray") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z/2]) 
                                cube_fillet_inside([width+2*wallthick+1,depth,case_z], 
                                    vertical=[0,0,0,0], top=[0,edge_fillet,0,edge_fillet,edge_fillet], 
                                        bottom=[0,0,0,0], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(case_z/2)-floorthick+.25]) 
                                cube_fillet_inside([width+1,depth+(wallthick*2),case_z], 
                                    vertical=[corner_fillet-wallthick,corner_fillet-wallthick,corner_fillet-wallthick,
                                        corner_fillet-wallthick],top=[0,0,0,0],bottom=[0,0,0,0], $fn=90);
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
                                    if((pcbhole_y <= 10 && pcbhole_x <= 10) || (ext_top_standoffs == true && 
                                        ext_top_rear_left_enable == true)) {
                                        translate([-wallthick-gap-adj-6,wallthick+gap+10,floorthick+3.4]) rotate([0,90,0]) 
                                            cylinder(d=3, h=10+sidethick+(2*adj));
                                    }
                                    else {
                                        translate([-wallthick-gap-adj-6,wallthick+gap+2,floorthick+3.4]) rotate([0,90,0]) 
                                            cylinder(d=3, h=10+sidethick+(2*adj));
                                    }
                                }
                                if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "left_front") {
                                    if((pcbhole_y >= pcb_depth+case_offset_y-10 && pcbhole_x <= 10) || 
                                        (ext_top_standoffs == true && ext_top_front_left_enable == true)) {
                                        translate([-wallthick-gap-adj-6,wallthick-gap+pcb_depth+case_offset_y-14,
                                            floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                    }
                                    else {
                                        translate([-wallthick-gap-adj-6,wallthick+gap+pcb_depth+case_offset_y-8,
                                            floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                    }
                                }
                                if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "right_rear") {
                                    if((pcbhole_y <= 10 && pcbhole_x >= pcb_width-10) || (ext_top_standoffs == true && 
                                        ext_top_rear_right_enable == true)) {
                                        translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+10,floorthick+3.4]) 
                                            rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                    }
                                    else {
                                        translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+2,floorthick+3.4]) 
                                            rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                    }
                                }
                                if(class == "pcbhole" && id == pcb_id && pcbhole_pos == "right_front") {
                                    if((pcbhole_y >= pcb_depth+case_offset_y-10 && pcbhole_x >= width-10) || 
                                        (ext_bottom_standoffs == true && ext_bottom_front_right_enable == true)) {
                                        translate([width-3*(wallthick+gap)-adj,wallthick-gap+pcb_depth+case_offset_y-14,
                                            floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                    }
                                    else {
                                        translate([width-3*(wallthick+gap)-adj,wallthick-gap+pcb_depth+case_offset_y-8,
                                            floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                    }
                                }
                            }
                        }
                    }
                    if(case_design == "round") {
                        difference() {
                            translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-lip/2]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=top_height+lip, r=case_diameter/2, 
                                    top=edge_fillet, bottom=0, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-floorthick-lip/2]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=top_height+lip, r=(case_diameter/2)-wallthick, 
                                    top=edge_fillet-1, bottom=0, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            translate([pcb_width/2,pcb_depth/2,bottom_height-adj-lip/2]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=lip+2*adj, r=(case_diameter/2)-wallthick/2+tol/2, 
                                    top=edge_fillet-1, bottom=0, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            // io cutout
                            if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                                sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                    sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                                translate([width,(depth/2)-wallthick-gap,bottom_height-lip+top_height/2-floorthick])
                                    cube_fillet_inside([18,depth-2*(wallthick+gap)-1,top_height+lip+2], 
                                        vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                            }
                            else {
                                translate([(width/2)-wallthick-gap,-20,bottom_height-lip+top_height/2-floorthick])
                                    cube_fillet_inside([width-2*(wallthick+gap)-1,40,top_height+lip+2], 
                                        vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                            }
                        }
                        if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                            sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                            translate([width-2*wallthick-gap-.95,depth/2-wallthick-gap-(depth-2*(floorthick+gap))/2,
                                bottom_height]) cube([wallthick-adj,depth-2*(floorthick+gap),top_height+adj]);
                        }
                        else {
                            translate([-.95,depth/2-2*wallthick-gap-(depth-2*(floorthick+gap))/2,
                                bottom_height]) cube([width-2*(floorthick+gap),wallthick-adj,top_height+adj]);
                        }
                    }
                    if(case_design == "hex") {
                        if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                            sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-lip/2]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=top_height+lip, r=case_diameter/2, 
                                        top=edge_fillet, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-floorthick-lip/2]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=top_height+lip, r=(case_diameter/2)-wallthick, 
                                        top=edge_fillet-1, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height-adj-lip/2]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=lip+2*adj, r=(case_diameter/2)-wallthick/2+tol/2, 
                                        top=edge_fillet-1, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                            // io cutout
                            translate([width,(depth/2)-wallthick-gap,bottom_height-lip+top_height/2-floorthick])
                                cube_fillet_inside([18,depth-2*(wallthick+gap)-1,top_height+lip+2], 
                                    vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                            }
                        }
                        else {
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-lip/2]) 
                                    cylinder_fillet_inside(h=top_height+lip, r=hex_diameter/2, 
                                        top=edge_fillet, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-floorthick-lip/2])
                                    cylinder_fillet_inside(h=top_height+lip, r=(hex_diameter/2)-wallthick, 
                                        top=edge_fillet-1, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height-adj-lip/2]) 
                                    cylinder_fillet_inside(h=lip+2*adj, r=(hex_diameter/2)-wallthick/2+tol/2, 
                                        top=edge_fillet-1, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                // io cutout
                                translate([(width/2)-wallthick-gap,-23,bottom_height-lip+top_height/2-floorthick])
                                    cube_fillet_inside([width-2*(wallthick+gap),40,top_height+lip+2], 
                                        vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                            }
                        }
                        if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                            sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" &&
                                sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                            translate([width-2*wallthick-gap-.95,depth/2-wallthick-gap-(depth-2*(floorthick+gap))/2,
                                bottom_height]) cube([wallthick-adj,depth-2*(floorthick+gap),top_height+adj]);
                        }
                        else {
                            translate([0,depth/2-2.25*(wallthick+gap)-(depth-2*(floorthick+gap))/2,
                                bottom_height]) cube([width-2*(floorthick+gap),wallthick-adj,top_height+adj]);
                        }
                    }
                    if(case_design == "snap") {
                        translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,floorthick*1.5+case_z])
                            cube_fillet_inside([width,depth,floorthick], 
                                vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                    top=[0,0,0,0],bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-adj]) 
                                cube_fillet_inside([width-2*wallthick-tol,depth-2*wallthick-tol,2*floorthick+1.5], 
                                    vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                        top=[0,0,0,0],bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                            
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-adj]) 
                                cube_fillet_inside([width-(3*wallthick),depth-(3*wallthick),2*floorthick+1.5+adj], 
                                    vertical=[corner_fillet-wallthick,corner_fillet-wallthick,corner_fillet-wallthick,
                                        corner_fillet-wallthick],top=[0,0,0,0],
                                            bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                        }
                        // snap top outdent
                        difference() {
                            translate([-wallthick-gap+1.25+tol,(depth/2)-((depth*.75)/2)+2.5-gap-wallthick,case_z-.5]) 
                                rotate([0,45,0]) cube([4,(depth*.75)-5,4]);
                            translate([-wallthick-gap+3,(depth/2)-((depth*.75)/2)+1.25-gap-wallthick,case_z+floorthick-5.75]) 
                                cube([6,(depth*.75)-2,6]);
                        }
                        difference() {
                            translate([width-wallthick-gap-6.8-tol,(depth/2)-((depth*.75)/2)+2.5-gap-wallthick,case_z-.5])
                                rotate([0,45,0]) cube([4,(depth*.75)-5,4]);
                            translate([width-wallthick-gap-8.5,(depth/2)-((depth*.75)/2)+1.25-gap-wallthick,
                                case_z+floorthick-5.75]) cube([6,(depth*.75)-2,6]);
                        }
                    }
                    if(case_design == "fitted") {
                        difference() {
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,case_z+floorthick/2-(lip)/2]) 
                                    cube_fillet_inside([width,depth,lip+floorthick], 
                                        vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                            top=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], 
                                                bottom=[0,0,0,0], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-floorthick-1]) 
                                    cube_fillet_inside([width-wallthick+tol,depth-wallthick+tol,lip+floorthick], 
                                        vertical=[corner_fillet-wallthick,corner_fillet-wallthick,corner_fillet-wallthick,corner_fillet-wallthick],
                                            top=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet],
                                                bottom=[0,0,0,0], $fn=90);
                        }
                    }
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
                            
                            if (class == "add1" && face == "top") {
                                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,size,data,[false,mask[1],mask[2],mask[3]]);
                            }
                        }
                    }
                }
                // pcb standoff holes
                if(sbc_top_standoffs == true) {
                    for (i=[1:11:len(sbc_data[s[0]])-2]) {
                        class = sbc_data[s[0]][i+1];
                        type = sbc_data[s[0]][i+2];
                        id = sbc_data[s[0]][i+3];
                        pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                        pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                        pcbhole_z = sbc_data[s[0]][i+6];
                        pcbhole_size = sbc_data[s[0]][i+9][0];
                        pcbhole_pos = sbc_data[s[0]][i+10][4];
                        case_z = case_design == "fitted" || case_design == "tray_sides" || 
                            case_design == "tray_vu5" || case_design == "tray_vu7" ? case_z+floorthick : 
                                case_design == "snap" ? case_z+(2 * floorthick) : 
                                    case_design == "panel_nas" ? case_z-floorthick : case_z;

                        if (class == "pcbhole" && id == 0 && pcbhole_pos == "left_rear" && 
                            top_rear_left_enable == true && top_standoff[6] != "blind") {
                            translate([pcbhole_x,pcbhole_y,case_z-(floorthick+adj)]) 
                                cylinder(d=top_standoff[4]-.2, h=floorthick+(2*adj));
                        }
                        if (class == "pcbhole" && id == 0 && pcbhole_pos == "left_front" && 
                            top_front_left_enable == true && top_standoff[6] != "blind") {
                            translate([pcbhole_x,pcbhole_y,case_z-(floorthick+adj)]) 
                                cylinder(d=top_standoff[4]-.2, h=floorthick+(2*adj));
                        }
                        if (class == "pcbhole" && id == 0 && pcbhole_pos == "right_rear" && 
                            top_rear_right_enable == true && top_standoff[6] != "blind") {
                            translate([pcbhole_x,pcbhole_y,case_z-(floorthick+adj)]) 
                                cylinder(d=top_standoff[4]-.2, h=floorthick+(2*adj));
                        }
                        if (class == "pcbhole" && id == 0 && pcbhole_pos == "right_front" && 
                            top_front_right_enable == true && top_standoff[6] != "blind") {
                            translate([pcbhole_x,pcbhole_y,case_z-(floorthick+adj)]) 
                                cylinder(d=top_standoff[4]-.2, h=floorthick+(2*adj));
                        }
                    }
                }
                // multi-pcb standoff holes
                if(multipcb_top_standoffs == true) {
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
                                pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x+pcbloc_x;
                                pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y+pcbloc_y;
                                pcbhole_z = sbc_data[s[0]][i+6];
                                pcbhole_size = sbc_data[s[0]][i+9][0];
                                pcbhole_state = sbc_data[s[0]][i+10][0];
                                pcbhole_pos = sbc_data[s[0]][i+10][4];
                                case_z = case_design == "fitted" || case_design == "tray_sides" || 
                                    case_design == "tray_vu5" || case_design == "tray_vu7" ? case_z+floorthick : 
                                        case_design == "snap" ? case_z+(2 * floorthick) : 
                                            case_design == "panel_nas" ? case_z-floorthick : case_z;

                                if(id == pcbid && id != 0 && pcbclass == "pcbhole") {
                                    if (pcbclass == "pcbhole" && pcbhole_pos == "left_rear" && 
                                        multipcb_top_rear_left_enable == true && 
                                            (pcbhole_state == "top" || pcbhole_state == "both")) {
                                        translate([pcbhole_x,pcbhole_y,case_z-(floorthick+adj)]) 
                                            cylinder(d=multipcb_top_standoff[4]-.2, h=floorthick+(2*adj));
                                    }
                                    if (pcbclass == "pcbhole" && pcbhole_pos == "left_front" && 
                                        multipcb_top_front_left_enable == true && 
                                            (pcbhole_state == "top" || pcbhole_state == "both")) {
                                        translate([pcbhole_x,pcbhole_y,case_z-(floorthick+adj)]) 
                                            cylinder(d=multipcb_top_standoff[4]-.2, h=floorthick+(2*adj));
                                    }
                                    if (pcbclass == "pcbhole" && pcbhole_pos == "right_rear" && 
                                        multipcb_top_rear_right_enable == true && 
                                            (pcbhole_state == "top" || pcbhole_state == "both")) {
                                        translate([pcbhole_x,pcbhole_y,case_z-(floorthick+adj)]) 
                                            cylinder(d=multipcb_top_standoff[4]-.2, h=floorthick+(2*adj));
                                    }
                                    if (pcbclass == "pcbhole" && pcbhole_pos == "right_front" && 
                                        multipcb_top_front_right_enable == true && 
                                            (pcbhole_state == "top" || pcbhole_state == "both")) {
                                        translate([pcbhole_x,pcbhole_y,case_z-(floorthick+adj)]) 
                                            cylinder(d=multipcb_top_standoff[4]-.2, h=floorthick+(2*adj));
                                    }
                                }
                            }
                        }
                    }
                }
                // extended standoff holes
                if(ext_top_standoffs == true) {

                    case_z = case_design == "fitted" || case_design == "tray_sides" || 
                        case_design == "tray_vu5" || case_design == "tray_vu7" ? case_z+floorthick : 
                            case_design == "snap" ? case_z+(2 * floorthick) : 
                                case_design == "panel_nas" ? case_z-floorthick : case_z;

                    // right-rear standoff
                    if((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_top_standoff_support_size || 
                        pcb_loc_y >= ext_top_standoff_support_size) && 
                            ext_top_rear_right_enable == true && ext_top_standoff[6] != "blind") {
                        translate([width-ext_top_standoff_support_size/4-(2*(wallthick+gap)),
                            ext_top_standoff_support_size/4,case_z-(floorthick+adj)]) 
                                cylinder(d=ext_top_standoff[4]-.2, h=floorthick+(2*adj));
                    }
                    // right-front standoff
                    if(((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_top_standoff_support_size && 
                        depth-pcb_loc_y-pcb_depth >= ext_top_standoff_support_size) || 
                            (width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_top_standoff_support_size && 
                                depth-pcb_loc_y-pcb_depth <= ext_top_standoff_support_size) ||
                                    (width-pcb_loc_x-pcb_width-(gap+2*wallthick) <= ext_top_standoff_support_size && 
                                        depth-pcb_loc_y-pcb_depth >= ext_top_standoff_support_size)) &&
                                            ext_top_front_right_enable == true && ext_top_standoff[6] != "blind") {
                        translate([width-ext_top_standoff_support_size/4-(2*(wallthick+gap)),
                            depth-ext_top_standoff_support_size/4-(2*(wallthick+gap)),case_z-(floorthick+adj)]) 
                                cylinder(d=ext_top_standoff[4]-.2, h=floorthick+(2*adj));
                    }
                    // left-rear standoff
                    if((pcb_loc_x >= ext_top_standoff_support_size || pcb_loc_y >= ext_top_standoff_support_size) && 
                            ext_top_rear_left_enable == true && ext_top_standoff[6] != "blind") {
                        translate([ext_top_standoff_support_size/4, ext_top_standoff_support_size/4,case_z-(floorthick+adj)]) 
                            cylinder(d=ext_top_standoff[4]-.2, h=floorthick+(2*adj));
                    }
                    // left-front standoff
                    if(((pcb_loc_x >= ext_top_standoff_support_size && 
                        (depth-(pcb_loc_y+pcb_depth)) >= ext_top_standoff_support_size) || 
                            (pcb_loc_x <= ext_top_standoff_support_size && 
                                (depth-(pcb_loc_y+pcb_depth)) >= ext_top_standoff_support_size) || 
                                    (pcb_loc_x >= ext_top_standoff_support_size && 
                                        (depth-(pcb_loc_y+pcb_depth)) <= ext_top_standoff_support_size)) &&
                                            ext_top_front_left_enable == true && ext_top_standoff[6] != "blind") {
                        translate([ext_top_standoff_support_size/4,
                            depth-ext_top_standoff_support_size/4-(2*(wallthick+gap)),case_z-(floorthick+adj)]) 
                                cylinder(d=ext_top_standoff[4]-.2, h=floorthick+(2*adj));
                    }
                }
                // top cover pattern
                if(top_cover_pattern != "solid") {
                    xvent8_adj = pcb_width > 100 ? width/5.5 : width/6;
                    if(top_cover_pattern == "hex_5mm") {
                        if(case_design == "panel_nas") { 
                            translate([6,5,case_z-(2*floorthick)])
                                vent_hex((width-10)/3.75,(depth-10)/7,floorthick+4,5,1.5,"horizontal");
                        }
                        else {
                            translate([1,0,case_z-(2*floorthick)]) vent_hex(width/3.75,depth/6,floorthick+4,5,1.5,"horizontal");
                        }
                    }
                    if(top_cover_pattern == "hex_8mm") { 
                        if(case_design == "panel_nas") { 
                            translate([-gap+5,6,case_z-(2*floorthick)]) vent_hex(xvent8_adj,depth/9.5,floorthick+4,8,1.5,"horizontal");
                        }
                        else {
                            translate([1,2,case_z-(2*floorthick)]) vent_hex(width/5.5,depth/9.5,floorthick+4,8,1.5,"horizontal");
                        }
                    }
                    if(top_cover_pattern == "linear_vertical") {
                        if(case_design == "panel_nas") { 
                            translate([wallthick+gap,wallthick,case_z-(2*floorthick)]) 
                                vent(wallthick,depth-6*wallthick-gap,floorthick+4,1,1,(width-2*(sidethick+gap))/5.35,"horizontal");
                        }
                        else {
                            translate([0,-gap,case_z-(2*floorthick)]) 
                                vent(wallthick,depth-2*wallthick-gap,floorthick+4,1,1,(width-2*wallthick-gap)/4,"horizontal");
                        }
                    }
                    if(top_cover_pattern == "linear_horizontal") {
                        if(case_design == "panel_nas") { 
                            translate([wallthick+gap,wallthick,case_z-(2*floorthick)]) 
                                vent(width-4*(sidethick+gap),wallthick,floorthick+4,1,
                                    (depth-2*(wallthick-gap))/4.35,1,"horizontal");
                        }
                        else {
                            translate([-gap,-gap,case_z-(2*floorthick)]) 
                                vent(width-2*wallthick-gap,wallthick,floorthick+4,1,(depth-2*wallthick-gap)/3,1,"horizontal");
                        }
                    }
                    if(top_cover_pattern == "astroid") {
                        xast_adj = pcb_width <= 100 ? 8 : 6;
                        if(case_design == "panel_nas") { 
                            for(c=[xast_adj:12:depth-16]) {
                                for(r=[8:12:width-16]) {
                                    translate([r,c,case_z-(2*floorthick)-adj]) 
                                        linear_extrude(floorthick+5) import("./dxf/astroid_8mm.dxf");
                                }
                            }
                        }
                        else {
                            for(c=[3:12:depth-8]) {
                                for(r=[4:12:width-8]) {
                                    translate([r,c,case_z-(2*floorthick)-adj]) 
                                        linear_extrude(floorthick+5) import("./dxf/astroid_8mm.dxf");
                                }
                            }
                        }
                    }
                }
                // rear io shield opening for standard form motherboards
                if(rear_io_shield == true) {
                    if(sbc_model == "mini-stx_thin") {
                        translate([6.2+pcb_loc_x,-4.5,-4.15+bottom_height-pcb_z+pcb_loc_z]) cube([123.95, 10+pcb_loc_y, 25]);
                    }
                    if(sbc_model == "mini-stx") {
                        translate([6.2+pcb_loc_x,-4.5,-4.15+bottom_height-pcb_z+pcb_loc_z]) cube([123.95, 10+pcb_loc_y, 40]);
                    }
                    if(sbc_model == "mini-itx_thin") {
                        translate([-2.62+pcb_loc_x,-4.5,-1.75+bottom_height-pcb_z+pcb_loc_z]) cube([158.75, 10+pcb_loc_y, 25]);
                    }
                    if(sbc_model != "mini-stx_thin" && sbc_model != "mini-stx" && sbc_model != "mini-itx_thin") {
                        translate([-2.62+pcb_loc_x,-4.5,-1.75+bottom_height-pcb_z+pcb_loc_z]) cube([158.75, 10+pcb_loc_y, 44]);
                    }
                }
            }
            // pcb standoffs
            if(sbc_top_standoffs == true) {
                    for (i=[1:11:len(sbc_data[s[0]])-2]) {
                        class = sbc_data[s[0]][i+1];
                        type = sbc_data[s[0]][i+2];
                        id = sbc_data[s[0]][i+3];
                        pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                        pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                        pcbhole_z = sbc_data[s[0]][i+6];
                        pcbhole_size = sbc_data[s[0]][i+9][0];
                        pcbhole_pos = sbc_data[s[0]][i+10][4];
                        case_z = case_design == "fitted" || case_design == "tray_sides" || 
                            case_design == "tray_vu5" || case_design == "tray_vu7" ? case_z+floorthick : 
                                case_design == "snap" ? case_z+(2 * floorthick) : 
                                    case_design == "panel_nas" ? case_z-floorthick : case_z;
                        stand_off_adj = case_design == "fitted" || case_design == "tray_sides" || 
                            case_design == "tray_vu5" || case_design == "tray_vu7" ? floorthick : 
                                case_design == "snap" ? 2 * floorthick : 0;

                    if(class == "pcbhole" && id == pcb_id && 
                        (pcbhole_pos == "left_rear" || pcbhole_pos == "left_front" || 
                            pcbhole_pos == "right_rear" || pcbhole_pos == "right_front")) {
                        if (pcbhole_pos == "left_rear" && top_rear_left_enable == true) {
                            top_support = top_sidewall_support == true ? top_rear_left_support : "none";
                            pcb_standoff = [top_standoff[0],
                                                top_standoff[1],
                                                top_height+top_rear_left_adjust-pcb_loc_z+stand_off_adj,
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_standoff[7],
                                                top_support,
                                                top_standoff[9],
                                                top_standoff[10],
                                                top_standoff[11],
                                                top_standoff[12]];
                            translate([pcbhole_x,pcbhole_y,case_z]) standoff(pcb_standoff,[false,10,2,"default"]);
                        }
                        if (pcbhole_pos == "left_front" && top_front_left_enable == true) {
                            top_support = top_sidewall_support == true ? top_front_left_support : "none";
                            pcb_standoff = [top_standoff[0],
                                                top_standoff[1],
                                                top_height+top_front_left_adjust-pcb_loc_z+stand_off_adj,
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_standoff[7],
                                                top_support,
                                                top_standoff[9],
                                                top_standoff[10],
                                                top_standoff[11],
                                                top_standoff[12]];
                            translate([pcbhole_x,pcbhole_y,case_z]) standoff(pcb_standoff,[false,10,2,"default"]);
                        }
                        if (pcbhole_pos == "right_rear" && top_rear_right_enable == true) {
                            top_support = top_sidewall_support == true ? top_rear_right_support : "none";
                            pcb_standoff = [top_standoff[0],
                                                top_standoff[1],
                                                top_height+top_rear_right_adjust-pcb_loc_z+stand_off_adj,
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_standoff[7],
                                                top_support,
                                                top_standoff[9],
                                                top_standoff[10],
                                                top_standoff[11],
                                                top_standoff[12]];
                            translate([pcbhole_x,pcbhole_y,case_z]) standoff(pcb_standoff,[false,10,2,"default"]);
                        }
                        if (pcbhole_pos == "right_front" && top_front_right_enable == true) {
                            top_support = top_sidewall_support == true ? top_front_right_support : "none";
                            pcb_standoff = [top_standoff[0],
                                                top_standoff[1],
                                                top_height+top_front_right_adjust-pcb_loc_z+stand_off_adj,
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_standoff[7],
                                                top_support,
                                                top_standoff[9],
                                                top_standoff[10],
                                                top_standoff[11],
                                                top_standoff[12]];
                            translate([pcbhole_x,pcbhole_y,case_z]) standoff(pcb_standoff,[false,10,2,"default"]);
                        }
                    }
                }
            }
            // multi-pcb standoffs
            if(multipcb_top_standoffs == true) {
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
                            pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x+pcbloc_x;
                            pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y+pcbloc_y;
                            pcbhole_z = sbc_data[s[0]][i+6];
                            pcbhole_size = sbc_data[s[0]][i+9][0];
                            pcbhole_state = sbc_data[s[0]][i+10][0];
                            pcbhole_pos = sbc_data[s[0]][i+10][4];
                            case_z = case_design == "fitted" || case_design == "tray_sides" || 
                                case_design == "tray_vu5" || case_design == "tray_vu7" ? case_z+floorthick : 
                                    case_design == "snap" ? case_z+(2 * floorthick) : 
                                        case_design == "panel_nas" ? case_z-floorthick : case_z;
                            stand_off_adj = case_design == "fitted" || case_design == "tray_sides" || 
                                case_design == "tray_vu5" || case_design == "tray_vu7" ? floorthick : 
                                    case_design == "snap" ? 2 * floorthick : 0;

                            if(pcbclass == "pcbhole" && pcbid == id && id != 0) {
                                if (pcbhole_pos == "left_rear" && multipcb_top_rear_left_enable == true && 
                                   (pcbhole_state == "top" || pcbhole_state == "both")) {
                                    top_support = multipcb_top_sidewall_support == true ? multipcb_top_rear_left_support : "none";
                                    pcb_standoff = [multipcb_top_standoff[0],
                                                        multipcb_top_standoff[1],
                                                        top_height+top_rear_right_adjust-pcb_loc_z+stand_off_adj,
                                                        multipcb_top_standoff[3],
                                                        multipcb_top_standoff[4],
                                                        multipcb_top_standoff[5],
                                                        multipcb_top_standoff[6],
                                                        multipcb_top_standoff[7],
                                                        top_support,
                                                        multipcb_top_standoff[9],
                                                        multipcb_top_standoff[10],
                                                        multipcb_top_standoff[11],
                                                        multipcb_top_standoff[12]];
                                    translate([pcbhole_x,pcbhole_y,case_z]) standoff(pcb_standoff,[false,10,2,"default"]);
                                }
                                if (pcbhole_pos == "left_front" && multipcb_top_front_left_enable == true && 
                                   (pcbhole_state == "top" || pcbhole_state == "both")) {
                                    top_support = multipcb_top_sidewall_support == true ? multipcb_top_front_left_support : "none";
                                    pcb_standoff = [multipcb_top_standoff[0],
                                                        multipcb_top_standoff[1],
                                                        top_height+top_rear_right_adjust-pcb_loc_z+stand_off_adj,
                                                        multipcb_top_standoff[3],
                                                        multipcb_top_standoff[4],
                                                        multipcb_top_standoff[5],
                                                        multipcb_top_standoff[6],
                                                        multipcb_top_standoff[7],
                                                        top_support,
                                                        multipcb_top_standoff[9],
                                                        multipcb_top_standoff[10],
                                                        multipcb_top_standoff[11],
                                                        multipcb_top_standoff[12]];
                                    translate([pcbhole_x,pcbhole_y,case_z]) standoff(pcb_standoff,[false,10,2,"default"]);
                                }
                                if (pcbhole_pos == "right_rear" && multipcb_top_rear_right_enable == true && 
                                   (pcbhole_state == "top" || pcbhole_state == "both")) {
                                    top_support = multipcb_top_sidewall_support == true ? multipcb_top_rear_right_support : "none";
                                    pcb_standoff = [multipcb_top_standoff[0],
                                                        multipcb_top_standoff[1],
                                                        top_height+top_rear_right_adjust-pcb_loc_z+stand_off_adj,
                                                        multipcb_top_standoff[3],
                                                        multipcb_top_standoff[4],
                                                        multipcb_top_standoff[5],
                                                        multipcb_top_standoff[6],
                                                        multipcb_top_standoff[7],
                                                        top_support,
                                                        multipcb_top_standoff[9],
                                                        multipcb_top_standoff[10],
                                                        multipcb_top_standoff[11],
                                                        multipcb_top_standoff[12]];
                                    translate([pcbhole_x,pcbhole_y,case_z]) standoff(pcb_standoff,[false,10,2,"default"]);
                                }
                                if (pcbhole_pos == "right_front" && multipcb_top_front_right_enable == true && 
                                   (pcbhole_state == "top" || pcbhole_state == "both")) {
                                    top_support = multipcb_top_sidewall_support == true ? multipcb_top_front_right_support : "none";
                                    pcb_standoff = [multipcb_top_standoff[0],
                                                        multipcb_top_standoff[1],
                                                        top_height+top_rear_right_adjust-pcb_loc_z+stand_off_adj,
                                                        multipcb_top_standoff[3],
                                                        multipcb_top_standoff[4],
                                                        multipcb_top_standoff[5],
                                                        multipcb_top_standoff[6],
                                                        multipcb_top_standoff[7],
                                                        top_support,
                                                        multipcb_top_standoff[9],
                                                        multipcb_top_standoff[10],
                                                        multipcb_top_standoff[11],
                                                        multipcb_top_standoff[12]];
                                    translate([pcbhole_x,pcbhole_y,case_z]) standoff(pcb_standoff,[false,10,2,"default"]);
                                }
                            }
                        }
                    }
                }
            }
            // extended standoffs
            if(ext_top_standoffs == true) {

                case_z = case_design == "fitted" || case_design == "tray_sides" || 
                    case_design == "tray_vu5" || case_design == "tray_vu7" ? case_z+floorthick : 
                        case_design == "snap" ? case_z+(2 * floorthick) : 
                            case_design == "panel_nas" ? case_z-floorthick : case_z;
                stand_off_adj = case_design == "fitted" || case_design == "tray_sides" || 
                    case_design == "tray_vu5" || case_design == "tray_vu7" ? floorthick : 
                        case_design == "snap" ? 2 * floorthick : 0;

                // extended right-rear standoff
                if((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_top_standoff_support_size || 
                    pcb_loc_y >= ext_top_standoff_support_size) && ext_top_rear_right_enable == true) {
                    extended_standoff = [ext_top_standoff[0],
                                        ext_top_standoff[1],
                                        top_height+ext_top_rear_right_adjust+stand_off_adj,
                                        ext_top_standoff[3],
                                        ext_top_standoff[4],
                                        ext_top_standoff[5],
                                        ext_top_standoff[6],
                                        ext_top_standoff[7],
                                        ext_top_rear_right_support,
                                        ext_top_standoff[9],
                                        ext_top_standoff[10],
                                        ext_top_standoff[11],
                                        ext_top_standoff[12]];
                    translate([width-ext_top_standoff_support_size/4-(2*(wallthick+gap)),
                        ext_top_standoff_support_size/4,case_z]) standoff(extended_standoff,[false,10,2,"default"]);
                }
                // extended right-front standoff    
                if(((width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_top_standoff_support_size && 
                    depth-pcb_loc_y-pcb_depth >= ext_top_standoff_support_size) || 
                        (width-pcb_loc_x-pcb_width-(gap+2*wallthick) >= ext_top_standoff_support_size && 
                            depth-pcb_loc_y-pcb_depth <= ext_top_standoff_support_size) ||
                                (width-pcb_loc_x-pcb_width-(gap+2*wallthick) <= ext_top_standoff_support_size && 
                                    depth-pcb_loc_y-pcb_depth >= ext_top_standoff_support_size)) && 
                                        ext_top_front_right_enable == true) {
                    extended_standoff = [ext_top_standoff[0],
                                        ext_top_standoff[1],
                                        top_height+ext_top_front_right_adjust+stand_off_adj,
                                        ext_top_standoff[3],
                                        ext_top_standoff[4],
                                        ext_top_standoff[5],
                                        ext_top_standoff[6],
                                        ext_top_standoff[7],
                                        ext_top_front_right_support,
                                        ext_top_standoff[9],
                                        ext_top_standoff[10],
                                        ext_top_standoff[11],
                                        ext_top_standoff[12]];
                    translate([width-ext_top_standoff_support_size/4-(2*(wallthick+gap)),
                        depth-ext_top_standoff_support_size/4-(2*(wallthick+gap)),case_z]) 
                            standoff(extended_standoff,[false,10,2,"default"]);
                }
                // extended left-rear standoff
                if((pcb_loc_x >= ext_top_standoff_support_size || pcb_loc_y >= ext_top_standoff_support_size) && 
                    ext_top_rear_left_enable == true) {
                    extended_standoff = [ext_top_standoff[0],
                                    ext_top_standoff[1],
                                    top_height+ext_top_rear_left_adjust+stand_off_adj,
                                    ext_top_standoff[3],
                                    ext_top_standoff[4],
                                    ext_top_standoff[5],
                                    ext_top_standoff[6],
                                    ext_top_standoff[7],
                                    ext_top_rear_left_support,
                                    ext_top_standoff[9],
                                    ext_top_standoff[10],
                                    ext_top_standoff[11],
                                    ext_top_standoff[12]];
                    translate([ext_top_standoff_support_size/4,
                        ext_top_standoff_support_size/4,case_z]) standoff(extended_standoff,[false,10,2,"default"]);
                }
                // extended left-front standoff
                if(((pcb_loc_x >= ext_top_standoff_support_size && 
                    (depth-(pcb_loc_y+pcb_depth)) >= ext_top_standoff_support_size) || 
                        (pcb_loc_x <= ext_top_standoff_support_size && 
                            (depth-(pcb_loc_y+pcb_depth)) >= ext_top_standoff_support_size) || 
                                (pcb_loc_x >= ext_top_standoff_support_size && 
                                    depth-(pcb_loc_y+pcb_depth) <= ext_top_standoff_support_size)) &&
                                        ext_top_front_left_enable == true) {
                    extended_standoff = [ext_top_standoff[0],
                                        ext_top_standoff[1],
                                        top_height+ext_top_front_left_adjust+stand_off_adj,
                                        ext_top_standoff[3],
                                        ext_top_standoff[4],
                                        ext_top_standoff[5],
                                        ext_top_standoff[6],
                                        ext_top_standoff[7],
                                        ext_top_front_left_support,
                                        ext_top_standoff[9],
                                        ext_top_standoff[10],
                                        ext_top_standoff[11],
                                        ext_top_standoff[12]];
                    translate([ext_top_standoff_support_size/4,
                        depth-ext_top_standoff_support_size/4-(2*(wallthick+gap)), case_z]) 
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
        if(case_design != "panel_nas") {
            if(sbc_highlight == true) {
                #translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj]) 
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
            }
            else {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj]) 
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
            }
        }
        else {
            if(nas_sbc_location == "top") {
                if(sbc_highlight == true) {
                    #translate([pcb_loc_x ,pcb_loc_y,case_z-(top_height+pcb_loc_z+(2*floorthick))]) 
                        sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
                }
                else {
                    translate([pcb_loc_x ,pcb_loc_y,case_z-(top_height+pcb_loc_z+(2*floorthick))]) 
                        sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
                }
            }
            if(nas_sbc_location == "bottom") {
                if(sbc_highlight == true) {
                    #translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) 
                        sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
                }
                else {
                    translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) 
                        sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
                }
            }
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
                            indent(loc_x, loc_y, bottom_height+loc_z-adj, rotation[2], 
                                side, class, type, wallthick, gap, floorthick, pcb_z);
                        }
                    }
                }
            }
        }
        // clean fillets
        if(case_design == "shell") {
            translate(([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,
                bottom_height+(top_height/2)]) ) 
                    cube_negative_fillet([width,depth,top_height], radius=-1,
                        vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                            top=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], 
                                bottom=[0,0,0,0], $fn=90);
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
            
            if (class == "add2" && face == "top") {
                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,
                    parametric,size,data,[false,mask[1],mask[2],mask[3]]);
            }
        }
    }
}
