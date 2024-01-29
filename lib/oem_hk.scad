/*
    uart_holder()
    uart_strap ()
    hc4_oled_holder(side,floorthick)
    hk_wb2()
    hc4_oled()
    h2_netcard()
    hk35_lcd()
    hk_uart()
    hk_vu7c(gpio_ext, tabs)
    hk_vu8m(bracket)
    u_bracket()
    m1_hdmount()
    hk_speaker()
    hk_boom(speakers,orientation)
    hk_boom_speaker(side,speaker,pcb)
    boom_speaker()
    hk_boom_grill(style,thick)
    boom_speaker_holder(style,tolerance)
    boom_speaker_strap()
    boom_vring(tolerance)
    hk_pwr_button(mask = false)
    hk_m1s_case_holes
    hk_m1s_ups()
    proto_m1s()
    proto_ups()

*/

/* odroid uart module holder */
module hk_uart_holder() {

    rotate([0,0,0]) 
    translate ([0,0,0])
        union () {
            difference () {
                translate ([0,0,0]) cube([18,24,9]);
                translate ([2,-2,3]) cube([14,27,7]);
                //pin slot
                translate ([3.5,16,-1]) cube([11,1,5]);
                //component bed
                translate ([3.5,1.5,2]) cube ([11,14,2]);
                //side trim
                translate ([-1,-1,6]) cube([20,18,4]);
            }    
            difference (){
                translate ([-1.5,20,0]) cylinder(r=3,h=9, $fn=90);
                translate ([-1.5,20,-1]) cylinder (r=1.375, h=11, $fn=90);
            }    
            difference (){
                translate ([19.5,20,0]) cylinder(r=3,h=9, $fn=90);
                translate ([19.5,20,-1]) cylinder (r=1.375, h=11,$fn=90);
            }  
        }
    }

    
/* odroid uart strap for holder */
module uart_strap() { 
    difference () {
        translate ([-4.5,17,9]) cube([27,6,3]);
        translate ([-1.5,20,8]) cylinder (r=1.6, h=5, $fn=90);
        translate ([19.5,20,8]) cylinder (r=1.6, h=5, $fn=90);
    }   
    difference (){
        translate ([-1.5,20,12]) cylinder(r=3,h=1, $fn=90);
        translate ([-1.5,20,11]) cylinder (r=1.6, h=7, $fn=90);
    }  
    difference (){
        translate ([19.5,20,12]) cylinder(r=3,h=1, $fn=90);
        translate ([19.5,20,11]) cylinder (r=1.6, h=7, $fn=90);
    }    
}

module hk_wb2() {
    difference () {
        union() {
        color("tan") cube([16.5,16.5,1]);
        translate([1.75,15.75,.75]) rotate([180,0,0]) header_f(6,9);
        color("silver") translate([11.5,11.5,1]) cube([2,3,.5]);
        color("silver") translate([11.5,3,1]) cube([2,3,.5]);
        }
    translate([9.6,8.33,-1])
        color("tan") hull() {
            cylinder(d=1, h=3);
            translate([5,0,0]) cylinder(d=1, h=3);
        }
    translate([7.36,2,-1]) rotate([0,0,90])
        color("tan") hull() {
            cylinder(d=1, h=3);
            translate([5,0,0]) cylinder(d=1, h=3);
        }
    }
}


/* odroid-hc4 oled holder */
module hc4_oled_holder(side,wallthick) {
    
    adjust=.01;
    $fn = 90;    
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
            translate([(32.75/2-(15/2))-1.85,-adjust-3-1.75,-wallthick-2.5]) cube([15,12,wallthick+3]);
        }
        if(side == "bottom") {
            translate([-.5,0,-adjust]) cube([29.5,1.42,5]);
            translate([(32.75/2-(15/2))-1.85,-adjust-3-1.75,-adjust]) cube([15,12,8]);
            translate([2.5,-adjust-3-1.75,-adjust]) cube([6,3,8]);
            translate([12.5,adjust,10]) rotate([90,0,0]) cylinder(d=21, h=2);
        }
    }   
}

/* odroid-hc4 oled */
module hc4_oled() {
    
adjust = .01;
$fn=90;

oled_x = 28.5;
oled_y = 1.25;
oled_z = 48.6;

oled_open_x = 29;
oled_open_y = 1.5;
    difference() {
        union() {
            // pcb board
            color("Tan", 1) translate([0,0,0]) cube([oled_x,oled_y,oled_z]);
            // oled
            color("Black", 1) translate([.5,1.25,25.5]) cube([oled_x-1,.625,15]);
            color("DarkGrey", 1) translate([.5,1.25,40.5]) cube([oled_x-1,.625,4]);
        }
        translate([2.8,0,46.7]) {
            translate([-.6,1.26,0]) rotate([90,0,0])
                hull() {
                translate([1.2,0,0]) cylinder(d=1.8, h=1.25+(adjust*2));
                cylinder(d=1.8, h=1.25+(adjust*2));
                }
        }
        translate([25.7,0,46.7]) {
            translate([-.6,1.26,0]) rotate([90,0,0])
                hull() {
                translate([1.2,0,0]) cylinder(d=1.8, h=1.25+(adjust*2));
                cylinder(d=1.8, h=1.25+(adjust*2));
                }
        }
        
    }
}


/* h2 network card */
module h2_netcard() {
    
    adjust = .01;
    $fn = 90;
    difference() {
        union() {
            color("tan") translate ([0,0,0]) linear_extrude(height = 1) import("./dxf/hk-network-card.dxf");
            color("goldenrod") translate([3.75,17.85,1-adjust]) cylinder(d=6,h=3);
            color("goldenrod") translate([106,24.85,1-adjust]) cylinder(d=6,h=3);
        }
        translate([20.85,3.85,-adjust]) cylinder(d=3,h=4);
        translate([3.75,17.85,-adjust]) cylinder(d=3,h=6);
        translate([3.75,51.1,-adjust]) cylinder(d=3,h=4);
        translate([20.15,43.85,-adjust]) cylinder(d=3,h=4);
        translate([106,24.85,-adjust]) cylinder(d=3,h=6);
        translate([96.5,3.85,-adjust]) cylinder(d=3,h=4);
    }
    rj45(26,-1,0,"bottom",1);
    rj45(43,-1,0,"bottom",1);
    rj45(60,-1,0,"bottom",1);
    rj45(77,-1,0,"bottom",1);
    place(30,25,0,6,6,0,"bottom") color("dimgray") translate([0,0,0]) cube([6,6,.8]);
    place(47,25,0,6,6,0,"bottom") color("dimgray") translate([0,0,0]) cube([6,6,.8]);
    place(64,25,0,6,6,0,"bottom") color("dimgray") translate([0,0,0]) cube([6,6,.8]);
    place(79,25,0,6,6,0,"bottom") color("dimgray") translate([0,0,0]) cube([6,6,.8]);
    place(56.5,41,0,5,9.75,0,"bottom") color("dimgray") translate([0,0,0]) cube([5,9.75,.8]);
    for (i=[34.65:.5:48.5]) {
        color("gold") translate([98,i,1]) cube([2,.25,.25]);
        color("gold") translate([98,i,-.24]) cube([2,.25,.25]);
    }
    for (i=[51:.5:53]) {
        color("gold") translate([98,i,1]) cube([2,.25,.25]);
        color("gold") translate([98,i,-.24]) cube([2,.25,.25]);
    }

}


/* hk 3.5 lcd */
module hk35_lcd() {
    
    adjust = .01;
    $fn = 90;
    difference() {
        union() {
            color("tan") translate ([0,0,0]) slab([95,56,1.7],3.5);
            color("black",1) translate([10.5,0,1.7]) cube([74.75,54.5,4]);
            color("white",1) translate([8.5,0,5.7-adjust]) cube([82.75,54.5,2]);
            color("grey",1) translate([8.5,0,7.7-adjust]) cube([82.75,54.5,.8]);
            color("dimgrey",1) translate([15,2,8.5-adjust]) cube([75.5,51,.25]);
        }
        translate([3.5,3.5,-adjust]) cylinder(d=3,h=6);
        translate([3.5,52.5,-adjust]) cylinder(d=3,h=4);
    }
    translate([3,8.75,1.70-adjust]) momentary45x15();
    translate([3,19.75,1.70-adjust]) momentary45x15();
    translate([3,30.75,1.70-adjust]) momentary45x15();
    translate([3,41.75,1.70-adjust]) momentary45x15();
    color("black") translate([7.375,.8,-9+adjust]) cube([51.5,5,9]);
    translate([92.5,4,adjust]) rotate([0,180,0]) header(5);
    }


// hk console uart model
module hk_uart() {
    
    size = [22,13,1.25];
    adjust = .01;
    $fn = 90;
    color("tan") cube([size[0],size[1],size[2]]);
    translate([6.5,.25,6.25-adjust]) rotate([90,180,-90]) uart_micro();
    translate([6.75,3,-2+adjust])cylinder(d=1, 2);
    translate([6.75,5.25,-2+adjust])cylinder(d=1, 2);
    translate([6.75,7.5,-2+adjust])cylinder(d=1, 2);
    translate([6.75,9.75,-2+adjust])cylinder(d=1, 2);
    translate([23,2.75,1.25]) rotate([0,0,90]) usb_micro();
    translate([13,4.5,1.25]) rotate([0,0,90]) ic([4,4,1]);
}


// hk vu7c lcd display
module hk_vu7c(gpio_ext, tabs) {
    
    lcd_size = [164.85,100,5.48];
    pcb_size = [184.6,75,1.6];
    view_size = [155,88.5,.125];        // 154.21 x 85.92
    hole = 3.2;
    length = 24-hole;
    depth = 2;    
    adjust = .1;
    $fn = 90;    
    difference() {
        union() {
            color("lightgray") translate([0,0,pcb_size[2]+3.12]) cube(lcd_size);
            if(tabs == true) {
                color("black") translate([-(pcb_size[0]-lcd_size[0])/2,lcd_size[1]-pcb_size[1]-1,0]) 
                    cube(pcb_size);
            }
            else {
                color("black") translate([0,lcd_size[1]-pcb_size[1]-1,0]) 
                    cube([pcb_size[0]-20,pcb_size[1],pcb_size[2]]);
            }
            color("black") translate([3,7.5,pcb_size[2]+3.12+lcd_size[2]-adjust]) cube(view_size);
            // tabs
            color("black") translate([51.8,99,0]) slab_r([8,8,1.6],[.1,4,4,.1]);
            color("black") translate([104.8,99,0]) slab_r([8,8,1.6],[.1,4,4,.1]);
        }
        // slots
        color("dimgray") translate([-(pcb_size[0]-lcd_size[0])/4,lcd_size[1]-1-7,-adjust]) 
            rotate([0,0,-90]) slot(hole,length,depth);
        color("dimgray") translate([-(pcb_size[0]-lcd_size[0])/4,lcd_size[1]-1-46,-adjust]) 
            rotate([0,0,-90]) slot(hole,length,depth);
        color("dimgray") translate([(pcb_size[0]-(pcb_size[0]-lcd_size[0])/2)-(pcb_size[0]-lcd_size[0])/4,
            lcd_size[1]-1-7,-adjust]) rotate([0,0,-90]) slot(hole,length,depth);
        color("dimgray") translate([(pcb_size[0]-(pcb_size[0]-lcd_size[0])/2)-(pcb_size[0]-lcd_size[0])/4,
            lcd_size[1]-1-46,-adjust]) rotate([0,0,-90]) slot(hole,length,depth);
        // holes
        color("dimgray") translate([55.8,103.5,-adjust]) cylinder(d=hole, h=3);
        color("dimgray") translate([108.8,103.5,-adjust]) cylinder(d=hole, h=3);
        // pcb cuts
        color("dimgray") translate([66,97.5,-adjust]) slab_r([20.3,4,2],[1,1,1,1]);
        color("dimgray") translate([17.8,lcd_size[1]-pcb_size[1]-2,-adjust]) slab_r([78.8,6,2],[1,1,1,1]);
    }
    // components
    translate([70+14.5,28.58,0]) rotate([180,0,180]) hdmi_a();
    translate([47.49-1,42.09-.75,0]) rotate([180,0,90]) header_f(7,15);
    translate([39.5,80.19-1,0]) rotate([180,0,90]) header_f(20,15);
    translate([39.5,82.73-1,0]) rotate([180,0,90]) header_f(20,15);
    translate([13.15+2.75-.25,36.71-1.25,0]) rotate([180,0,180]) header(7);
    translate([23.58+2.5,74.42-1.25,0]) rotate([180,0,180]) header(5);
    translate([98+2,26.04-2,0]) rotate([180,0,180]) pcb_pad(7);
    color("dimgray") translate([16.25,69.4,-1.99]) cube([4,4,2]);
    translate([18.5,58,-1.99]) cube([25,5.5,2]);
    translate([80.5,52.5,-1.99]) cube([4.5,3.5,2]);
    // gpio extension
    if(gpio_ext == true) {
        translate([57.37-1.25,94.93-1.25,0]) rotate([180,0,90]) header(20);
        translate([57.37-1.25,92.39-1.25,0]) rotate([180,0,90]) header(20);
    }
    else {
        translate([57.37-2,94.93-2,0]) rotate([180,0,90]) pcb_pad(20);
        translate([57.37-2,92.39-2,0]) rotate([180,0,90]) pcb_pad(20);        
    }
    translate([59,52.69,-1.59]) ic(9);
}


// hk vu8m lcd display
module hk_vu8m(brackets) {
    $fn = 90;    
    
    m1_screw_spacing = 72;

    body_size  = [    198,     133,                1.93];
    glass_size = [ 195.73,  131.14,                1.60];
    lcd_size   = [ 184.63,  114.94, body_size[2] + 0.40];
    view_size  = [ 173.23,  108.64,                  .1];

    rb = 5.25;   // body edge radius

    lcd_clearance = [0.15, 0.1, 0];
    pcb_size = [14,24,1.6];
    hole = 4.31;
    spacer_size = [5.5, 6, 2.5, 5.5, 1, 0, 1, 1, 0, 0, 0];

    // "body"
    color([0.1,0.1,0.1])
    difference(){
        slab(body_size, rb); 
        lcd_space = lcd_size + 2*lcd_clearance;
        translate([3.76               , 9               ,    -1]) cube(lcd_space);
        translate([3.76               , 9               ,    -1]) cylinder(r=1.3, h=5);
        translate([3.76 + lcd_space[0], 9               ,    -1]) cylinder(r=1.3, h=5);
        translate([3.76               , 9 + lcd_space[1],    -1]) cylinder(r=1.3, h=5);
        translate([3.76 + lcd_space[0], 9 + lcd_space[1],    -1]) cylinder(r=1.3, h=5);
    // 8x holes in body
        translate([  44.5,              4.5, -1]) cylinder(d=hole, h=5);
        translate([  51.5,              4.5, -1]) cylinder(d=hole, h=5);
        translate([ 183.5,              4.5, -1]) cylinder(d=hole, h=5);
        translate([ 190.5,              4.5, -1]) cylinder(d=hole, h=5);
        translate([  44.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);
        translate([  51.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);
        translate([ 183.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);
        translate([ 190.5, body_size[1]-4.5, -1]) cylinder(d=hole, h=5);

    }
    // 4x standoffs
        color([0.6,0.6,0.6]) {
            translate([  44.5,              4.5, 0]) standoff(spacer_size);
            translate([ 183.5,              4.5, 0]) standoff(spacer_size);
            translate([  44.5, body_size[1]-4.5, 0]) standoff(spacer_size);
            translate([ 183.5, body_size[1]-4.5, 0]) standoff(spacer_size);
        }
    // LCD panel
    color([0.6, 0.6, 0.65])
        translate([3.76, 9, body_size[2]-lcd_size[2]]+lcd_clearance)
            cube(lcd_size); 

    // Front glass
    // It's actually thinner and glued, but for the sake of simplicity...
    color([0.2, 0.2, 0.2], 0.9)
        translate([0.86, 1.38, body_size[2] + 0.01])
            slab(glass_size, rb);

    // view area
    color("dimgrey", 0.9)
        translate([(glass_size[0]-view_size[0])/2, (glass_size[1]-view_size[1])/2, body_size[2] + glass_size[2]- 0.01])
            slab(view_size, .1);

    // PCB stub
    color([0.1,0.1,0.1])
        translate([20.5, 24.5, -3])
            cube(pcb_size);
    color("dimgrey")
        translate([22.5, 26.5, -2])
            cube([8,16,3]);
    color([0.1,0.1,0.1])
        translate([12, 21, -2])
            cube([7,7,1.6]);
    color([0.1,0.1,0.1])
        translate([10, 34, -2])
            cube([4,10,1.6]);

    //Brackets
    if(brackets) {
        translate([44.5 - 7.5,   body_size[1]/2 + m1_screw_spacing/2 - 7.5, - spacer_size[1] - 2]) u_bracket();
        translate([44.5 - 7.5,   body_size[1]/2 - m1_screw_spacing/2 + 7.5, - spacer_size[1] - 2 + 1.93]) rotate([180,0,0]) u_bracket();

    //Screws
        color([0.1,0.1,0.1]) {
            translate([  44.5,              4.5, -8]) rotate([180,0,0]) screw([3,7,0]);
            translate([ 183.5,              4.5, -8]) rotate([180,0,0]) screw([3,7,0]);
            translate([  44.5, body_size[1]-4.5, -8]) rotate([180,0,0]) screw([3,7,0]);
            translate([ 183.5, body_size[1]-4.5, -8]) rotate([180,0,0]) screw([3,7,0]);
        }
    }
}

// Vu8M LCD U-BRACKET
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

// hk vu8s lcd display
module hk_vu8s() {
    
    body_size  = [202, 133, 1.70];
    glass_size = [195.5, 131, 1.75];
    lcd_size   = [183.5,114, body_size[2] + 1];
    view_size  = [172.5, 107.5, .1];

    rb = 5.25;   // body edge radius

    lcd_clearance = [0.15, 0.1, 0];
    pcb_size = [14,24,1.6];
    hole = 4.31;
    spacer_size = [5.5, 1.75+body_size[2], 2.5, 5.5, 1, 0, 1, 1, 0, 0, 0];
    
    $fn = 90;    
    adj = .01;

    // "body"
    color([0.1,0.1,0.1])
    difference(){
        union() {
            slab(body_size, rb);
            translate([(8.25/2),-1.74-(8.25/2),0]) rotate([0,0,90]) slot(8.25,10+(8.25/2),body_size[2]);
            translate([body_size[0]-(8.25/2),-1.74-(8.25/2),0]) rotate([0,0,90]) slot(8.25,10+(8.25/2),body_size[2]);
            translate([(8.25/2),body_size[1]-10,0]) rotate([0,0,90]) slot(8.25,10.75+(8.25/2),body_size[2]);
            translate([body_size[0]-(8.25/2),body_size[1]-10,0]) rotate([0,0,90]) slot(8.25,10.75+(8.25/2),body_size[2]);
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
            translate([4, 3.75, body_size[2]+adj]) standoff(spacer_size);
            translate([3.75, 128.25, body_size[2]+adj]) standoff(spacer_size);
            translate([111.5, 4, body_size[2]+adj]) standoff(spacer_size);
            translate([111.25, 128.75, body_size[2]+adj]) standoff(spacer_size);
        }
    // LCD panel
    color([0.6, 0.6, 0.65])
        translate([10, 9, body_size[2]-lcd_size[2]]+lcd_clearance)
            cube(lcd_size); 

    // Front glass
    // It's actually thinner and glued, but for the sake of simplicity...
    color([0.2, 0.2, 0.2], 0.9)
        translate([3, 1.25, body_size[2] + 0.01])
            slab(glass_size, rb);

    // view area
    color("dimgrey", 0.9)
        translate([14, 12.5, body_size[2] + glass_size[2]- 0.01])
            slab(view_size, .1);

    // PCB stub
    color([0.1,0.1,0.1])
        translate([body_size[0]-25, body_size[1]-30, -2])
            cube([7,7,.1]);
    color([0.1,0.1,0.1])
        translate([body_size[0]-50, body_size[1]-35, -2])
            cube([4,5,.1]);
}

// ODROID M1 2.5" SATA HDD mounting kit
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
    color([0.1,0.1,0.1]) {
        translate ([   3.1,  28.3 ,  2]) rotate([  0,0,0]) screw([3, 7, 0]);
        translate ([  86.5,  28.3 ,  2]) rotate([  0,0,0]) screw([3, 7, 0]);

        translate ([  15.1,  10.15,  0]) rotate([180,0,0]) screw([3, 7, 0]);
        translate ([    76,  10.15,  0]) rotate([180,0,0]) screw([3, 7, 0]);
    }

    // "HDD HOLDER"
    color([0.9, 0.9, 0.9])
    translate([67,8,0]) rotate([180,0,180])
    linear_extrude(height=0.01) text("HDD HOLDER",5);
}

/* hk speakers */
module hk_speaker() {
    
    spk_x = 44;
    spk_y = 20;
    spk_z = 98;
    c_hole = 6;
    i_dia = c_hole+3;
    adjust = .1;
    
    difference() {
        translate([spk_x/2,spk_y/2,spk_z/2]) cube_fillet_inside([spk_x,spk_y,spk_z], 
            vertical=[0,0,0,0,0], top=[0,c_hole,0,c_hole], bottom=[0,c_hole,0,c_hole], $fn=90);
        // speaker cone
        translate([spk_x/2,-adjust,spk_z-72]) rotate([-90,0,0]) cylinder(d=36, h=.5);
        
        // corner holes
        translate([(c_hole/2)+2,-adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adjust));
        translate([(c_hole/2)+2,-adjust,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adjust));
        translate([spk_x-(c_hole/2)-2,-adjust,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adjust));
        translate([spk_x-(c_hole/2)-2,-adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=c_hole, h=spk_y+(2*adjust));
        
        // lower left corner indent
        translate([(c_hole/2)+2,-adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([-adjust-1,-adjust,-adjust]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([adjust+.5,-adjust,-(i_dia/2)+adjust]) cube([i_dia+adjust,10+adjust,i_dia+adjust+.5]);        
        translate([(c_hole/2)+2,-adjust+12+adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([-adjust-1,-adjust+12+adjust,-adjust]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([adjust+.5,-adjust+12+adjust,-(i_dia/2)+adjust]) cube([i_dia+adjust,10+adjust,i_dia+adjust+.5]);
 
        // upper left corner corner indent
        translate([(c_hole/2)+2,-adjust,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([-adjust-1,-adjust,spk_z-i_dia-.5]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([-adjust+.5,-adjust,spk_z-(i_dia/2)+adjust-.5]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
        translate([(c_hole/2)+2,-adjust+12,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([-adjust-1,-adjust+12,spk_z-i_dia-.5]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([-adjust+.5,-adjust+12,spk_z-(i_dia/2)+adjust-.5]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
        
        // upper right corner corner indent
        translate([spk_x-(c_hole/2)-2,-adjust,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([spk_x-1-(i_dia/2),-adjust,spk_z-i_dia+adjust-.5]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-.5-i_dia,-adjust,spk_z-(i_dia/2)+adjust-.5]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-(c_hole/2)-2,-adjust+12,spk_z-(c_hole/2)-2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([spk_x-1-(i_dia/2),-adjust+12,spk_z-i_dia+adjust-.5]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-.5-i_dia,-adjust+12,spk_z-(i_dia/2)+adjust-.5]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
      
        // lower right corner corner indent
        translate([spk_x-(c_hole/2)-2,-adjust,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([spk_x-1-(i_dia/2),-adjust,-adjust]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-.5-i_dia,-adjust,-(i_dia/2)+adjust]) cube([i_dia,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-(c_hole/2)-2,-adjust+12,(c_hole/2)+2]) rotate([-90,0,0]) 
            cylinder(d=i_dia, h=10+adjust);
        translate([spk_x-1-(i_dia/2),-adjust+12,-adjust]) cube([c_hole+adjust,10+adjust,i_dia+adjust+.5]);
        translate([spk_x-.5-i_dia,-adjust+12,-(i_dia/2)+adjust]) cube([i_dia,10+adjust,i_dia+adjust+.5]);            
        }
        // speaker cone
        translate([spk_x/2,-adjust+46,spk_z-72]) {
            difference() {
                translate([0,0,0]) sphere(d=96, $fn=180);
                translate([-50,-46,-50]) cube([100,100,100]);
            }
        }

    }

    
/* hk boom bonnet */
module hk_boom(speakers,orientation) {
    
    adjust = .01;
    $fn = 90;
    difference() {
        union() {
            color("tan") translate ([0,0,0]) slab([60,35,1.6],.5);
            if(speakers == true) {
                color("tan") translate ([-31.5,0,0]) slab([31.5,35,1.6],.5);
                color("white") translate ([-0.25,0,0]) cube([.5,35,1.6]);
                color("tan") translate ([60,0,0]) slab([31.5,35,1.6],.5);                
                color("white") translate ([60,0,0]) cube([.5,35,1.6]);
            }
        }
        // pcb holes
        color("tan") translate([3.5,3.5,-adjust]) cylinder(d=3,h=6);
        color("tan") translate([3.5,31.5,-adjust]) cylinder(d=3,h=6);
        color("tan") translate([56.5,3.5,-adjust]) cylinder(d=3,h=4);
        color("tan") translate([56.5,31.5,-adjust]) cylinder(d=3,h=4);
        if(speakers == true) {
            // left
            color("tan") translate([-28,3.5,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([-28,31.5,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([-3.5,3.5,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([-3.5,31.5,-adjust]) cylinder(d=3,h=6);
            // right
            color("tan") translate([64.5,3.5,-adjust]) cylinder(d=3,h=4);
            color("tan") translate([64.5,31.5,-adjust]) cylinder(d=3,h=4);
            color("tan") translate([88,3.5,-adjust]) cylinder(d=3,h=4);
            color("tan") translate([88,31.5,-adjust]) cylinder(d=3,h=4);
            // left speaker openings
            color("tan") translate([-31.5/2,35/2,-adjust]) cylinder(d=23.5, h=3);
            color("tan") translate([-4-31.5/2,35/2+(23.5/2)-.5,-adjust]) cube([6,3,3]);
            color("tan") translate([-4-31.5/2,35/2-(23.5/2)-2.5,-adjust]) cube([6,3,3]);
            color("tan") translate([-4-31.5/2+(23.5/2)+1,-2+35/2,-adjust]) cube([6,3,3]);
            // right speaker openings
            color("tan") translate([60+(31.5/2),35/2,-adjust]) cylinder(d=23.5, h=3);
            color("tan") translate([60-3+31.5/2,35/2+(23.5/2)-.5,-adjust]) cube([6,3,3]);
            color("tan") translate([60-3+31.5/2,35/2-(23.5/2)-2.5,-adjust]) cube([6,3,3]);
            color("tan") translate([60+1.25,-2+35/2,-adjust]) cube([6,3,3]);
        }
    }
    // headers
    translate([7.5,3.5,1.6-adjust]) rotate([0,0,-90]) header(3);
    translate([16,3.5,1.6-adjust]) rotate([0,0,-90]) header(7);
    translate([34,2,1.6-adjust]) rotate([0,0,0]) encl_header_12();
    translate([40,13.5,1.6-adjust]) rotate([0,0,-90]) header(2);
    translate([45.5,13.5,1.6-adjust]) rotate([0,0,-90]) header(2);
    difference() {
        union() {
            color("dimgray", 1) translate([44.5,27,1.6+2]) rotate([0,0,0]) cylinder(d=16, h=3);
            color("dimgray", 1) translate([44.5,27,1.6]) rotate([0,0,0]) cylinder(d=8, h=2);
        }
        color("dimgray", 1) translate([44.5,27,1.6+4]) rotate([0,0,0]) cylinder(d=12, h=3);     
        for(d=[5:10:360]) {
            color("dimgray") translate([44.5+(16/2)*cos(d),27+(16/2)*sin(d),1.6+2-adjust]) cylinder(d=.75, h=3+2*adjust);
        }  
    }
    color("gray", 1) translate([45,27,1.6+4-adjust]) rotate([0,0,0]) cylinder(d=1.5, h=.25);
    translate([3.75,13,1.6-adjust]) rotate([0,0,90]) micro2pin();
    translate([56.5,20.5,1.6-adjust]) rotate([0,0,-90]) micro2pin();
    translate([7.75,21.75,1.6-adjust]) audio_jack35();
    translate([20,30,1.6-adjust]) capacitor(6.25,6.5);
    translate([30,30,1.6-adjust]) capacitor(6.25,6.5);
    translate([22,16,1.6-adjust]) ic([6.5,4.5,1]);
    translate([10,12,1.6-adjust]) ic([4,4,1]);
    translate([32.5,9,1.6-adjust]) ic([3.5,3,1]);
    if(speakers == true && orientation == "rear") {
        translate([-31.5/2,35/2,1.6]) boom_speaker();
        translate([60+(31.5/2),35/2,1.6]) boom_speaker();
    }
    if(speakers == true && orientation == "front") {
        translate([-31.5/2,35/2,0]) rotate([0,180,0]) boom_speaker();
        translate([60+(31.5/2),35/2,0]) rotate([0,180,0]) boom_speaker();
    }
}


// hk stero boom bonnet speaker with board
module hk_boom_speaker(side,speaker,pcb) {

    adjust = .01;
    $fn = 90;

    if(pcb == true) {
        difference() {
            color("tan") slab([31.5,35,1.6],.5);
            color("tan") translate([27.5,4,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([27.5,31,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([4,4,-adjust]) cylinder(d=3,h=6);
            color("tan") translate([4,31,-adjust]) cylinder(d=3,h=6);
            
            // speaker openings
            color("tan") translate([(31.5/2),35/2,-adjust]) cylinder(d=23.5, h=3);
            color("tan") translate([-3+31.5/2,35/2+(23.5/2)-.5,-adjust]) cube([6,3,3]);
            color("tan") translate([-3+31.5/2,35/2-(23.5/2)-2.5,-adjust]) cube([6,3,3]);
            if(side == "right") {
                color("tan") translate([.5,-2+35/2,-adjust]) cube([6,3,3]);
            }
            if(side == "left") {
                color("tan") translate([31.5/2+(23.5/2)-2.5,-2+35/2,-adjust]) cube([6,3,3]);
            }
        }
    }
    if(speaker == true && pcb == true) {
        translate([(31.5/2),35/2,1.6]) boom_speaker();        
    }
    if(speaker == true && pcb == false) {
        boom_speaker();        
    }
}


// hk stero boom bonnet speakers
module boom_speaker() {

    adjust = .01;
    $fn = 90;
    difference() {
        union() {
            color("silver") translate([0,0,-8.5]) cylinder_fillet_inside(h=6.5, r=21.4/2, 
                top=0, bottom=2, $fn=90, fillet_fn=30, center=false);
            color("dimgray") translate([0,0,2.5-adjust]) cylinder_fillet_inside(h=1, r=21.75/2, 
                top=1, bottom=0, $fn=90, fillet_fn=30, center=true);
  
            difference() {                
                color("black") translate([0,0,-5-adjust]) cylinder(d=23.7, h=5);
                for(d=[30:60:360]) {
                    color("dimgray") translate([(23.7/2)*cos(d),(23.7/2)*sin(d),-6-adjust]) cylinder(d=6, h=5+2*adjust);
                }
            }                
            color("black") translate([0,0,-adjust]) cylinder(d=27.8, h=2);
            color("dimgray") translate([0,0,1]) cylinder(d=22.8, h=1);
            color("dimgray") translate([0,0,1]) cylinder(d=17.5, h=1.25);
        }
        color("darkgray") translate([0,0,10.5]) sphere(d=23);
    }  
}


// hk boom bonnet speaker grill
module hk_boom_grill(style,thick) {

    adjust = .01;
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
                        translate([0,0,-1.25-adjust]) cylinder(d=24, h=thick+2*adjust);      
                    }
                }
            }
        }
    }
    if(style == "flat") {
        difference() {
            translate([0,0,0]) cylinder(d=24.5, h=thick);
            for(c=[-14.5:3:24]) {
                for(r=[-14.5:3:24]) {
                    translate([r,c,-1]) cube([2,2,thick+2]);
                }
            }
        }
    }
}


// hk stero boom bonnet speaker holder
module boom_speaker_holder(style, tolerance) {

    adjust = .01;
    $fn = 90;

    if(style == "friction") {
        difference() {
            translate([0,0,0]) cylinder(d=31, h=4);
            translate([0,0,-adjust]) cylinder(d=28+tolerance, h=4+2*adjust);
            translate([0,-1,-adjust]) cube([15,40,10], center=true);
        }  
        difference() {
            translate([0,0,0]) cylinder(d=28+tolerance, h=2);
            translate([0,0,-adjust]) cylinder(d=28+tolerance-2, h=4+2*adjust);                
            translate([0,-1,-adjust]) cube([15,40,10], center=true);
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


// hk stero boom bonnet speaker clamp holder top
module boom_speaker_strap(side) {

    topthick = 2;
    top_height = 14;
    adjust = .01;
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
            translate([10.75-adjust,14.5,top_height]) rotate([0,90,0]) cylinder(d=35,h=3);
            }
            translate([-9.25,0,top_height-topthick-adjust]) cube([20,29,topthick]);
            difference() {
                translate([-4.25,14.5,14]) rotate([0,90,0]) cylinder(d=28, h=15);
                translate([-5.25,0,19]) cube([20,30,19.5]);
            }
        }
        // speaker holders
        translate([-3-adjust,14.5,14]) rotate([0,90,0]) cylinder(d=30.8, h=4.5);
        translate([-3-adjust,14.5,14]) rotate([0,90,0]) cylinder(d=32.8, h=2);
        translate([-2.75,14.5,14]) rotate([0,90,0]) cylinder(d=28, h=14.5);
        translate([-4.55,-4,-4]) cube([20,37,topthick+15]);

        if(side == "left") {
            translate([4.15,-3.4,-adjust]) cylinder(d=3.2, h=50);
            translate([4.15,-3.4,15]) cylinder(d=6, h=10);
            translate([5.75,40,-adjust]) cylinder(d=3.2, h=50);
        }
        if(side == "right") {
            translate([4.5,32.5,-adjust]) cylinder(d=3.2, h=50);
            translate([4.5,32.5,15]) cylinder(d=6, h=10);
            translate([10.5,-11,-adjust]) cylinder(d=3.2, h=50);
        }
    }
}


// hk stero boom bonnet volume ring 
module boom_vring(tolerance) {

    out_dia = 22;
    in_dia = 16.15 + tolerance;
    thick = 3;
    nub = 1.25;
    adjust = .01;
    $fn = 90;
    difference() {
        color("black") translate([0,0,0])cylinder(d=out_dia, h=thick);
        color("dimgray") translate([0,0,-adjust]) cylinder(d=in_dia, h=thick+2*adjust);
        for(d=[5:10:360]) {
            color("dimgray") translate([(out_dia/2)*cos(d),(out_dia/2)*sin(d),-adjust]) cylinder(d=nub, h=thick+2*adjust);
        }
    }  
}
// hk power button
module hk_pwr_button(mask = false) {
    
    adjust=.01;
    $fn = 90;

    if(mask == true) {
        color("silver") translate([0, 0, -19]) cylinder(h=20, d=16);
    }
    else {
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

// hk m1s ups
module hk_m1s_ups() {
    
    pcb_size = [115,32,1.62];

    adj = .01;
    $fn = 90;
    
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
   color("silver") translate([15,5,pcb_size[2]]) rotate([0,0,270]) battery_clip();
   color("silver") translate([80,16,pcb_size[2]]) rotate([0,0,90]) battery_clip();
   translate([13.25,10.5,pcb_size[2]+10.4]) rotate([0,90,0]) battery("18650_convex");
   
   translate([86.75,.5,pcb_size[2]]) momentary45x15();
   translate([97.5,-1,pcb_size[2]]) usbc();
   
   translate([35,28,pcb_size[2]]) led("DodgerBlue");
   translate([40,28,pcb_size[2]]) led("DodgerBlue");
   translate([45,28,pcb_size[2]]) led("DodgerBlue");
   translate([50,28,pcb_size[2]]) led("DodgerBlue");
 
   translate([113,8,pcb_size[2]]) rotate([0,0,90]) led("green");
   translate([113,16,pcb_size[2]])  rotate([0,0,90]) led();
   translate([113,21,pcb_size[2]])  rotate([0,0,90]) led();
   
   translate([78,29,pcb_size[2]]) rotate([0,0,270])header(7);
   translate([78,31.5,pcb_size[2]]) rotate([0,0,270])header(7);
}


// prototype board, ups footprint
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
       for(r=[5:2.54:30]) {
        translate([10,r,pcb_size[2]+adj]) pcb_pad(38);
       }
   }
}


// prototype board, m1s footprint
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
       // pads
       for(r=[7:2.54:32]) {
        translate([10,r,pcb_size[2]+adj]) pcb_pad(28);
       }
   }
}

module hk_m1s_case_holes(type="landscape") {
    
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

