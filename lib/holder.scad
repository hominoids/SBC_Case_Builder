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

    nut_holder(nut, style, dia_x, dia_y, height)
    pcb_holder(size, wallthick)
    vu_holder(vu_model, side, vesa, cheight)

*/


/*
           NAME: nut_holder
    DESCRIPTION: creates various nut holders
           TODO: none

          USAGE: nut_holder(nut, style, dia_x, dia_y, height, mask)

                            nut = "m2", "m2.5", "m3", "m4", "m3-insert"
                          style = "default", "sloped", "trap"
                          dia_x = top diameter or x size in mm
                          dia_y = bottom diameter or y size in mm
                         height = holder height in mm
                        mask[0] = true enables component mask
                        mask[1] = mask length
                        mask[2] = mask setback
                        mask[3] = mstyle "default"

*/

module nut_holder(nut, style, dia_x, dia_y, height, mask) {

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

    if(enablemask == true && mstyle == "default") {
        if(nut == "m2") {
            translate([0, 0, -mlength+msetback]) cylinder(d = nuts[0][0], h = mlength);
        }
         if(nut == "m2.5") {
            translate([0, 0, -mlength+msetback]) cylinder(d = nuts[1][0], h = mlength);
        }
         if(nut == "m3") {
            translate([0, 0, -mlength+msetback]) cylinder(d = nuts[2][0], h = mlength);
        }
         if(nut == "m4") {
            translate([0, 0, -mlength+msetback]) cylinder(d = nuts[3][0], h = mlength);
        }
    }
    if(enablemask == false) {

        if( style == "default") {
            difference() {
                cylinder(d=dia_x, h=height);
                if(nut == "m2") {
                    translate([0, 0, -1]) cylinder(d=nuts[0][0]+.25, h=height+2);
                    translate([0, 0, 2]) cylinder(d=nuts[0][1]*2/sqrt(3), h=height, $fn=6);
                }
                if(nut == "m2.5") {
                    translate([0, 0, -1]) cylinder(d=nuts[1][0]+.25, h=height+2);
                    translate([0, 0, 2]) cylinder(d=nuts[1][1]*2/sqrt(3), h=height, $fn=6);
                }
                if(nut == "m3") {
                    translate([0, 0, -1]) cylinder(d=nuts[2][0]+.5, h=height+2);
                    translate([0, 0, 2]) cylinder(d=nuts[2][1]*2/sqrt(3), h=height, $fn=6);
                }
                if(nut == "m3-insert") {
                    translate([0, 0, -1]) cylinder(d=nuts[2][0]+.5, h=height+2);
                    translate([0, 0, 0]) cylinder(d=4.2, h=5.1);
                }
                if(nut == "m4") {
                    translate([0, 0, -1]) cylinder(d=nuts[3][0]+.5, h=height+2);
                    translate([0, 0, 2]) cylinder(d=nuts[3][1]*2/sqrt(3), h=height, $fn=6);
                }
            }
        }
        if( style == "sloped") {
            difference() {
                cylinder(d2=dia_x, d1=dia_y, h=height);
                if(nut == "m2") {
                    translate([0, 0, -1]) cylinder(d=nuts[0][0]+.25, h=height+2);
                    translate([0, 0, 2]) cylinder(d=nuts[0][1]*2/sqrt(3), h=height, $fn=6);
                }
                if(nut == "m2.5") {
                    translate([0, 0, -1]) cylinder(d=nuts[1][0]+.25, h=height+2);
                    translate([0, 0, 2]) cylinder(d=nuts[1][1]*2/sqrt(3), h=height, $fn=6);
                }
                if(nut == "m3") {
                    translate([0, 0, -1]) cylinder(d=nuts[2][0]+.5, h=height+2);
                    translate([0, 0, 0]) cylinder(d=nuts[2][1]*2/sqrt(3), h=height+5, $fn=6);
                }
                if(nut == "m3-insert") {
                    translate([0, 0, -1]) cylinder(d=nuts[2][0]+.5, h=height+2);
                    translate([0, 0, 0]) cylinder(d=4.2, h=5.1);
                }
                if(nut == "m4") {
                    translate([0, 0, -1]) cylinder(d=nuts[3][0]+.5, h=height+2);
                    translate([0, 0, 2]) cylinder(d=nuts[3][1]*2/sqrt(3), h=height, $fn=6);
                }
            }
        }
        if( style == "trap") {
            if(nut == "m2") {
                difference() {
                    translate([-dia_x/2, -dia_y/2, 0]) cube([dia_x, dia_y, height]);
                    translate([0, 0, -1]) cylinder(d=nuts[0][0]+.25, h=height+2);
                    translate([0, 0, 2]) rotate([0,0,30]) cylinder(d=nuts[0][1]*2/sqrt(3), h=nuts[0][2], $fn=6);
                    translate([-nuts[0][1]/2, 0, 2]) cube([nuts[0][1], dia_x, nuts[0][2]]);
                }
            }
            if(nut == "m2.5") {
                difference() {
                    translate([-dia_x/2, -dia_y/2, 0]) cube([dia_x, dia_y, height]);
                    translate([0, 0, -1]) cylinder(d=nuts[1][0]+.325, h=height+2);
                    translate([0, 0, 2]) rotate([0,0,30]) cylinder(d=nuts[1][1]*2/sqrt(3), h=nuts[1][2], $fn=6);
                    translate([-nuts[1][1]/2, 0, 2]) cube([nuts[1][1], dia_x, nuts[1][2]]);
                }
            }
            if(nut == "m3") {
                difference() {
                    translate([-dia_x/2, -dia_y/2, 0]) cube([dia_x, dia_y, height]);
                    translate([0, 0, -1]) cylinder(d=nuts[2][0]+.5, h=height+2);
                    translate([0, 0, 2]) rotate([0,0,30]) cylinder(d=nuts[2][1]*2/sqrt(3), h=nuts[2][2], $fn=6);
                    translate([-nuts[2][1]/2, 0, 2]) cube([nuts[2][1], dia_x, nuts[2][2]]);
                }
            }
            if(nut == "m4") {
                difference() {
                    translate([-dia_x/2, -dia_y/2, 0]) cube([dia_x, dia_y, height]);
                    translate([0, 0, -1]) cylinder(d=nuts[3][0]+.5, h=height+2);
                    translate([0, 0, 2]) rotate([0,0,30]) cylinder(d=nuts[3][1]*2/sqrt(3), h=nuts[3][2], $fn=6);
                    translate([-nuts[3][1]/2, 0, 2]) cube([nuts[3][1], dia_x, nuts[3][2]]);
                }
            }
        }
    }
}


/*
           NAME: pcb_holder
    DESCRIPTION: pcb bottom edge holder
           TODO: none

          USAGE: pcb_holder(size, wallthick)

                           size = width of holder
                      wallthick = holder wall thickness
*/

module pcb_holder(size, wallthick) {

    adj=.01;
    $fn = 90;    
    difference() {
        union() {
            translate([-1.85,-1.75,0]) cube([size[0]+3.5,5,6]);
                translate([size[0]+1.65,-5.75,1]) 
                    rotate([0,-90,0]) 
                    linear_extrude(height = size[0]+3.5) 
                        polygon(points = [ [-wallthick/2,-wallthick/2],
                            [2,wallthick], 
                            [4,4], 
                            [-wallthick/2,4]]);
                translate([-1.85,4,1]) 
                    rotate([0,-90,180]) 
                    linear_extrude(height = size[0]+3.5) 
                        polygon(points = [ [-wallthick/2,-wallthick/2],
                            [2,wallthick], 
                            [2,2], 
                            [-wallthick/2,2]]);
        }
        translate([-.5,0,2]) cube([size[0]+1,size[2],5]);
        translate([6,-adj-5-1.75,-adj]) cube([size[0]-12,14,8]);
    }
}


/*
           NAME: vu_holder
    DESCRIPTION: hk vu5,vu5a,vu7,vu7a display holder
           TODO: none

          USAGE: vu_holder(vu_model, side, vesa, cheight)

                           vu_model = "vu5", "vu7"
                               side = "left", "right"
                               vesa = 75 for vu5, 100 for vu7
                            cheight = case_z+90 for vu5, case_z+122 for vu7
*/

module vu_holder(vu_model, side, vesa, cheight) {

//cheight = case_z+90;
v_fillet = 3;
    
vu5_case_x_offset = 6.5;                // for uniform front vu5=6.5, vu7=20
vu5_pcb_width = 121;
vu5_pcb_height = 93.31;
vu5_width = vu5_pcb_width + vu5_case_x_offset;
vu5_height = vu5_pcb_height + 9.75;
    
vu7_case_x_offset = 20;                 // for uniform front vu5=6.5, vu7=20
vu7_pcb_width = 172.90;
vu7_pcb_height = 124.27;
vu7_width = vu7_pcb_width + vu7_case_x_offset;
vu7_height = vu7_pcb_height + 9.75;
vu_rotation = [15,0,0];

        difference() {
        union() {
            if(side == "right") {
                translate([width-wallthick-gap,-(2*wallthick)-gap,0]) 
                    cube([sidethick,depth+2*wallthick,cheight]);
                // right tabs for vu5 attachment
                if(vu_model == "vu5") {
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick,depth-39,
                        case_z+80]) rotate([75,180,0]) 
                            slab_r([((width-vesa)/2)+4.5,10,sidethick], [.01,.01,3,3]);
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick,depth-26,
                        case_z+31.5]) rotate([75,180,0]) 
                            slab_r([((width-vesa)/2)+4.5,10,sidethick], [.01,.01,3,3]);
                
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick-1.5,depth-40.85-adj,
                        case_z+79.5]) rotate([75,180,0]) 
                    difference() { 
                        cube([sidethick,10,sidethick]);
                        translate([0,-adj,sidethick]) rotate([0,45,0]) 
                            cube([2*sidethick,10+(2*adj),sidethick]);
                    }
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick-1.5,depth-27.85-adj,
                        case_z+31]) rotate([75,180,0])
                    difference() { 
                        cube([sidethick,10,sidethick]);
                        translate([0,-adj,sidethick]) rotate([0,45,0]) 
                            cube([2*sidethick,10+(2*adj),sidethick]);
                    }
                }
                // right tabs for vu7 attachment
                if(vu_model == "vu7") {
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick-1,depth-49.40,
                        case_z+vu7_height-15]) rotate([75,180,0]) 
                            slab_r([((width-vesa)/2)+12,10,sidethick], [.01,.01,3,3]);
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick-1,depth-23.60,
                        case_z+22.5]) rotate([75,180,0]) 
                            slab_r([((width-vesa)/2)+12,10,sidethick], [.01,.01,3,3]);
                    
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick-1.5,depth-51.25,
                        case_z+vu7_height-15.5]) rotate([75,180,0]) 
                            difference() { 
                                cube([sidethick,10,sidethick]);
                                translate([0,-adj,sidethick]) rotate([0,45,0]) 
                                    cube([2*sidethick,10+(2*adj),sidethick]);
                            }
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick-1.5,depth-25.5,
                        case_z+21.8]) rotate([75,180,0])
                            difference() { 
                                cube([sidethick,10,sidethick]);
                                translate([0,-adj,sidethick]) rotate([0,45,0]) 
                                    cube([2*sidethick,10+(2*adj),sidethick]);
                            }
                }
                // top rail
                    translate([width-6.9-adj,-gap,case_z-floorthick-.5])
                    cube([4,depth-2*(wallthick+gap),2]);
            }
            if(side == "left") {
                translate([-wallthick-gap-sidethick,-(2*wallthick)-gap,0]) 
                    cube([sidethick,depth+2*wallthick,cheight]);
                // left tabs for vu5 attachment
                if(vu_model == "vu5") {
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adj,depth-36.4,
                        case_z+70]) rotate([105,0,0]) 
                            slab_r([((width-vesa)/2)+4,10, sidethick], [.01,.01,3,3]);
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adj,depth-23.5,
                        case_z+22]) rotate([105,0,0]) 
                            slab_r([((width-vesa)/2)+4,10,sidethick], [.01,.01,3,3]);
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adj,depth-38.35+adj,
                        case_z+69.5]) rotate([105,0,0])
                            difference() { 
                                cube([sidethick,10,sidethick]);
                                translate([0,-adj,sidethick]) rotate([0,45,0]) 
                                    cube([2*sidethick,10+(2*adj),2*sidethick]);
                            }                
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adj,depth-25.4+adj,
                        case_z+21.5]) rotate([105,0,0])  
                        difference() { 
                            cube([sidethick,10,sidethick]);
                            translate([0,-adj,sidethick]) rotate([0,45,0]) 
                                cube([2*sidethick,10+(2*adj),2*sidethick]);
                        }
                }           
                // left tabs for vu7 attachment
                if(vu_model == "vu7") {
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-4.25-adj,depth-46.85,
                        case_z+vu7_height-24.5]) rotate([105,0,0]) 
                            slab_r([((width-vesa)/2),10, sidethick], [.01,.01,3,3]);
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-4.25-adj,depth-21,
                        case_z+13]) rotate([105,0,0]) 
                            slab_r([((width-vesa)/2),10,sidethick], [.01,.01,3,3]);
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adj,depth-48.75+adj,
                        case_z+vu7_height-25]) rotate([105,0,0])
                            difference() { 
                                cube([sidethick,10,sidethick]);
                                translate([0,-adj,sidethick]) rotate([0,45,0]) 
                                    cube([2*sidethick,10+(2*adj),2*sidethick]);
                            }                
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adj,depth-22.65+adj,
                        case_z+12.5]) rotate([105,0,0])  
                        difference() { 
                            cube([sidethick,10,sidethick]);
                            translate([0,-adj,sidethick]) rotate([0,45,0]) 
                                cube([2*sidethick,10+(2*adj),2*sidethick]);
                        }
                }
                // top rail
                translate([-wallthick-gap-adj,-gap,case_z-floorthick-.5]) 
                        cube([4,depth-2*(wallthick+gap),2]);
            }
        }

        if(side == "right") {
            // vu5 shape and back cut
            if(vu_model == "vu5") {
                translate([width+adj,-.6,case_z+sidethick+2.5]) 
                    rotate([0,-90,0]) 
                    linear_extrude(height = 3*sidethick) 
                        polygon(points = [ [-sidethick,-sidethick-wallthick-5],
                            [cheight-bottom_height-top_height-3,-sidethick-wallthick-5], 
                            [cheight-bottom_height-top_height-3,depth-53], 
                            [-sidethick,depth-33]]);
                
                translate([width-(sidethick/2),depth-8,case_z+(121/2)]) 
                    rotate([vu_rotation[0],0,0]) 
                        cube_fillet_inside([10,50,110],vertical=[v_fillet,v_fillet,v_fillet,v_fillet],
                            top=[0,0,0,0],bottom=[3,3,3,3], $fn=90);
                // tab holes
                translate([width/2+(vesa/2)-3,depth-37,
                    case_z+75]) rotate([75,180,0]) cylinder(d=3, h=sidethick+1);
                translate([width/2+(vesa/2)-3,depth-24,
                    case_z+26.75]) rotate([75,180,0]) cylinder(d=3, h=sidethick+1);
            }
            // vu7 shape and back cut
            if(vu_model == "vu7") {
                translate([width+adj,-.6,case_z+sidethick+2.5]) 
                    rotate([0,-90,0]) 
                    linear_extrude(height = 2*sidethick) 
                        polygon(points = [ [-sidethick,-sidethick-wallthick-5],
                            [cheight-bottom_height-top_height-3,-sidethick-wallthick-5], 
                            [cheight-bottom_height-top_height-3,depth-63], 
                            [-sidethick,depth-33]]);
                
                translate([width-(sidethick/2),depth-10.5,case_z+70.5]) 
                    rotate([vu_rotation[0],0,0]) 
                        cube_fillet_inside([10,50,130],vertical=[v_fillet,v_fillet,v_fillet,v_fillet],
                            top=[0,0,0,0],bottom=[3,3,3,3], $fn=90);
                // tab holes
                translate([width/2+(vesa/2)-10,depth-47,case_z+vu7_height-19.75]) 
                    rotate([75,180,0]) cylinder(d=3, h=sidethick+4);
                translate([width/2+(vesa/2)-10,depth-21.25,case_z+18]) 
                    rotate([75,180,0]) cylinder(d=3, h=sidethick+4);
            }
            // bottom attachment holes                         
            translate([width-wallthick-gap-adj-5,wallthick+gap+10,
                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adj)+10);
            translate([width-wallthick-gap-adj-5,depth-wallthick-gap-10,
                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adj)+10);
        }

        if(side == "left") {
            // vu5 shape and back cut
            if(vu_model == "vu5") {
                translate([-sidethick+adj,-.6,case_z+sidethick+2.5]) 
                    rotate([0,-90,0]) 
                        linear_extrude(height = 3*sidethick) 
                            polygon(points = [ [-sidethick,-sidethick-wallthick-5],
                                [cheight-bottom_height-top_height-3,-sidethick-wallthick-5], 
                                [cheight-bottom_height-top_height-3,depth-53], 
                                [-sidethick,depth-33]]);
                
                translate([-wallthick-gap-(sidethick/2),depth-8,case_z+(121/2)]) 
                    rotate([vu_rotation[0],0,0]) 
                        cube_fillet_inside([10,50,110],vertical=[v_fillet,v_fillet,v_fillet,v_fillet],
                            top=[0,0,0,0],bottom=[3,3,3,3], $fn=90);
                // tab holes
                translate([width/2-(vesa/2)-3,depth-36.75,case_z+75]) 
                    rotate([105,0,0]) cylinder(d=3, h=sidethick+1);
                translate([width/2-(vesa/2)-3,depth-24.25,case_z+26.75]) 
                    rotate([75,0,0])  cylinder(d=3, h=sidethick+1);
            }
            // vu7 shape and back cut
            if(vu_model == "vu7") {
                translate([-sidethick+adj,-.6,case_z+sidethick+2.5]) 
                    rotate([0,-90,0]) 
                        linear_extrude(height = 2*sidethick) 
                            polygon(points = [ [-sidethick,-sidethick-wallthick-5],
                                [cheight-bottom_height-top_height-3,-sidethick-wallthick-5], 
                                [cheight-bottom_height-top_height-3,depth-63], 
                                [-sidethick,depth-33]]);
                
                translate([-wallthick-gap-(sidethick/2),depth-10.5,case_z+70.5]) 
                    rotate([vu_rotation[0],0,0]) 
                        cube_fillet_inside([10,50,130],vertical=[v_fillet,v_fillet,v_fillet,v_fillet],
                            top=[0,0,0,0],bottom=[3,3,3,3], $fn=90);
                // tab holes
                translate([width/2-(vesa/2)-10,depth-48,case_z+vu7_height-19.75]) 
                    rotate([105,0,0]) cylinder(d=3, h=sidethick+4);
                translate([width/2-(vesa/2)-10,depth-22.25,case_z+18]) 
                    rotate([105,0,0])  cylinder(d=3, h=sidethick+4);
            }
            // bottom attachment holes
            translate([-sidethick-adj-6,wallthick+gap+10,((bottom_height+floorthick)/2)-1]) 
                rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adj)+10);
            if(depth >= 75) {
                translate([-sidethick-adj-6,depth-wallthick-gap-10,
                    ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adj)+10);
            }
            else {
                translate([-sidethick-adj-6,wallthick+gap+40.5,((bottom_height+floorthick)/2)-1])
                    rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adj)+10);                        
            }
        }
    }
}
