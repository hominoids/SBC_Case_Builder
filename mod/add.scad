/*

    add(type,loc_x,loc_y,loc_z,size_x,size_y,size_z,rotation,face,side,case_z,data_1,data_2,data_3,data_4)

*/

/* addition module */
module add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4) {
    
    if(type == "rectangle") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) slab_r([size_x,size_y,size_z],data_4);
    }
    if(type == "round") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) cylinder(d=size_x,h=size_z);
    }
    if(type == "slot") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) slot(size_x,size_y,size_z);
    }
    if(type == "text") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) linear_extrude(height = size_z) text(data_3, size=data_1);
    }    
    if(type == "art") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) art(data_1,data_2,data_3); 
    }
    if(type == "button") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) button(data_3,[size_x,size_y,size_z],data_4,data_1); 
    }
    if(type == "button_top") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) button_assembly(data_3,size_x,size_z); 
    }
    if(type == "pcb_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) pcb_holder([size_x,size_y,size_z],data_1);
    }
    if(type == "batt_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) batt_holder(data_1);
    }
    if(type == "hk_uart_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_uart_holder();
    }
    if(type == "hk_uart_strap") {
        color("grey",1) translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_uart_strap();
    }
    if(type == "standoff") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) standoff(data_4);
    }
    if(type == "hd_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd_mount(data_1,data_3,"horizontal","none"); 
    }
    if(type == "hd_vertleft") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd_mount(data_1,data_3,"vertical","left"); 
    }
    if(type == "hd_vertright") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd_mount(data_1,data_3,"vertical","right"); 
    }
    if(type == "hd25") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd25(data_1); 
    }
    if(type == "hd35") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd35(); 
    }
    if(type == "hk_wb2") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_wb2(); 
    }
    if(type == "hc4_oled") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hc4_oled(); 
    }
    if(type == "hc4_oled_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hc4_oled_holder(face,size_z); 
    }
    if(type == "h2_netcard") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) h2_netcard(); 
    }
    if(type == "hk_lcd35") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk35_lcd(); 
    }
    if(type == "hk_m1s_ups") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_m1s_ups(); 
    }
    if(type == "hk_uart") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_uart(); 
    }
    if(type == "hk_vu7c") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_vu7c(data_1,data_2); 
    }
    if(type == "hk_boom") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom(data_1,data_3); 
    }
    if(type == "boom_speaker") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom_speaker(data_3,true,data_1); 
    }
    if(type == "boom_grill") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom_grill(data_3,size_z); 
    }
    if(type == "boom_speaker_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) boom_speaker_holder(data_1); 
    }
    if(type == "hk_speaker") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_speaker(); 
    }
    if(type == "fan_cover") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) fan_cover(size_x, size_z);
    }
    if(type == "vent_panel_hex") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) vent_panel_hex(x=size_x, y=size_y, thick=size_z, 
            cell_size=data_1, cell_spacing=data_2, border=data_4, borders=data_3);
    }
    if(type == "feet") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) feet(size_x, size_z);
    }
    if(type == "access_port") {
        if(rotation[2] == 180) {
            translate([loc_x+size_x,loc_y+size_y,loc_z])  rotate(rotation) access_port([size_x,size_y,size_z],data_3);
        }
        else {
            translate([loc_x,loc_y,loc_z])  rotate(rotation) access_port([size_x,size_y,size_z],data_3);
        }
    }
    if(type == "access_cover") {
        if(rotation[2] == 180) {
            color("grey",1) translate([loc_x+size_x,loc_y+size_y,loc_z])  rotate(rotation) access_cover([size_x,size_y,size_z],data_3);
        }
        else {
            color("grey",1) translate([loc_x,loc_y,loc_z]) rotate(rotation) access_cover([size_x,size_y,size_z],data_3);
        }
    }
    if(type == "boom_vring") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) boom_vring(data_1);
    }
    if(type == "h3_port_extender") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) h3_port_extender(data_3); 
    }
    if(type == "h3_port_extender_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) h3_port_extender_holder(data_3,data_1); 
    }
    if(type == "hk_pwr_button") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_pwr_button(); 
    }
    if(type == "keyhole") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) keyhole(data_4); 
    }
    if(type == "dsub") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) dsub(data_4); 
    }
    if(type == "nut_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) nut_holder(data_1, data_2, size_x, size_y, size_z); 
    }
    if(type == "standoff") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) standoff(data_4);
    }
}
