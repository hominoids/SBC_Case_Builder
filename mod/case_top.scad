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
                                        vertical=[corner_fillet-1,corner_fillet-1,corner_fillet-1,corner_fillet-1],
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
                    if(case_design == "stacked") {
                        translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,
                            case_z-(floorthick/2)]) 
                             cube_fillet_inside([width-(2*wallthick),depth-(2*wallthick),floorthick], 
                                 vertical=[corner_fillet,corner_fillet,corner_fillet,corner_fillet], 
                                     top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                        }
                    if(case_design == "tray" && (case_style == "vu5" || case_style == "vu7" || case_style == "sides")) {
                        translate([-wallthick-gap+.5,-wallthick-gap,case_z])
                            cube([width-1,depth,floorthick]);
                        translate([-wallthick-gap+.5,-wallthick-gap,
                            case_z-floorthick+adj]) cube([width-1,wallthick,wallthick]);
                    }
                    if(case_design == "tray" && case_style == "none") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z/2]) 
                                cube_fillet_inside([width+2*wallthick+1,depth,case_z], 
                                    vertical=[0,0,0,0], top=[0,edge_fillet,0,edge_fillet,edge_fillet], 
                                        bottom=[0,0,0,0], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(case_z/2)-floorthick+.25]) 
                                cube_fillet_inside([width+1,depth+(wallthick*2),case_z], 
                                    vertical=[corner_fillet-1,corner_fillet-1,corner_fillet-1,corner_fillet-1],
                                        top=[0,0,0,0],bottom=[0,0,0,0], $fn=90);
                            // right side bottom attachment hole
                            translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+10,
                                floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                            // left side bottom attachment hole
                            translate([-2*(wallthick+gap)-sidethick-adj,wallthick+gap+10,
                                floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                            if(depth >= 75 && sbc_model != "visionfive2" && sbc_model != "visionfive2q" && 
                                sbc_model != "rock5b" && sbc_model != "rock5bq" && sbc_model != "rock5b-v1.3") {
                                translate([width-2*(wallthick+gap)-sidethick-adj,depth-wallthick-gap-10,
                                    floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                translate([-wallthick-gap-adj-6,depth-wallthick-gap-10,
                                    floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                            }
                            else {
                                if(sbc_model == "visionfive2" || sbc_model == "visionfive2q" || sbc_model == "rock5b" || 
                                    sbc_model == "rock5bq" || sbc_model == "rock5b-v1.3") {
                                    translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+58,
                                        floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                    translate([-wallthick-gap-adj-6,wallthick+gap+58,
                                        floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                }
                                else {
                                   translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+40,
                                        floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                                    translate([-wallthick-gap-adj-6,wallthick+gap+40,
                                        floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
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
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-lip/2]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=top_height+lip, r=hex_diameter/2, 
                                        top=edge_fillet, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-floorthick-lip/2])
                                    rotate([0,0,0]) cylinder_fillet_inside(h=top_height+lip, r=(hex_diameter/2)-wallthick, 
                                        top=edge_fillet-1, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height-adj-lip/2]) rotate([0,0,0]) 
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
                                    vertical=[corner_fillet-1,corner_fillet-1,corner_fillet-1,corner_fillet-1],top=[0,0,0,0],
                                        bottom=[edge_fillet,edge_fillet,edge_fillet,edge_fillet,edge_fillet], $fn=90);
                        }
                        // snap top outdent
                        difference() {
                            translate([-wallthick-gap+1.25+tol,(depth/2)-((depth*.75)/2)+2.5-gap-wallthick,case_z-.5]) 
                                rotate([0,45,0]) cube([4,(depth*.75)-5,4]);
                            translate([-wallthick-gap+3,(depth/2)-((depth*.75)/2)+1.25-gap-wallthick,case_z+floorthick-5.75]) 
                                rotate([0,0,0]) cube([6,(depth*.75)-2,6]);
                        }
                        difference() {
                            translate([width-wallthick-gap-6.8-tol,(depth/2)-((depth*.75)/2)+2.5-gap-wallthick,case_z-.5])
                                rotate([0,45,0]) cube([4,(depth*.75)-5,4]);
                            translate([width-wallthick-gap-8.5,(depth/2)-((depth*.75)/2)+1.25-gap-wallthick,case_z+floorthick-5.75])
                                rotate([0,0,0]) cube([6,(depth*.75)-2,6]);
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
                                        vertical=[corner_fillet-1,corner_fillet-1,corner_fillet-1,corner_fillet-1],
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
                                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,size,data,mask);
                            }
                        }
                    }
                }
                // pcb standoff holes
                if(sbc_top_standoffs == true && top_standoff[5] != 4) {
                    for (i=[1:11:len(sbc_data[s[0]])-2]) {
                        class = sbc_data[s[0]][i+1];
                        type = sbc_data[s[0]][i+2];
                        id = sbc_data[s[0]][i+3];
                        pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                        pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                        pcbhole_z = sbc_data[s[0]][i+6];
                        pcbhole_size = sbc_data[s[0]][i+9][0];
                        pcbhole_pos = sbc_data[s[0]][i+10][4];

                        if (class == "pcbhole" && id == pcb_id && 
                            (pcbhole_pos == "left_rear" || pcbhole_pos == "left_front" || 
                                pcbhole_pos == "right_rear" || pcbhole_pos == "right_front")) {
                            translate([pcbhole_x,pcbhole_y,top_height+1]) cylinder(d=6.5, h=top_height);
                        }
                    }
                }
                // extended standoff holes
                if(case_ext_standoffs == true) {
                    // right-rear standoff
                    if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                        translate([width-(2*(wallthick+gap))-(corner_fillet/2),(corner_fillet/2),top_height+1]) 
                            cylinder(d=6.5, h=top_height);
                    }
                    // right-front standoff
                    if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(corner_fillet/2)-(2*(wallthick+gap)),
                            depth-(corner_fillet/2)-(2*(wallthick+gap)),top_height+1]) cylinder(d=6.5, h=top_height);
                    }
                    // left-rear standoff
                    if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                        translate([(corner_fillet/2),(corner_fillet/2),top_height+1]) cylinder(d=6.5, h=top_height);
                    }
                    // left-front standoff
                    if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                        translate([+(corner_fillet/2),depth-(corner_fillet/2)-(2*(wallthick+gap)),
                            top_height+1]) cylinder(d=6.5, h=top_height+1);
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

                    if(class == "pcbhole" && id == pcb_id && 
                        (pcbhole_pos == "left_rear" || pcbhole_pos == "left_front" || pcbhole_pos == "right_rear" || pcbhole_pos == "right_front")) {
                        if (pcbhole_pos == "left_rear") {
                            normal_standoff = [top_standoff[0],
                                                top_height+pcb_loc_z+top_rear_left_adjust,
                                                top_standoff[2],
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_rear_left_support,
                                                top_standoff[8],
                                                top_standoff[9],
                                                top_standoff[10],
                                                top_standoff[11]];
                            translate([pcbhole_x,pcbhole_y,case_z]) standoff(normal_standoff);
                        }
                        if (pcbhole_pos == "left_front") {
                            normal_standoff = [top_standoff[0],
                                                top_height+pcb_loc_z+top_front_left_adjust,
                                                top_standoff[2],
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_front_left_support,
                                                top_standoff[8],
                                                top_standoff[9],
                                                top_standoff[10],
                                                top_standoff[11]];
                            translate([pcbhole_x,pcbhole_y,case_z]) standoff(normal_standoff);
                        }
                        if (pcbhole_pos == "right_rear") {
                            normal_standoff = [top_standoff[0],
                                                top_height+pcb_loc_z+top_rear_right_adjust,
                                                top_standoff[2],
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_rear_right_support,
                                                top_standoff[8],
                                                top_standoff[9],
                                                top_standoff[10],
                                                top_standoff[11]];
                            translate([pcbhole_x,pcbhole_y,case_z]) standoff(normal_standoff);
                        }
                        if (pcbhole_pos == "right_front") {
                            normal_standoff = [top_standoff[0],
                                                top_height+pcb_loc_z+top_front_right_adjust,
                                                top_standoff[2],
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_front_right_support,
                                                top_standoff[8],
                                                top_standoff[9],
                                                top_standoff[10],
                                                top_standoff[11]];
                            translate([pcbhole_x,pcbhole_y,case_z]) standoff(normal_standoff);
                        }
                    }
                }
            }
            // extended standoffs
            if(case_ext_standoffs == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(corner_fillet/2),(corner_fillet/2),case_z]) 
                        standoff(top_ext_standoff);
                }
                // right-front standoff    
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) 
                    || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(corner_fillet/2)-(2*(wallthick+gap)),
                            depth-(corner_fillet/2)-(2*(wallthick+gap)),case_z]) standoff(top_ext_standoff);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(corner_fillet/2),(corner_fillet/2),case_z]) standoff(top_ext_standoff);
                }
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(corner_fillet/2),depth-(corner_fillet/2)-(2*(wallthick+gap)),
                        case_z]) standoff(top_ext_standoff);
                }
            }
            // extended standoff sidewall support
            if(case_ext_standoffs == true && top_sidewall_support == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(corner_fillet/2)+(top_ext_standoff[0]/2)-.6,
                        (corner_fillet/2)-1,bottom_height]) cube([gap+adj+2,2,top_height]);
                }
                // right-front standoff    
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) 
                    || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(2*(wallthick+gap))-(corner_fillet/2)+(top_ext_standoff[0]/2)-.6,
                            depth-(corner_fillet/2)-(2*(wallthick+gap))-1,bottom_height])
                                cube([gap+adj+2,2,top_height]);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(corner_fillet/2)-(wallthick+gap)-(top_ext_standoff[0]/2)+.6,(corner_fillet/2)-1,
                        bottom_height]) cube([gap+adj+2,2,top_height]);
                }
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(corner_fillet/2)-(wallthick+gap)-(top_ext_standoff[0]/2)+.6,
                        depth-(corner_fillet/2)-(2*(wallthick+gap))-1, bottom_height]) 
                            cube([gap+adj+2,2,top_height]);
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
                if (class == "add2" && face == "top" && type == "standoff") {
                    parametric_move_sub("round",loc_x,loc_y,loc_z,face,rotation,parametric,[6.5,size_y,floorthick+1],data,mask);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "uart_holder") {
                    if(accessory_highlight == false) {
                        parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,[0,0,0],data,mask);
                    }
                    else {
                        #parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,[0,0,0],data,mask);
                    }
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "hc4_oled_holder") {
                    parametric_move_sub("rectangle",loc_x+1,loc_y+1.75,loc_z+26,face,rotation,
                        parametric,[26.5,wallthick+gap+4,14.5],[[.1,.1,.1,.1]],mask);
                }
                if ((class == "add1" || class == "add2") && face == "top" && type == "button") {
                    if(data[1] == "recess") {
                        parametric_move_sub("sphere",loc_x,loc_y,loc_z,face,rotation,
                            parametric,[size_x-1,size_y,size_z],data,mask);
                    }
                    if(data[1] == "cutout") {
                        parametric_move_sub("rectangle",loc_x+10,loc_y+4,loc_z-adj,face,rotation,
                            parametric,[size_x+2,size_y+1,size_z+2*adj],[[.1,.1,.1,.1]],mask);
                    }
                }
                if (class == "model" && face == "bottom" && type == "hk_boom" && 
                    rotation[0] == 90 && rotation[1] == 0 && rotation[2] == 0) {
                        parametric_move_sub("round",loc_x+11,loc_y-4,loc_z,face,[0,0,0],
                            parametric,[5,size_y,80],data,mask);
                        parametric_move_sub("slot",loc_x+37.5,loc_y-4.75,loc_z,face,[0,0,0],
                            parametric,[6,14,80],data,mask);
                }
            }
        }
        // sbc openings
        if(sbc_highlight == true) {
            #translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj]) 
                sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
        }
        else {
            translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj]) 
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
                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,size,data,mask);
            }
        }
    }
}
