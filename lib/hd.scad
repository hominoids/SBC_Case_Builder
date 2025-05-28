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

    hd25(orientation, height, mask)
    hd25_tab(side)
    hd25_vtab(side)
    hd35(orientation, mask)
    hd35_25holder(length,width)
    hd35_tab(side)
    hd35_vtab(side)
    hd_bottom_holes(hd, orientation, side, thick, holetype)
    hd_mount(hd, orientation, position, side)

*/


/*
           NAME: hd25
    DESCRIPTION: creates 2.5" hard drive model
           TODO: none

          USAGE: hd25(orientation, height, mask)

                      orientation = "landscape", "portrait"
                           height = drive height
                          mask[0] = true enables component mask
                          mask[1] = mask length
                          mask[2] = mask setback
                          mask[3] = mstyle "default", "bottom", "side", "both"
*/

module hd25(orientation, height, mask) {

    hd25_x = 100;
    hd25_y = 69.85;
    hd25_z = height;
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        if(orientation == "landscape" && (mstyle == "side" || mstyle == "both" || mstyle == "default")) {
            translate([0, msetback, 0]) hd_holes(2.5, "landscape", "left", mlength);
            translate([0, -msetback, 0]) hd_holes(2.5, "landscape", "right", mlength);
        }
        if(orientation == "landscape" && (mstyle == "bottom" || mstyle == "both")) {
            translate([0, 0, msetback]) hd_holes(2.5, "landscape", "bottom", mlength);
        }
        if(orientation == "portrait" && (mstyle == "side" || mstyle == "both" || mstyle == "default")) {
            translate([msetback, 0, 0]) hd_holes(2.5, "portrait", "left", mlength);
            translate([-msetback, 0, 0]) hd_holes(2.5, "portrait", "right", mlength);
        }
        if(orientation == "portrait" && (mstyle == "bottom" || mstyle == "both")) {
            translate([0, 0, -mlength+msetback]) hd_holes(2.5, "portrait", "bottom", mlength);
        }
    }
    if(enablemask == false) {
        if(orientation == "landscape") {
            difference() {
                color("LightGrey",.6) cube([hd25_x,hd25_y,hd25_z]);

                // bottom screw holes
                color("Black",.6) translate([9.4,4.07,-adj]) cylinder(d=3,h=3);
                color("Black",.6) translate([86,4.07,-adj]) cylinder(d=3,h=3);
                color("Black",.6) translate([86,65.79,-adj]) cylinder(d=3,h=4);
                color("Black",.6) translate([9.4,65.79,-adj]) cylinder(d=3,h=4);

                // side screw holes
                color("Black",.6) translate([9.4,-adj,3]) rotate([-90,0,0]) cylinder(d=3,h=3);
                color("Black",.6) translate([86,-adj,3]) rotate([-90,0,0])  cylinder(d=3,h=3);
                color("Black",.6) translate([86,hd25_y+adj,3]) rotate([90,0,0])  cylinder(d=3,h=3);
                color("Black",.6) translate([9.4,hd25_y+adj,3]) rotate([90,0,0])  cylinder(d=3,h=3);

                // connector opening
                color("LightSlateGray",.6) translate([hd25_x-5,11,-1]) cube([5+adj,32,5+adj]);
            }
        }
        if(orientation == "portrait") {
            translate([0,hd25_x,0]) rotate([0,0,270])
                difference() {
                    color("LightGrey",.6) cube([hd25_x,hd25_y,hd25_z]);

                    // bottom screw holes
                    color("Black",.6) translate([9.4,4.07,-adj]) cylinder(d=3,h=3);
                    color("Black",.6) translate([86,4.07,-adj]) cylinder(d=3,h=3);
                    color("Black",.6) translate([86,65.79,-adj]) cylinder(d=3,h=4);
                    color("Black",.6) translate([9.4,65.79,-adj]) cylinder(d=3,h=4);

                    // side screw holes
                    color("Black",.6) translate([9.4,-adj,3]) rotate([-90,0,0]) cylinder(d=3,h=3);
                    color("Black",.6) translate([86,-adj,3]) rotate([-90,0,0])  cylinder(d=3,h=3);
                    color("Black",.6) translate([86,hd25_y+adj,3]) rotate([90,0,0])  cylinder(d=3,h=3);
                    color("Black",.6) translate([9.4,hd25_y+adj,3]) rotate([90,0,0])  cylinder(d=3,h=3);

                    // connector opening
                    color("LightSlateGray",.6) translate([hd25_x-5,11,-1]) cube([5+adj,32,5+adj]);
                }
        }
    }
}


/*
           NAME: hd25_tab
    DESCRIPTION: creates 2.5" hard drive tabs for horizontal mounting
           TODO: none

          USAGE: hd25_tab(side)

                          side = "left", "right"
*/

module hd25_tab(side) {

    width = 15;
    l_width = 26;
    depth = 15;
    height = 4;
    fillet = 2;
    hole = 3.6;
    length = 3;

    adj = .01;
    $fn = 90;

    if(side == "left") {
        difference() {
            union() {
                translate([0,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([-height,-depth/2,0]) cube([height,depth,height]);
                translate([adj,-5.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adj,7.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([4.07,0,-adj]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-height-adj,(width/2)-(length/2)-depth/2,3]) rotate([90,0,90]) slot(hole,length,height+(2*adj));
            translate([-height-adj,(width/2)-(length/2)-depth/2,21]) rotate([90,0,90]) slot(hole,length,height+(2*adj));
        }
    }
    if(side == "right") {
        difference() {
            union() {
                translate([height,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([0,-depth/2,0]) cube([height,depth,height]);
                translate([adj,-7.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adj,5.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([-4.07,0,-adj]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-adj,(width/2)-(length/2)-depth/2,3]) rotate([90,0,90]) slot(hole,length,height+(2*adj));
            translate([-adj,(width/2)-(length/2)-depth/2,21]) rotate([90,0,90]) slot(hole,length,height+(2*adj));
        }
    }
}


/*
           NAME: hd25_vtab
    DESCRIPTION: creates 2.5" hard drive tabs for vertical mounting
           TODO: none

          USAGE: hd25_vtab(side)

                           side = "left", "right"
*/

module hd25_vtab(side) {
    
    width = 15;
    l_width = 16;
    depth = 15;
    height = 4;
    fillet = 2;
    hole = 3.6;
    length = 3;

    adj = .01;
    $fn = 90;

    if(side == "left") {
        difference() {
            union() {
                translate([0,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([-height,-depth/2,0]) cube([height,depth,height]);
                translate([adj,-5.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adj,7.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([3,0,-adj]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-height-adj,1.5+(width/2)-(length/2)-depth/2,5.57]) rotate([90,90,90]) slot(hole,length,height+(2*adj));
        }
    }
    if(side == "right") {
        difference() {
            union() {
                translate([height,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([0,-depth/2,0]) cube([height,depth,height]);
                translate([adj,-7.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adj,5.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([-3,0,-adj]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-adj,1.5+(width/2)-(length/2)-depth/2,5.57]) rotate([90,90,90]) slot(hole,length,height+(2*adj));
        }
    }
}


/*
           NAME: hd35
    DESCRIPTION: creates 3.5" hard drive model
           TODO: none

          USAGE: hd35(orientation, mask)

                      orientation = "landscape", "portrait"
                          mask[0] = true enables component mask
                          mask[1] = mask length
                          mask[2] = mask setback
                          mask[3] = mstyle "default", "bottom", "side", "both"
*/

module hd35(orientation, mask) {
    
    hd35_x = 147;
    hd35_y = 101.6;
    hd35_z = 26.1;
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        if(orientation == "landscape" && (mstyle == "side" || mstyle == "both" || mstyle == "default")) {
            translate([0, msetback, 0]) hd_holes(3.5, "landscape", "left", mlength);
            translate([0, -msetback, 0]) hd_holes(3.5, "landscape", "right", mlength);
        }
        if(orientation == "landscape" && (mstyle == "bottom" || mstyle == "both")) {
            translate([0, 0, msetback]) hd_holes(3.5, "landscape", "bottom", mlength);
        }
        if(orientation == "portrait" && (mstyle == "side" || mstyle == "both" || mstyle == "default")) {
            translate([msetback, 0, 0]) hd_holes(3.5, "portrait", "left", mlength);
            translate([-msetback, 0, 0]) hd_holes(3.5, "portrait", "right", mlength);
        }
        if(orientation == "portrait" && (mstyle == "bottom" || mstyle == "both")) {
            translate([0, 0, -mlength+msetback]) hd_holes(3.5, "portrait", "bottom", mlength);
        }
    }
    if(enablemask == false) {
        if(orientation == "landscape") {
            difference() {
                color("LightGrey",.6) cube([hd35_x,hd35_y,hd35_z]);

                // bottom screw holes
                color("Black",.6) translate([29.52,3.18,-adj]) cylinder(d=3,h=3+adj);
                color("Black",.6) translate([61.27,3.18,-adj]) cylinder(d=3,h=3+adj);
                color("Black",.6) translate([105.72,3.18,-adj]) cylinder(d=3,h=3+adj);
                color("Black",.6) translate([29.52,98.43,-adj]) cylinder(d=3,h=3+adj);
                color("Black",.6) translate([61.27,98.43,-adj]) cylinder(d=3,h=3+adj);
                color("Black",.6) translate([105.72,98.43,-adj]) cylinder(d=3,h=3+adj);

                // side screw holes
                color("Black",.6) translate([16.9,-adj,6.35]) rotate([-90,0,0]) cylinder(d=3,h=3);
                color("Black",.6) translate([76.6,-adj,6.35]) rotate([-90,0,0])  cylinder(d=3,h=3);
                color("Black",.6) translate([118.5,-adj,6.35]) rotate([-90,0,0])  cylinder(d=3,h=3);
                color("Black",.6) translate([118.5,hd35_y+adj,6.35]) rotate([90,0,0]) cylinder(d=3,h=3);
                color("Black",.6) translate([76.6,hd35_y+adj,6.35]) rotate([90,0,0]) cylinder(d=3,h=3);
                color("Black",.6) translate([16.9,hd35_y+adj,6.35]) rotate([90,0,0]) cylinder(d=3,h=3);

                // connector opening
                color("LightSlateGray",.6) translate([hd35_x-5,11,-1]) cube([5+adj,32,5+adj]);
            }
        }
        if(orientation == "portrait") {
            translate([0,hd35_x,0]) rotate([0,0,270])
                difference() {
                    color("LightGrey",.6) cube([hd35_x,hd35_y,hd35_z]);

                    // bottom screw holes
                    color("Black",.6) translate([29.52,3.18,-adj]) cylinder(d=3,h=3+adj);
                    color("Black",.6) translate([61.27,3.18,-adj]) cylinder(d=3,h=3+adj);
                    color("Black",.6) translate([105.72,3.18,-adj]) cylinder(d=3,h=3+adj);
                    color("Black",.6) translate([29.52,98.43,-adj]) cylinder(d=3,h=3+adj);
                    color("Black",.6) translate([61.27,98.43,-adj]) cylinder(d=3,h=3+adj);
                    color("Black",.6) translate([105.72,98.43,-adj]) cylinder(d=3,h=3+adj);

                    // side screw holes
                    color("Black",.6) translate([16.9,-adj,6.35]) rotate([-90,0,0]) cylinder(d=3,h=3);
                    color("Black",.6) translate([76.6,-adj,6.35]) rotate([-90,0,0])  cylinder(d=3,h=3);
                    color("Black",.6) translate([118.5,-adj,6.35]) rotate([-90,0,0])  cylinder(d=3,h=3);
                    color("Black",.6) translate([118.5,hd35_y+adj,6.35]) rotate([90,0,0]) cylinder(d=3,h=3);
                    color("Black",.6) translate([76.6,hd35_y+adj,6.35]) rotate([90,0,0]) cylinder(d=3,h=3);
                    color("Black",.6) translate([16.9,hd35_y+adj,6.35]) rotate([90,0,0]) cylinder(d=3,h=3);

                    // connector opening
                    color("LightSlateGray",.6) translate([hd35_x-5,11,-1]) cube([5+adj,32,5+adj]);
                }
        }
    }
}


/*
           NAME: hd35_25holder
    DESCRIPTION: 3.5" hdd to 2.5" hdd holder
           TODO: none

          USAGE: hd35_25holder(length, width=101.6)

                      length = length of holder min. 145mm for 3.5" drive
*/

module hd35_25holder(length, width=101.6) {

    wallthick = 3;
    floorthick = 2;
    hd35_x = length;                    // 145mm for 3.5" drive
    hd35_y = width;
    hd35_z = 12;
    hd25_x = 100;
    hd25_y = 69.85;
    hd25_z = 9.5;
    hd25_xloc = 2;                     // or (hd35_x-hd25_x)/2
    hd25_yloc = (hd35_y-hd25_y)/2;
    hd25_zloc = 9.5;
    adj = .1;    
    $fn=90;

    difference() {
        union() {
            difference() {
                translate([(hd35_x/2),(hd35_y/2),(hd35_z/2)])
                    cube_fillet_inside([hd35_x,hd35_y,hd35_z], 
                        vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                translate([(hd35_x/2),(hd35_y/2),(hd35_z/2)+floorthick])
                    cube_fillet_inside([hd35_x-(wallthick*2),hd35_y-(wallthick*2),hd35_z], 
                        vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);

                // end trim
                translate([-adj,5,wallthick+2]) cube([wallthick+(adj*2),hd35_y-10,10]);
                translate([hd35_x-wallthick-adj,5,wallthick+2]) cube([wallthick+(adj*2),hd35_y-10,10]);

                // bottom vents
                for ( r=[15:40:hd35_x-40]) {
                    for (c=[hd35_y-76:4:75]) {
                        translate ([r,c,-adj]) cube([35,2,wallthick+(adj*2)]);
                    }
                }
            }
            // 2.5 hdd bottom support
            translate([9.4+hd25_xloc,4.07+hd25_yloc,floorthick-adj]) cylinder(d=8,h=4);
            translate([86+hd25_xloc,4.07+hd25_yloc,floorthick-adj]) cylinder(d=8,h=4);
            translate([86+hd25_xloc,65.79+hd25_yloc,floorthick-adj]) cylinder(d=8,h=4);
            translate([9.4+hd25_xloc,65.79+hd25_yloc,floorthick-adj]) cylinder(d=8,h=4);

        // side nut holder support    
        translate([16,wallthick-adj,7]) rotate([-90,0,0]) cylinder(d=10,h=3);
        translate([76,wallthick-adj,7]) rotate([-90,0,0])  cylinder(d=10,h=3);
            if(length >= 120) {
                translate([117.5,wallthick-adj,7]) rotate([-90,0,0])  cylinder(d=10,h=3);
                translate([117.5,hd35_y-wallthick+adj,7]) rotate([90,0,0])  cylinder(d=10,h=3);
            }
        translate([76,hd35_y-wallthick+adj,7]) rotate([90,0,0])  cylinder(d=10,h=3);
        translate([16,hd35_y-wallthick+adj,7]) rotate([90,0,0])  cylinder(d=10,h=3);
        
        // bottom-side support
        translate([wallthick,wallthick,floorthick-2]) rotate([45,0,0]) cube([hd35_x-(wallthick*2),3,3]);
        translate([wallthick,hd35_y-wallthick+adj,floorthick-2]) rotate([45,0,0]) cube([hd35_x-(wallthick*2),3,3]);

        }
        // bottom screw holes
        translate([9.4+hd25_xloc,4.07+hd25_yloc,-adj]) cylinder(d=3,h=(floorthick*3)+(adj*2));
        translate([86+hd25_xloc,4.07+hd25_yloc,-adj]) cylinder(d=3,h=(floorthick*3)+(adj*2));
        translate([86+hd25_xloc,65.79+hd25_yloc,-adj]) cylinder(d=3,h=(floorthick*3)+(adj*2));
        translate([9.4+hd25_xloc,65.79+hd25_yloc,-adj]) cylinder(d=3,h=(floorthick*3)+(adj*2));

         // countersink holes
        translate([9.4+hd25_xloc,4.07+hd25_yloc,-adj]) cylinder(d1=6.5, d2=3, h=3);
        translate([86+hd25_xloc,4.07+hd25_yloc,-adj]) cylinder(d1=6.5, d2=3, h=3);
        translate([86+hd25_xloc,65.79+hd25_yloc,-adj]) cylinder(d1=6.5, d2=3, h=3);
        translate([9.4+hd25_xloc,65.79+hd25_yloc,-adj]) cylinder(d1=6.5, d2=3, h=3);

        // side screw holes
        translate([16,-adj,7]) rotate([-90,0,0]) cylinder(d=3.6,h=7);
        translate([76,-adj,7]) rotate([-90,0,0])  cylinder(d=3.6,h=7);
        translate([117.5,-adj,7]) rotate([-90,0,0])  cylinder(d=3.6,h=7);
        translate([117.5,hd35_y+adj,7]) rotate([90,0,0])  cylinder(d=3.6,h=7);
        translate([76,hd35_y+adj,7]) rotate([90,0,0])  cylinder(d=3.6,h=7);
        translate([16,hd35_y+adj,7]) rotate([90,0,0])  cylinder(d=3.6,h=7);

        // side nut trap
        translate([16,wallthick-adj,7]) rotate([-90,0,0]) cylinder(r=3.30,h=5,$fn=6);
        translate([76,wallthick-adj,7]) rotate([-90,0,0])  cylinder(r=3.30,h=5,$fn=6);
        translate([117.5,wallthick-adj,7]) rotate([-90,0,0])  cylinder(r=3.30,h=5,$fn=6);
        translate([117.5,hd35_y-wallthick-adj,7]) rotate([90,0,0])  cylinder(r=3.30,h=5,$fn=6);
        translate([76,hd35_y-wallthick-adj,7]) rotate([90,0,0])  cylinder(r=3.30,h=5,$fn=6);
        translate([16,hd35_y-wallthick-adj,7]) rotate([90,0,0])  cylinder(r=3.30,h=5,$fn=6);
    }
}


/*
           NAME: hd35_tab
    DESCRIPTION: creates 3.5" hard drive tabs for horizontal mounting
           TODO: none

          USAGE: hd35_tab(side)

                          side = "left", "right"
*/

module hd35_tab(side) {

    width = 15;
    l_width = 46;
    depth = 15;
    height = 4;
    fillet = 2;
    hole = 3.6;
    length = 3;

    adj = .01;
    $fn = 90;

    if(side == "left") {
        difference() {
            union() {
                translate([0,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([-height,-depth/2,0]) cube([height,depth,height]);

                translate([adj,-5.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height+20],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adj,7.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height+20],
                                [-depth+4,-depth], 
                                [-height,-depth]]);

            }
            translate([3.18,0,-adj]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-height-adj,(width/2)-(length/2)-depth/2,6.35]) rotate([90,0,90]) slot(hole,length,height+(2*adj));
            translate([-height-adj,(width/2)-(length/2)-depth/2,38.35]) rotate([90,0,90]) slot(hole,length,height+(2*adj));
        }
    }
    if(side == "right") {
        difference() {
            union() {
                translate([height,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([0,-depth/2,0]) cube([height,depth,height]);

                translate([adj,-7.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height+20],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adj,5.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height+20],
                                [-depth+4,-depth], 
                                [-height,-depth]]);

            }
            translate([-3.18,0,-adj]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-adj,(width/2)-(length/2)-depth/2,6.35]) rotate([90,0,90]) slot(hole,length,height+(2*adj));
            translate([-adj,(width/2)-(length/2)-depth/2,38.35]) rotate([90,0,90]) slot(hole,length,height+(2*adj));
        }
    }
}


/*
           NAME: hd35_vtab
    DESCRIPTION: creates 3.5" hard drive tabs for vertical mounting
           TODO: none

          USAGE: hd35_vtab(side)

                           side = "left", "right"
*/

module hd35_vtab(side) {

    width = 15;
    l_width = 16;
    depth = 15;
    height = 4;
    fillet = 2;
    hole = 3.6;
    length = 3;

    adj = .01;
    $fn = 90;
    if(side == "left") {
        difference() {
            union() {
                translate([0,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([-height,-depth/2,0]) cube([height,depth,height]);
                translate([adj,-5.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adj,7.5,depth]) 
                    rotate([90,0,0]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([3,0,-adj]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-height-adj,1.5+(width/2)-(length/2)-depth/2,5.57]) rotate([90,90,90]) slot(hole,length,height+(2*adj));
        }
    }
    if(side == "right") {
        difference() {
            union() {
                translate([height,-depth/2,0]) rotate([0,-90,0]) 
                    slab_r([l_width,depth,height], [fillet,fillet,fillet,fillet]);
                translate([0,-depth/2,0]) cube([height,depth,height]);
                translate([adj,-7.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
                translate([adj,5.5,depth]) 
                    rotate([90,0,180]) 
                        linear_extrude(height = 2) 
                            polygon(points = [ [-height,height-5],
                                [-depth+4,-depth], 
                                [-height,-depth]]);
            }
            translate([-3,0,-adj]) rotate([0,0,0]) cylinder(d=hole, h=3);
            translate([-adj,1.5+(width/2)-(length/2)-depth/2,5.57]) rotate([90,90,90]) slot(hole,length,height+(2*adj));
        }
    }
}


/*
           NAME: hd_holes
    DESCRIPTION: creates 2.5" and 3.5" hard drive hole mask for mounting
           TODO: none

          USAGE: hd_holes(hd, orientation, side, thick, holetype)

                                 hd = 2.5, 3.5
                        orientation = "portrait", "landscape"
                               side = "left", "right", "both", "bottom", "all"
                              thick = floor thickness
                           holetype = "hole", "slot"
*/

module hd_holes(hd=3.5, orientation="portrait", side="all", thick=2, holetype="slot") {

    hd25_x = 100;
    hd25_y = 69.85;
    hd35_x = 147;
    hd35_y = 101.6;
    hd35_z = 26.1;
    hole_size = 3.2;
    hole_len = 3 * hole_size;
    slot_size = [hole_size, hole_len, thick];
    adj = .01;
    $fn = 90;

    if(hd == 2.5) {
        if(orientation == "portrait") {
            translate([0,hd25_x,0]) rotate([0,0,270]) union() {
                if(side == "left" || side == "both" || side == "all") {
                    if(holetype == "hole") {
                        translate([9.4,-thick,3]) rotate([270,0,0]) cylinder(d=hole_size,h=thick);
                        translate([86,-thick,3]) rotate([270,0,0]) cylinder(d=hole_size,h=thick);
                    }
                    if(holetype == "slot") {
                        translate([9.4-(1.5*hole_size),-thick,3]) rotate([270,0,0]) 
                            slot(hole_size, hole_len, thick);
                        translate([86-(1.5*hole_size),-thick,3]) rotate([270,0,0]) 
                            slot(hole_size, hole_len, thick);
                    }
                }
                if(side == "right" || side == "both" || side == "all") {
                    if(holetype == "hole") {
                        translate([9.4,hd25_y+thick,3]) rotate([90,0,0]) cylinder(d=hole_size,h=thick);
                        translate([86,hd25_y+thick,3]) rotate([90,0,0]) cylinder(d=hole_size,h=thick);
                    }
                    if(holetype == "slot") {
                        translate([9.4-(1.5*hole_size),hd25_y+thick,3]) rotate([90,0,0]) 
                            slot(hole_size, hole_len, thick);
                        translate([86-(1.5*hole_size),hd25_y+thick,3]) rotate([90,0,0]) 
                            slot(hole_size, hole_len, thick);
                    }
                }
                if(side == "bottom" || side == "all") {
                    if(holetype == "hole") {
                        translate([9.4,4.07,0]) cylinder(d=hole_size,h=thick);
                        translate([86,4.07,0]) cylinder(d=hole_size,h=thick);
                        translate([86,65.79,0]) cylinder(d=hole_size,h=thick);
                        translate([9.4,65.79,0]) cylinder(d=hole_size,h=thick);
                    }
                    if(holetype == "slot") {
                        translate([9.4-(1.5*hole_size),4.07,0]) slot(hole_size, hole_len, thick);
                        translate([86-(1.5*hole_size),4.07,0]) slot(hole_size, hole_len, thick);
                        translate([86-(1.5*hole_size),65.79,0]) slot(hole_size, hole_len, thick);
                        translate([9.4-(1.5*hole_size),65.79,0]) slot(hole_size, hole_len, thick);
                    }
                }
            }
        }
        if(orientation == "landscape") {
            if(side == "left" || side == "both" || side == "all") {
                if(holetype == "hole") {
                    translate([9.4,-thick,3]) rotate([270,0,0]) cylinder(d=hole_size,h=thick);
                    translate([86,-thick,3]) rotate([270,0,0]) cylinder(d=hole_size,h=thick);
                }
                if(holetype == "slot") {
                    translate([9.4-(1.5*hole_size),-thick,3]) rotate([270,0,0]) 
                        slot(hole_size, hole_len, thick);
                    translate([86-(1.5*hole_size),-thick,3]) rotate([270,0,0]) 
                        slot(hole_size, hole_len, thick);
                }
            }
            if(side == "right" || side == "both" || side == "all") {
                if(holetype == "hole") {
                    translate([9.4,hd25_y+thick,3]) rotate([90,0,0]) cylinder(d=hole_size,h=thick);
                    translate([86,hd25_y+thick,3]) rotate([90,0,0]) cylinder(d=hole_size,h=thick);
                }
                if(holetype == "slot") {
                    translate([9.4-(1.5*hole_size),hd25_y+thick,3]) rotate([90,0,0]) 
                        slot(hole_size, hole_len, thick);
                    translate([86-(1.5*hole_size),hd25_y+thick,3]) rotate([90,0,0]) 
                        slot(hole_size, hole_len, thick);
                }
            }
            if(side == "bottom" || side == "all") {
                if(holetype == "hole") {
                    translate([9.4,4.07,-thick]) cylinder(d=hole_size,h=thick);
                    translate([86,4.07,-thick]) cylinder(d=hole_size,h=thick);
                    translate([86,65.79,-thick]) cylinder(d=hole_size,h=thick);
                    translate([9.4,65.79,-thick]) cylinder(d=hole_size,h=thick);
                }
                if(holetype == "slot") {
                    translate([9.4-(1.5*hole_size),4.07,-thick]) slot(hole_size, hole_len, thick);
                    translate([86-(1.5*hole_size),4.07,-thick]) slot(hole_size, hole_len, thick);
                    translate([86-(1.5*hole_size),65.79,-thick]) slot(hole_size, hole_len, thick);
                    translate([9.4-(1.5*hole_size),65.79,-thick]) slot(hole_size, hole_len, thick);
                }
            }
        }
    }
    if(hd == 3.5) {
        if(orientation == "portrait") {
            translate([0,hd35_x,0]) rotate([0,0,270]) union() {
                if(side == "left" || side == "both" || side == "all") {
                    if(holetype == "hole") {
                        translate([16.9,-thick,6.35]) rotate([270,0,0]) cylinder(d=hole_size,h=thick);
                        translate([76.6,-thick,6.35]) rotate([270,0,0])  cylinder(d=hole_size,h=thick);
                        translate([118.5,-thick,6.35]) rotate([270,0,0])  cylinder(d=hole_size,h=thick);
                    }
                    if(holetype == "slot") {
                        translate([16.9-(1.5*hole_size),-thick,6.35]) rotate([270,0,0]) 
                            slot(hole_size, hole_len, thick);
                        translate([76.6-(1.5*hole_size),-thick,6.35]) rotate([270,0,0])  
                            slot(hole_size, hole_len, thick);
                        translate([118.5-(1.5*hole_size),-thick,6.35]) rotate([270,0,0]) 
                            slot(hole_size, hole_len, thick);
                    }
                }
                if(side == "right" || side == "both" || side == "all") {
                    if(holetype == "hole") {
                        translate([118.5,hd35_y+thick,6.35]) rotate([90,0,0]) cylinder(d=hole_size,h=thick);
                        translate([76.6,hd35_y+thick,6.35]) rotate([90,0,0]) cylinder(d=hole_size,h=thick);
                        translate([16.9,hd35_y+thick,6.35]) rotate([90,0,0]) cylinder(d=hole_size,h=thick);
                    }
                    if(holetype == "slot") {
                        translate([118.5-(1.5*hole_size),hd35_y+thick,6.35]) rotate([90,0,0]) 
                           slot(hole_size, hole_len, thick);
                        translate([76.6-(1.5*hole_size),hd35_y+thick,6.35]) rotate([90,0,0]) 
                           slot(hole_size, hole_len, thick);
                        translate([16.9-(1.5*hole_size),hd35_y+thick,6.35]) rotate([90,0,0]) 
                           slot(hole_size, hole_len, thick);
                    }
                }
                if(side == "bottom" || side == "all") {
                    if(holetype == "hole") {
                        translate([29.52,3.18,0]) cylinder(d=hole_size,h=thick);
                        translate([61.27,3.18,0]) cylinder(d=hole_size,h=thick);
                        translate([105.72,3.18,0]) cylinder(d=hole_size,h=thick);
                        translate([29.52,98.43,0]) cylinder(d=hole_size,h=thick);
                        translate([61.27,98.43,0]) cylinder(d=hole_size,h=thick);
                        translate([105.72,98.43,0]) cylinder(d=hole_size,h=thick);
                    }
                    if(holetype == "slot") {
                        translate([29.52-(1.5*hole_size),3.18,0]) slot(hole_size, hole_len, thick);
                        translate([61.27-(1.5*hole_size),3.18,0]) slot(hole_size, hole_len, thick);
                        translate([105.72-(1.5*hole_size),3.18,0]) slot(hole_size, hole_len, thick);
                        translate([29.52-(1.5*hole_size),98.43,0]) slot(hole_size, hole_len, thick);
                        translate([61.27-(1.5*hole_size),98.43,0]) slot(hole_size, hole_len, thick);
                        translate([105.72-(1.5*hole_size),98.43,0]) slot(hole_size, hole_len, thick);
                    }
                }
            }
        }
        if(orientation == "landscape") {
            if(side == "left" || side == "both" || side == "all") {
                if(holetype == "hole") {
                    translate([16.9,-thick,6.35]) rotate([270,0,0]) cylinder(d=3,h=thick);
                    translate([76.6,-thick,6.35]) rotate([270,0,0])  cylinder(d=3,h=thick);
                    translate([118.5,-thick,6.35]) rotate([270,0,0])  cylinder(d=3,h=thick);
                }
                if(holetype == "slot") {
                    translate([16.9-(1.5*hole_size),-thick,6.35]) rotate([270,0,0]) 
                        slot(hole_size, hole_len, thick);
                    translate([76.6-(1.5*hole_size),-thick,6.35]) rotate([270,0,0]) 
                        slot(hole_size, hole_len, thick);
                    translate([118.5-(1.5*hole_size),-thick,6.35]) rotate([270,0,0]) 
                        slot(hole_size, hole_len, thick);
                }
            }
            if(side == "right" || side == "both" || side == "all") {
                if(holetype == "hole") {
                    translate([118.5,hd35_y+thick,6.35]) rotate([90,0,0]) cylinder(d=3,h=thick);
                    translate([76.6,hd35_y+thick,6.35]) rotate([90,0,0]) cylinder(d=3,h=thick);
                    translate([16.9,hd35_y+thick,6.35]) rotate([90,0,0]) cylinder(d=3,h=thick);
                }
                if(holetype == "slot") {
                    translate([118.5-(1.5*hole_size),hd35_y+thick,6.35]) rotate([90,0,0]) 
                        slot(hole_size, hole_len, thick);
                    translate([76.6-(1.5*hole_size),hd35_y+thick,6.35]) rotate([90,0,0]) 
                        slot(hole_size, hole_len, thick);
                    translate([16.9-(1.5*hole_size),hd35_y+thick,6.35]) rotate([90,0,0]) 
                        slot(hole_size, hole_len, thick);
                }
            }
            if(side == "bottom" || side == "all") {
                if(holetype == "hole") {
                    translate([29.52,3.18,-thick]) cylinder(d=3.6,h=thick);
                    translate([61.27,3.18,-thick]) cylinder(d=3.6,h=thick);
                    translate([105.72,3.18,-thick]) cylinder(d=3.6,h=thick);
                    translate([29.52,98.43,-thick]) cylinder(d=3.6,h=thick);
                    translate([61.27,98.43,-thick]) cylinder(d=3.6,h=thick);
                    translate([105.72,98.43,-thick]) cylinder(d=3.6,h=thick);
                }
                if(holetype == "slot") {
                    translate([29.52-(1.5*hole_size),3.18,-thick]) slot(hole_size, hole_len, thick);
                    translate([61.27-(1.5*hole_size),3.18,-thick]) slot(hole_size, hole_len, thick);
                    translate([105.72-(1.5*hole_size),3.18,-thick]) slot(hole_size, hole_len, thick);
                    translate([29.52-(1.5*hole_size),98.43,-thick]) slot(hole_size, hole_len, thick);
                    translate([61.27-(1.5*hole_size),98.43,-thick]) slot(hole_size, hole_len, thick);
                    translate([105.72-(1.5*hole_size),98.43,-thick]) slot(hole_size, hole_len, thick);
                }
            }
        }
    }
}


/*
           NAME: hd_mount
    DESCRIPTION: creates 2.5" and 3.5" hard drive mounts
           TODO: none

          USAGE: hd_mount(hd, orientation, position, side)

                          hd = 2.5, 3.5
                 orientation = "portrait", "landscape"
                    position = "vertical", "horizontal"
                        side = "left", "right"
*/

module hd_mount(hd, orientation, position, side) {

    adj = .01;
    $fn = 90;

    if(hd == 2.5) {
        if(orientation == "portrait") {
            if(position == "vertical") {
                if(side == "left") {
                    translate([0,14,0]) rotate([0,0,0]) hd25_vtab("right");
                    translate([0,90.6,0]) rotate([0,0,0]) hd25_vtab("right");
                }
                else {  // right
                    translate([0,14,0]) rotate([0,0,0]) hd25_vtab("left");
                    translate([0,90.6,0]) rotate([0,0,0]) hd25_vtab("left");
                }
            }
            else {
                translate([-.5,14,0]) hd25_tab("left");
                translate([-.5,90.6,0]) hd25_tab("left");
                translate([70.35,14,0]) hd25_tab("right");
                translate([70.35,90.6,0]) hd25_tab("right");
            }
        }
        if(orientation == "landscape") {
            if(position == "vertical") {
                if(side == "left") {
                    translate([9.4,0,0]) rotate([0,0,90]) hd25_vtab("right");
                    translate([86,0,0])  rotate([0,0,90]) hd25_vtab("right");
                }
                else {  // right
                    translate([9.4,0,0]) rotate([0,0,90]) hd25_vtab("left");
                    translate([86,0,0])  rotate([0,0,90]) hd25_vtab("left");
                }
            }
            else {
                translate([9.4,4.07-4.5,0]) rotate([0,0,90]) hd25_tab("left");
                translate([86,4.07-4.5,0])  rotate([0,0,90]) hd25_tab("left");
                translate([86,65.79+4.5,0]) rotate([0,0,90]) hd25_tab("right");
                translate([9.4,65.79+4.5,0]) rotate([0,0,90]) hd25_tab("right");
            }
        }
    }
    if(hd == 3.5) {
        if(orientation == "portrait") {
            if(position == "vertical") {
                if(side == "left") {
                    translate([0,41.28,0]) rotate([0,0,0]) hd35_vtab("right");
                    translate([0,41.28+44.45,0]) rotate([0,0,0]) hd35_vtab("right");
                    translate([0,41.28+76.20,0]) rotate([0,0,0]) hd35_vtab("right");
                }
                else {  // right
                    translate([0,41.28,0]) rotate([0,0,0]) hd35_vtab("left");
                    translate([0,41.28+44.45,0]) rotate([0,0,0]) hd35_vtab("left");
                    translate([0,41.28+76.20,0]) rotate([0,0,0]) hd35_vtab("left");
                }
            }
            else {
                translate([-.5,28.5,0]) hd35_tab("left");
                translate([-.5,69.75,0]) hd35_tab("left");
                translate([-.5,130.1,0]) hd35_tab("left");
                translate([101.6+.5,28.5,0]) hd35_tab("right");
                translate([101.6+.5,69.75,0]) hd35_tab("right");
                translate([101.6+.5,130.1,0]) hd35_tab("right");
            }
        }
        if(orientation == "landscape") {
            if(position == "vertical") {
                if(side == "left") {
                    translate([9.4,0,0]) rotate([0,0,90]) hd35_vtab("right");
                    translate([86,0,0])  rotate([0,0,90]) hd35_vtab("right");
                }
                else {  // right
                    translate([9.4,0,0]) rotate([0,0,90]) hd35_vtab("left");
                    translate([86,0,0])  rotate([0,0,90]) hd35_vtab("left");
                }
            }
            else {
                translate([16.9,-.5,0]) rotate([0,0,90]) hd35_tab("left");
                translate([76.6,-.5,0])  rotate([0,0,90]) hd35_tab("left");
                translate([118.5,-.5,0]) rotate([0,0,90]) hd35_tab("left");
                translate([16.9,101.6-.5,0]) rotate([0,0,90]) hd35_tab("right");
                translate([76.6,101.6-.5,0]) rotate([0,0,90]) hd35_tab("right");
                translate([118.5,101.6-.5,0]) rotate([0,0,90]) hd35_tab("right");
            }
        }
    }
}