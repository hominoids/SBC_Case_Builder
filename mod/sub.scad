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


           NAME: sub
    DESCRIPTION: places subtractive objects 
           TODO: none

          USAGE: sub(type, loc_x, loc_y, loc_z, face, rotation, size_x, size_y, size_z, data_1, data_2, data_3, data_4)

                           type = 
                          loc_x = 
                          loc_y = 
                          loc_z = 
                           face = 
                       rotation = 
                        size[0] = size_x
                        size[1] = size_y
                        size[2] = size_z
                        data[0] = 
                        data[1] = 
                        data[2] = 

*/

module sub(type, loc_x, loc_y, loc_z, face, rotation, size_x, size_y, size_z, data_1, data_2, data_3, data_4) {

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
        translate([loc_x,loc_y,loc_z])  rotate(rotation) linear_extrude(height = size_z) text(data_3, size=data_1);
    }
    if(type == "art") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) art(data_1,data_2,data_3); 
    }
    if(type == "button") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) button(data_3,[size_x,size_y,size_z],data_4,data_1); 
    }
    if(type == "hd_holes") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hd_bottom_holes(data_1,data_3,"none","none",data_2);
    }    
    if(type == "hd_vertleft_holes") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hd_bottom_holes(data_1,data_3,"vertical","left",data_2);
    }    
    if(type == "hd_vertright_holes") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hd_bottom_holes(data_1,data_3,"vertical","right",data_2);
    }    
    if(type == "hk_fan_top") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hk_fan_top();
    }    
    if(type == "knockout") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) knockout(size_x,size_y,data_1,size_z,data_2,data_3);
    }    
    if(type == "fan") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) fan_mask(size_x, size_z, data_1);
    }
    if(type == "vent") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) vent(size_x,size_y,size_z,data_4,data_1,data_2,data_3);
    }
    if(type == "vent_hex") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) vent_hex(size_x,size_y,size_z,data_1,data_2,data_3);
    }
    if(type == "microusb") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) microusb_open();
    }
    if(type == "sphere") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) sphere(d=size_x);
    }
    if(type == "keyhole") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) keyhole(data_4, true); 
    }
    if(type == "h3_port_extender") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) h3_port_extender(data_3, true); 
    }
    if(type == "hk_pwr_button") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) hk_pwr_button(true); 
    }
    if(type == "dsub") {
        translate([loc_x,loc_y,loc_z]) rotate(rotation) dsub(data_4, true); 
    }
}
