/*

    slab(size, radius)
    slab_r(size, radius)
    slot(hole,length,depth)
    punchout(width,depth,gap,thick,fillet,shape)
    hdmi_open(hdmi_style)
    microusb_open()

*/

/* slab module */
module slab(size, radius) {
    
    x = size[0];
    y = size[1];
    z = size[2];   
    linear_extrude(height=z)
    hull() {
        translate([0+radius ,0+radius, 0]) circle(r=radius);	
        translate([0+radius, y-radius, 0]) circle(r=radius);	
        translate([x-radius, y-radius, 0]) circle(r=radius);	
        translate([x-radius, 0+radius, 0]) circle(r=radius);
    }  
}


/* multi-radius round slab */
module slab_r(size, radius) {
    
    x = size[0];
    y = size[1];
    z = size[2];
    r0 = radius[0];
    r1 = radius[1];
    r2 = radius[2];
    r3 = radius[3];
    
    linear_extrude(height=z)
    hull() {
        translate([0+radius[0] ,0+radius[0], 0]) circle(r=radius[0]);	
        translate([0+radius[1], y-radius[1], 0]) circle(r=radius[1]);	
        translate([x-radius[2], y-radius[2], 0]) circle(r=radius[2]);	
        translate([x-radius[3], 0+radius[3], 0]) circle(r=radius[3]);
    }  
}


/* slot module */
module slot(hole,length,depth) {
    
    hull() {
        translate([0,0,0]) cylinder(d=hole,h=depth);
        translate([length,0,0]) cylinder(d=hole,h=depth);        
        }
    } 

// punchout opening
module punchout(width,depth,gap,thick,fillet,shape) {
    
    adjust = .01;
    $fn=90;

    // slot punchout
    if(shape == "slot") {
        difference() {
            translate([0,0,0]) slot(depth,width,thick);
            translate([0,0,-adjust]) slot(depth-gap,width,thick+(2*adjust));
            // cross ties    
            translate([-1,-(depth/2)-1,-adjust]) cube([2,depth+2,thick+(2*adjust)]);
            translate([(width/2)-1-(width/4)+4,-(depth/2)-1,-adjust]) cube([2,depth+2,thick+(2*adjust)]);
            translate([(width/2)-1+(width/4)-4,-(depth/2)-1,-adjust]) cube([2,depth+2,thick+(2*adjust)]);
            translate([width-1,-(depth/2)-1,-adjust]) cube([2,depth+2,thick+(2*adjust)]);
            }
        }
    if(shape == "rectangle") {
        difference() {
            translate([(width/2),(depth/2),thick/2]) 
                cube_fillet_inside([width,depth,thick], 
                    vertical=[fillet,fillet,fillet,fillet], 
                        top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
            translate([(width/2),(depth/2),(thick/2)-adjust]) 
                cube_fillet_inside([width-gap,depth-gap,thick+(3*adjust)], 
                    vertical=[fillet,fillet,fillet,fillet], 
                        top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
            // cross ties    
            translate([-1,(depth/2)-1,-adjust]) cube([gap+2,2,thick+(2*adjust)]);
            translate([width-4,depth-gap-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            translate([2,depth-gap-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            translate([width-gap-1,(depth/2)-1,-adjust]) cube([gap+2,2,thick+(2*adjust)]);
            translate([width-4,-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            translate([2,-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            }
        }
    if(shape == "round") {
        difference() {
            translate([(width/2),(width/2),0]) 
                cylinder(d=width, h=thick); 
            translate([(width/2),(width/2),-adjust]) 
                cylinder(d=width-gap, h=thick+2*adjust); 
            // cross ties    
            translate([-1,(depth/2)-1,-adjust]) cube([gap+2,2,thick+(2*adjust)]);
            translate([(width/2)-1,depth-gap-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            translate([width-gap-1,(depth/2)-1,-adjust]) cube([gap+2,2,thick+(2*adjust)]);
            translate([(width/2)-1,-1,-adjust]) cube([2,gap+2,thick+(2*adjust)]);
            }
        }
    }

/* hdmi opening */
module hdmi_open(hdmi_style) {
    
    if(hdmi_style == "hdmi_a") {
        union() { 
            difference() {
                translate([0,-5,1.25]) cube([15.5,8,5.75]);
                translate([0.5,-5.2,.5]) rotate ([-90,0,0]) cylinder(d=3, h=13.5,$fn=30);
                translate([15,-5.2,.5]) rotate ([-90,0,0]) cylinder(d=3, h=13.5,$fn=30);
            }
            translate([1.75,-5,.5]) cube([12, 8, 1]);
        }
    }
    if(hdmi_style == "hdmi_micro") {
        union() { 
            difference() {
                translate([-.25,-6,-.01]) cube([7,8,3.15]);
                translate([-.25,-6.2,0]) rotate ([-90,0,0]) cylinder(d=1.5, h=9.5,$fn=30);
                translate([6.75,-6.2,0]) rotate ([-90,0,0]) cylinder(d=1.5, h=9.5,$fn=30);
            }
        }
    }
    if(hdmi_style == "hdmi_mini") {
        union() { 
            difference() {
                translate([-.25,-6,-.01]) cube([11.5,8,3.5]);
                translate([-1,-6.2,-.5]) rotate ([-90,0,0]) cylinder(d=3, h=10,$fn=30);
                translate([12.25,-6.2,-.5]) rotate ([-90,0,0]) cylinder(d=3, h=10,$fn=30);
            }
        }
    }
    if(hdmi_style=="dp_mini") {
        size_x = 9;
        size_y = 8;        
        union() {    
            difference() {
                translate([-.25,-6,0]) cube([size_x, size_y, 5.75]);
                translate([-7.5,-7,1]) rotate([0,45,0]) cube([size_x, size_y+2, 5.6]);
                translate([10,-7,-5]) rotate([0,-45,0]) cube([size_x, size_y+2, 5.6]);                    
            }
        }
    }
}       


/* micro-usb opening */
module microusb_open() {
    
    translate([0,0,.5])rotate([90,0,0])
    hull() {
        translate([6,1.5,-5]) cylinder(d=3.5,h=12);
        translate([1,1.5,-5]) cylinder(d=3.5,h=12);
    }
}
