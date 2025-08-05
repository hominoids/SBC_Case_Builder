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


           NAME: case_side
    DESCRIPTION: creates case side for supported designs and styles
           TODO: none

          USAGE: case_side(case_design, side)

*/

module case_side(case_design, side) {
    
    difference() {
        union() {
            if(case_design == "panel") {
                if(side == "rear") {
                    difference() {
                        union() {
                            translate([-gap,-wallthick-gap,-floorthick]) 
                                cube([width-2*wallthick,wallthick,case_z+2*floorthick]);
                            // right hook
                            difference() {
                                translate([width-(2*wallthick)-gap-adj,-wallthick-gap,
                                    ((case_z)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([width-(2*wallthick)-gap-adj,-wallthick-gap-adj,
                                    ((case_z)/2)-4-adj]) 
                                        cube([wallthick+.25,wallthick+(2*adj),4.25]);
                            }
                            // left hook
                            difference() {
                                translate([-(2*wallthick)-gap-adj-.25,-wallthick-gap,
                                    ((case_z)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([-wallthick-gap-adj-.25,-wallthick-gap-adj,
                                    ((case_z)/2)-4-adj]) 
                                        cube([wallthick+.25,wallthick+(2*adj),4.25]);
                            }
                        }
                        // top slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),-wallthick-gap-adj,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,-wallthick-gap-adj,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        // bottom slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),-wallthick-gap-adj,-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,-wallthick-gap-adj,-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                    }
                }
                if(side == "front") {
                    difference() {
                        union() {
                            translate([-gap,depth-2*(wallthick)-gap,-floorthick]) 
                                cube([width-2*wallthick,wallthick,case_z+2*floorthick]);
                            // right hook
                            difference() {
                                translate([width-(2*wallthick)-gap-adj,depth-2*(wallthick)-gap-adj,
                                    ((case_z)/2)-4])
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([width-(2*wallthick)-gap-adj,
                                    depth-2*(wallthick)-adj-gap-adj,((case_z)/2)-4-adj])
                                        cube([wallthick+.25,wallthick+(2*adj),4.25]);
                            }
                            // left hook
                            difference() {
                                translate([-(2*wallthick)-gap-adj-.25,depth-2*(wallthick)-gap-adj,(
                                    (case_z)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([-wallthick-gap-adj-.25,depth-2*(wallthick)-adj-gap-adj,
                                    ((case_z)/2)-4-adj]) 
                                        cube([wallthick+.25,wallthick+(2*adj),4.25]);
                            }
                        }
                        // top slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),depth-2*wallthick-gap-adj,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,depth-2*wallthick-gap-adj,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        // bottom slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),depth-2*wallthick-gap-adj,-.25]) 
                                cube([8.5,wallthick+2*adj,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,
                            depth-2*wallthick-gap-adj,-.25]) cube([8.5,wallthick+2*adj,floorthick+.5]);
                    }
                }
                if(side == "right") {
                    difference() {
                        translate([width-(2*wallthick)-gap,-(2*wallthick)-gap,-wallthick]) 
                            cube([wallthick,depth+2*wallthick,case_z+(2*wallthick)]);
                        translate([width-(2*wallthick)-gap-adj,-wallthick-gap-.25,
                            ((case_z)/2)]) cube([wallthick+2*adj,wallthick+.5,8.5]);
                        translate([width-(2*wallthick)-gap-adj,depth-2*(wallthick)-gap-.25,
                            ((case_z)/2)])
                                cube([wallthick+2*adj,wallthick+.5,8.5]);
                    }
                }
                if(side == "left") {
                    difference() {
                        translate([-wallthick-gap,-(2*wallthick)-gap,-wallthick]) 
                            cube([wallthick,depth+2*wallthick,case_z+(2*wallthick)]);
                        translate([-wallthick-gap-adj,-wallthick-gap-.25,((case_z)/2)])
                            cube([wallthick+2*adj,wallthick+.5,8.5]);
                        translate([-wallthick-gap-adj,depth-2*(wallthick)-gap-.25,
                            ((case_z)/2)])
                                cube([wallthick+2*adj,wallthick+.5,8.5]);
                    }
                }
            }
            if(case_design == "panel_nas") {
                x_adj = pcb_width > 100 ? width-2*sidethick : 101.6+case_offset_x;
                xtab_adj = pcb_width > 100 ? width-gap-2*sidethick-adj : 101.6-gap+case_offset_x-adj;
                xvent8_adj = pcb_width > 100 ? width/5.5 : width/6;
                if(side == "rear") {
                    difference() {
                        union() {
                            translate([-gap,-(2*wallthick),0]) 
                                cube([x_adj,wallthick,case_z-floorthick]);
                            // bottom right tab
                            translate([xtab_adj,-(2*wallthick),20])
                                cube([sidethick+(2*adj),wallthick,10]);
                            // top right tab
                            translate([xtab_adj,-(2*wallthick),case_z-30])
                                cube([sidethick+(2*adj),wallthick,10]);
                            // bottom left tab
                            translate([-sidethick-gap-adj,-(2*wallthick),20])
                                cube([sidethick+(2*adj),wallthick,10]);
                            // top left tab
                            translate([-sidethick-gap-adj,-(2*wallthick),case_z-30])
                                cube([sidethick+(2*adj),wallthick,10]);
                            if(hd_bays > 3) {
                                // middle right tab
                                translate([xtab_adj,-(2*wallthick),(case_z/2)-5])
                                    cube([sidethick+(2*adj),wallthick,10]);
                                // middle left tab
                                translate([-sidethick-gap-adj,-(2*wallthick),(case_z/2)-5])
                                    cube([sidethick+(2*adj),wallthick,10]);
                            }
                        }
                        if(rear_fan == 1 || rear_fan == 2) {
                            if(rear_fan_center == false) {
                                translate([-1+(101.6-rear_fan_size)/2,-1,rear_fan_position]) 
                                    rotate([90,0,0]) fan_mask(rear_fan_size, wallthick+2, rear_cooling);
                            }
                            if(rear_fan_center == true) {
                                translate([-1+(101.6-rear_fan_size)/2+(width-2*(sidethick+gap)-101.6)/2,-1,rear_fan_position]) 
                                    rotate([90,0,0]) fan_mask(rear_fan_size, wallthick+2, rear_cooling);
                            }
                        }
                        if(rear_fan == 2) {
                            if(rear_fan_center == false) {
                                translate([-1+(101.6-rear_fan_size)/2,-1,rear_fan_position+rear_dualfan_spacing+rear_fan_size]) 
                                    rotate([90,0,0]) fan_mask(rear_fan_size, wallthick+2, rear_cooling);
                            }
                            if(rear_fan_center == true) {
                                translate([-1+(101.6-rear_fan_size)/2+(width-2*(sidethick+gap)-101.6)/2,
                                    -1,rear_fan_position+rear_dualfan_spacing+rear_fan_size]) 
                                        rotate([90,0,0]) fan_mask(rear_fan_size, wallthick+2, rear_cooling);
                            }
                        }
                    }
                }
                if(side == "front") {
                    difference() {
                        union() {
                            translate([-gap,depth-(4*wallthick),floorthick]) 
                                cube([x_adj,wallthick,case_z-3*floorthick]);
                            // bottom right tab
                            translate([xtab_adj,depth-(4*wallthick),20])
                                cube([sidethick+(2*adj),wallthick,10]);
                            // top right tab
                            translate([xtab_adj,depth-(4*wallthick),case_z-30])
                                cube([sidethick+(2*adj),wallthick,10]);
                            // bottom left tab
                            translate([-sidethick-gap-adj,depth-(4*wallthick),20])
                                cube([sidethick+(2*adj),wallthick,10]);
                            // top left tab
                            translate([-sidethick-gap-adj,depth-(4*wallthick),case_z-30])
                                cube([sidethick+(2*adj),wallthick,10]);
                            if(hd_bays > 3) {
                                // middle right tab
                                translate([xtab_adj,depth-(4*wallthick),(case_z/2)-5])
                                    cube([sidethick+(2*adj),wallthick,10]);
                                // middle left tab
                                translate([-sidethick-gap-adj,depth-(4*wallthick),(case_z/2)-5])
                                    cube([sidethick+(2*adj),wallthick,10]);
                            }
                        }
                        // front cover pattern
                        if(front_cover_pattern != "solid" && case_design == "panel_nas") {
                            xvent_pos = pcb_width <= 100 ? -gap+3 : -gap+6;
                            if(front_cover_pattern == "hex_5mm" && hd_bays < 6) {
                                translate([xvent_pos,depth-3*(wallthick)+gap,hd_z_position-5])
                                    vent_hex(round(width/3.85),round(hd_bays*(27.1+hd_space)/5.75),wallthick+4,5,1.5,"vertical");
                            }
                            if(front_cover_pattern == "hex_5mm" && hd_bays == 6) {
                                translate([xvent_pos,depth-3*(wallthick)+gap,hd_z_position])
                                    vent_hex(round(width/3.85),round(hd_bays*(27.1+hd_space)/5.75),wallthick+4,5,1.5,"vertical");
                            }
                            if(front_cover_pattern == "hex_8mm") {
                                translate([-gap+4,depth-3*(wallthick)+gap,hd_z_position]) 
                                    vent_hex(xvent8_adj,round(hd_bays*(27.1+hd_space)/5.75)-5,floorthick+4,8,1.5,"vertical");
                            }
                            if(front_cover_pattern == "linear_vertical") {
                                translate([-gap+4,depth-3*(wallthick)+gap,hd_z_position]) 
                                    vent(wallthick,(case_z-2*(wallthick+gap)-20)/8,floorthick+4,1,1,
                                        (width-2*(sidethick+gap))/5.35,"vertical");
                                translate([-gap+4,depth-3*(wallthick)+gap,case_z-(top_height+bottom_height+4*floorthick)-5]) 
                                    vent(wallthick,(case_z-2*(wallthick+gap)-20)/8,floorthick+4,1,1,
                                        (width-2*(sidethick+gap))/5.35,"vertical");
                            }
                            if(front_cover_pattern == "linear_horizontal") {
                                translate([wallthick+gap,depth-3*(wallthick)+gap,hd_z_position]) 
                                    vent(width-2*(wallthick+gap+sidethick)-4,wallthick,floorthick+4,2,
                                        (case_z-2*(wallthick+gap)-20)/20,1,"vertical");
                                translate([wallthick+gap,depth-3*(wallthick)+gap,
                                    case_z-(top_height+bottom_height+4*floorthick)-20]) 
                                        vent(width-4*(sidethick+gap),wallthick,floorthick+4,2,
                                            (case_z-2*(wallthick+gap)-20)/20,1,"vertical");
                            }
                            if(front_cover_pattern == "astroid") {
                                xast_adj = pcb_width <= 100 ? 8 : 6;
                                for(c=[xast_adj:12:case_z-20]) {
                                    for(r=[8:12:width-8]) {
                                        translate([r,depth-2*wallthick,c]) rotate([90,0,0])
                                            linear_extrude(wallthick+5) import("./dxf/astroid_8mm.dxf");
                                    }
                                }   
                            }
                        }
                    }
                }
                if(side == "right") {
                    difference() {
                        if(case_design == "panel_nas") {
                            if(pcb_width > 100) {
                                translate([pcb_width+sidethick+gap+case_offset_x,-(3*wallthick)-gap,-2*wallthick]) 
                                    rotate([0,-90,0]) slab([case_z+(3*wallthick),depth+2*wallthick,sidethick],corner_fillet);
                            }
                            if(pcb_width <= 100) {
                                translate([101.6-gap+sidethick+case_offset_x,-(3*wallthick)-gap,-2*wallthick]) 
                                    rotate([0,-90,0]) slab([case_z+(3*wallthick),depth+2*wallthick,sidethick],corner_fillet);
                            }
                        }
                        else {
                            translate([width-2*sidethick-gap,-(3*wallthick)-gap,-2*wallthick]) 
                                rotate([0,-90,0]) slab([case_z+(3*wallthick),depth+2*wallthick,sidethick],corner_fillet);
                        }

                        // rear edge top tab openings
                        translate([width-3*sidethick-gap-adj,-2*wallthick+adj-tol,case_z-30]) 
                            cube([2*sidethick+2*adj,wallthick+tol,20+tol]);
                        translate([width-3*sidethick-gap-adj,-(4*wallthick)+2*adj,case_z-20]) 
                            cube([2*sidethick+(2*adj),2*wallthick,10+tol]);

                        // rear edge bottom tab openings
                        translate([width-3*sidethick-gap-adj,-2*wallthick+adj-tol,20]) 
                            cube([2*sidethick+2*adj,wallthick+tol,20+tol]);
                        translate([width-3*sidethick-gap-adj,-(4*wallthick)+2*adj,30]) 
                            cube([2*sidethick+(2*adj),2*wallthick,10+tol]);

                        // front edge top tab openings
                        translate([width-3*sidethick-gap-adj,depth-(4*wallthick),case_z-30])
                            cube([2*sidethick+(2*adj),wallthick+tol,20+tol]);
                        translate([width-3*sidethick-gap-adj,depth-(4*wallthick),case_z-20])
                            cube([2*sidethick+(2*adj),3*wallthick,10+tol]);

                        // front edge bottom tab openings
                        translate([width-3*sidethick-gap-adj,depth-(4*wallthick),20])
                            cube([2*sidethick+(2*adj),wallthick+tol,20+tol]);
                        translate([width-3*sidethick-gap-adj,depth-(4*wallthick),30])
                            cube([2*sidethick+(2*adj),3*wallthick,10+tol]);

                        if(hd_bays > 3) {
                            // front edge middle tab openings
                            translate([width-3*sidethick-gap-adj,depth-(4*wallthick),(case_z/2)-5]) 
                                cube([2*sidethick+2*adj,wallthick+tol,20+tol]);
                            translate([width-3*sidethick-gap-adj,depth-(4*wallthick),(case_z/2)-5+10]) 
                                cube([2*sidethick+(2*adj),3*wallthick,10+tol]);

                            // rear edge middle tab openings
                            translate([width-3*sidethick-gap-adj,-2*wallthick+adj-tol,(case_z/2)-5]) 
                                cube([2*sidethick+2*adj,wallthick+tol,20+tol]);
                            translate([width-3*sidethick-gap-adj,-(4*wallthick),(case_z/2)-5+10]) 
                                cube([2*sidethick+(2*adj),3*wallthick,10+tol]);
                        }

                        // hd holes for bays
                        if(hd_reverse == false) {
                            for( i=[0:1:hd_bays-1]) {
                                translate([(width-101.6)-(4*sidethick)-gap+adj,
                                    -(3*wallthick)-gap+hd_y_position,hd_z_position+(hd_space+27.1)*i]) 
                                        hd_holes(3.5, "portrait", "both", 4*sidethick+2);
                            }
                        }
                        else {
                            for( i=[0:1:hd_bays-1]) {
                                translate([width-(4*sidethick)-adj,-(3*wallthick)-gap+hd_y_position+147,
                                    hd_z_position+(hd_space+27.1)*i]) 
                                        rotate([0,0,180]) hd_holes(3.5, "portrait", "both", 4*sidethick+2);
                            }
                        }
                        // top edge front tab opening
                        translate([width-3*sidethick-gap-adj,depth-(3*wallthick)-gap-adj-30-tol,
                            case_z-(2*floorthick)]) 
                                cube([2*sidethick+(2*adj),20+tol,floorthick+tol]);
                        translate([width-3*sidethick-gap-adj,depth-(3*wallthick)-gap-adj-30-tol,
                            case_z-(2*floorthick)]) 
                                cube([2*sidethick+(2*adj),10+tol,(3*floorthick)+adj]);

                        // top edge rear tab opening
                        translate([width-3*sidethick-gap-adj,40-wallthick-gap-adj-tol,
                            case_z-(2*floorthick)])
                                cube([2*sidethick+(2*adj),10+tol,floorthick+tol]);
                        translate([width-3*sidethick-gap-adj,30-wallthick-gap+adj-tol,
                            case_z-(2*floorthick)]) 
                                cube([2*sidethick+(2*adj),10+tol,(3*floorthick)+adj]);

                        // bottom edge front tab opening
                        translate([width-3*sidethick-gap-adj,depth-(3*wallthick)-gap-adj-30-tol,-tol]) 
                                cube([2*sidethick+2*adj,20+tol,floorthick+tol]);
                        translate([width-3*sidethick-gap-adj,depth-(3*wallthick)-gap-adj-30-tol,-(3*floorthick)+adj]) 
                                cube([2*sidethick+2*adj,10+tol,(3*floorthick)+adj]);

                        // bottom edge rear tab opening
                        translate([width-3*sidethick-gap-adj,30-wallthick-gap+adj-tol,-tol])
                                cube([2*sidethick+2*adj,20+tol,floorthick+tol]);
                        translate([width-3*sidethick-gap-adj,30-wallthick-gap+adj-tol,-(3*floorthick)+adj]) 
                                cube([2*sidethick+(2*adj),10+tol,(3*floorthick)+adj]);

                    }
                }
                if(side == "left") {
                    difference() {
                        translate([-gap,-(3*wallthick)-gap,-2*wallthick]) 
                            rotate([0,-90,0]) slab([case_z+(3*wallthick),depth+(2*wallthick),sidethick],corner_fillet);

                        // rear edge top tab openings
                        translate([-sidethick-gap-adj,-2*wallthick+adj-tol,case_z-30]) 
                            cube([sidethick+2*adj,wallthick+tol,20]);
                        translate([-sidethick-gap-adj,-(4*wallthick)+tol,case_z-20]) 
                            cube([sidethick+(2*adj),3*wallthick+adj,10+tol]);

                        // rear edge bottom tab openings
                        translate([-sidethick-gap-adj,-2*wallthick+adj-tol,20]) 
                            cube([sidethick+2*adj,wallthick+tol,20]);
                        translate([-sidethick-gap-adj,-(4*wallthick)+tol,30]) 
                            cube([sidethick+(2*adj),3*wallthick,10+tol]);

                        // front edge top tab openings
                        translate([-sidethick-gap-adj,depth-(4*wallthick),case_z-30])
                            cube([sidethick+(2*adj),wallthick+tol,20]);
                        translate([-sidethick-gap-adj,depth-(4*wallthick),case_z-20])
                            cube([sidethick+(2*adj),3*wallthick,10+tol]);

                        // front edge bottom tab openings
                        translate([-sidethick-gap-adj,depth-(4*wallthick),20])
                            cube([sidethick+(2*adj),wallthick+tol,20]);
                        translate([-sidethick-gap-adj,depth-(4*wallthick),30])
                            cube([sidethick+(2*adj),3*wallthick,10+tol]);

                        if(hd_bays > 3) {
                        // rear edge middle tab openings
                        translate([-sidethick-gap-adj,-2*wallthick+adj-tol,(case_z/2)-5]) 
                            cube([sidethick+2*adj,wallthick+tol,20]);
                        translate([-sidethick-gap-adj,-(4*wallthick)+tol,(case_z/2)-5+10]) 
                            cube([sidethick+(2*adj),3*wallthick,10+tol]);

                        // front edge middle tab openings
                        translate([-sidethick-gap-adj,depth-(4*wallthick),(case_z/2)-5]) 
                            cube([sidethick+2*adj,wallthick+tol,20]);
                        translate([-sidethick-gap-adj,depth-(4*wallthick),(case_z/2)-5+10]) 
                            cube([sidethick+(2*adj),3*wallthick,10+tol]);
                        }

                        // hd holes for bays
                        if(hd_reverse == false) {
                            for( i=[0:1:hd_bays-1]) {
                                translate([-gap+adj,-(3*wallthick)-gap+hd_y_position,hd_z_position+(hd_space+27.1)*i]) 
                                    hd_holes(3.5, "portrait", "both", sidethick+2);
                            }
                        }
                        else {
                            for( i=[0:1:hd_bays-1]) {
                                translate([101.6-gap+adj,-(3*wallthick)-gap+hd_y_position+147,
                                    hd_z_position+(hd_space+27.1)*i]) 
                                        rotate([0,0,180]) hd_holes(3.5, "portrait", "both", sidethick+2);
                            }
                        }
  
                        // top edge front tab openings
                        translate([-gap-sidethick-adj,depth-(3*wallthick)-gap-adj-30,
                            case_z-(2*floorthick)]) 
                                cube([sidethick+(2*adj),20,floorthick+tol]);
                        translate([-gap-sidethick-adj,depth-(3*wallthick)-gap-adj-30-tol,
                            case_z-(2*floorthick)]) 
                                cube([sidethick+(2*adj),10+tol,(3*floorthick)+adj]);
                        // top edge rear tab openings
                        translate([-gap-sidethick-adj,30-wallthick-gap+adj,
                            case_z-(2*floorthick)])
                                cube([sidethick+(2*adj),20,floorthick+tol]);
                        translate([-gap-sidethick-adj,30-wallthick-gap+adj-tol,
                            case_z-(2*floorthick)]) 
                                cube([sidethick+(2*adj),10+tol,(3*floorthick)+adj]);

                        // bottom edge front tab openings
                        translate([-gap-sidethick-adj,depth-(3*wallthick)-gap-adj-30,-tol]) 
                                cube([sidethick+(2*adj),20,floorthick+tol]);
                        translate([-gap-sidethick-adj,depth-(3*wallthick)-gap-adj-30-tol,-(2*floorthick)-adj]) 
                                cube([sidethick+(2*adj),10+tol,(3*floorthick)+adj]);

                        // bottom edge rear tab openings
                        translate([-gap-sidethick-adj,30-wallthick-gap+adj,-tol])
                                cube([sidethick+(2*adj),20,floorthick+tol]);
                        translate([-gap-sidethick-adj,30-wallthick-gap+adj-tol,-(2*floorthick)-adj]) 
                                cube([sidethick+(2*adj),10+tol,(3*floorthick)+adj]);

                    }
                }
            }
            if(case_design == "tray_sides") {
                if(side == "right") {
                    difference() {
                        union() {
                            translate([width-wallthick-gap,-(2*wallthick)-gap,0]) 
                                cube([sidethick,depth+2*wallthick,case_z+(2*wallthick)]);
                            translate([width-gap-wallthick-1+adj,depth-2*(wallthick+gap)-.5,case_z+(2*wallthick)-2]) 
                                cube([1,6,2]);
                            translate([width-gap-wallthick-1+adj,-2*(wallthick+gap)+1.5,case_z+(2*wallthick)-2]) 
                                cube([1,6,2]);
                            // top rail
                            translate([width-6.9-adj,-gap,case_z-floorthick-.5])
                                cube([4,depth-2*(wallthick+gap),2]);
                        }
                        // right side bottom attachment holes          
                        translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                        if(depth >= 75) {                        
                            translate([width-2*(wallthick+gap)-sidethick-adj,depth-wallthick-gap-10,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                        }
                        else {
                            translate([width-2*(wallthick+gap)-sidethick-adj,wallthick+gap+40,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                        }
                    }
                }
                if(side == "left") {
                    difference() {
                        union() {
                            translate([-wallthick-gap-sidethick,-(2*wallthick)-gap,0]) 
                                cube([sidethick,depth+2*wallthick,case_z+(2*wallthick)]);
                            translate([-gap-wallthick-adj,depth-2*(wallthick+gap)-.5,case_z+(2*wallthick)-2])
                                cube([1,6,2]);
                            translate([-gap-wallthick-adj,-2*(wallthick+gap)+1.5,case_z+(2*wallthick)-2]) 
                                cube([1,6,2]);
                            // top rail
                            translate([-wallthick-gap-adj,-gap,case_z-floorthick-.5]) 
                                cube([4,depth-2*(wallthick+gap),2]);
                        }
                        // left side bottom attachment holes
                        translate([-wallthick-gap-adj-5,wallthick+gap+10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adj));
                        if(depth >= 75) {
                            translate([-wallthick-gap-adj-6,depth-wallthick-gap-10,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                        }
                        else {
                            translate([-wallthick-gap-adj-6,wallthick+gap+40,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adj));
                        }
                    }
                }
            }
            if(case_design == "tray_vu5") {
                cheight = case_z+90;
                vesa = 75;
                vu_holder("vu5",side,vesa,cheight);
            }
            if(case_design == "tray_vu7") {
                cheight = case_z+122;
                vesa = 100;
                vu_holder("vu7",side,vesa,cheight);
            }         
            // additive accessories
            if(accessory_name != "none") {
                for (i=[1:11:len(accessory_data[a[0]])-1]) {
                    class = accessory_data[a[0]][i];
                    type = accessory_data[a[0]][i+1];
                    loc_x = accessory_data[a[0]][i+2];
                    loc_y = accessory_data[a[0]][i+3];
                    loc_z = accessory_data[a[0]][i+4];
                    face = accessory_data[a[0]][i+5];
                    rotation = accessory_data[a[0]][i+6];
                    parametric = accessory_data[a[0]][i+7];
                    size = accessory_data[a[0]][i+8];
                    data = accessory_data[a[0]][i+9];
                    mask = accessory_data[a[0]][i+10];
                    
                    if (class == "add1" && face == side) {
                        parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,size,data,[false,mask[1],mask[2],mask[3]]);
                    }
                }
            }
        }
        // subtractive accessories
        if(accessory_name != "none") {
            for (i=[1:11:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size_x = accessory_data[a[0]][i+8][0];
                size_y = accessory_data[a[0]][i+8][1];
                size_z = accessory_data[a[0]][i+8][2];
                data = accessory_data[a[0]][i+9];
                mask = accessory_data[a[0]][i+10];
                
                if ((class == "sub" && face == side) || class == "suball") {
                    if(accessory_highlight == false) {
                        parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            [size_x,size_y,size_z],data,mask);
                    }
                    else {
                        #parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            [size_x,size_y,size_z],data,mask);
                    }
                }
                // create openings for additive 
                if((class == "add1" || class == "add2" || class == "model") && mask[0] == true) {
                    if(accessory_highlight == false) {
                            parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,[size_x,size_y,size_z],data,mask);
                    }
                    else {
                            #parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,[size_x,size_y,size_z],data,mask);
                    }
                }
            }
        }
        // sbc openings
        if(case_design != "panel_nas") {
            if(sbc_highlight == true) {
                #translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj-adj]) 
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
            }
            else {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj-adj]) 
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
            }
        }
        else {
            if(nas_sbc_location == "top") {
                if(sbc_highlight == true) {
                    #translate([pcb_loc_x ,pcb_loc_y,case_z-(top_height+pcb_loc_z+(2*floorthick))]) 
                        sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
                }
                else {
                    translate([pcb_loc_x ,pcb_loc_y,case_z-(top_height+pcb_loc_z+(2*floorthick))]) 
                        sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
                }
            }
            if(nas_sbc_location == "bottom") {
                if(sbc_highlight == true) {
                    #translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) 
                        sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
                }
                else {
                    translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) 
                        sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, true);
                }
            }
        }
        // indents
        if(indents == true) {
            for (i=[1:11:len(sbc_data[s[0]])-2]) {
                class = sbc_data[s[0]][i+1];
                type = sbc_data[s[0]][i+2];
                pcbid = sbc_data[s[0]][i+3];
                pcbloc_x = sbc_data[s[0]][i+4];
                pcbloc_y = sbc_data[s[0]][i+5];
                pcbloc_z = sbc_data[s[0]][i+6];
                if(class == "pcb") {
                    for (i=[1:11:len(sbc_data[s[0]])-2]) {
                        class = sbc_data[s[0]][i+1];
                        type = sbc_data[s[0]][i+2];
                        id = sbc_data[s[0]][i+3];
                        loc_x = sbc_data[s[0]][i+4]+pcb_loc_x+pcbloc_x;
                        loc_y = sbc_data[s[0]][i+5]+pcb_loc_y+pcbloc_y;
                        loc_z = sbc_data[s[0]][i+6]+pcb_loc_z+pcbloc_z;
                        side = sbc_data[s[0]][i+7];
                        rotation = sbc_data[s[0]][i+8];
                        if(id == pcbid && case_design != "panel_nas") {
                            indent(loc_x, loc_y, bottom_height+loc_z-adj, rotation[2], side, class, type, wallthick, gap, floorthick, pcb_z);
                        }
                        if(id == pcbid && case_design == "panel_nas" && nas_sbc_location == "bottom") {
                            indent(loc_x, loc_y, bottom_height+loc_z-adj, rotation[2], side, class, 
                                type, 2*wallthick, gap, floorthick, pcb_z);

                        }
                        if(id == pcbid && case_design == "panel_nas" && nas_sbc_location == "top") {
                            indent(loc_x, loc_y, case_z-(top_height+pcb_loc_z+(2*floorthick))+.5, rotation[2], 
                                side, class, type, 2*wallthick, gap, floorthick, pcb_z);
                        }
                    }
                }
            }
        }
    }
    if(accessory_name != "none") {
        for (i=[1:11:len(accessory_data[a[0]])-1]) {
            class = accessory_data[a[0]][i];
            type = accessory_data[a[0]][i+1];
            loc_x = accessory_data[a[0]][i+2];
            loc_y = accessory_data[a[0]][i+3];
            loc_z = accessory_data[a[0]][i+4];
            face = accessory_data[a[0]][i+5];
            rotation = accessory_data[a[0]][i+6];
            parametric = accessory_data[a[0]][i+7];
            size = accessory_data[a[0]][i+8];
            data = accessory_data[a[0]][i+9];
            mask = accessory_data[a[0]][i+10];
            
            if (class == "add2" && face == side) {
                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,size,data,[false,mask[1],mask[2],mask[3]]);
            }
        }
    }
}
