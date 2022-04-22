/*
    SBC Models Copyright 2016,2017,2018,2019,2020 Edward A. Kisiel
    hominoid @ www.forum.odroid.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    Code released under GPLv3: http://www.gnu.org/licenses/gpl.html

    20190214 Version 1.0.0  SBC Model Framework
    20190218 Version 1.0.1  Added HK Odroid n2 as "n2"
    20200425 Version 1.0.2  Added AtomicPi as "atomicpi"
                            Added Nvidia JetsonNano as "jetsonnano"
                            Updated Odroid n2 sbc data
                            Updated Odroid h2 sbc data
                            Added Odroid c4 as"c4"
                            Added oem heatsinks
                            Added Odroid xu4q as "xu4q"
    20200725 Version 1.0.3  Added Odroid n2+ and heatsink
    20201021 Version 1.0.4  Added HK Odroid hc4 as "hc4"
    20220202 Version 1.0.5  Added HK Show2 as "show2"
    
    USE: sbc(model)
             model = "c1+","c2","c4","xu4","xu4q","mc1","hc1","hc4","n1","n2","n2+","h2"
                     "rpi3b+","a64","rock64","rockpro64","atomicpi","jetsonnano","show2"

*/

include <./sbc_models.cfg>
use <./sbc_library.scad>

module sbc(model) {
    sbc_model = [model];
    s = search(sbc_model,sbc_data);

    $fn=60;
    
    // pcb and holes
    // pcbsize_x, pcbsize_y, pcbsize_z, pcbcorner_radius, topmax_component_z, bottommax_component_z
    pcbsize_x = sbc_data[s[0]][1];
    pcbsize_y = sbc_data[s[0]][2];
    pcbsize_z = sbc_data[s[0]][3];
    pcbcorner_radius = sbc_data[s[0]][4];
    difference() {
        color("tan") pcb([pcbsize_x,pcbsize_y,pcbsize_z], pcbcorner_radius);
        // pcb mounting holes
        for (i=[7:3:36]) {
            pcb_hole_x = sbc_data[s[0]][i];
            pcb_hole_y = sbc_data[s[0]][i+1];
            pcb_hole_size = sbc_data[s[0]][i+2];
            
            if (pcb_hole_x!=0 && pcb_hole_y!=0) {
                translate([pcb_hole_x,pcb_hole_y,-1]) 
                    cylinder(d=pcb_hole_size, h=5);
            }
        }
    }

    // soc placement
    // soc1size_x, soc1size_y, soc1size_z, soc1loc_x, soc1loc_y, soc1loc_z, soc1_rotation, "soc1_side"
    for (i=[37:8:68]) {
        soc1size_x = sbc_data[s[0]][i];
        soc1size_y = sbc_data[s[0]][i+1];
        soc1size_z = sbc_data[s[0]][i+2];
        soc1loc_x = sbc_data[s[0]][i+3];
        soc1loc_y = sbc_data[s[0]][i+4];
        soc1loc_z = sbc_data[s[0]][i+5];
        soc1_rotation = sbc_data[s[0]][i+6];
        soc1_side = sbc_data[s[0]][i+7];
        
        if (soc1size_x!=0 && soc1size_y!=0) {            
            if (soc1_side == "top" ) {
                color("dimgray",1) 
                    translate([soc1loc_x,soc1loc_y,pcbsize_z]) 
                        rotate([0,0,-soc1_rotation]) 
                            cube([soc1size_x,soc1size_y,soc1size_z]);
            }
            if (soc1_side == "bottom") {               
                color("dimgray",1) 
                    translate([soc1loc_x,soc1loc_y,-pcbsize_z]) 
                        rotate([0,0,soc1_rotation]) 
                            cube([soc1size_x,soc1size_y,soc1size_z]);
            }
        }
    }
 
    // component placement loc_x, loc_y, rotation, "side", "type"    
    for (i=[69:6:len(sbc_data[s[0]])]) {   
        loc_x = sbc_data[s[0]][i];
        loc_y = sbc_data[s[0]][i+1];
        rotation = sbc_data[s[0]][i+2];
        side = sbc_data[s[0]][i+3];
        class = sbc_data[s[0]][i+4];
        type = sbc_data[s[0]][i+5];

        if (class == "memory") {
            if (loc_x!=0 || loc_y!=0) {
                memory(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }            
        }
        if (class == "switch") {
            if (loc_x!=0 || loc_y!=0) {
                switch(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }           
        }
        if (class == "button") {
            if (loc_x!=0 || loc_y!=0) {
                button(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }           
        }
        if (class == "plug") {
            if (loc_x!=0 || loc_y!=0) {
                plug(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }           
        }
        if (class == "usb2") {
            if (loc_x!=0 || loc_y!=0) {
                usb2(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }          
        }
        if (class == "usb3") {
            if (loc_x!=0 || loc_y!=0) {
                usb3(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }           
        }
        if (class == "network") {
            if (loc_x!=0 || loc_y!=0) {
                network(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }           
        }
        if (class == "video") {
            if (loc_x!=0 || loc_y!=0) {
                video(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }           
        }
        if (class == "fan") {
            if (loc_x!=0 || loc_y!=0) {
                fan(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }           
        }
        if (class == "gpio") {
            if (loc_x!=0 || loc_y!=0) {
                gpio(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }           
        }
        if (class == "audio") {
            if (loc_x!=0 || loc_y!=0) {
                audio(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }            
        }
        if (class == "storage") {
            if (loc_x!=0 || loc_y!=0) {
                storage(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }           
        }
        if (class == "combo") {
            if (loc_x!=0 || loc_y!=0) {
                combo(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }            
        }
        if (class == "jumper") {
            if (loc_x!=0 || loc_y!=0) {
                jumper(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }            
        }
        if (class == "ic") {
            if (loc_x!=0 || loc_y!=0) {
                ic(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }            
        }
        if (class == "misc") {
            if (loc_x!=0 || loc_y!=0) {
                misc(loc_x,loc_y,rotation,side,type,pcbsize_z);
            }   
        }   
        if (class == "heatsink") {
            if (loc_x!=0 || loc_y!=0) {
                heatsink(loc_x,loc_y,rotation,side,type,pcbsize_z,sbc_data[s[0]][39]);
            }   
        }   
    }
}   
  
