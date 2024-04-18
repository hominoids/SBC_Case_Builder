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

    hk_35lcd(mask)
    hk_boom(speakers, orientation, mask)
    hk_boom_grill(style, thick)
    hk_boom_speaker(mask)
    hk_boom_speaker_holder(style, tolerance)
    hk_boom_speaker_pcb(side, speaker, pcb, mask)
    hk_boom_speaker_strap()
    hk_boom_vring(tolerance)
    hk_hc4_oled(mask)
    hk_hc4_oled_holder(side, floorthick, mask)
    hk_m1s_case_holes(type)
    hk_m1s_ups(mask)
    hk_netcard(mask)
    hk_pwr_button(mask)
    hk_speaker()
    hk_uart(mask)
    hk_uart_holder(mask)
    hk_uart_strap ()
    hk_vu7c(gpio_ext, tabs, mask)
    hk_vu8m(bracket, mask)
    hk_vu8s(mask)
    hk_wb2()
    hk_xu4_shifter_shield(mask)
    m1_hdmount()
    proto_m1s()
    proto_ups()
    u_bracket()

*/


/*
           NAME: hk_35lcd
    DESCRIPTION: hardkernel 3.5 lcd
           TODO: none

          USAGE: hk_35lcd(mask)
                          mask[0] = true enables component mask
                          mask[1] = mask length
                          mask[2] = mask setback
                          mask[3] = mstyle "default"

*/

module hk_35lcd(mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];
    adj = .01;
    $fn = 90;

    if(enablemask == true && mstyle == "default") {
        translate([14.5, 1.5, 8.5-adj-msetback]) cube([76.5, 52, mlength]);
    }
    if(enablemask == false) {

        difference() {
            union() {
                color("#008066") slab([95, 56, 1.7], 3.5);
                color("black", 1) translate([10.5, 0, 1.7]) cube([74.75, 54.5, 4]);
                color("white", 1) translate([8.5, 0, 5.7-adj]) cube([82.75, 54.5, 2]);
                color("grey", 1) translate([8.5, 0, 7.7-adj]) cube([82.75, 54.5, .8]);
                color("dimgrey", 1) translate([15, 2, 8.5-adj]) cube([75.5, 51, .25]);
            }
            translate([3.5, 3.5, -adj]) cylinder(d=3, h=6);
            translate([3.5, 52.5, -adj]) cylinder(d=3, h=4);
        }
        button("momentary_4.5x4.5x4.5", 3, 8.75, 0, "top", 0, [0,0,0], [0], 1.7, false, [false,10,2,"default"]);
        button("momentary_4.5x4.5x4.5", 3, 19.75, 0, "top", 0, [0,0,0], [0], 1.7, false, [false,10,2,"default"]);
        button("momentary_4.5x4.5x4.5", 3, 30.75, 0, "top", 0, [0,0,0], [0], 1.7, false, [false,10,2,"default"]);
        button("momentary_4.5x4.5x4.5", 3, 41.75, 0, "top", 0, [0,0,0], [0], 1.7, false, [false,10,2,"default"]);
        header("open", 7.375, .8, 0, "bottom", 0, [20, 2, 6.75], ["thruhole", "black", "female", 2.54,"#fee5a6"], 1.7, false, [false,10,2,"default"]);
        header("open", 92.5, 4, 0, "bottom", 0, [1, 5, 6.75], ["thruhole", "black", "male", 2.54,"#fee5a6"], 1.7, false, [false,10,2,"default"]);
    }
}


/*
           NAME: hk_boom
    DESCRIPTION: hardkernel boom bonnet
           TODO: none

          USAGE: hk_boom(speakers, orientation, mask)

                         speakers = true, false
                      orientation = "front", "rear"
                          mask[0] = true enables component mask
                          mask[1] = mask length
                          mask[2] = mask setback
                          mask[3] = mstyle "default", "pcb", "speakers"
*/

module hk_boom(speakers, orientation, mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        if(mstyle == "default" || mstyle == "pcb") {
            translate([35,35-msetback,5]) rotate([270,0,0]) slot(5, 19, mlength);
            audio("jack_3.5-2", 7.75, 21.75, 0, "top", 180, [6.5,13.5,4], [5,0], 1.6, true, [true,mlength,msetback+2.5,"default"]);
        }
        if(mstyle == "default" || mstyle == "speakers") {
            if(speakers == true && orientation == "rear") {
                translate([-31.5/2,35/2,1.6]) hk_boom_speaker(mask);
                translate([60+(31.5/2),35/2,1.6]) hk_boom_speaker(mask);
            }
            if(speakers == true && orientation == "front") {
                translate([-31.5/2,35/2,0]) rotate([0,180,0]) hk_boom_speaker(mask);
                translate([60+(31.5/2),35/2,0]) rotate([0,180,0]) hk_boom_speaker(mask);
            }
        }
    }
    if(enablemask == false) {
        difference() {
            union() {
                color("#008066") translate ([0,0,0]) slab([60,35,1.6],.5);
                if(speakers == true) {
                    color("#008066") translate ([-31.5,0,0]) slab([31.5,35,1.6],.5);
                    color("white") translate ([-0.25,0,0]) cube([.5,35,1.6]);
                    color("#008066") translate ([60,0,0]) slab([31.5,35,1.6],.5);
                    color("white") translate ([60,0,0]) cube([.5,35,1.6]);
                }
            }
            // pcb holes
            color("#008066") translate([3.5,3.5,-adj]) cylinder(d=3,h=6);
            color("#008066") translate([3.5,31.5,-adj]) cylinder(d=3,h=6);
            color("#008066") translate([56.5,3.5,-adj]) cylinder(d=3,h=4);
            color("#008066") translate([56.5,31.5,-adj]) cylinder(d=3,h=4);
            if(speakers == true) {
                // left
                color("#008066") translate([-28,3.5,-adj]) cylinder(d=3,h=6);
                color("#008066") translate([-28,31.5,-adj]) cylinder(d=3,h=6);
                color("#008066") translate([-3.5,3.5,-adj]) cylinder(d=3,h=6);
                color("#008066") translate([-3.5,31.5,-adj]) cylinder(d=3,h=6);
                // right
                color("#008066") translate([64.5,3.5,-adj]) cylinder(d=3,h=4);
                color("#008066") translate([64.5,31.5,-adj]) cylinder(d=3,h=4);
                color("#008066") translate([88,3.5,-adj]) cylinder(d=3,h=4);
                color("#008066") translate([88,31.5,-adj]) cylinder(d=3,h=4);
                // left speaker openings
                color("#008066") translate([-31.5/2,35/2,-adj]) cylinder(d=23.5, h=3);
                color("#008066") translate([-4-31.5/2,35/2+(23.5/2)-.5,-adj]) cube([6,3,3]);
                color("#008066") translate([-4-31.5/2,35/2-(23.5/2)-2.5,-adj]) cube([6,3,3]);
                color("#008066") translate([-4-31.5/2+(23.5/2)+1,-2+35/2,-adj]) cube([6,3,3]);
                // right speaker openings
                color("#008066") translate([60+(31.5/2),35/2,-adj]) cylinder(d=23.5, h=3);
                color("#008066") translate([60-3+31.5/2,35/2+(23.5/2)-.5,-adj]) cube([6,3,3]);
                color("#008066") translate([60-3+31.5/2,35/2-(23.5/2)-2.5,-adj]) cube([6,3,3]);
                color("#008066") translate([60+1.25,-2+35/2,-adj]) cube([6,3,3]);
            }
        }
        // headers
        header("open", 7.5, 1, 0, "top", 0, [3,1,6], ["thruhole","black","male",2.54,"silver"], 1.6, false, [true,10,2,"default"]);
        header("open", 16, 1, 0, "top", 0, [7,1,6], ["thruhole","black","male",2.54,"silver"], 1.6, false, [true,10,2,"default"]);
        header("open", 40, 11, 0, "top", 0, [2,1,6], ["thruhole","black","male",2.54,"silver"], 1.6, false, [true,10,2,"default"]);
        header("open", 45.5, 11, 0, "top", 0, [2,1,6], ["thruhole","black","male",2.54,"silver"], 1.6, false, [true,10,2,"default"]);
        gpio("encl_header_12", 34, 2, 0, "top", 0, [2,1,6], ["thruhole","black","male",2.54,"silver"], 1.6, false, [true,10,2,"default"]);

        difference() {
            union() {
                color("dimgray", 1) translate([44.5,27,1.6+2]) rotate([0,0,0]) cylinder(d=16, h=3);
                color("dimgray", 1) translate([44.5,27,1.6]) rotate([0,0,0]) cylinder(d=8, h=2);
            }
            color("dimgray", 1) translate([44.5,27,1.6+4]) rotate([0,0,0]) cylinder(d=12, h=3);
            for(d=[5:10:360]) {
                color("dimgray") translate([44.5+(16/2)*cos(d),27+(16/2)*sin(d),1.6+2-adj]) cylinder(d=.75, h=3+2*adj);
            }
        }
        color("gray", 1) translate([45,27,1.6+4-adj]) rotate([0,0,0]) cylinder(d=1.5, h=.25);
        jst("ph", 0, 13.75, 0, "top", 90, [2,0,0], ["thruhole","top","white"], 1.6, false, [true,10,2,"default"]);
        jst("ph", 55.75, 13.75, 0, "top", 270, [2,0,0], ["thruhole","top","white"], 1.6, false, [true,10,2,"default"]);
        discrete("capacitor", 20, 30, 0, "top", 0, [6.25,0,6.5], [0], 1.6, false, [true,10,2,"default"]);
        discrete("capacitor", 30, 30, 0, "top", 0, [6.25,0,6.5], [0], 1.6, false, [true,10,2,"default"]);
        audio("jack_3.5-2", 7.75, 21.75, 0, "top", 180, [6.5,13.5,4], [5,2], 1.6, false, [true,10,2,"default"]);
        translate([22,16,1.6-adj]) color("dimgrey") cube([6.5,4.5,1]);
        translate([10,12,1.6-adj]) color("dimgrey") cube([4,4,1]);
        translate([32.5,9,1.6-adj]) color("dimgrey") cube([3.5,3,1]);
        if(speakers == true && orientation == "rear") {
            translate([-31.5/2,35/2,1.6]) hk_boom_speaker([false,10,0,"default"]);
            translate([60+(31.5/2),35/2,1.6]) hk_boom_speaker([false,10,0,"default"]);
        }
        if(speakers == true && orientation == "front") {
            translate([-31.5/2,35/2,0]) rotate([0,180,0]) hk_boom_speaker([false,10,0,"default"]);
            translate([60+(31.5/2),35/2,0]) rotate([0,180,0]) hk_boom_speaker([false,10,0,"default"]);
        }
    }
}


/*
           NAME: hk_boom_grill
    DESCRIPTION: hardkernel stereo boom bonnet speaker grill
           TODO: none

          USAGE: hk_boom_grill(style, thick)

                               style = "flat", "frame", "dome"
                               thick = material thickness
*/

module hk_boom_grill(style, thick) {

    adj = .01;
    $fn = 90;
    if(style == "dome" || style == "frame") {
        difference() {
            union() {
                difference() {
                    translate([0,0,-23]) sphere(d=52.5);
                    translate([0,0,-25]) sphere(d=52.5);
                    translate([-30,-30,-60.5]) cube([60,60,60]);
                    for(c=[-14.5:3:24]) {
                        for(r=[-14.5:3:24]) {
                            translate([r,c,-1]) cube([2,2,40]);
                        }
                    }
                }
                if(style == "frame") {
                    difference() {
                        translate([0,0,-1.25]) cylinder(d=30.5, h=thick);
                        translate([0,0,-1.25-adj]) cylinder(d=24, h=thick+2*adj);
                    }
                }
            }
        }
    }
    if(style == "flat") {
        difference() {
            translate([0,0,0]) cylinder(d=27, h=thick);
            for(c=[-14.5:3:24]) {
                for(r=[-14.5:3:24]) {
                    translate([r,c,-1]) cube([2,2,thick+2]);
                }
            }
        }
    }
}


/*
           NAME: hk_boom_speaker
    DESCRIPTION: hardkernel stereo boom bonnet speakers
           TODO: none

          USAGE: hk_boom_speaker(mask)
                              mask[0] = true enables component mask
                              mask[1] = mask length
                              mask[2] = mask setback
                              mask[3] = mstyle "default"
*/

module hk_boom_speaker(mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        translate([0,0,-msetback]) cylinder(d=27, h=mlength);
    }
    if(enablemask == false) {
        difference() {
            union() {
                color("silver") translate([0,0,-8.5]) cylinder_fillet_inside(h=6.5, r=21.4/2, 
                    top=0, bottom=2, $fn=90, fillet_fn=30, center=false);
                color("dimgray") translate([0,0,2.5-adj]) cylinder_fillet_inside(h=1, r=21.75/2, 
                    top=1, bottom=0, $fn=90, fillet_fn=30, center=true);

                difference() {
                    color("black") translate([0,0,-5-adj]) cylinder(d=23.7, h=5);
                    for(d=[30:60:360]) {
                        color("dimgray") translate([(23.7/2)*cos(d),(23.7/2)*sin(d),-6-adj]) cylinder(d=6, h=5+2*adj);
                    }
                }
                color("black") translate([0,0,-adj]) cylinder(d=27.8, h=2);
                color("dimgray") translate([0,0,1]) cylinder(d=22.8, h=1);
                color("dimgray") translate([0,0,1]) cylinder(d=17.5, h=1.25);
            }
            color("darkgray") translate([0,0,10.5]) sphere(d=23);
        }
    }
}


/*
           NAME: hk_boom_speaker_holder
    DESCRIPTION: hardkernel stereo boom bonnet speaker holder
           TODO: none

          USAGE: hk_boom_speaker_holder(style, tolerance)

                               style = "friction", "clamp"
                           tolerance = friction adjustment
*/

module hk_boom_speaker_holder(style, tolerance=0) {

    adj = .01;
    $fn = 90;

    if(style == "friction") {
        difference() {
            translate([0,0,0]) cylinder(d=31, h=4);
            translate([0,0,-adj]) cylinder(d=28+tolerance, h=4+2*adj);
            translate([0,-1,-adj]) cube([15,40,10], center=true);
        }  
        difference() {
            translate([0,0,0]) cylinder(d=28+tolerance, h=2);
            translate([0,0,-adj]) cylinder(d=28+tolerance-2, h=4+2*adj);
            translate([0,-1,-adj]) cube([15,40,10], center=true);
        }
    }

    if(style == "clamp") {
        // bottom clamp
        topthick = 2;
        top_height = 14;
        difference() {
            cube([10.5,29,top_height-topthick]);
            // speaker holders
                translate([-1,14.5,14]) rotate([0,90,0]) cylinder(d=28, h=4.5);
                translate([2,14.5,14]) rotate([0,90,0]) cylinder(d=24, h=6);
                translate([4,14.5,14]) rotate([0,90,0]) cylinder(d=21.9, h=7.8);
        }
    }
}


/*
           NAME: hk_boom_speaker_pcb
    DESCRIPTION: hardkernel stereo boom bonnet speakers with optional speaker pcbs
           TODO: none

          USAGE: hk_boom_speaker_pcb(side, speaker, pcb, mask)

                                 side = "left, "right"
                             speakers = true, false
                          orientation = "front", "rear"
                              mask[0] = true enables component mask
                              mask[1] = mask length
                              mask[2] = mask setback
                              mask[3] = mstyle "default"
*/

module hk_boom_speaker_pcb(side, speaker, pcb, mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        translate([31.5/2,35/2,0]) hk_boom_speaker(mask);
    }
    if(enablemask == false) {
        if(pcb == true) {
            difference() {
                color("#008066") slab([31.5,35,1.6],.5);
                color("#008066") translate([27.5,4,-adj]) cylinder(d=3,h=6);
                color("#008066") translate([27.5,31,-adj]) cylinder(d=3,h=6);
                color("#008066") translate([4,4,-adj]) cylinder(d=3,h=6);
                color("#008066") translate([4,31,-adj]) cylinder(d=3,h=6);
                
                // speaker openings
                color("#008066") translate([(31.5/2),35/2,-adj]) cylinder(d=23.5, h=3);
                color("#008066") translate([-3+31.5/2,35/2+(23.5/2)-.5,-adj]) cube([6,3,3]);
                color("#008066") translate([-3+31.5/2,35/2-(23.5/2)-2.5,-adj]) cube([6,3,3]);
                if(side == "right") {
                    color("#008066") translate([.5,-2+35/2,-adj]) cube([6,3,3]);
                }
                if(side == "left") {
                    color("#008066") translate([31.5/2+(23.5/2)-2.5,-2+35/2,-adj]) cube([6,3,3]);
                }
            }
        }
        if(speaker == true && pcb == true) {
            translate([(31.5/2),35/2,1.6]) hk_boom_speaker([false,10,0,"default"]);
        }
        if(speaker == true && pcb == false) {
            hk_boom_speaker([false,10,0,"default"]);
        }
    }
}


/*
           NAME: hk_boom_speaker_strap
    DESCRIPTION: hardkernel stereo boom bonnet speaker clamp holder top
           TODO: none

          USAGE: hk_boom_speaker_strap(side)

                                    side = "left", "right"
*/

module hk_boom_speaker_strap(side) {

    topthick = 2;
    top_height = 14;
    adj = .01;
    $fn = 90;
    // top clamp
    difference() {
        difference() {
            union() {
                translate([-3,14.5,top_height]) rotate([0,90,0]) cylinder(d=35,h=13.75);
                if(side == "left") {
                    translate([5.4,16.5,top_height+(topthick/2)-1]) cube_fillet_inside([16.75,55,topthick], 
                    vertical=[6,1,6,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                }        
                if(side == "right") {
                    translate([5.4,13,top_height+(topthick/2)-1]) cube_fillet_inside([16.75,55,topthick], 
                        vertical=[1,6,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                }
            translate([10.75-adj,14.5,top_height]) rotate([0,90,0]) cylinder(d=35,h=3);
            }
            translate([-9.25,0,top_height-topthick-adj]) cube([20,29,topthick]);
            difference() {
                translate([-4.25,14.5,14]) rotate([0,90,0]) cylinder(d=28, h=15);
                translate([-5.25,0,19]) cube([20,30,19.5]);
            }
        }
        // speaker holders
        translate([-3-adj,14.5,14]) rotate([0,90,0]) cylinder(d=30.8, h=4.5);
        translate([-3-adj,14.5,14]) rotate([0,90,0]) cylinder(d=32.8, h=2);
        translate([-2.75,14.5,14]) rotate([0,90,0]) cylinder(d=28, h=14.5);
        translate([-4.55,-4,-4]) cube([20,37,topthick+15]);

        if(side == "left") {
            translate([4.15,-3.4,-adj]) cylinder(d=3.2, h=50);
            translate([4.15,-3.4,15]) cylinder(d=6, h=10);
            translate([5.75,40,-adj]) cylinder(d=3.2, h=50);
        }
        if(side == "right") {
            translate([4.5,32.5,-adj]) cylinder(d=3.2, h=50);
            translate([4.5,32.5,15]) cylinder(d=6, h=10);
            translate([10.5,-11,-adj]) cylinder(d=3.2, h=50);
        }
    }
}


/*
           NAME: hk_boom_vring
    DESCRIPTION: hardkernel stereo boom bonnet volume ring
           TODO: none

          USAGE: hk_boom_vring(tolerance)

                            tolerance = friction fit adjustment
*/

module hk_boom_vring(tolerance) {

    out_dia = 22;
    in_dia = 16.15 + tolerance;
    thick = 3;
    nub = 1.25;
    adj = .01;
    $fn = 90;
    difference() {
        color("black") translate([0,0,0])cylinder(d=out_dia, h=thick);
        color("dimgray") translate([0,0,-adj]) cylinder(d=in_dia, h=thick+2*adj);
        for(d=[5:10:360]) {
            color("dimgray") translate([(out_dia/2)*cos(d),(out_dia/2)*sin(d),-adj]) cylinder(d=nub, h=thick+2*adj);
        }
    }
}


/*
           NAME: hk_hc4_oled
    DESCRIPTION: hardkernel odroid-hc4 oled
           TODO: none

          USAGE: hk_hc4_oled(mask)
*/

module hk_hc4_oled(mask) {
    
    adj = .01;
    $fn=90;
    oled_x = 28.5;
    oled_y = 1.25;
    oled_z = 48.6;
    oled_open_x = 29;
    oled_open_y = 1.5;

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    if(enablemask == true) {
        translate([.5,2-msetback+mlength,25.25]) rotate([90,0,0]) slab([27.5,15.5,mlength], .25);
    }
    if(enablemask == false) {

        difference() {
            union() {
                // pcb board
                color("#008066", 1) translate([0,0,0]) cube([oled_x,oled_y,oled_z]);
                // oled
                color("Black", 1) translate([.5,1.25,25.5]) cube([oled_x-1,.625,15]);
                color("DarkGrey", 1) translate([.5,1.25,40.5]) cube([oled_x-1,.625,4]);
            }
            color("#008066", 1) translate([2.8,0,46.7]) {
                translate([-.6,1.26,0]) rotate([90,0,0])
                    hull() {
                        translate([1.2,0,0]) cylinder(d=1.8, h=1.25+(adj*2));
                        cylinder(d=1.8, h=1.25+(adj*2));
                    }
            }
            color("#008066", 1) translate([25.7,0,46.7]) {
                translate([-.6,1.26,0]) rotate([90,0,0])
                    hull() {
                        translate([1.2,0,0]) cylinder(d=1.8, h=1.25+(adj*2));
                        cylinder(d=1.8, h=1.25+(adj*2));
                    }
            }
        }
    }
}


/*
           NAME: hk_hc4_oled_holder
    DESCRIPTION: hardkernel odroid-hc4 oled holder
           TODO: none

          USAGE: hk_hc4_oled_holder(side, wallthick, mask)

                                 side = "top", "bottom"
                            wallthick = wall thickness
*/

module hk_hc4_oled_holder(side, wallthick, mask) {

    adj=.01;
    $fn = 90;

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    if(enablemask == true) {
        translate([.5,2-msetback+mlength,25.25]) rotate([90,0,0]) slab([27.5,15.5,mlength], .25);
    }
    if(enablemask == false) {
        difference() {
            union() {
                if(side == "top") {
                    translate([-1.85,-1.75,-4]) cube([32,5,4]);
                    translate([30.15,-3.75,1]) 
                        rotate([0,-90,0]) 
                        linear_extrude(height = 32) 
                            polygon(points = [ [-wallthick/2,-wallthick/2],
                                [-4,wallthick], 
                                [-4,2], 
                                [-wallthick/2,2]]);
                            translate([-1.85,4,1]) 
                                rotate([0,-90,180]) 
                                linear_extrude(height = 32) 
                                    polygon(points = [ [-wallthick/2,-wallthick/2],
                                        [-4,wallthick], 
                                        [-4,2], 
                                        [-wallthick/2,2]]);
                }
                if(side == "bottom") {
                    translate([-1.85,-1.75,0]) cube([32,5,4]);
                        translate([30.15,-3.75,1]) 
                            rotate([0,-90,0]) 
                            linear_extrude(height = 32) 
                                polygon(points = [ [-wallthick/2,-wallthick/2],
                                    [2,wallthick], 
                                    [2,2], 
                                    [-wallthick/2,2]]);
                        translate([-1.85,4,1]) 
                            rotate([0,-90,180]) 
                            linear_extrude(height = 32) 
                                polygon(points = [ [-wallthick/2,-wallthick/2],
                                    [2,wallthick], 
                                    [2,2], 
                                    [-wallthick/2,2]]);
                }
            }
            if(side == "top") {
                translate([-.5,0,wallthick-8]) cube([29.5,1.9,5]);
                translate([(32.75/2-(15/2))-1.85,-adj-3-1.75,-wallthick-2.5]) cube([15,12,wallthick+3]);
            }
            if(side == "bottom") {
                translate([-.5,0,-adj]) cube([29.5,1.42,5]);
                translate([(32.75/2-(15/2))-1.85,-adj-3-1.75,-adj]) cube([15,12,8]);
                translate([2.5,-adj-3-1.75,-adj]) cube([6,3,8]);
                translate([12.5,adj,10]) rotate([90,0,0]) cylinder(d=21, h=2);
            }
        }
    }
}


/*
           NAME: hk_m1s_case_holes
    DESCRIPTION: hardkernel odroid-m1s oem case hole pattern 
           TODO: none

          USAGE: hk_m1s_case_holes(type = "landscape")

                                   type = "landscape", "portrait"
*/

module hk_m1s_case_holes(type = "landscape") {
    
    if(type == "portrait") {
        cylinder(d=3, h=6);
        translate([0,107,0]) cylinder(d=3, h=6);
        translate([58,0,0]) cylinder(d=3, h=6);
        translate([58,107,0]) cylinder(d=3, h=6);
    }
    else {
        cylinder(d=3, h=6);
        translate([0,58,0]) cylinder(d=3, h=6);
        translate([107,0,0]) cylinder(d=3, h=6);
        translate([107,58,0]) cylinder(d=3, h=6);
    }
}


/*
           NAME: hk_m1s_ups
    DESCRIPTION: hardkernel odroid-m1s ups
           TODO: none

          USAGE: hk_m1s_ups(mask)

                            mask[0] = true enables component mask
                            mask[1] = mask length
                            mask[2] = mask setback
                            mask[3] = mstyle "default"
*/

module hk_m1s_ups(mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    pcb_size = [115,32,1.62];
    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        usbc("single_horizontal", 97.5, -1, 0, "top", 0, [0,0,0], [0], pcb_size[2], true, [true,mlength,msetback,mstyle]);
    }
    if(enablemask == false) {
        difference() {
            union() {
                color("#008066") slab(pcb_size,4);
                color("#fee5a6") translate([3.5,3.5,-.1]) cylinder(d=5.5, h=pcb_size[2]+.2);
                color("#fee5a6") translate([3.5,pcb_size[1]-3.5,-.1]) cylinder(d=5.5, h=pcb_size[2]+.2);
                color("#fee5a6") translate([pcb_size[0]-3.5,3.5,-.1]) cylinder(d=5.5, h=pcb_size[2]+.2);
                color("#fee5a6") translate([pcb_size[0]-3.5,pcb_size[1]-3.5,-.1]) cylinder(d=5.5, h=pcb_size[2]+.2);
            }
            color("#fee5a6") translate([3.5,3.5,-1]) cylinder(d=4, h=4);
            color("#fee5a6") translate([3.5,pcb_size[1]-3.5,-1]) cylinder(d=4, h=4);
            color("#fee5a6") translate([pcb_size[0]-3.5,3.5,-1]) cylinder(d=4, h=4);
            color("#fee5a6") translate([pcb_size[0]-3.5,pcb_size[1]-3.5,-1]) cylinder(d=4, h=4);
        }
        // battery and clips
        color("grey") translate([15,5,pcb_size[2]]) rotate([0,0,270]) battery_clip();
        color("grey") translate([80,16,pcb_size[2]]) rotate([0,0,90]) battery_clip();
        translate([13.25,10.5,pcb_size[2]+10.4]) rotate([0,90,0]) battery("18650_convex");

        header("open", 78, 26.5, 0, "top", 0, [7,2,6], ["thruhole","black","male",2.54,"silver"], pcb_size[2], false, [true,10,2,"default"]);
        button("momentary_4.5x4.5x4.5", 86.75, .5, 0, "top", 0, [0,0,0], [0], pcb_size[2], false, [false,10,2,"default"]);
        usbc("single_horizontal", 97.5, -1, 0, "top", 0, [0,0,0], [0], pcb_size[2], false, [false,10,2,"default"]);
        smd("led", 35, 28, 0, "top", 0, [3,1.5,.5], ["DodgerBlue"], pcb_size[2], false, [false,10,2,"default"]);
        smd("led", 40, 28, 0, "top", 0, [3,1.5,.5], ["DodgerBlue"], pcb_size[2], false, [false,10,2,"default"]);
        smd("led", 45, 28, 0, "top", 0, [3,1.5,.5], ["DodgerBlue"], pcb_size[2], false, [false,10,2,"default"]);
        smd("led", 50, 28, 0, "top", 0, [3,1.5,.5], ["DodgerBlue"], pcb_size[2], false, [false,10,2,"default"]);
        smd("led", 111.5, 8, 0, "top", 90, [3,1.5,.5], ["green"], pcb_size[2], false, [false,10,2,"default"]);
        smd("led", 111.5, 16, 0, "top", 90, [3,1.5,.5], ["red"], pcb_size[2], false, [false,10,2,"default"]);
        smd("led", 111.5, 21, 0, "top", 90, [3,1.5,.5], ["red"], pcb_size[2], false, [false,10,2,"default"]);
    }
}


/*
           NAME: hk_netcard
    DESCRIPTION: hardkernel m.2 network card
           TODO: none

          USAGE: hk_netcard(mask)
*/

module hk_netcard(mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        translate([25.5, msetback-1,-14]) rotate([90, 0, 0]) slab([68, 14.5, mlength], .25);
    }
    if(enablemask == false) {

        difference() {
            union() {
                color("#008066") translate ([0,0,0]) linear_extrude(height = 1) import("./dxf/hk-network-card.dxf");
                color("goldenrod") translate([3.75,17.85,1-adj]) cylinder(d=6,h=3);
                color("goldenrod") translate([106,24.85,1-adj]) cylinder(d=6,h=3);
            }
            translate([20.85,3.85,-adj]) cylinder(d=3,h=4);
            translate([3.75,17.85,-adj]) cylinder(d=3,h=6);
            translate([3.75,51.1,-adj]) cylinder(d=3,h=4);
            translate([20.15,43.85,-adj]) cylinder(d=3,h=4);
            translate([106,24.85,-adj]) cylinder(d=3,h=6);
            translate([96.5,3.85,-adj]) cylinder(d=3,h=4);
        }
        network("rj45_single", 26, -1, 0, "bottom", 0, [6, 6, .8], [0], 1, false, [false, 0, 0, "none"]);
        network("rj45_single", 43, -1, 0, "bottom", 0, [6, 6, .8], [0], 1, false, [false, 0, 0, "none"]);
        network("rj45_single", 60, -1, 0, "bottom", 0, [6, 6, .8], [0], 1, false, [false, 0, 0, "none"]);
        network("rj45_single", 77, -1, 0, "bottom", 0, [6, 6, .8], [0], 1, false, [false, 0, 0, "none"]);
        ic("generic", 30, 25, 0, "bottom", 0, [6, 6, .8], ["dimgrey"], 1, false, [false, 0, 0, "none"]);
        ic("generic", 47, 25, 0, "bottom", 0, [6, 6, .8], ["dimgrey"], 1, false, [false, 0, 0, "none"]);
        ic("generic", 64, 25, 0, "bottom", 0, [6, 6, .8], ["dimgrey"], 1, false, [false, 0, 0, "none"]);
        ic("generic", 79, 25, 0, "bottom", 0, [6, 6, .8], ["dimgrey"], 1, false, [false, 0, 0, "none"]);
        ic("generic", 56.5, 41, 0, "bottom", 0, [5, 9.75, .8], ["dimgrey"], 1, false, [false, 0, 0, "none"]);
        for (i=[34.65:.5:48.5]) {
            color("#fee5a6") translate([98,i,1]) cube([2,.25,.25]);
            color("#fee5a6") translate([98,i,-.24]) cube([2,.25,.25]);
        }
        for (i=[51:.5:53]) {
            color("#fee5a6") translate([98,i,1]) cube([2,.25,.25]);
            color("#fee5a6") translate([98,i,-.24]) cube([2,.25,.25]);
        }
    }
}


/*
           NAME: hk_pwr_button
    DESCRIPTION: hardkernel power button
           TODO: none

          USAGE: hk_pwr_button(mask)

                               mask[0] = true enables component mask
                               mask[1] = mask length
                               mask[2] = mask setback
                               mask[3] = mstyle "default"
*/

module hk_pwr_button(mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj=.01;
    $fn = 90;

    if(enablemask == true) {
        translate([0, 0, -mlength+msetback+adj]) cylinder(d=16, h=mlength);
    }
    if(enablemask == false) {
        difference() {
            union() {
                // light ring
                difference() {
                    color("blue", .6) translate([0, 0, 1.67]) cylinder(h=.1, d=14.75);
                    color("blue", .6) translate([0, 0, 1.66]) cylinder(h=.2, d=13.75);
                }
                // power symbol
                color("blue", .6) translate([-.5, 0, 1.65]) color("blue", .6) cube([1,3.5,.1]);
                difference() {
                    color("blue", .6) translate([0, 0, 1.66]) cylinder(h=.1, d=5.75);
                    color("blue", .6) translate([0, 0, 1.65]) cylinder(h=.2, d=4.5);
                    color("blue", .6) translate([-1.75, 0, 1.65]) cube([3.5,4,2]);
                }
                // body
                color("Gainsboro") cylinder(h=1.66, d1=17.75, d2=14.75);
                color("silver") translate([0, 0, -19]) cylinder(h=19, d=15.8);
                difference() {
                    color("steelblue") translate([0, 0, -27.9]) cylinder(h=9, d=15.8);
                    color("steelblue") translate([-1+15.8/2, -4, -19-9.1]) cube([2,8,6.1]);
                    color("steelblue") translate([-1-15.8/2, -4, -19-9.1]) cube([2,8,6.1]);
                }
                color("white") translate([-3.5, -6, -28]) cube([7,12,2]);

                // nut
                difference() {
                    translate([0, 0, -4.75]) color("Gainsboro", .6) cylinder(h=2.75, d=21.5, $fn=6);
                    translate([0, 0, -4.75]) color("Gainsboro", .6) cylinder(h=2.75, d=15.8);
                }
                // connector pins
                color("silver") translate([-1.4, -.5, -34.99]) cube([2.8, 1, 7]);
                color("silver") translate([-1.4, -.5+5, -34.99]) cube([2.8, 1, 7]);
                color("silver") translate([-1.4, -.5-5, -34.99]) cube([2.8, 1, 7]);
                color("silver") translate([-1.4-1.75, -.5+1.75, -34.99]) cube([1, 2.8, 7]);
                color("silver") translate([-1.4+3.5, -.5+1.75, -34.99]) cube([1, 2.8, 7]);
            }
         }
    }
}


/*
           NAME: hk_speaker
    DESCRIPTION: hardkernel speaker
           TODO: none

          USAGE: hk_speaker()
*/

module hk_speaker() {

    spk_x = 44;
    spk_y = 20;
    spk_z = 98;
    c_hole = 6;
    i_dia = c_hole+3;
    adj = .1;

    difference() {
        translate([spk_x/2,spk_y/2,spk_z/2]) cube_fillet_inside([spk_x,spk_y,spk_z], 
            vertical=[0,0,0,0,0], top=[0,c_hole,0,c_hole], bottom=[0,c_hole,0,c_hole], $fn=90);
        // speaker cone
        translate([spk_x/2,-adj,spk_z-72]) rotate([-90,0,0]) cylinder(d=36, h=.5);

        // corner holes
        translate([(c_hole/2)+2,-adj,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adj));
        translate([(c_hole/2)+2,-adj,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adj));
        translate([spk_x-(c_hole/2)-2,-adj,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adj));
        translate([spk_x-(c_hole/2)-2,-adj,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adj));

        // lower left corner indent
        translate([(c_hole/2)+2,-adj,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adj);
        translate([-adj-1,-adj,-adj]) cube([c_hole+adj,10+adj,i_dia+adj+.5]);
    translate([adj+.5,-adj,-(i_dia/2)+adj]) cube([i_dia+adj,10+adj,i_dia+adj+.5]);
    translate([(c_hole/2)+2,-adj+12+adj,(c_hole/2)+2]) rotate([-90,0,0]) 
        cylinder(d=i_dia, h=10+adj);
    translate([-adj-1,-adj+12+adj,-adj]) cube([c_hole+adj,10+adj,i_dia+adj+.5]);
    translate([adj+.5,-adj+12+adj,-(i_dia/2)+adj]) cube([i_dia+adj,10+adj,i_dia+adj+.5]);

    // upper left corner corner indent
    translate([(c_hole/2)+2,-adj,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
        cylinder(d=i_dia, h=10+adj);
    translate([-adj-1,-adj,spk_z-i_dia-.5]) cube([c_hole+adj,10+adj,i_dia+adj+.5]);
    translate([-adj+.5,-adj,spk_z-(i_dia/2)+adj-.5]) cube([i_dia,10+adj,i_dia+adj+.5]);
    translate([(c_hole/2)+2,-adj+12,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
        cylinder(d=i_dia, h=10+adj);
    translate([-adj-1,-adj+12,spk_z-i_dia-.5]) cube([c_hole+adj,10+adj,i_dia+adj+.5]);
    translate([-adj+.5,-adj+12,spk_z-(i_dia/2)+adj-.5]) cube([i_dia,10+adj,i_dia+adj+.5]);

    // upper right corner corner indent
    translate([spk_x-(c_hole/2)-2,-adj,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
        cylinder(d=i_dia, h=10+adj);
    translate([spk_x-1-(i_dia/2),-adj,spk_z-i_dia+adj-.5]) cube([c_hole+adj,10+adj,i_dia+adj+.5]);
    translate([spk_x-.5-i_dia,-adj,spk_z-(i_dia/2)+adj-.5]) cube([i_dia,10+adj,i_dia+adj+.5]);
    translate([spk_x-(c_hole/2)-2,-adj+12,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
        cylinder(d=i_dia, h=10+adj);
    translate([spk_x-1-(i_dia/2),-adj+12,spk_z-i_dia+adj-.5]) cube([c_hole+adj,10+adj,i_dia+adj+.5]);
    translate([spk_x-.5-i_dia,-adj+12,spk_z-(i_dia/2)+adj-.5]) cube([i_dia,10+adj,i_dia+adj+.5]);

    // lower right corner corner indent
    translate([spk_x-(c_hole/2)-2,-adj,(c_hole/2)+2]) rotate([-90,0,0]) 
        cylinder(d=i_dia, h=10+adj);
    translate([spk_x-1-(i_dia/2),-adj,-adj]) cube([c_hole+adj,10+adj,i_dia+adj+.5]);
    translate([spk_x-.5-i_dia,-adj,-(i_dia/2)+adj]) cube([i_dia,10+adj,i_dia+adj+.5]);
    translate([spk_x-(c_hole/2)-2,-adj+12,(c_hole/2)+2]) rotate([-90,0,0]) 
        cylinder(d=i_dia, h=10+adj);
    translate([spk_x-1-(i_dia/2),-adj+12,-adj]) cube([c_hole+adj,10+adj,i_dia+adj+.5]);
    translate([spk_x-.5-i_dia,-adj+12,-(i_dia/2)+adj]) cube([i_dia,10+adj,i_dia+adj+.5]);
    }
    // speaker cone
    translate([spk_x/2,-adj+46,spk_z-72]) {
        difference() {
            translate([0,0,0]) sphere(d=96, $fn=180);
            translate([-50,-46,-50]) cube([100,100,100]);
        }
    }
}


/*
           NAME: hk_uart
    DESCRIPTION: hardkernel micro-usb console uart
           TODO: none

          USAGE: hk_uart(mask)

                         mask[0] = enablemask
                         mask[1] = mask length
                         mask[2] = mask setback
                         mask[3] = mask style, "default"
*/

module hk_uart(mask) {

    size = [22,13,1.25];
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        translate([23-msetback,2,3]) rotate([90,0,90]) slot(4, 8.5, mlength);
    }
    if(enablemask == false) {
        color("#008066") cube([size[0],size[1],size[2]]);
        translate([6.75,3,-2+adj])cylinder(d=.62, 2);
        translate([6.75,5.25,-2+adj])cylinder(d=.62, 2);
        translate([6.75,7.5,-2+adj])cylinder(d=.62, 2);
        translate([6.75,9.75,-2+adj])cylinder(d=.62, 2);
        uart("molex_5268",.5,.25,0,"top", 90, [0,0,0], [0], size[2], false, [false,0,0,"none"]);
        usb2("micro",18.5, 2.5, 0, "top", 270, [0,0,0], [0], size[2], false, [false,0,0,"none"]);
        ic("generic", 13, 4.5, 0, "top", 0, [4,4,1], ["dimgrey"], size[2], false, [false,0,0,"none"]);
    }
}


/*
           NAME: hk_uart_holder
    DESCRIPTION: hardkernel micro-usb uart holder
           TODO: none

          USAGE: hk_uart_holder(mask)

                                mask[0] = enablemask
                                mask[1] = mask length
                                mask[2] = mask setback
                                mask[3] = mask style, "default"
*/

module hk_uart_holder(mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    if(enablemask == true) {
        translate([4.5,msetback-1,6]) rotate([90,0,0]) slot(4, 8.5, mlength);
    }
    if(enablemask == false) {
//        translate([22,-2.5,-3]) rotate([0,0,90])
        union () {
            difference () {
                cube([18,21.75,9]);
                translate ([2,-2,3]) cube([14,27,7]);
                //pin slot
                translate ([3.5,14.75,-1]) cube([11,1,5]);
                //component bed
                translate ([3.5,1.5,2]) cube ([11,14,2]);
                //side trim
                translate ([-1,-2.5,6]) cube([20,18,4]);
            }
            difference (){
                translate ([-1.5,18.5,0]) cylinder(r=3,h=9, $fn=90);
                translate ([-1.5,18.5,-1]) cylinder (r=1.375, h=11, $fn=90);
            }
            difference (){
                translate ([19.5,18.5,0]) cylinder(r=3,h=9, $fn=90);
                translate ([19.5,18.5,-1]) cylinder (r=1.375, h=11,$fn=90);
            }
        }
    }
}


/*
           NAME: hk_uart_strap
    DESCRIPTION: hardkernel micro-usb uart holder strap
           TODO: none

          USAGE: hk_uart_strap()

*/

module hk_uart_strap() {

    translate([22,-2.5,-3]) rotate([0,0,90])
    union() {
        difference () {
            translate ([-4.5,15.5,9]) cube([27,6,3]);
            translate ([-1.5,18.5,8]) cylinder (r=1.6, h=5, $fn=90);
            translate ([19.5,18.5,8]) cylinder (r=1.6, h=5, $fn=90);
        }   
        difference (){
            translate ([-1.5,18.5,12]) cylinder(r=3,h=1, $fn=90);
            translate ([-1.5,18.5,11]) cylinder (r=1.6, h=7, $fn=90);
        }
        difference (){
            translate ([19.5,18.5,12]) cylinder(r=3,h=1, $fn=90);
            translate ([19.5,18.5,11]) cylinder (r=1.6, h=7, $fn=90);
        }
    }
}


/*
           NAME: hk_vu7c
    DESCRIPTION: hardkernel vu7c lcd display
           TODO: none

          USAGE: hk_vu7c(gpio_ext, tabs, mask)

                         gpio_ext = true, false
                             tabs = true, false
                          mask[0] = true enables component mask
                          mask[1] = mask length
                          mask[2] = mask setback
                          mask[3] = mstyle "default"
*/

module hk_vu7c(gpio_ext, tabs, mask) {
    
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    lcd_size = [164.85,100,5.48];
    pcb_size = [184.6,75,1.6];
    view_size = [155,88.5,.125];        // 154.21 x 85.92
    hole = 3.2;
    length = 24-hole;
    depth = 2;

    adj = .1;
    $fn = 90;

    if(enablemask == true && mstyle == "default") {
        translate([2.5,7,pcb_size[2]+3.12+lcd_size[2]-adj]) cube([view_size[0]+1, view_size[1]+1, mlength]);
        video("hdmi_a", 70, 28.58, 0, "bottom", 0, [0,0,0], [0], pcb_size[2], true, [true,10,2,"default"]);
//        translate([55.8,103.5,-adj-msetback]) cylinder(d=hole, h=mlength);
//        translate([108.8,103.5,-adj-msetback]) cylinder(d=hole, h=mlength);
    }
    if(enablemask == false) {
        difference() {
            union() {
                color("lightgray") translate([0,0,pcb_size[2]+3.12]) cube(lcd_size);
                if(tabs == true) {
                    color("#383838") translate([-(pcb_size[0]-lcd_size[0])/2,lcd_size[1]-pcb_size[1]-1,0]) 
                        cube(pcb_size);
                }
                else {
                    color("#383838") translate([0,lcd_size[1]-pcb_size[1]-1,0]) 
                        cube([pcb_size[0]-20,pcb_size[1],pcb_size[2]]);
                }
                color("black") translate([3,7.5,pcb_size[2]+3.12+lcd_size[2]-adj]) cube(view_size);
                // tabs
                color("#383838") translate([51.8,99,0]) slab_r([8,8,1.6],[.1,4,4,.1]);
                color("#383838") translate([104.8,99,0]) slab_r([8,8,1.6],[.1,4,4,.1]);
            }
            // slots
            color("dimgray") translate([-(pcb_size[0]-lcd_size[0])/4,lcd_size[1]-1-7,-adj]) 
                rotate([0,0,-90]) slot(hole,length,depth);
            color("dimgray") translate([-(pcb_size[0]-lcd_size[0])/4,lcd_size[1]-1-46,-adj]) 
                rotate([0,0,-90]) slot(hole,length,depth);
            color("dimgray") translate([(pcb_size[0]-(pcb_size[0]-lcd_size[0])/2)-(pcb_size[0]-lcd_size[0])/4,
                lcd_size[1]-1-7,-adj]) rotate([0,0,-90]) slot(hole,length,depth);
            color("dimgray") translate([(pcb_size[0]-(pcb_size[0]-lcd_size[0])/2)-(pcb_size[0]-lcd_size[0])/4,
                lcd_size[1]-1-46,-adj]) rotate([0,0,-90]) slot(hole,length,depth);
            // holes
            color("dimgray") translate([55.8,103.5,-adj]) cylinder(d=hole, h=3);
            color("dimgray") translate([108.8,103.5,-adj]) cylinder(d=hole, h=3);
            // pcb cuts
            color("dimgray") translate([66,97.5,-adj]) slab_r([20.3,4,2],[1,1,1,1]);
            color("dimgray") translate([17.8,lcd_size[1]-pcb_size[1]-2,-adj]) slab_r([78.8,6,2],[1,1,1,1]);
        }
        // components
        video("hdmi_a", 70, 28.58, 0, "bottom", 0, [0,0,0], [0], pcb_size[2], false, [true,10,2,"default"]);
        header("open", 46.49, 41.34, 0, "bottom", 0, [7,1,15], ["thruhole","black","female",2.54,"silver"], pcb_size[2], false, [true,10,2,"default"]);
        header("open", 39.5, 79.19, 0, "bottom", 0, [20,2,15], ["thruhole","black","female",2.54,"silver"], pcb_size[2], false, [true,10,2,"default"]);
        header("open", 13.11, 35.46, 0, "bottom", 0, [1,7,6], ["thruhole","black","male",2.54,"silver"], pcb_size[2], false, [true,10,2,"default"]);
        header("open", 23.58, 73.17, 0, "bottom", 0, [1,5,6], ["thruhole","black","male",2.54,"silver"], pcb_size[2], false, [true,10,2,"default"]);
        color("dimgray") translate([16.25,69.4,-1.99]) cube([4,4,2]);
        translate([18.5,58,-1.99]) cube([25,5.5,2]);
        translate([80.5,52.5,-1.99]) cube([4.5,3.5,2]);

        // gpio extension
        if(gpio_ext == true) {
            header("open", 56.12, 91.14, 0, "bottom", 0, [20,2,6], ["thruhole","black","male",2.54,"silver"], pcb_size[2], false, [true,10,2,"default"]);
        }
        else {
            pcbpad("round", 57.37, 92.39, 0, "bottom", 0, [20,2,6], [1.27,"#fee5a6",2.1], pcb_size[2], false, [true,10,2,"default"]);
        }
        translate([59,52.69,-1.59]) color("dimgray") cube([9,9,.8]);
    }
}


/*
           NAME: hk_vu8m
    DESCRIPTION: hardkernel vu8m lcd display
           TODO: none

          USAGE: hk_vu8m(brackets, mask)

                         brackets = true, false
                          mask[0] = true enables component mask
                          mask[1] = mask length
                          mask[2] = mask setback
                          mask[3] = mstyle "default"
*/

module hk_vu8m(brackets, mask) {

    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    m1_screw_spacing = 72;

    body_size  = [198, 133, 1.93];
    glass_size = [195.73, 131.14, 1.60];
    lcd_size   = [184.63, 114.94, body_size[2] + 0.40];
    view_size  = [173.23, 108.64, .1];

    rb = 5.25;   // body edge radius

    lcd_clearance = [0.15, 0.1, 0];
    lcd_space = lcd_size + 2*lcd_clearance;
    pcb_size = [14,24,1.6];
    hole = 4.31;
    spacer_size = [6, 6+body_size[2], 3, 6, 1, "none", "round", "none", true, false, 4, 5];

    adj = .01;
    $fn = 90;    

    if(enablemask == true && mstyle == "default") {
        translate([-.5+(glass_size[0]-view_size[0])/2, -.5+(glass_size[1]-view_size[1])/2, body_size[2] + glass_size[2]- 0.01]) 
            cube([view_size[0]+1, view_size[1]+1, mlength]);
        translate([44.5, 4.5, msetback-mlength]) cylinder(d=7, h=mlength);
        translate([183.5, 4.5, msetback-mlength]) cylinder(d=7, h=mlength);
        translate([44.5, body_size[1]-4.5, msetback-mlength]) cylinder(d=7, h=mlength);
        translate([183.5, body_size[1]-4.5, msetback-mlength]) cylinder(d=7, h=mlength);
    }
    if(enablemask == false) {
        // "body"
        difference(){
            union() {
                color("#181818") slab(body_size, rb);
                color("#fee5a6") translate([51.5, 4.5, -adj]) cylinder(d=hole+2, h=body_size[2]+2*adj);
                color("#fee5a6") translate([190.5, 4.5, -adj]) cylinder(d=hole+2, h=body_size[2]+2*adj);
                color("#fee5a6") translate([51.5, body_size[1]-4.5, -adj]) cylinder(d=hole+2, h=body_size[2]+2*adj);
                color("#fee5a6") translate([190.5, body_size[1]-4.5, -adj]) cylinder(d=hole+2, h=body_size[2]+2*adj);
            }
            color("#181818") translate([3.76, 9, -1]) cube(lcd_space);
            color("#181818") translate([3.76, 9, -1]) cylinder(r=1.3, h=5);
            color("#181818") translate([3.76 + lcd_space[0], 9, -1]) cylinder(r=1.3, h=5);
            color("#181818") translate([3.76, 9 + lcd_space[1], -1]) cylinder(r=1.3, h=5);
            color("#181818") translate([3.76 + lcd_space[0], 9 + lcd_space[1], -1]) cylinder(r=1.3, h=5);

            // 4x holes in body
            color("#fee5a6") translate([51.5, 4.5, -1]) cylinder(d=hole, h=5);
            color("#fee5a6") translate([190.5, 4.5, -1]) cylinder(d=hole, h=5);
            color("#fee5a6") translate([51.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);
            color("#fee5a6") translate([190.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);
	    
	        // standoff openings
            color("silver") translate([44.5, 4.5, -1]) cylinder(d=hole, h=5);
            color("silver") translate([183.5, 4.5, -1]) cylinder(d=hole, h=5);
            color("silver") translate([44.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);
            color("silver") translate([183.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);

        }
        // 4x standoffs
        color("silver") translate([44.5, 4.5, glass_size[2]]) standoff(spacer_size, [false,10,2,"default"]);
        color("silver") translate([183.5, 4.5, glass_size[2]]) standoff(spacer_size, [false,10,2,"default"]);
        color("silver") translate([44.5, body_size[1]-4.5, glass_size[2]]) standoff(spacer_size, [false,10,2,"default"]);
        color("silver") translate([183.5, body_size[1]-4.5, glass_size[2]]) standoff(spacer_size, [false,10,2,"default"]);
        // LCD panel
        color([0.6, 0.6, 0.65]) translate([3.76, 9, body_size[2]-lcd_size[2]]+lcd_clearance) cube(lcd_size); 

        // front glass
        // it's actually thinner and glued, but for the sake of simplicity...
        color([0.2, 0.2, 0.2], 0.9) translate([0.86, 1.38, body_size[2] + 0.01]) slab(glass_size, rb);

        // view area
        color("dimgrey", 0.9)
            translate([(glass_size[0]-view_size[0])/2, (glass_size[1]-view_size[1])/2, body_size[2] + glass_size[2]- 0.01])
                slab(view_size, .1);

        // PCB stub
        color("black") translate([20.5, 24.5, -3]) cube(pcb_size);
        color("dimgrey") translate([22.5, 26.5, -2]) cube([8,16,3]);
        color("black") translate([12, 21, -2]) cube([7,7,1.6]);
        color("black") translate([10, 34, -2]) cube([4,10,1.6]);

        fpc("fh19", 30.5, 35, 3, "bottom", 90, [15,0,0], ["smt","side","white","black"], pcb_size[2]+body_size[2], false, [true,10,2,"default"]);
            
        // brackets
        if(brackets) {
            translate([44.5 - 7.5,   body_size[1]/2 + m1_screw_spacing/2 - 7.5, - spacer_size[1] - 2]) u_bracket();
            translate([44.5 - 7.5,   body_size[1]/2 - m1_screw_spacing/2 + 7.5, - spacer_size[1] - 2 + 1.93]) rotate([180,0,0]) u_bracket();
        }
    }
}


/*
           NAME: hk_vu8s
    DESCRIPTION: hardkernel vu8s lcd display
           TODO: none

          USAGE: hk_vu8s(mask)
                         mask[0] = true enables component mask
                         mask[1] = mask length
                         mask[2] = mask setback
                         mask[3] = mstyle "default"
*/

module hk_vu8s(mask) {
    
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    body_size  = [202, 133, 1.70];
    glass_size = [195.5, 131, 1.75];
    lcd_size   = [183.5,114, body_size[2] + 1];
    view_size  = [172.5, 107.5, .1];

    rb = 5.25;   // body edge radius

    lcd_clearance = [0.15, 0.1, 0];
    pcb_size = [14,24,1.6];
    hole = 4.31;
//    spacer_size = [5.5, 1.75+body_size[2], 2.5, 5.5, 1, 0, 1, 1, 0, 0, 0];
    spacer_size = [5.5, 1.75+body_size[2], 2.5, 5.5, 1, "none", "round", "none", true, false, 4, 5];

    $fn = 90;
    adj = .01;

    if(enablemask == true && mstyle == "default") {
        translate([13.5, 12, body_size[2] + glass_size[2]- msetback]) 
            cube([view_size[0]+1, view_size[1]+1, mlength]);
        // corner holes
        translate([4, -5, body_size[2]/2-(mlength/2)]) cylinder(d=hole, h=mlength);
        translate([4, 143-5, body_size[2]/2-(mlength/2)]) cylinder(d=hole, h=mlength);
        translate([202-4, -5, body_size[2]/2-(mlength/2)]) cylinder(d=hole, h=mlength);
        translate([202-4, 143-5, body_size[2]/2-(mlength/2)]) cylinder(d=hole, h=mlength);
        // back studs
        translate([4, 3.75, msetback-mlength]) cylinder(d=7, h=mlength);
        translate([3.75, 128.25, msetback-mlength]) cylinder(d=7, h=mlength);
        translate([111.5, 4, msetback-mlength]) cylinder(d=7, h=mlength);
        translate([111.25, 128.75, msetback-mlength]) cylinder(d=7, h=mlength);
    }
    if(enablemask == false) {
        // "body"
        color("black")
        difference(){
            union() {
                slab(body_size, rb);
                translate([(8.25/2),-1.74-8.25,0]) rotate([0,0,90]) slot(8.25,10+8.25,body_size[2]);
                translate([body_size[0]-(8.25/2),-1.74-8.25,0]) rotate([0,0,90]) slot(8.25,10+8.25,body_size[2]);
                translate([(8.25/2),body_size[1]-10,0]) rotate([0,0,90]) slot(8.25,10.75+8.25,body_size[2]);
                translate([body_size[0]-(8.25/2),body_size[1]-10,0]) rotate([0,0,90]) slot(8.25,10.75+8.25,body_size[2]);
            }
            lcd_space = lcd_size + 2*lcd_clearance;
            
            // corner holes
            translate([4, -5, -1]) cylinder(d=hole, h=5);
            translate([4, 143-5, -1]) cylinder(d=hole, h=5);
            translate([202-4, -5, -1]) cylinder(d=hole, h=5);
            translate([202-4, 143-5, -1]) cylinder(d=hole, h=5);

            translate([3.5, 3.5, -1]) cylinder(d=hole, h=5);
            translate([3.5, body_size[1]-3.5, -1]) cylinder(d=hole, h=5);
            translate([111, 3.5, -1]) cylinder(d=hole, h=5);
            translate([111.5, body_size[1]-3.5, -1]) cylinder(d=hole, h=5);
        }
        // standoffs
        color([0.6,0.6,0.6]) {
            translate([4, 3.75, body_size[2]+adj]) standoff(spacer_size, [false,10,2,"default"]);
            translate([3.75, 128.25, body_size[2]+adj]) standoff(spacer_size, [false,10,2,"default"]);
            translate([111.5, 4, body_size[2]+adj]) standoff(spacer_size, [false,10,2,"default"]);
            translate([111.25, 128.75, body_size[2]+adj]) standoff(spacer_size, [false,10,2,"default"]);
        }
        // LCD panel
        color([0.6, 0.6, 0.65])
            translate([10, 9, body_size[2]-lcd_size[2]]+lcd_clearance)
                cube(lcd_size); 

        // Front glass
        // It's actually thinner and glued, but for the sake of simplicity
        color([0.2, 0.2, 0.2], 0.9)
            translate([3, 1.25, body_size[2] + 0.01])
                slab(glass_size, rb);

        // view area
        color("dimgrey", 0.9)
            translate([14, 12.5, body_size[2] + glass_size[2]- 0.01])
                slab(view_size, .1);

        // PCB stub
        color("black")
            translate([body_size[0]-25, body_size[1]-30, -2])
                cube([7,7,.1]);
        color("black")
            translate([body_size[0]-50, body_size[1]-35, -2])
                cube([4,5,.1]);
    }
}


/*
           NAME: hk_wb2
    DESCRIPTION: hardkernel weather board 2
           TODO: none

          USAGE: hk_wb2()

*/

module hk_wb2() {
    difference () {
        union() {
        color("#008066") cube([16.5,16.5,1]);
        header("open", 1.75, 0.5, 0, "bottom", 90, [6,1,6], ["thruhole","black","female",2.54,"silver"], 1, false, [true,10,2,"default"]);
//        translate([1.75,15.75,.75]) rotate([180,0,0]) header_f(6,9);
        color("silver") translate([11.5,11.5,1]) cube([2,3,.5]);
        color("silver") translate([11.5,3,1]) cube([2,3,.5]);
        }
    translate([9.6,8.33,-1])
        color("#008066") hull() {
            cylinder(d=1, h=3);
            translate([5,0,0]) cylinder(d=1, h=3);
        }
    translate([7.36,2,-1]) rotate([0,0,90])
        color("#008066") hull() {
            cylinder(d=1, h=3);
            translate([5,0,0]) cylinder(d=1, h=3);
        }
    }
}


/*
           NAME: hk_xu4_shifter_shield
    DESCRIPTION: hardkernel xu4 shifter shield
           TODO: none

          USAGE: hk__xu4_shifter_shield(mask)

                                        mask[0] = enablemask
                                        mask[1] = mask length
                                        mask[2] = mask setback
                                        mask[3] = mask style, "default"
*/

module hk_xu4_shifter_shield(mask) {

    size = [83,59,1];
    enablemask = mask[0];
    mlength = mask[1];
    msetback = mask[2];
    mstyle = mask[3];

    adj = .01;
    $fn = 90;

    if(enablemask == true) {
        switch("slide_4x9", 28, 55, 0, "top", 180, [5, 4, .8], ["dimgrey"], size[2], true, [true, 10, 2, "default"]);
        gpio("open", 25, 1, 0, "top", 180, [20,2,6], ["thruhole","black","male",2.54,"silver"], size[2], true, [true, 10, 0, "block"]);
    }
    if(enablemask == false) {
        difference() {
            union() {
                color("#18525d") slab(size,3.5);
                pcbhole("round",3.5,3.5,0,"top",0,[3,0,0],["solid","#fee5a6","none",5,"left_rear"],size[2],false,[false,10,2,"default"]);
                pcbhole("round",3.5,55.5,0,"top",0,[3,0,0],["solid","#fee5a6","none",5,"left_front"],size[2],false,[false,10,2,"default"]);
                pcbhole("round",79.5,3.5,0,"top",0,[3,0,0],["solid","#fee5a6","none",5,"right_rear"],size[2],false,[false,10,2,"default"]);
                pcbhole("round",79.5,55.5,0,"top",0,[3,0,0],["solid","#fee5a6","none",5,"right_front"],size[2],false,[false,10,2,"default"]);
            }
            color("#fee5a6") translate([3.5,3.5,-1]) cylinder(d=3, h=4);
            color("#fee5a6") translate([3.5,55.5,-1]) cylinder(d=3, h=4);
            color("#fee5a6") translate([79.5,3.5,-1]) cylinder(d=3, h=4);
            color("#fee5a6") translate([79.5,55.5,-1]) cylinder(d=3, h=4);
        }
        ic("generic", 43, 39.5, 0, "top", 0, [5, 4, .8], ["dimgrey"], size[2], false, [false, 0, 0, "none"]);
        ic("generic", 53, 39.5, 0, "top", 0, [5, 4, .8], ["dimgrey"], size[2], false, [false, 0, 0, "none"]);
        ic("generic", 63, 39.5, 0, "top", 0, [5, 4, .8], ["dimgrey"], size[2], false, [false, 0, 0, "none"]);
        header("open", 77, 36.5, 0, "bottom", 0, [2,6,16], ["thruhole","black","female",2,"silver"], size[2], false, [true,10,2,"default"]);
        header("open", 39, 53, 0, "bottom", 0, [15,2,16], ["thruhole","black","female",2,"silver"], size[2], false, [true,10,2,"default"]);
        gpio("open", 25, 1, 0, "top", 180, [20,2,6], ["thruhole","black","male",2.54,"silver"], size[2], false, [true,10,2,"default"]);
        header("open", 8, 1, 0, "top", 0, [6,1,6], ["thruhole","black","male",2.54,"silver"], size[2], false, [true,10,2,"default"]);
        switch("slide_4x9", 28, 55, 0, "top", 180, [5, 4, .8], ["dimgrey"], size[2], false, [true, 0, 0, "none"]);
        pcbpad("round", 9.27, 4.81, 0, "top", 0, [6, 21, .8], [1,"#fee5a6",1.7,"front"], size[2], false, [false, 0, 0, "none"]);
        pcbpad("round", 24.54, 35.27, 0, "top", 0, [2, 9, .8], [1,"#fee5a6",1.7,"front"], size[2], false, [false, 0, 0, "none"]);
        
    }
}


/*
           NAME: m1_hdmount
    DESCRIPTION: hardkernel odroid-m1 2.5" sata hdd mounting kit
           TODO: none

          USAGE: m1_hdmount()
*/

module m1_hdmount() {

    $fn   = 30;
    dims  = [89.6,   38.5,  2.0];
    holes = 4;
    slots = [4.15,    3.3];
    standoff_style = [5, 16, 0, 3, 25, 0, 0, 1, 0, 0, 0];

    color([0.2,0.2,0.2])
    difference() {
        slab(dims, 4.0);
        translate([     3.1,   28.3, -1]) cylinder(d = holes, h = 4);
        translate([    86.5,   28.3, -1]) cylinder(d = holes, h = 4);
        hull() {
            translate([   14.75,     10.15, -1]) cylinder(d=3.30, h=4);
            translate([   15.60,     10.15, -1]) cylinder(d=3.30, h=4);
        }
        hull() {
            translate([   75.60,     10.15, -1]) cylinder(d=3.30, h=4);
            translate([   76.45,     10.15, -1]) cylinder(d=3.30, h=4);
        }
    }

    color([0.6,0.6,0.6]) {
        translate ([   3.1,  28.3 ,  0]) rotate([  0,0,0]) standoff(standoff_style);
        translate ([  86.5,  28.3 ,  0]) rotate([  0,0,0]) standoff(standoff_style);
    }
    color("black") {
        translate ([   3.1,  28.3 ,  2]) rotate([  0,0,0]) screw([3, 7, 0]);
        translate ([  86.5,  28.3 ,  2]) rotate([  0,0,0]) screw([3, 7, 0]);

        translate ([  15.1,  10.15,  0]) rotate([180,0,0]) screw([3, 7, 0]);
        translate ([    76,  10.15,  0]) rotate([180,0,0]) screw([3, 7, 0]);
    }

    // hdd holder
    color([0.9, 0.9, 0.9])
    translate([67,8,0]) rotate([180,0,180])
    linear_extrude(height=0.01) text("HDD HOLDER",5);
}


/*
           NAME: proto_m1s
    DESCRIPTION: prototype board with odroid-m1s footprint 
           TODO: none

          USAGE: proto_m1s()

*/

module proto_m1s() {

    pcb_size = [90,65,1.62];
    adj = .01;
    $fn = 90;

    union() {
        difference() {
            union() {
                color("#008066") slab(pcb_size,2);
                color("#fee5a6") translate([3.5,3.5,-.1]) cylinder(d=4.5, h=pcb_size[2]+.2);
                color("#fee5a6") translate([pcb_size[0]-3.5,3.5,-.1]) cylinder(d=4.5, h=pcb_size[2]+.2);
                color("#fee5a6") translate([17.5,52.5,-.1]) cylinder(d=4.5, h=pcb_size[2]+.2);
                color("#fee5a6") translate([67.5,55.1,-.1]) cylinder(d=4.5, h=pcb_size[2]+.2);
            }
            color("#fee5a6") translate([3.5,3.5,-1]) cylinder(d=3, h=4);
            color("#fee5a6") translate([pcb_size[0]-3.5,3.5,-1]) cylinder(d=3, h=4);
            color("#fee5a6") translate([17.5,52.5,-1]) cylinder(d=3, h=4);
            color("#fee5a6") translate([67.5,55.1,-1]) cylinder(d=3, h=4);
       }
       pcbpad("round", 8, 5, 0, "bottom", 0, [30,16,6], [1.27,"#fee5a6",2.1], pcb_size[2], false, [true,10,2,"default"]);
   }
}


/*
           NAME: proto_ups
    DESCRIPTION: prototype board with odroid-m1s ups footprint
           TODO: none

          USAGE: proto_ups()

*/

module proto_ups() {

    pcb_size = [115,32,1.62];
    adj = .01;
    $fn = 90;

    union() {
        difference() {
            union() {
                color("#008066") slab(pcb_size,4);
                color("#fee5a6") translate([3.5,3.5,-.1]) cylinder(d=5.5, h=pcb_size[2]+.2);
                color("#fee5a6") translate([3.5,pcb_size[1]-3.5,-.1]) cylinder(d=5.5, h=pcb_size[2]+.2);
                color("#fee5a6") translate([pcb_size[0]-3.5,3.5,-.1]) cylinder(d=5.5, h=pcb_size[2]+.2);
                color("#fee5a6") translate([pcb_size[0]-3.5,pcb_size[1]-3.5,-.1]) cylinder(d=5.5, h=pcb_size[2]+.2);
            }
            color("#fee5a6") translate([3.5,3.5,-1]) cylinder(d=4, h=4);
            color("#fee5a6") translate([3.5,pcb_size[1]-3.5,-1]) cylinder(d=4, h=4);
            color("#fee5a6") translate([pcb_size[0]-3.5,3.5,-1]) cylinder(d=4, h=4);
            color("#fee5a6") translate([pcb_size[0]-3.5,pcb_size[1]-3.5,-1]) cylinder(d=4, h=4);
       }
       // pads
       pcbpad("round", 9.5, 5, 0, "bottom", 0, [39,10,6], [1.27,"#fee5a6",2.1], pcb_size[2], false, [true,10,2,"default"]);
   }
}


/*
           NAME: u_bracket
    DESCRIPTION: hardkernel vu8m lcd brackets
           TODO: none

          USAGE: u_bracket()

*/

module u_bracket() {
    $fn= 30;
    xi = 124;
    xo = 154;
    yi = 42;
    yo = 42 + 12;   // Outer vertical dimension 
    z  = 1.93;
    rlo = 21.3;     // Lower outer corner radii
    rli = 1;        // Lower inner corner radii
    ruo = 5.7;      // Upper outer corner radii
    rui = 5.7;      // Upper inner corner radii

    color([0.2,0.2,0.2])
    difference() {
        union() {
            hull() {
                translate([          rlo,      rlo,0]) cylinder(r=rlo, h=z, $fn=100);
                translate([xo -      rlo,      rlo,0]) cylinder(r=rlo, h=z, $fn=100);
            }
            hull() {
                translate([          ruo, yo - ruo,0]) cylinder(r=ruo, h=z);
                translate([     15 - rui, yo - rui,0]) cylinder(r=rui, h=z);
                translate([            0,      rlo,0]) cube([15,$fs,z]);
            }
            hull() {
                translate([xo -      ruo, yo - ruo,0]) cylinder(r=ruo, h=z);
                translate([xo - 15 + rui, yo - rui,0]) cylinder(r=rui, h=z);
                translate([xo - 15      ,      rlo,0]) cube([15,$fs,z]);
            }
        }
        hull() {
            translate([     15 + rli, yo - yi + rli,-1]) cylinder(r=rli, h=z+2);
            translate([xo - 15 - rli, yo - yi + rli,-1]) cylinder(r=rli, h=z+2);
            translate([           15,            yo,-1]) cube([xi,$fs,z+2]);
        }
        translate([     7.5, yo - 4, -1]) cylinder(d=3.21, h=z+2);
        translate([xo - 7.5, yo - 4, -1]) cylinder(d=3.21, h=z+2);
        hull() {
            translate([     7.5, yo -  9.6, -1]) cylinder(d=3.21, h=z+2);
            translate([     7.5, yo - 29.4, -1]) cylinder(d=3.21, h=z+2);
        }
        hull() {
            translate([xo - 7.5, yo -  9.6, -1]) cylinder(d=3.21, h=z+2);
            translate([xo - 7.5, yo - 29.4, -1]) cylinder(d=3.21, h=z+2);
        }
        translate([     15 +   5.00, 8.25, -1]) cylinder(d=4.11, h=z+2);
        translate([xo - 15 -  30.00, 8.25, -1]) cylinder(d=4.11, h=z+2);
        translate([     15 +  10.75, 2.50, -1]) cylinder(d=4.11, h=z+2);
        translate([     15 +  41.75, 2.50, -1]) cylinder(d=4.11, h=z+2);
        translate([     15 +  82.25, 2.50, -1]) cylinder(d=4.11, h=z+2);
        translate([     15 + 113.25, 2.50, -1]) cylinder(d=4.11, h=z+2);
    }
}