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


           NAME: case_side
    DESCRIPTION: creates case side for supported designs and styles
           TODO: none

          USAGE: case_side(case_design, side)

*/

module case_side(case_design, side) {
    
    difference() {
        union() {
            if(case_design == "panel") {
                if(side == "rear") {
                    difference() {
                        union() {
                            translate([-gap,-wallthick-gap,-floorthick]) 
                                cube([width-2*wallthick,wallthick,case_z+2*floorthick]);
                            // right hook
                            difference() {
                                translate([width-(2*wallthick)-gap-adj,-wallthick-gap,
                                    ((case_z)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([width-(2*wallthick)-gap-adj,-wallthick-gap-adj,
                                    ((case_z)/2)-4-adj]) 
                                        cube([wallthick+.25,wallthick+(2*adj),4.25]);
                            }
                            // left hook
                            difference() {
                                translate([-(2*wallthick)-gap-adj-.25,-wallthick-gap,
                                    ((case_z)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([-wallthick-gap-adj-.25,-wallthick-gap-adj,
                                    ((case_z)/2)-4-adj]) 
                                        cube([wallthick+.25,wallthick+(2*adj),4.25]);
                            }
                        }
                        // top slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),-wallthick-gap-adj,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,-wallthick-gap-adj,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        // bottom slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),-wallthick-gap-adj,-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,-wallthick-gap-adj,-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                    }
                }
                if(side == "front") {
                    difference() {
                        union() {
                            translate([-gap,depth-2*(wallthick)-gap,-floorthick]) 
                                cube([width-2*wallthick,wallthick,case_z+2*floorthick]);
                            // right hook
                            difference() {
                                translate([width-(2*wallthick)-gap-adj,depth-2*(wallthick)-gap-adj,
                                    ((case_z)/2)-4])
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([width-(2*wallthick)-gap-adj,
                                    depth-2*(wallthick)-adj-gap-adj,((case_z)/2)-4-adj])
                                        cube([wallthick+.25,wallthick+(2*adj),4.25]);
                            }
                            // left hook
                            difference() {
                                translate([-(2*wallthick)-gap-adj-.25,depth-2*(wallthick)-gap-adj,(
                                    (case_z)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([-wallthick-gap-adj-.25,depth-2*(wallthick)-adj-gap-adj,
                                    ((case_z)/2)-4-adj]) 
                                        cube([wallthick+.25,wallthick+(2*adj),4.25]);
                            }
                        }
                        // top slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),depth-2*wallthick-gap-adj,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,depth-2*wallthick-gap-adj,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        // bottom slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),depth-2*wallthick-gap-adj,-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,
                            depth-2*wallthick-gap-adj,-.25]) cube([8.5,wallthick+2*adj,floorthick+.5]);
                    }
                }
                if(side == "right") {
                    difference() {
                        translate([width-(2*wallthick)-gap,-(2*wallthick)-gap,-wallthick]) 
                            cube([wallthick,depth+2*wallthick,case_z+(2*wallthick)]);
                        translate([width-(2*wallthick)-gap-adj,-wallthick-gap-.25,
                            ((case_z)/2)]) cube([wallthick+2*adj,wallthick+.5,8.5]);
                        translate([width-(2*wallthick)-gap-adj,depth-2*(wallthick)-gap-.25,
                            ((case_z)/2)])
                                cube([wallthick+2*adj,wallthick+.5,8.5]);
                    }
                }
                if(side == "left") {
                    difference() {
                        translate([-wallthick-gap,-(2*wallthick)-gap,-wallthick]) 
                            cube([wallthick,depth+2*wallthick,case_z+(2*wallthick)]);
                        translate([-wallthick-gap-adj,-wallthick-gap-.25,((case_z)/2)])
                            cube([wallthick+2*adj,wallthick+.5,8.5]);
                        translate([-wallthick-gap-adj,depth-2*(wallthick)-gap-.25,
                            ((case_z)/2)])
                                cube([wallthick+2*adj,wallthick+.5,8.5]);
                    }
                }
            }
            if(case_design == "tray_sides") {
                if(side == "right") {
                    difference() {
                        union() {
                            translate([width-wallthick-gap,-(2*wallthick)-gap,0]) 
                                cube([sidethick,depth+2*wallthick,case_z+(2*wallthick)]);
                            translate([width-gap-wallthick-1+adj,depth-2*(wallthick+gap)-.5,case_z+(2*wallthick)-2]) 
                                cube([1,6,2]);
                            translate([width-gap-wallthick-1+adj,-2*(wallthick+gap)+1.5,case_z+(2*wallthick)-2]) 
                                cube([1,6,2]);
                            // top rail
                            translate([width-6.9-adj,-gap,case_z-floorthick-.5])
                                cube([4,depth-2*(wallthick+gap),2]);
                        }
                        // right side bottom attachment holes          
                        translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                        if(depth >= 75) {                        
                            translate([width-2*(wallthick+gap)-sidethick-adj,depth-wallthick-gap-10,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                        }
                        else {
                            translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+40,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                        }
                    }
                }
                if(side == "left") {
                    difference() {
                        union() {
                            translate([-wallthick-gap-sidethick,-(2*wallthick)-gap,0]) 
                                cube([sidethick,depth+2*wallthick,case_z+(2*wallthick)]);
                            translate([-gap-wallthick-adj,depth-2*(wallthick+gap)-.5,case_z+(2*wallthick)-2])
                                cube([1,6,2]);
                            translate([-gap-wallthick-adj,-2*(wallthick+gap)+1.5,case_z+(2*wallthick)-2]) 
                                cube([1,6,2]);
                            // top rail
                            translate([-wallthick-gap-adj,-gap,case_z-floorthick-.5]) 
                                cube([4,depth-2*(wallthick+gap),2]);
                        }
                        // left side bottom attachment holes
                        translate([-wallthick-gap-adj-5,wallthick+gap+10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                        if(depth >= 75) {
                            translate([-wallthick-gap-adj-6,depth-wallthick-gap-10,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                        }
                        else {
                            translate([-wallthick-gap-adj-6,wallthick+gap+40,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                        }
                    }
                }
            }
            if(case_design == "tray_vu5") {
                cheight = case_z+90;
                vesa = 75;
                vu_holder("vu5",side,vesa,cheight);
            }
            if(case_design == "tray_vu7") {
                cheight = case_z+122;
                vesa = 100;
                vu_holder("vu7",side,vesa,cheight);
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
                    
                    if (class == "add1" && face == side) {
                        parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,size,data,[false,mask[1],mask[2],mask[3]]);
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
                
                if ((class == "sub" && face == side) || class == "suball") {
                    if(accessory_highlight == false) {
                        parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            [size_x,size_y,size_z],data,mask);
                    }
                    else {
                        #parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            [size_x,size_y,size_z],data,mask);
                    }
                }
                // create openings for additive 
                if((class == "add1" || class == "add2" || class == "model") && mask[0] == true) {
                    if(accessory_highlight == false) {
                            parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,[size_x,size_y,size_z],data,mask);
                    }
                    else {
                            #parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,[size_x,size_y,size_z],data,mask);
                    }
                }
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
            
            if (class == "add2" && face == side) {
                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,size,data,[false,mask[1],mask[2],mask[3]]);
            }
        }
    }
}
