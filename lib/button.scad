/*
    button(style, diameter, height)
    button_assembly(style, diameter, height
    button_plunger(style, diameter, height)
    button_top(style, diameter, height)
    button_clip(style)

*/

/* buttons */
module button(style, size, radius, pad) {

    diameter = size[0];
    height = size[2];
    gap = 1.5;
    adjust = .01;
    $fn = 90;

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
            translate([-1.75,-1.25,-height-1]) cube([3.5,2.5,height+2]);
            translate([0,0,-(diameter/2)]) cylinder(d=5, h=2);
        }
    }
    if(style == "cutout") {
        difference() {
            translate([-size[0]+2,-3-size[1]/2,0]) slab_r([size[0]+2,size[1]+6,size[2]-2*adjust], [.1,.1,.1,.1]);            
            difference() {
                translate([-size[0]+3,-size[1]/2,-adjust]) 
                    slab_r([size[0],size[1],size[2]], [radius[0],radius[1],radius[2],radius[3]]);
                translate([-size[0]+3+(gap/2),-size[1]/2+(gap/2),-1]) slab_r([size[0]-gap,size[1]-gap,1+size[2]+2*adjust], 
                    [radius[0],radius[1],radius[2]-gap/2,radius[3]-gap/2]);
                translate([-size[0]+3-gap,-1,-1]) cube([gap*2,2,1+height+2*adjust]);
            }
            translate([0,0,2]) sphere(d=3);
        }
        translate([0,0,-pad+adjust]) cylinder(d=3, h=pad);
    }
}


/* button plunger,top,clip */
module button_assembly(style, diameter, height) {

adjust = .01;
$fn = 90;

    if(style == "recess") {
        button_plunger(style, diameter, height);
        button_top(style, diameter, height);
        translate([0,0,-height]) button_clip(style);
    }
}


/* button plunger */
module button_plunger(style, diameter, height) {

adjust = .01;
$fn = 90;

    if(style == "recess") {
        difference() {
            translate([-1.5,-1,-(height)-2]) cube([3,2,height+1]);
            translate([-1.5-adjust,-1.5,-height]) cube([.5,3,1]);
            translate([1+adjust,-1.5,-height]) cube([.5,3,1]);
            translate([-1.5-adjust,-1.5,-4]) cube([.5,3,4]);
            translate([1+adjust,-1.5,-4]) cube([.5,3,4]);
        }
    }
}


/* button top */
module button_top(style, diameter, height) {

adjust = .01;
$fn = 90;

    if(style == "recess") {
        difference() {
            translate([0,0,-3]) cylinder(d=5, h=2.75);
            translate([-1.25,-1.25,-3-adjust]) cube([2.5,2.5,2]);
        }
    }
}


/* button c-clip */
module button_clip(style) {

adjust = .01;
$fn = 90;

    if(style == "recess") {
        difference() {
            cylinder(d=8.5, h=.8);
            translate([-1.5,-1.75,-adjust]) cube([2.75,3.5,1]);
            translate([-.75,-.75,-adjust]) cube([5,1.25,1.25]);
        }
    }
}
