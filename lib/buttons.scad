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

    buttons(style, diameter, height, mask)
    button_assembly(style, diameter, height)
    button_clip(style)
    button_plunger(style, diameter, height)
    button_top(style, diameter, height)

*/


/*
           NAME: buttons
    DESCRIPTION: creates different button bodys and styles
           TODO: none

          USAGE: buttons(style, size, radius, post, mask)

                        style = "recess", "cutout"
                      size[0] = diameter of button body
                      size[2] = height above button
                       radius = radius for cutout style
                         post = button post size for cutout style
                      mask[0] = true enables component mask
                      mask[1] = mask length
                      mask[2] = mask setback
                      mask[3] = mstyle "default"
*/

module buttons(style, size, radius, post, mask) {

    size_x = size[0];
    size_y = size[1];
    size_z = size[2];
    diameter = size[0];
    height = size[2];
    gap = 1.5;
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true && mstyle == "default") {
        if(style == "recess") {
            translate([0, 0, -adj-msetback]) cylinder(d = diameter-2*adj, h = mlength);
        }
        if(style == "cutout") {
            translate([-size[0]+2.5, -2.5-size[1]/2, -adj-msetback]) cube([size[0]+1, size[1]+5, mlength]);
        }
    }
    if(enablemask == false) {
        if(style == "recess") {
            difference() {
                union() {
                    sphere(d=diameter);
                    translate([0,0,-height+3]) cylinder(d=6, h=height-6);
                }
                translate([-(diameter/2)-1,-(diameter/2)-1,0]) cube([diameter+2,diameter+2,(diameter/2)+2]);
                difference() {
                    union() {
                        sphere(d=diameter-2);
                    }
                }
                translate([-1.75, -1.25, -height-1]) cube([3.5, 2.5, height+2]);
                translate([0,0,-(diameter/2)]) cylinder(d=5, h=2);
            }
        }
        if(style == "cutout") {
            difference() {
                translate([-size[0]+2, -3-size[1]/2, 0]) slab_r([size[0]+2,size[1]+6,size[2]-2*adj], [.1,.1,.1,.1]);
                difference() {
                    translate([-size[0]+3, -size[1]/2, -adj]) 
                        slab_r([size[0],size[1],size[2]], [radius[0],radius[1],radius[2],radius[3]]);
                    translate([-size[0]+3+(gap/2), -size[1]/2+(gap/2), -1]) slab_r([size[0]-gap,size[1]-gap,1+size[2]+2*adj], 
                        [radius[0],radius[1],radius[2]-gap/2,radius[3]-gap/2]);
                    translate([3-size[0]-gap, -1, -1]) cube([gap*2, 2, 1+height+2*adj]);
                }
                translate([0, 0, 2]) sphere(d=3);
            }
            translate([0, 0, adj-post]) cylinder(d=3, h=post);
        }
    }
}


/*
           NAME: button_assembly
    DESCRIPTION: creates button assembly of plunger,top,clip
           TODO: none

          USAGE: button_assembly(style, diameter, height)

                                 style = "recess", "cutout"
                              diameter = diameter of button body
                                height = height above button
*/

module button_assembly(style, diameter, height) {

adj = .01;
$fn = 90;

    if(style == "recess") {
        button_plunger(style, diameter, height);
        button_top(style, diameter, height);
        translate([0,0,-height]) button_clip(style);
    }
}


/*
           NAME: button_clip
    DESCRIPTION: creates button c-clip
           TODO: none

          USAGE: button_clip(style)

                             style = "recess", "cutout"
*/

module button_clip(style) {

adj = .01;
$fn = 90;

    if(style == "recess") {
        difference() {
            cylinder(d=8.5, h=.8);
            translate([-1.5,-1.75,-adj]) cube([2.75,3.25,1]);
            translate([-.75,-.75,-adj]) cube([5,1.25,1.25]);
        }
    }
}


/*
           NAME: button_plunger
    DESCRIPTION: creates button plunger
           TODO: none

          USAGE: button_plunger(style, diameter, height)

                                style = "recess", "cutout"
                             diameter = diameter of button body
                               height = height above button
*/

module button_plunger(style, diameter, height) {

adj = .01;
$fn = 90;

    if(style == "recess") {
        difference() {
            translate([-1.5,-1,-(height)-2]) cube([3,2,height+1]);
            translate([-1.5-adj,-1.5,-height]) cube([.5,3,1]);
            translate([1+adj,-1.5,-height]) cube([.5,3,1]);
            translate([-1.5-adj,-1.5,-4]) cube([.5,3,4]);
            translate([1+adj,-1.5,-4]) cube([.5,3,4]);
        }
    }
}


/*
           NAME: button_top
    DESCRIPTION: creates button top
           TODO: none

          USAGE: button_top(style, diameter, height)

                                style = "recess", "cutout"
                             diameter = diameter of button body
                               height = height above button
*/

module button_top(style, diameter, height) {

adj = .01;
$fn = 90;

    if(style == "recess") {
        difference() {
            translate([0,0,-3]) cylinder(d=5, h=2.75);
            translate([-1.25,-1.25,-3-adj]) cube([2.5,2.5,2]);
        }
    }
}