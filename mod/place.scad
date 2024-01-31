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


           NAME: place
    DESCRIPTION: transformation to place objects on either side of a geometric plane of a given thickness
           TODO: none

          USAGE: place(x, y, z, size_x, size_y, rotation, side)

*/

/* placement module *must be first* for children() */
module place(x, y, z, size_x, size_y, rotation, side) {

    if (side == "top") {
        if (rotation == 0 || rotation == 90 || rotation == 180 || rotation == 270) {    
            if ((rotation >= 0 && rotation < 90) || (rotation < -270 && rotation > -360))
                translate([x,y,z]) rotate([0,0,-rotation]) children();

            if ((rotation >= 90 && rotation < 180) || (rotation < -180 && rotation >= -270))
                translate([x,y+size_x,z]) rotate([0,0,-rotation]) children();
           
            if ((rotation >= 180 && rotation < 270) || (rotation < -90 && rotation >= -180))
                translate([x+size_x,y+size_y,z]) rotate([0,0,-rotation]) children(0);
           
            if ((rotation >= 270 && rotation < 360) || (rotation < 0 && rotation >= -90))
                translate([x+size_y,y,z]) rotate([0,0,-rotation]) children(); }
        else {
            translate([x,y,z]) rotate([0,0,-rotation]) children();            
        }
    }   
    if (side == "bottom") {
        if (rotation == 0 || rotation == 90 || rotation == 180 || rotation == 270) {   
            if ((rotation >= 0 && rotation < 90) || (rotation < -270 && rotation > -360))
                translate([x+size_x,y,z]) rotate([0,180,rotation]) children();
           
            if ((rotation >= 90 && rotation < 180) || (rotation < -180 && rotation >= -270))
                translate([x+size_y,y+size_x,z]) rotate([0,180,rotation]) children();
               
            if ((rotation >= 180 && rotation < 270) || (rotation < -90 && rotation >= -180))
                translate([x,y+size_y,z]) rotate([0,180,rotation]) children();
           
            if ((rotation >= 270 && rotation < 360) || (rotation < 0 && rotation >= -90))
                translate([x,y,z]) rotate([0,180,rotation]) children(); }
        else {
            translate([x,y,z]) rotate([0,180,rotation]) children();
            
        }
    }    
    children([1:1:$children-1]);
}
