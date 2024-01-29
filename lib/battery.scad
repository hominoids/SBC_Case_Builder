/*

    battery(type)
    battery_clip(bat_dia = 18.4)
    batt_holder(tolerance)

*/

module battery(type) {

    adj = .01;
    if(type == "18650") {
        difference() {
            cylinder(d=18.4, h=65);
            translate([0,0,65-4]) difference() {
                cylinder(d=18.5, h=2);
                cylinder(d=17.5, h=3);
            }
        }
    }
    if(type == "18650_convex") {
        difference() {
            cylinder(d=18.4, h=68);
            translate([0,0,65-4]) difference() {
                cylinder(d=18.5, h=2);
                cylinder(d=17.5, h=3);
            }
            translate([0,0,65-adj]) difference() {
                cylinder(d=18.5, h=3+2*adj);
                cylinder(d=14.4, h=3+2*adj);
            }
        }
    }
    if(type == "21700") {
        difference() {
            cylinder(d=21, h=70);
            translate([0,0,70-4]) difference() {
                cylinder(d=21.1, h=2);
                cylinder(d=20.1, h=3);
            }
        }
    }
}

module battery_clip(bat_dia = 18.4) {
    
    mat = .38;
    width = 9.5;
    tab = 8.9;
    bat_holder = bat_dia+2*mat;
    adj = .1;

    translate([-5.5,0,10.5]) {
        difference() {
            translate([0,width,0]) rotate([90,0,0]) cylinder(d=bat_holder, h=9.5);
            translate([0,width+adj,0]) rotate([90,0,0]) cylinder(d=bat_dia, h=10.5);
            translate([mat/2-11.1/2,-adj,mat-1.3-bat_dia/2]) cube([11.1-mat,width+2*adj,3]);
            translate([0,width+adj,0]) rotate([90,-45,0]) cube([bat_dia,bat_dia,bat_holder]);
        }
        difference() {
            translate([-11.1/2,0,-1.3-bat_dia/2]) cube([11.1,width,3]);
            translate([mat-11.1/2,-adj,mat/2-1.3-bat_dia/2]) cube([11.1-2*mat,width+2*adj,3]);
        }
        difference() {
            translate([-(tab/2),-3.5,-1-bat_dia/2]) rotate([-5,0,0]) cube([tab,3.5,10]);
            translate([-(tab/2)-adj,-3.5+mat,mat-1-bat_dia/2]) rotate([-5,0,0]) cube([tab+2*adj,3.5+mat,10]);
        }    
        translate([0,-2.225,0]) rotate([85,0,0]) cylinder(d=tab, h=mat);
        difference() {
            translate([0,-2.75,0]) sphere(d=3);
            translate([-5,-2.75,-5]) rotate([85,0,0]) cube([tab,10,10]);
        }
    }
}

module batt_holder(tolerance) {
    
    $fn = 90;
    difference () {
        cylinder(d=25.5,h=6);
        translate ([0,0,-1]) cylinder(d=20.4+tolerance,h=8);
        cube([14,26,13], true);
    }
    cylinder(r=12.75, h=2);
}

