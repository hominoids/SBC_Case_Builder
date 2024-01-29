/*

    fan_cover(size, thick)
    fan_mask(size, thick, style)

*/

/* fan cover */
module fan_cover(size, thick) {
    difference() {
        color("grey",1) slab([size,size,thick],3);
        color("grey",1) fan_mask(size, thick, 2);
    }
}

/* fan mask to create opening */
module fan_mask(size, thick, style) {

    $fn=90;
    
    if(style == 1) {
        translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-2);
        if(size == 40) {
            // mount holes
            translate ([size-4,size-4,-1]) cylinder(h=thick+2, d=3);
            translate ([size-4,4,-1]) cylinder(h=thick+2, d=3);
            translate ([4,size-4,-1]) cylinder(h=thick+2, d=3);
            translate ([4,4,-1]) cylinder(h=thick+2, d=3);
        }
        if(size == 60) {
            // mount holes
            translate ([size-5,size-5,-1]) cylinder(h=thick+2, d=3);
            translate ([size-5,5,-1]) cylinder(h=thick+2, d=3);
            translate ([5,size-5,-1]) cylinder(h=thick+2, d=3);
            translate ([5,5,-1]) cylinder(h=thick+2, d=3);
        }
        if(size >= 80) {
            // mount holes
            translate ([size-3.75,size-3.75,-1]) cylinder(h=thick+2, d=3);
            translate ([size-3.75,3.75,-1]) cylinder(h=thick+2, d=3);
            translate ([3.75,size-3.75,-1]) cylinder(h=thick+2, d=3);
            translate ([3.75,3.75,-1]) cylinder(h=thick+2, d=3);
        }
    }
    if(style == 2 && size == 40) {
        difference() {
            union () {
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-2);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-6);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-10);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-14);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-18);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-22);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-26);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-30);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-34);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-38);
                }
                // mount holes
                translate ([size-4,size-4,-1]) cylinder(h=thick+2, d=3);
                translate ([size-4,4,-1]) cylinder(h=thick+2, d=3);
                translate ([4,size-4,-1]) cylinder(h=thick+2, d=3);
                translate ([4,4,-1]) cylinder(h=thick+2, d=3);
            }
            translate([6.5,5,-2]) rotate([0,0,45]) cube([size,2,thick+4]);
            translate([4.5,size-6,-2]) rotate([0,0,-45]) cube([size,2,thick+4]);
        } 
    }
    if(style == 2 && size == 60) {
        difference() {
            union () {
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-2);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-6);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-10);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-14);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-18);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-22);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-26);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-30);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-34);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-38);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-42);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-46);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-50);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-54);
                }
                // mount holes
                translate ([size-5,size-5,-1]) cylinder(h=thick+2, d=3);
                translate ([size-5,5,-1]) cylinder(h=thick+2, d=3);
                translate ([5,size-5,-1]) cylinder(h=thick+2, d=3);
                translate ([5,5,-1]) cylinder(h=thick+2, d=3);
            }
            translate([9.5,8,-2]) rotate([0,0,45]) cube([size,2,thick+4]);
            translate([8.5,size-10,-2]) rotate([0,0,-45]) cube([size,2,thick+4]);
        } 
    }
    if(style == 2 && size >= 80) {
        difference() {
            union () {
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-2);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-8);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-14);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-20);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-26);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-32);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-38);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-44);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-50);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-56);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-62);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-68);
                }
                difference() {
                    translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-74);
                    translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-79);
                }
                if(size == 92) {
                    difference() {
                        translate ([size/2,size/2,-1]) cylinder(h=thick+2, d=size-86);
                        translate ([size/2,size/2,-2]) cylinder(h=thick+4, d=size-92);
                    }
                }
                // mount holes
                translate ([size-3.75,size-3.75,-1]) cylinder(h=thick+2, d=3);
                translate ([size-3.75,3.75,-1]) cylinder(h=thick+2, d=3);
                translate ([3.75,size-3.75,-1]) cylinder(h=thick+2, d=3);
                translate ([3.75,3.75,-1]) cylinder(h=thick+2, d=3);
            }
            translate([6.5,4.25,-2]) rotate([0,0,45]) cube([size*1.2,3,thick+4]);
            translate([4.25,size-6.5,-2]) rotate([0,0,-45]) cube([size*1.2,3,thick+4]);
        } 
    }
    if(style == 3) {
        inner = size == 30 ? 24 :
            size == 40 ? 32 :
            size == 50 ? 40 :
                size == 60 ? 50 :
                size == 70 ? 61.9 :
                    size == 80 ? 71.5 :
                    size * 0.8; // Use 80% as default
        
        rings = size <= 40 ? 4 : 6;
        bar_size = size <= 40 ? 2 : 3;

        screw_offset = inner / 2;
        center_point = size * 0.5;
        base_ring_size = size * 0.95;
        rings_spacing = size / rings;

        translate([size/2, size/2, -1])
        union() {
            translate([screw_offset, screw_offset, (thick+2)/2]) cylinder(d=3, h=thick+2, center=true);
            translate([-screw_offset, screw_offset, (thick+2)/2]) cylinder(d=3, h=thick+2, center=true);
            translate([screw_offset, -screw_offset, (thick+2)/2]) cylinder(d=3, h=thick+2, center=true);
            translate([-screw_offset, -screw_offset, (thick+2)/2]) cylinder(d=3, h=thick+2, center=true);

            difference() {
            union() {
                for(i=[inner:-rings_spacing:0]) {
                    difference() {
                        cylinder(d=base_ring_size - i, h=thick+2);
                        translate([0, 0, -1]) cylinder(d=base_ring_size - i - (rings_spacing/2), h=thick+4);
                    }
                }
            }
                
            translate([0, 0, -1]) union() {
                cylinder(d=bar_size*2+0.1, thick+6); // Add a circle to prevent any tiny holes around cross bar
                rotate([0, 0, 45]) cube([size, bar_size, 12], center=true);
                rotate([0, 0, 45]) cube([bar_size, size, 12], center=true);
            }
            }
        }
    }
}
