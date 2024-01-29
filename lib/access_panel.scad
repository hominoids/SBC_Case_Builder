/*
    access_port(size[],orientation)
    access_cover(size[],orientation)

*/

/* access port and support */
module access_port(size,orientation) {
    
    floorthick = size[2];
    adjust = .01;
    $fn = 90;
    if(orientation == "portrait") {
        difference() {
            union() {
                translate([0,0,0]) cube([size[0],size[1],size[2]]);
                // access panel support
                translate([(size[0]/2)+.25,size[1]-6.5,0]) cylinder(d=9,h=floorthick+(adjust*2)+5);
                translate([(size[0]/2)-10,size[1]-11,floorthick-adjust]) cube([20,9.5,floorthick]);
                translate([1,0,floorthick-adjust]) cube([size[0]-2,5,4.5]);
                }
            // access opening
            translate([.5,6,-adjust]) cube([size[0]-1.15,size[1]-17,floorthick+(adjust*2)]);
            translate([(size[0]/2)-5,size[1]-12,-adjust]) slab([10.5,5.5,floorthick],5.5);
            translate([(size[0]/2)+.25,size[1]-6.5,floorthick+2])
                cylinder(r=3.2,h=floorthick+(adjust*2)+5,$fn=6);
            translate([(size[0]/2)+.25,size[1]-6.5,-adjust]) 
                cylinder(d=3.2,h=floorthick+(adjust*2)+5);
            translate([4,2+adjust,floorthick]) cube([7.75,3,2.75]);
            translate([size[0]-13,2+adjust,floorthick]) cube([7.75,3,2.75]);
            if(size[0] > 100) {
                translate([(size[0]/2),2+adjust,floorthick]) cube([7.75,3,2.75]);
            }
        }
    }
    if(orientation == "landscape") {
        difference() {
            union() {
                translate([0,-1,0]) cube([size[0],size[1],size[2]]);
                // access panel support
                translate([size[0]-6.5,(size[1]/2)-.5,0]) cylinder(d=9,h=floorthick+(adjust*2)+5);
                translate([size[0]-11,(size[1]/2)-10.5,floorthick-adjust]) cube([9.5,20,floorthick]);
                translate([0,0,floorthick-adjust]) cube([5,size[1]-2,4.5]);
            }
            // access opening
            translate([6,-.5,-adjust]) cube([size[0]-17,size[1]-1.15,floorthick+(adjust*3)]);
            translate([size[0]-12,(size[1]/2)-6,-adjust]) slab([5.5,10.5,floorthick],5.5);
            translate([size[0]-6.5,(size[1]/2)-.5,floorthick+2]) rotate([0,0,30])
                cylinder(r=3.2,h=floorthick+(adjust*2)+5,$fn=6);
            translate([size[0]-6.5,(size[1]/2)-.5,-adjust]) 
                cylinder(d=3.2,h=floorthick+(adjust*2)+5);
            translate([2+adjust,3,floorthick]) cube([3,8.25,2.75]);
            translate([2+adjust,size[1]-13,floorthick]) cube([3,8.25,2.75]);
            if(size[1] > 100) {
                translate([2+adjust,(size[1]/2)-(7.75/2)-1.25,floorthick]) cube([3,7.75,2.5]);
            }
        }
    }
}


/* access cover and support */        
module access_cover(size,orientation) {
    
    floorthick = size[2];
    adjust = .01;
    $fn = 90;
    if(orientation == "portrait") {
        difference() {
            union() {
                translate([1,6.25,0]) cube([size[0]-2.15,size[1]-17.5,floorthick]);
                translate([(size[0]/2)-4.75,size[1]-12.25,0]) slab([10,5,floorthick], 5);
                translate([1,6.25,floorthick-adjust]) cube([size[0]-2.15,6,floorthick]);
                translate([4.25,3,floorthick]) cube([7.25,4,2]);
                translate([size[0]-12.75,3,floorthick]) cube([7.25,4,2]);
                if(size[0] > 100) {
                    translate([(size[0]/2)+.25,3,floorthick]) cube([7.25,4,2]);
                }
            }
            translate([(size[0]/2)+.25,size[1]-6.5,-floorthick-adjust]) 
                cylinder(d=3.2,h=(floorthick*2)+(adjust*2));
            translate([(size[0]/2)+.25,size[1]-6.5,-floorthick-adjust+floorthick]) 
                cylinder(d1=6, d2=3.2, h=floorthick);
        }
    }
    if(orientation == "landscape") {
        difference() {
            union() {
                translate([6.25,0,0]) cube([size[0]-17.75,size[1]-2,floorthick]);
                translate([size[0]-12.25,(size[1]/2)-5.75,0]) slab([5,10,floorthick], 5);
                translate([6.25,0,floorthick-adjust]) cube([6,size[1]-2.15,floorthick]);
                translate([3.5+adjust,3.25,floorthick]) cube([4,7.25,2]);
                translate([3.5+adjust,size[1]-12.75,floorthick]) cube([4,7.25,2]);
                if(size[1] > 100) {
                    translate([3.5+adjust,(size[1]/2)-(7.75/2)-1,floorthick]) cube([4,7.25,2]);
                }
            }
            translate([size[0]-6.5,(size[1]/2)-.75,-floorthick-adjust]) 
                cylinder(d=3.2,h=(floorthick*2)+(adjust*2));
            translate([size[0]-6.5,(size[1]/2)-.75,-floorthick-adjust+floorthick]) 
                cylinder(d1=6, d2=3.2, h=floorthick);
        }
    }
}
