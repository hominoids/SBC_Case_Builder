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


           NAME: add
    DESCRIPTION: places additive objects 
           TODO: none

          USAGE: add(type, loc_x, loc_y, loc_z, face, rotation, size[], data[], mask[])

                         type = component type
                        loc_x = x location placement
                        loc_y = y location placement
                        loc_z = z location placement
                         face = "top", "bottom", "left", "right", "front", "rear"
                   rotation[] = object rotation
                 parametric[] = parametric movement array
                       size[] = size array x,y,z
                       data[] = data variable on type
                      mask[0] = true enables component mask
                      mask[1] = mask length
                      mask[2] = mask setback
                      mask[3] = mstyle "default"

*/

module add(type, loc_x, loc_y, loc_z, face, rotation, size, data, mask) {

    size_x = size[0];
    size_y = size[1];
    size_z = size[2];
    enablemask = mask[0];
    mlen = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    if(type == "access_cover") {
        if(rotation[2] == 180) {
            color("grey",1) translate([loc_x+size_x,loc_y+size_y,loc_z])  rotate(rotation) access_cover([size_x,size_y,size_z],data[0]);
        }
        else {
            color("grey",1) translate([loc_x,loc_y,loc_z]) rotate(rotation) access_cover([size_x,size_y,size_z],data[0]);
        }
    }
    if(type == "access_panel") {
        if(rotation[2] == 180) {
            translate([loc_x+size_x,loc_y+size_y,loc_z])  rotate(rotation) access_panel([size_x,size_y,size_z],data[0],mask);
        }
        else {
            translate([loc_x,loc_y,loc_z])  rotate(rotation) access_panel([size_x,size_y,size_z],data[0],mask);
        }
    }
    if(type == "art") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) art(data[0],data[1],data[2]); 
    }
    if(type == "batt_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) batt_holder(data[0]);
    }
    if(type == "button") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) buttons(data[0],[size_x,size_y,size_z],data[1],data[2],mask); 
    }
    if(type == "button_assembly") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) button_assembly(data[0],size_x,size_z); 
    }
    if(type == "fan_cover") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) fan_cover(size_x, size_z, data[0]);
    }
    if(type == "feet") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) feet(size_x, size_z);
    }
    if(type == "grommet") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) grommet(data[0], data[1], size_x, size_y, size_z, data[2], mask);
    }
    if(type == "hd_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd_mount(data[0],data[1],data[2],data[3]); 
    }
    if(type == "hk_boom_grill") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom_grill(data[0],size_z); 
    }
    if(type == "hk_boom_speaker_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom_speaker_holder(data[0],data[1]); 
    }
    if(type == "hk_boom_vring") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hk_boom_vring(data[0]);
    }
    if(type == "hk_h3_port_extender_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_h3_port_extender_holder(data[1],data[0]); 
    }
    if(type == "hk_hc4_oled_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_hc4_oled_holder(face, size_z, mask); 
    }
    if(type == "hk_uart_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_uart_holder(mask);
    }
    if(type == "hk_uart_strap") {
        color("grey",1) translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_uart_strap();
    }
    if(type == "keyhole") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) keyhole(data[0],mask); 
    }
    if(type == "nut_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) nut_holder(data[0], data[1], size_x, size_y, size_z, mask); 
    }
    if(type == "panel_clamp") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) panel_clamp(data[0], data[1], data[2], size_x, size_y, size_z, mask);
    }
    if(type == "pcb_holder") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) pcb_holder([size_x,size_y,size_z],data[0]);
    }
    if(type == "rectangle") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) slab_r([size_x,size_y,size_z],data[0]);
    }
    if(type == "round") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) cylinder(d=size_x,h=size_z);
    }
    if(type == "slot") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) slot(size_x,size_y,size_z);
    }
    if(type == "sphere") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) sphere(d=size_x);
    }
    if(type == "standoff") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) standoff(data[0], mask);
    }
    if(type == "text") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) linear_extrude(height = size_z) text(data[1], size=data[0]);
    }    
    if(type == "vent_panel_hex") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) vent_panel_hex(size_x, size_y, thick=size_z, 
            cell_size=data[0], cell_spacing=data[1], border=data[3], borders=data[2]);
    }

    // models
    if(type == "adafruit_2030_powerboost") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) adafruit_2030_powerboost(mask); 
    }
    if(type == "adafruit_4311_lcd") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) adafruit_4311_lcd(mask); 
    }
    if(type == "adafruit_4755_solar_charger") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) adafruit_4755_solar_charger(mask); 
    }
    if(type == "dsub") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) dsub(data[0], data[1], mask); 
    }
    if(type == "fan") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) fans(data[0],mask); 
    }
    if(type == "hd25") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd25(data[0],data[1],mask); 
    }
    if(type == "hd35") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hd35(data[0],mask); 
    }
    if(type == "hk_boom") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom(data[0],data[1],mask); 
    }
    if(type == "hk_boom_speaker") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom_speaker(mask); 
    }
    if(type == "hk_boom_speaker_pcb") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_boom_speaker_pcb(data[1],true,data[0],mask); 
    }
    if(type == "hk_h3_port_extender") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_h3_port_extender(data[0],mask); 
    }
    if(type == "hk_hc4_oled") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_hc4_oled(mask); 
    }
    if(type == "hk_lcd35") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_35lcd(mask); 
    }
    if(type == "hk_m1s_ups") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_m1s_ups(mask); 
    }
    if(type == "hk_netcard") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_netcard(mask); 
    }
    if(type == "hk_pwr_button") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_pwr_button(mask); 
    }
    if(type == "hk_speaker") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_speaker(mask); 
    }
    if(type == "hk_uart") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_uart(mask); 
    }
    if(type == "hk_vu7c") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_vu7c(data[0],data[1],mask); 
    }
    if(type == "hk_vu8m") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_vu8m(data[0],mask); 
    }
    if(type == "hk_vu8s") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_vu8s(mask); 
    }
    if(type == "hk_wb2") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_wb2(); 
    }
    if(type == "hk_xu4_shifter_shield") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_xu4_shifter_shield(mask); 
    }
    if(type == "pillar") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) pillar(data[0], 0, 0, 0, data[2], 0, size, data, 0, false, mask); 
    }
    if(type == "rpi_m2hat") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) rpi_m2hat(mask); 
    }
    if(type == "stl_model") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) stl_model(data[0],data[1]); 
    }
}
