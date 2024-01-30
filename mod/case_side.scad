

// case side
module case_side(case_design,case_style,side) {
    
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
            if(case_design == "tray" && case_style == "sides") {
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
            if(case_design == "tray" && case_style == "vu5") {
                cheight = case_z+90;
                vesa = 75;
                vu_holder(case_style,side,vesa,cheight);
            }
            if(case_design == "tray" && case_style == "vu7") {
                cheight = case_z+122;
                vesa = 100;
                vu_holder(case_style,side,vesa,cheight);
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
                    
                    if (class == "add1" && face == side) {
                        parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                }
            }
        }
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
                
                if ((class == "sub" && face == side) || class == "suball") {
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
                    parametric_move_sub("round",loc_x,loc_y,-.1,face,rotation,parametric,
                        6.5,size_y,floorthick+1,data_1,data_2,data_3,data_4);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "uart_holder") {
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
                    parametric_move_sub("rectangle",loc_x+1,loc_y+1.75,loc_z+25.5,face,rotation,
                        parametric,26.5,wallthick+gap+4,15,data_1,data_2,data_3,[.1,.1,.1,.1]);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "access_port") {
                    if(data_3 == "landscape") {
                        parametric_move_sub("rectangle",loc_x+6,loc_y-.5,loc_z-adj,face,rotation,
                            parametric,size_x-17,size_y-1,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                        parametric_move_sub("rectangle",loc_x+size_x-12.5,loc_y+(size_y/2)-6,loc_z-adj,face,rotation,
                            parametric,5.5,10.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                    }
                    else {
                        parametric_move_sub("rectangle",loc_x+.5,loc_y+5.75,loc_z-adj,face,rotation,parametric,
                            size_x-1,size_y-17,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                        parametric_move_sub("rectangle",loc_x+(size_x/2)-5,loc_y+size_y-12.5,loc_z-adj,face,rotation,
                            parametric,10.5,5.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]); 
                    }
                }
                if ((class == "model") && face == "bottom" && type == "h2_netcard") {
                    parametric_move_sub("rectangle",loc_x+25,loc_y-6,loc_z-14,face,rotation,
                        parametric,68.5,wallthick+3,14.5,data_1,data_2,data_3,[1,1,1,1]);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "button") {
                    if(data_3 == "recess") {
                    parametric_move_sub("sphere",loc_x,loc_y,loc_z,face,rotation,
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
    }
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
            
            if (class == "add2" && face == side) {
                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                    size_x,size_y,size_z,data_1,data_2,data_3,data_4);
            }
        }
    }
}
