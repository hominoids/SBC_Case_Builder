/*

    keyhole(keysize, mask = false)

*/

// enclosed keyhole
module keyhole(keysize, mask = false) {
    
    adjust=.01;
    $fn = 90;

    if(mask == true) {
        union() {
            translate([0, 0, -adjust]) cylinder(h=keysize[3]+2*adjust, d=keysize[0]);
            translate([-keysize[1]/2, 0, -adjust]) cube([keysize[1], keysize[2]+keysize[0]/2, keysize[3]+2*adjust]);
            translate([0, -keysize[1]/2, -adjust]) cube([keysize[2]+keysize[0]/2, keysize[1], keysize[3]+2*adjust]);
        }
    }
    else {
        difference() {
            union() {
                translate([0, 0, -adjust]) 
                difference() {
                    difference() {
                        translate([-keysize[2], -keysize[2], keysize[3]]) cube([keysize[2]*3, keysize[2]*3, 4.5]);
                        translate([0, -10, 0]) rotate([0, 0, 135]) cube([20, 10, 10]);
                        translate([keysize[2], keysize[2], -adjust]) cube([keysize[2]*3, keysize[2]*3, keysize[3]+5]);        
                    }
                    difference() {
                        translate([-keysize[2]+2, -keysize[2]+2, keysize[3]-adjust]) 
                            cube([-4+keysize[2]*3, -4+keysize[2]*3, 3.5]);
                        translate([2, -10, 0]) rotate([0, 0, 135]) cube([20, 10, 10]);
                        translate([+keysize[2]-2, keysize[2]-2, -adjust]) 
                            cube([keysize[2]*3, keysize[2]*3, keysize[3]+5]);        
                    }
                }
                difference() {   
                    translate([-keysize[2], -keysize[2], 0]) cube([keysize[2]*3, keysize[2]*3, keysize[3]]);
                    translate([0, -10, -adjust]) rotate([0, 0, 135]) cube([20, 10, 10]);
                }   
            }
            translate([keysize[2], keysize[2], -adjust]) cube([keysize[2]*3, keysize[2]*3, keysize[3]+2*adjust]);        
            union() {
                translate([0, 0, -adjust]) cylinder(h=keysize[3]+2*adjust, d=keysize[0]);
                translate([-keysize[1]/2, 0, -adjust]) cube([keysize[1], keysize[2]+keysize[0]/2, keysize[3]+2*adjust]);
                translate([0, -keysize[1]/2, -adjust]) cube([keysize[2]+keysize[0]/2, keysize[1], keysize[3]+2*adjust]);
            }
        }
    }
}
