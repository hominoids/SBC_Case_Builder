/*

    cableholder_spacer()

*/

module cableholder_spacer() {
    
    size = [9.4,16,6];
    $fn = 90;
    translate([0,size[2]/2,-5]) rotate([90,0,0])
    difference() {
        translate([size[0]/2,size[0]/2,0]) rotate([0,0,90]) slot(size[0],size[1],size[2]);
        translate([-1,5,3]) rotate([0,90,0]) cylinder(d=3.2, h=12);
        translate([-1,7.5,-1]) cube([2,20,9]);
        translate([5,9.5,-1]) rotate([0,0,90]) slot(4.5,11,9);
        translate([3,20,-1]) rotate([0,0,45]) cube([2,6,9]);
    }
}
