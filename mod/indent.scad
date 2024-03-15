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


           NAME: indent
    DESCRIPTION: creates case IO indents
           TODO: none

          USAGE: indent(loc_x, loc_y, loc_z, rotation, side, class, type, wallthick, gap, floorthick, pcb_z)

*/

module indent(loc_x, loc_y, loc_z, rotation, side, class, type, wallthick, gap, floorthick, pcb_z) {
    
    adj = .01;
    $fn=90;
    
    // hdmi indent
    if(class == "video" && type == "hdmi_a" && side == "top" && rotation == 0) {
        place(loc_x+2.375,-(wallthick+gap)+wallthick/2,loc_z+3.75,12,10,rotation,side) 
             rotate([90,0,0]) long_slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "top" && rotation == 90) {
        place(-gap-wallthick/2,loc_y,loc_z+3.75,12,10,rotation,side)
             rotate([90,0,0]) long_slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "top" && rotation == 180) {
        place(loc_x,depth-(wallthick+gap)-10-wallthick/2,loc_z+3.75,12,10,rotation,side)
             rotate([90,0,0]) long_slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "top" && rotation == 270) {
        place(width-(wallthick+gap)-10-wallthick/2,loc_y+2.375,loc_z+3.75,12,10,rotation,side)
             rotate([90,0,0]) long_slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "bottom" && rotation == 0) {
        place(loc_x,-(wallthick+gap)+wallthick/2,loc_z-pcb_z-3.75,12,10,rotation,side)
             rotate([90,0,0]) long_slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "bottom" && rotation == 90) {
        place(width-(wallthick+gap)-10-wallthick/2,loc_y,loc_z-5.25,12,10,rotation,side)
             rotate([90,0,0]) long_slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "bottom" && rotation == 180) {
        place(loc_x+2.375,depth-(wallthick+gap)-10-wallthick/2,loc_z-pcb_z-3.75,12,10,rotation,side)
             rotate([90,0,0]) long_slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "bottom" && rotation == 270) {
        place(-gap-wallthick/2,loc_y+1.75,loc_z-pcb_z-3.75,12,10,rotation,side)
             rotate([90,0,0]) long_slot(12,10,wallthick);
    }
    // hdmi micro indent
    if(class == "video" && type == "hdmi_micro" && rotation == 0 && side == "top") {
        place(loc_x-.5,-(wallthick+gap)+wallthick/2,loc_z+1.5,6,8,rotation,side) 
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y+1.5,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 180 && side == "top") {
        place(loc_x+1,depth-(wallthick+gap)-8-wallthick/2,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y-.75,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 0 && side == "bottom") {
        place(loc_x+1.5,-(wallthick+gap)+wallthick/2,loc_z-3,6,8,rotation,side) 
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 90 && side == "bottom") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+1.25,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);

    }
    if(class == "video" && type == "hdmi_micro" && rotation == 180 && side == "bottom") {
        place(loc_x-1,depth-(wallthick+gap)-8-wallthick/2,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 270 && side == "bottom") {
        place(-gap-wallthick/2,loc_y-.5,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    // hdmi mini indent
    if(class == "video" && type == "hdmi_mini" && rotation == 0 && side == "top") {
        place(loc_x+.5,loc_y-gap-wallthick/2+1,loc_z+1.5,6,10,rotation,side) 
            rotate([90,0,0]) long_slot(6,10,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 90 && side == "top") {
        place(loc_x-wallthick/2,loc_y+3.5,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);

    }
    if(class == "video" && type == "hdmi_mini" && rotation == 180 && side == "top") {
        place(loc_x+4.5,loc_y-wallthick/2,loc_z+1.5,6,10,rotation,side)
            rotate([90,0,0]) long_slot(6,10,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 270 && side == "top") {
        place(loc_x+wallthick/2,loc_y+1.5,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 0 && side == "bottom") {
        place(loc_x+4.5,loc_y-gap-wallthick/2+1,loc_z-3,6,10,rotation,side) 
            rotate([90,0,0]) long_slot(6,10,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 90 && side == "bottom") {
        place(loc_x+wallthick/2,loc_y+3.5,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);

    }
    if(class == "video" && type == "hdmi_mini" && rotation == 180 && side == "bottom") {
        place(loc_x+.5,loc_y-wallthick/2,loc_z-3,6,10,rotation,side)
            rotate([90,0,0]) long_slot(6,10,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 270 && side == "bottom") {
        place(loc_x-wallthick/2,loc_y+1.5,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    // power plug indent
    if(class == "power" && type == "pwr5.5_7.5x11.5" && rotation == 0 && side == "top") {
        place(loc_x+3.75,-(wallthick+gap)+wallthick/2,loc_z+6.25,10,10,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "power" && type == "pwr5.5_7.5x11.5" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y-6.25,loc_z+6.25,10,10,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "power" && type == "pwr5.5_7.5x11.5" && rotation == 180 && side == "top") {
        place(loc_x-6.5,depth-10-(wallthick+gap)-wallthick/2,loc_z+6.25,10,10,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "power" && type == "pwr5.5_7.5x11.5" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-10-wallthick/2,loc_y+3.75,loc_z+6.25,10,10,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "power" && type == "pwr2.5_5x7.5" && rotation == 0 && side == "top") {
        place(loc_x+2.75,-(wallthick+gap)+wallthick/2,loc_z+2.1,7,7,rotation,side) 
            rotate([90,0,0]) cylinder(d=7, h=wallthick);
    }
    if(class == "power" && type == "pwr2.5_5x7.5" && rotation == 90 && side == "top") {
        place(-(wallthick+gap)+wallthick/2,loc_y-4.5,loc_z+2,7,7,rotation,side) 
            rotate([90,0,0]) cylinder(d=7, h=wallthick);
    }
    if(class == "power" && type == "pwr2.5_5x7.5" && rotation == 180 && side == "top") {
        place(loc_x-4.5,depth-(wallthick+gap)-7-wallthick/2,loc_z+2,7,7,rotation,side) 
            rotate([90,0,0]) cylinder(d=7, h=wallthick);
    }
    if(class == "power" && type == "pwr2.5_5x7.5" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-7-wallthick/2,loc_y+2.5,loc_z+2,7,7,rotation,side) 
            rotate([90,0,0]) cylinder(d=7, h=wallthick);
    }
    // micro usb indent
    if(class == "usb2" && type == "micro" && rotation == 0 && side == "top") {
        place(loc_x-.5,-(wallthick+gap)+wallthick/2,loc_z+1.9,6,8,rotation,side) 
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y+1.5,loc_z+1.9,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);

    }
    if(class == "usb2" && type == "micro" && rotation == 180 && side == "top") {
        place(loc_x+1.5,depth-(wallthick+gap)-8-wallthick/2,loc_z+1.9,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y-.5,loc_z+1.9,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 0 && side == "bottom") {
        place(loc_x+1.5,-(wallthick+gap)+wallthick/2,loc_z-3.25,6,8,rotation,side) 
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 90 && side == "bottom") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+1.5,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);

    }
    if(class == "usb2" && type == "micro" && rotation == 180 && side == "bottom") {
        place(loc_x-.5,depth-(wallthick+gap)-8-wallthick/2,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 270 && side == "bottom") {
        place(-gap-wallthick/2,loc_y-.5,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    // single horizontal usbc indent
    if(class == "usbc" && type == "single_horizontal" && rotation == 0 && side == "top") {
        place(loc_x+.5,-(wallthick+gap)+wallthick/2,loc_z+1.75,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y+2.5,loc_z+1.75,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 180 && side == "top") {
        place(loc_x+2.5,depth-(wallthick+gap)-8-wallthick/2,loc_z+2,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+.5,loc_z+1.75,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 0 && side == "bottom") {
        place(loc_x+2.75,-(wallthick+gap)+wallthick/2,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 90 && side == "bottom") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+2.5,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick-(wallthick+gap)+wallthick/2);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 180 && side == "bottom") {
        place(loc_x+.5,depth-(wallthick+gap)-8-wallthick/2,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 270 && side == "bottom") {
        place(-gap-wallthick/2,loc_y+.5,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) long_slot(6,8,wallthick);
    }
    // audio jack indent
    if(class == "audio" && type == "jack_3.5" && rotation == 0 && side == "top") {
        place(loc_x+3.15,-(wallthick+gap)+wallthick/2,loc_z+2,8,8,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y-4.6,loc_z+2,8,8,rotation,side)
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 180 && side == "top") {
        place(loc_x-4.6,depth-(wallthick+gap)-8-wallthick/2,loc_z+2,8,8,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+3.15,loc_z+2,8,8,rotation,side)
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 0 && side == "bottom") {
        place(loc_x-4.6,-(wallthick+gap)+wallthick/2,loc_z-3.5,8,8,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 90 && side == "bottom") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y-4.6,loc_z-3.5,8,8,rotation,side)
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 180 && side == "bottom") {
        place(loc_x+3.15,depth-(wallthick+gap)-8-wallthick/2,loc_z-3.5,8,8,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 270 && side == "bottom") {
        place(-gap-wallthick/2,loc_y+3.15,loc_z-3.5,8,8,rotation,side)
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
}