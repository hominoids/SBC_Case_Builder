/*
           NAME: panel_clamp
    DESCRIPTION: creates various clamps to join two panels
           TODO: none

          USAGE: panel_clamp(face, style, screw, dia_x, dia_y, height, mask)

                        data[0] = "top","bottom","rear","front","left","right"
                        data[1] = "sloped"
                        data[2] = "m2", "m2.5", "m3", "m4"
                         size_x = top diameter or x size in mm
                         size_y = bottom diameter or y size in mm
                         size_z = clamp height in mm
                        mask[0] = true enables component mask
                        mask[1] = mask length
                        mask[2] = mask setback
                        mask[3] = mstyle "default", "holes"

*/


module panel_clamp(face, style, screw, dia_x, dia_y, height, mask) {

    nuts = [[2,4,1.6],         // m2 size, diameter, height
            [2.5,5,2],         // m2.5 size, diameter, height
            [3,5.5,2.4],       // m3 size, diameter, height
            [4,7,3.2]];        // m4 size, diameter, height

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];
    adj = .01;
    $fn = 90;

    rotx = face == "rear" ? 270 : face == "front" || face == "left"  || face == "right" ? 90 : face == "top" ? 180 : 0;
    roty = 0;
    rotz = face == "left" ? 90 : face == "right" ? 270 : 0;

    if(enablemask == true) {
        rotate([rotx,roty,rotz]) {
            if(mstyle == "default") {
                cylinder(d=dia_y, h=height);
            }
            if(screw == "m2" && mstyle == "holes") {
                translate([(-dia_y-(nuts[2][0]+.5)/2)/2, 0, 2.25]) rotate([0,90,0]) 
                    cylinder(d=nuts[0][0]+.5, h=dia_y+2);
                translate([-(dia_y/2), 0, 2.25]) rotate([0,90,0]) 
                    cylinder(d=nuts[0][1]*2/sqrt(3), h=dia_y*.375, $fn=6);
                translate([nuts[0][0]+.5, 0, 2.25]) rotate([0,90,0]) 
                    cylinder(d=nuts[0][1]+.5, h=dia_y*.375);
            }
            if(screw == "m2.5" && mstyle == "holes") {
                translate([(-dia_y-(nuts[2][0]+.5)/2)/2, 0, 3]) rotate([0,90,0]) 
                    cylinder(d=nuts[1][0]+.5, h=dia_y+2);
                translate([-(dia_y/2), 0, 3]) rotate([0,90,0]) 
                    cylinder(d=nuts[1][1]*2/sqrt(3), h=dia_y*.375, $fn=6);
                translate([nuts[1][0]+.5, 0, 3]) rotate([0,90,0]) 
                    cylinder(d=nuts[1][1]+.5, h=dia_y*.375);
            }
            if(screw == "m3" && mstyle == "holes") {
                translate([(-dia_y-(nuts[2][0]+.5)/2)/2, 0, 3]) rotate([0,90,0]) 
                    cylinder(d=nuts[2][0]+.5, h=dia_y+2);
                translate([-(dia_y/2), 0, 3]) rotate([0,90,0]) 
                    cylinder(d=nuts[2][1]*2/sqrt(3), h=dia_y*.375, $fn=6);
                translate([nuts[2][0]+.5, 0, 3]) rotate([0,90,0]) 
                    cylinder(d=nuts[2][1]+.5, h=dia_y*.375);
            }
            if(screw == "m4" && mstyle == "holes") {
                translate([(-dia_y-(nuts[2][0]+.5)/2)/2, 0, 3]) rotate([0,90,0]) 
                    cylinder(d=nuts[3][0]+.5, h=dia_y+2);
                translate([-(dia_y/2), 0, 3]) rotate([0,90,0]) 
                    cylinder(d=nuts[3][1]*2/sqrt(3), h=dia_y*.375, $fn=6);
                translate([nuts[3][0]+.5, 0, 3]) rotate([0,90,0]) 
                    cylinder(d=nuts[3][1]+.5, h=dia_y*.375);
            }
        }
    }
    if(enablemask == false) {
        rotate([rotx,roty,rotz]) {
            difference() {
                cylinder(d2=dia_x, d1=dia_y, h=height);
                if(screw == "m2") {
                    translate([(-dia_y-(nuts[2][0]+.5)/2)/2, 0, 2.25]) rotate([0,90,0]) 
                        cylinder(d=nuts[0][0]+.5, h=dia_y+2);
                    translate([-(dia_y/2), 0, 2.25]) rotate([0,90,0]) 
                        cylinder(d=nuts[0][1]*2/sqrt(3), h=dia_y*.375, $fn=6);
                    translate([nuts[0][0]+.5, 0, 2.25]) rotate([0,90,0]) 
                        cylinder(d=nuts[0][1]+.5, h=dia_y*.375);
                }
                if(screw == "m2.5") {
                    translate([(-dia_y-(nuts[2][0]+.5)/2)/2, 0, 3]) rotate([0,90,0]) 
                        cylinder(d=nuts[1][0]+.5, h=dia_y+2);
                    translate([-(dia_y/2), 0, 3]) rotate([0,90,0]) 
                        cylinder(d=nuts[1][1]*2/sqrt(3), h=dia_y*.375, $fn=6);
                    translate([nuts[1][0]+.5, 0, 3]) rotate([0,90,0]) 
                        cylinder(d=nuts[1][1]+.5, h=dia_y*.375);
                }
                if(screw == "m3") {
                    translate([(-dia_y-(nuts[2][0]+.5)/2)/2, 0, 3]) rotate([0,90,0]) 
                        cylinder(d=nuts[2][0]+.5, h=dia_y+2);
                    translate([-(dia_y/2), 0, 3]) rotate([0,90,0]) 
                        cylinder(d=nuts[2][1]*2/sqrt(3), h=dia_y*.375, $fn=6);
                    translate([nuts[2][0]+.5, 0, 3]) rotate([0,90,0]) 
                        cylinder(d=nuts[2][1]+.5, h=dia_y*.375);
                }
                if(screw == "m4") {
                    translate([(-dia_y-(nuts[2][0]+.5)/2)/2, 0, 3]) rotate([0,90,0]) 
                        cylinder(d=nuts[3][0]+.5, h=dia_y+2);
                    translate([-(dia_y/2), 0, 3]) rotate([0,90,0]) 
                        cylinder(d=nuts[3][1]*2/sqrt(3), h=dia_y*.375, $fn=6);
                    translate([nuts[3][0]+.5, 0, 3]) rotate([0,90,0]) 
                        cylinder(d=nuts[3][1]+.5, h=dia_y*.375);
                }
            }
        }
    }
}
