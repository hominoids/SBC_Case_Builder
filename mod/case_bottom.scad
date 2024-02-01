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

    difference() {
        union() {
            difference() {
                union() {
                    if(case_design == "shell") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,bottom_height/2]) 
                                cube_fillet_inside([width,depth,bottom_height], 
                                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                        top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,(bottom_height/2)+floorthick]) 
                                    cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),bottom_height], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                            top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
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
                                vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                    top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                    }
                    if(case_design == "tray") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(bottom_height)/2]) 
                                cube_fillet_inside([width,depth,bottom_height], 
                                    vertical=[0,0,0,0], top=[0,0,0,0], 
                                        bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(bottom_height/2)+floorthick]) 
                                cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),bottom_height+adj], 
                                    vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                        top=[0,0,0,0],bottom=[2,2,2,2], $fn=90);
                        }
                        // right side nut
                        translate([width-wallthick-gap-wallthick-4+adj,wallthick+gap+10,
                                floorthick+3.4]) rotate([90,0,90]) 
                                    cylinder(d=10, h=4, $fn=6);
                        // left side nut
                        translate([-adj-gap,wallthick+gap+10,floorthick+3.4]) 
                            rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                        if(depth >= 75 && sbc_model != "visionfive2" && sbc_model != "visionfive2q" && 
                            sbc_model != "rock5b" && sbc_model != "rock5bq" && sbc_model != "rock5b-v1.3") {
                            translate([width-wallthick-gap-wallthick-4+adj,depth-wallthick-gap-10,
                                    floorthick+3.4]) rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                            translate([-adj-gap,depth-wallthick-gap-10,floorthick+3.4]) 
                                rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                        }
                        else {
                            if(sbc_model == "visionfive2" || sbc_model == "visionfive2q" || sbc_model == "rock5b" ||  
                                sbc_model == "rock5bq" || sbc_model == "rock5b-v1.3") {
                                translate([width-wallthick-gap-wallthick-4+adj,wallthick+gap+58,
                                        floorthick+3.4]) rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                                translate([-adj-gap,wallthick+gap+58,floorthick+3.4]) 
                                    rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                            }
                            else {
                                translate([width-wallthick-gap-wallthick-4+adj,wallthick+gap+40,
                                        floorthick+3.4]) rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                                translate([-adj-gap,wallthick+gap+40,floorthick+3.4]) 
                                    rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                            }
                        }
                        
                        // front panel
                        if(case_style == "sides" || case_style == "vu5" || case_style == "vu7") {
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
                                    top=0, bottom=fillet, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+floorthick]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=bottom_height+adj, r=(case_diameter/2)-lip/2, 
                                    top=0, bottom=fillet-1, $fn=case_fn, fillet_fn=case_ffn, center=true);
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
                                    r=(case_diameter/2)-lip/2,top=0,bottom=fillet-1, $fn=case_fn, 
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
                                        top=0, bottom=fillet, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+floorthick]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=bottom_height+adj,r=(case_diameter/2)-lip/2,top=0, 
                                        bottom=fillet-1,$fn=6,fillet_fn=case_ffn, center=true);
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
                                        r=(case_diameter/2)-lip/2,top=0, bottom=fillet-1, $fn=6, 
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
                                        top=0, bottom=fillet, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+floorthick]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=bottom_height+adj,r=(hex_diameter/2)-lip/2,top=0, 
                                        bottom=fillet-1,$fn=6,fillet_fn=case_ffn, center=true);
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
                                        r=(hex_diameter/2)-lip/2,top=0, bottom=fillet-1, $fn=6, 
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
                                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                        top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,floorthick+(floorthick+case_z)/2]) 
                                cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),case_z+floorthick], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                            top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
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
                                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                        top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,(case_z/2)+floorthick]) 
                                    cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),case_z], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                            top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            difference() {
                                translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-lip/2]) 
                                    cube_fillet_inside([width+adj,depth+adj,lip+adj], 
                                        vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                            top=[0,0,0,0],bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                                
                                translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-lip/2]) 
                                    cube_fillet_inside([width-wallthick,depth-wallthick,lip+adj], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],top=[0,0,0,0],
                                            bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            }
                        }
                    }
                    // additive accessories
                    if(accessory_name != "none") {
                        for (i=[1:15:len(accessory_data[a[0]])-1]) {
                            class = accessory_data[a[0]][i];
                            type = accessory_data[a[0]][i+1];
                            loc_x = accessory_data[a[0]][i+2];
                            loc_y = accessory_data[a[0]][i+3];
                            loc_z = accessory_data[a[0]][i+4];
                            face = accessory_data[a[0]][i+5];
                            rotation = accessory_data[a[0]][i+6];
                            parametric = accessory_data[a[0]][i+7];
                            size_x = accessory_data[a[0]][i+8];
                            size_y = accessory_data[a[0]][i+9];
                            size_z = accessory_data[a[0]][i+10];
                            data_1 = accessory_data[a[0]][i+11];
                            data_2 = accessory_data[a[0]][i+12];
                            data_3 = accessory_data[a[0]][i+13];
                            data_4 = accessory_data[a[0]][i+14];

                            if(class == "add1" && face == "bottom") {
                                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                                    size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                            }
                        }
                    }
                }
                // side attachment holes
                if(case_design == "tray") {
                    // right side bottom attachment holes
                    translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+10,
                        floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                    // right side bottom nut inset
                    translate([width-3.5-(2*wallthick)-gap-.6,wallthick+gap+10,
                        floorthick+3.4]) rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                    // left side bottom attachment holes
                    translate([-wallthick-gap-adj,wallthick+gap+10,floorthick+3.4]) rotate([0,90,0]) 
                            cylinder(d=3, h=10+sidethick+(2*adj));
                    // left side bottom nut inset
                    translate([-gap+.6,wallthick+gap+10,floorthick+3.4]) 
                        rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                    if(depth >= 75 && sbc_model != "visionfive2" && sbc_model != "visionfive2q" && 
                        sbc_model != "rock5b" && sbc_model != "rock5bq" && sbc_model != "rock5b-v1.3") {
                        translate([width-2*(wallthick+gap)-sidethick-adj,depth-wallthick-gap-10,
                            floorthick+3.4]) rotate([0,90,0]) 
                                cylinder(d=3, h=10+sidethick+(2*adj));
                        translate([-wallthick-gap-adj-6,depth-wallthick-gap-10,
                            floorthick+3.4]) rotate([0,90,0]) 
                                cylinder(d=3, h=10+sidethick+(2*adj));
                        translate([width-3.5-(2*wallthick)-gap-.6,depth-wallthick-gap-10,
                            floorthick+3.4])rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                        translate([-gap+.6,depth-wallthick-gap-10,floorthick+3.4]) 
                            rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                    }
                    else {
                        if(sbc_model == "visionfive2" || sbc_model == "visionfive2q" || sbc_model == "rock5b" ||  
                            sbc_model == "rock5bq" || sbc_model == "rock5b-v1.3") {
                            translate([width-3*(wallthick+gap)-adj,wallthick+gap+58,
                                floorthick+3.4]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                            translate([-wallthick-gap-adj-6,wallthick+gap+58,
                                floorthick+3.4]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                            translate([width-3.5-(2*wallthick)-gap-.6,wallthick+gap+58,
                                floorthick+3.4])rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                            translate([-gap+.6,wallthick+gap+58,floorthick+3.4]) 
                                rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                        }
                        else {
                            translate([width-3*(wallthick+gap)-adj,wallthick+gap+40,
                                floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                            translate([-wallthick-gap-adj-6,wallthick+gap+40,
                                floorthick+3.4]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                            translate([width-3.5-(2*wallthick)-gap-.6,wallthick+gap+40,
                                floorthick+3.4])rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                            translate([-gap+.6,wallthick+gap+40,floorthick+3.4]) 
                                rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                        }
                    }
                }
                // pcb standoff holes
                if(sbc_bottom_standoffs == true && bottom_standoff[5] != 4) {
                    for (i=[1:11:len(sbc_data[s[0]])-2]) {
                        class = sbc_data[s[0]][i+1];
                        type = sbc_data[s[0]][i+2];
                        id = sbc_data[s[0]][i+3];
                        pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                        pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                        pcbhole_z = sbc_data[s[0]][i+6];
                        pcbhole_size = sbc_data[s[0]][i+9][0];
                        pcbhole_pos = sbc_data[s[0]][i+10][4];

                        if(class == "pcbhole" && id == pcb_id && (pcbhole_pos == "left_rear" || pcbhole_pos == "left_front" || 
                            pcbhole_pos == "right_rear" || pcbhole_pos == "right_front")) {
                            translate([pcbhole_x,pcbhole_y,-1]) cylinder(d=6.5, h=bottom_height);
                        }
                    }
                }


                // extended standoff holes
                if(case_ext_standoffs == true) {
                    // right-rear standoff
                    if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                        translate([width-(2*(wallthick+gap))-(c_fillet/2),(c_fillet/2),-1]) cylinder(d=6.5, h=bottom_height);
                    }
                    // right-front standoff
                    if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(c_fillet/2)-(2*(wallthick+gap)),
                        depth-(c_fillet/2)-(2*(wallthick+gap)),-1]) cylinder(d=6.5, h=bottom_height);
                    }
                    // left-rear standoff
                    if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                        translate([(c_fillet/2),(c_fillet/2),-1]) cylinder(d=6.5, h=bottom_height);
                    }
                    // left-front standoff
                    if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                        translate([(c_fillet/2),depth-(c_fillet/2)-(2*(wallthick+gap)),-1]) 
                            cylinder(d=6.5, h=bottom_height);
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

                    if(class == "pcbhole" && id == pcb_id && (pcbhole_pos == "left_rear" || pcbhole_pos == "left_front" || 
                        pcbhole_pos == "right_rear" || pcbhole_pos == "right_front")) {
                        if (pcbhole_pos == "left_rear") {
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_rear_left,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_standoff[7],
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10]];
                            translate([pcbhole_x,pcbhole_y,0]) standoff(normal_standoff);
                        }
                        if (pcbhole_pos == "left_front") {
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_front_left,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_standoff[7],
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10]];
                            translate([pcbhole_x,pcbhole_y,0]) standoff(normal_standoff);
                        }
                        if (pcbhole_pos == "right_rear") {
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_rear_right,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_standoff[7],
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10]];
                            translate([pcbhole_x,pcbhole_y,0]) standoff(normal_standoff);
                        }
                        if (pcbhole_pos == "right_front") {
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_front_right,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_standoff[7],
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10]];
                            translate([pcbhole_x,pcbhole_y,0]) standoff(normal_standoff);
                        }
                    }
                }
            }

            // extended standoffs
            if(case_ext_standoffs == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2),(c_fillet/2),0]) standoff(bottom_ext_standoff);
                }
                // right-front standoff
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || width-pcb_loc_x-pcb_width >= 10) {
                    translate([width-(c_fillet/2)-(2*(wallthick+gap)),
                        depth-(c_fillet/2)-(2*(wallthick+gap)),0]) standoff(bottom_ext_standoff);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(c_fillet/2),(c_fillet/2),0]) standoff(bottom_ext_standoff);
                }
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(c_fillet/2),depth-(c_fillet/2)-(2*(wallthick+gap)),0]) 
                        standoff(bottom_ext_standoff);
                }
            }
            // standoff sidewall support
            if(sidewall_support == true && sbc_top_standoffs == true) {
                for (i=[1:11:len(sbc_data[s[0]])-2]) {
                    class = sbc_data[s[0]][i+1];
                    type = sbc_data[s[0]][i+2];
                    id = sbc_data[s[0]][i+3];
                    pcbhole_x = sbc_data[s[0]][i+4]+pcb_loc_x;
                    pcbhole_y = sbc_data[s[0]][i+5]+pcb_loc_y;
                    pcbhole_z = sbc_data[s[0]][i+6];
                    pcbhole_size = sbc_data[s[0]][i+9][0];
                    pcb_side_pos = sbc_data[s[0]][i+10][2];
                    pcbhole_pos = sbc_data[s[0]][i+10][4];
                    ex_stand = 0;

                    if (class == "pcbhole" && id == pcb_id && (pcbhole_pos == "left_rear" || pcbhole_pos == "left_front" || 
                        pcbhole_pos == "right_rear" || pcbhole_pos == "right_front")) {
                        ex_stand = pcbhole_pos == "left_rear" ? bottom_rear_left :
                                   pcbhole_pos == "left_front" ? bottom_front_left :
                                   pcbhole_pos == "right_rear" ? bottom_rear_right :
                                   pcbhole_pos == "right_front" ? bottom_front_right : 0;

                        if(pcb_side_pos == "rear") {
                            translate([pcbhole_x-1, pcbhole_y-(bottom_standoff[0]/2)-(gap-adj)-1.4, 0])
                                cube([2,gap+1.6,bottom_height-pcb_z+pcb_loc_z+ex_stand]);
                        }
                        if(pcb_side_pos == "front") {
                        translate([pcbhole_x-1, pcbhole_y+(bottom_standoff[0]/2)-.6+adj,0]) 
                            cube([2,gap+1.6,bottom_height-pcb_z+pcb_loc_z+ex_stand]);
                        }
                        if(pcb_side_pos == "left") {
                        translate([pcbhole_x-(bottom_standoff[0]/2)-2.4+adj,pcbhole_y-1,0]) 
                            cube([gap+1.6,2,bottom_height-pcb_z+pcb_loc_z+ex_stand]);
                        }
                        if(pcb_side_pos == "right") {
                        translate([pcbhole_x+(bottom_standoff[0]/2)-.6+adj,pcbhole_y-1,0]) 
                            cube([gap+1.6,2,bottom_height-pcb_z+pcb_loc_z+ex_stand]);
                        }
                    }
                }
            }
            // extended standoff sidewall support
            if(case_ext_standoffs == true && sidewall_support == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2)+(bottom_ext_standoff[0]/2)-.5,
                        (c_fillet/2)-1,0]) cube([gap+adj+2,2,bottom_ext_standoff[1]]);
                }
                // right-front standoff
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) 
                    || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(2*(wallthick+gap))-(c_fillet/2)+(bottom_ext_standoff[0]/2)-.5,
                            depth-(c_fillet/2)-(2*(wallthick+gap))-1,0])
                                cube([gap+adj+2,2,bottom_ext_standoff[1]]);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(c_fillet/2)-(wallthick+gap)-(bottom_ext_standoff[0]/2)+.6,
                        (c_fillet/2)-1,0]) cube([gap+adj+2,2,bottom_ext_standoff[1]]);
                }
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(c_fillet/2)-(wallthick+gap)-(bottom_ext_standoff[0]/2)+.6,
                        depth-(c_fillet/2)-(2*(wallthick+gap))-1,0]) 
                            cube([gap+adj+2,2,bottom_ext_standoff[1]]);
                }
            }
        }
        // subtractive accessories
        if(accessory_name != "none") {
            for (i=[1:15:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size_x = accessory_data[a[0]][i+8];
                size_y = accessory_data[a[0]][i+9];
                size_z = accessory_data[a[0]][i+10];
                data_1 = accessory_data[a[0]][i+11];
                data_2 = accessory_data[a[0]][i+12];
                data_3 = accessory_data[a[0]][i+13];
                data_4 = accessory_data[a[0]][i+14];

                if ((class == "sub" && face == "bottom") || class == "suball") {
                    if(accessory_highlight == false) {
                        parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                    else {
                        #parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);

                    }
                }
                // create openings for additive 
                if (class == "add2" && face == "bottom" && type == "standoff") {
                    parametric_move_sub("round",loc_x,loc_y,loc_z-.1,face,rotation,parametric,
                        6.5,size_y,floorthick+1,data_1,data_2,data_3,data_4);
                }
                if ((class == "add1" || class == "add2") && type == "uart_holder") {
                    if(accessory_highlight == false) {
                            parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,
                                0,0,0,data_1,data_2,data_3,data_4);
                    }
                    else {
                            #parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,
                                0,0,0,data_1,data_2,data_3,data_4);
                    }
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "hc4_oled_holder") {
                    parametric_move_sub("rectangle",loc_x+1,loc_y+1.75,loc_z+25.5,face,rotation,parametric,
                        26.5,wallthick+gap+4,15,data_1,data_2,data_3,[.1,.1,.1,.1]);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "access_port") {
                    if(data_3 == "landscape") {
                        if(rotation[2] == 180) {
                            parametric_move_sub("rectangle",loc_x-6+size_x,loc_y+.5+size_y,loc_z-adj,face,rotation,
                                parametric,size_x-17,size_y-1,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                            parametric_move_sub("rectangle",loc_x-size_x+12.5+size_x,loc_y-(size_y/2)+6+size_y,loc_z-adj,
                                face,rotation,parametric,5.5,10.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                        }
                        else {
                            parametric_move_sub("rectangle",loc_x+6,loc_y-.5,loc_z-adj,face,rotation,
                                parametric,size_x-17,size_y-1,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                            parametric_move_sub("rectangle",loc_x+size_x-12.5,loc_y+(size_y/2)-6,loc_z-adj,face,rotation,
                                parametric,5.5,10.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);

                        }
                    }
                    else {
                        if(rotation[2] == 180) {
                            if(data_3 == "portrait") {
                                parametric_move_sub("rectangle",loc_x+size_x-.5,loc_y+size_y-5.75,loc_z-adj,face,
                                    rotation,parametric,size_x-1,size_y-17,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                                parametric_move_sub("rectangle",loc_x-(size_x/2)+5+size_x,loc_y-size_y+12.5+size_y,
                                    loc_z-adj,face,rotation,parametric,10.5,5.5,floorthick+.12,data_1,data_2,data_3,
                                        [5.5,5.5,5.5,5.5]);
                            }
                            else {
                                parametric_move_sub("rectangle",loc_x-.5,loc_y-5.75,loc_z-adj,face,rotation,
                                    parametric,size_x-1,size_y-17,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                                parametric_move_sub("rectangle",loc_x-(size_x/2)+5,loc_y-size_y+12.5,loc_z-adj,face,
                                rotation,parametric,10.5,5.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                            }
                        }
                        else {
                            parametric_move_sub("rectangle",loc_x+.5,loc_y+5.75,loc_z-adj,face,rotation,
                                parametric,size_x-1,size_y-17,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                            parametric_move_sub("rectangle",loc_x+(size_x/2)-5,loc_y+size_y-12.5,loc_z-adj,face,rotation,
                                parametric,10.5,5.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                        }
                    }
                }
                if ((class == "model") && face == "bottom" && type == "h2_netcard") {
                    parametric_move_sub("rectangle",loc_x+25,loc_y-6,loc_z-14,face,rotation,
                        parametric,68.5,wallthick+3,14.5,data_1,data_2,data_3,[1,1,1,1]);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "button") {
                    if(data_3 == "recess") {
                        #parametric_move_sub("sphere",loc_x,loc_y,loc_z,face,rotation,
                            parametric,size_x-1,size_y,size_z,data_1,data_2,data_3,0);
                    }
                    if(data_3 == "cutout") {
                        parametric_move_sub("rectangle",loc_x+10,loc_y+4,loc_z-adj,face,rotation,
                            parametric,size_x+2,size_y+1,size_z+2*adj,data_1,data_2,data_3,[.1,.1,.1,.1]);
                    }
                }
            }
        }
        // sbc openings
        if(sbc_highlight == true) {
            #translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj]) sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
        }
        else {
            translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj]) sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
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
                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], top=[0,0,0,0], 
                            bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
        }
    }
    // additive accessories
    if(accessory_name != "none") {
        for (i=[1:15:len(accessory_data[a[0]])-1]) {
            class = accessory_data[a[0]][i];
            type = accessory_data[a[0]][i+1];
            loc_x = accessory_data[a[0]][i+2];
            loc_y = accessory_data[a[0]][i+3];
            loc_z = accessory_data[a[0]][i+4];
            face = accessory_data[a[0]][i+5];
            rotation = accessory_data[a[0]][i+6];
            parametric = accessory_data[a[0]][i+7];
            size_x = accessory_data[a[0]][i+8];
            size_y = accessory_data[a[0]][i+9];
            size_z = accessory_data[a[0]][i+10];
            data_1 = accessory_data[a[0]][i+11];
            data_2 = accessory_data[a[0]][i+12];
            data_3 = accessory_data[a[0]][i+13];
            data_4 = accessory_data[a[0]][i+14];

            if(class == "add2" && face == "bottom") {
                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                    size_x,size_y,size_z,data_1,data_2,data_3,data_4);
            }
        }
    }
}
