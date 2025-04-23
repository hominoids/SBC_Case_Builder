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

          USAGE: sub(type, loc_x, loc_y, loc_z, face, rotation, size[], data[], mask[])

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

module sub(type, loc_x, loc_y, loc_z, face, rotation, size, data, mask) {

    size_x = size[0];
    size_y = size[1];
    size_z = size[2];
    enablemask = mask[0];
    mlen = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    if(type == "art") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) art(data[0],data[1],data[2]); 
    }
    if(type == "fan_mask") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) fan_mask(size_x, size_z, data[0]);
    }
    if(type == "hd_holes") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) hd_bottom_holes(data[0],data[1],data[2],data[3],data[4]);
    }    
    if(type == "knockout") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) knockout(size_x,size_y,data[0],size_z,data[1],data[2]);
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
    if(type == "text") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) linear_extrude(height = size_z) text(data_2, size=data[0]);
    }
    if(type == "vent") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) vent(size_x,size_y,size_z,data[3],data[0],data[1],data[2]);
    }
    if(type == "vent_hex") {
        translate([loc_x,loc_y,loc_z])  rotate(rotation) vent_hex(size_x,size_y,size_z,data[0],data[1],data[2]);
    }
}
