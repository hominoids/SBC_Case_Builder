/*

    m_insert(type="M3", icolor = "#ebdc8b")

*/

module m_insert(type="M3", icolor = "#ebdc8b") { //#f4e6c3, #ebdc8b 
    
    odiam = type == "M3" ? 4.2 : 3.5;
    idiam = type == "M3" ? 3 : 2.5;
    iheight = 4;
    
    difference() {
        color(icolor,.6) cylinder(d=odiam, h=iheight);
        color(icolor,.6) translate([0,0,-1]) cylinder(d=idiam, h=iheight+2);
    }
    for(bearing = [0:10:360]) {
        color(icolor) translate([-.25+(odiam/2)*cos(bearing),-.25+(odiam/2)*sin(bearing),iheight-1.5]) 
            rotate([0,0,0]) cube([.5,.5,1.5]);
    }
}


// General purpose screw
// screw(screw[d, l, style])
// 	d - thread diameter
// 	l - thread length
// 	style - screw head style
//
// 	Styles:
// 	0 - Mushroom head, 5mm diameter

module screw(screw_type) {
    d = screw_type[0];
    l = screw_type[1];
    style = screw_type[2];

    // Head
        if(style == 0) {
            difference() {
                translate([  0,  0, -0.3]) sphere(2.7);
                translate([-10,-10,-10]) cube([20,20,10]);
                translate([-10,-10,  2]) cube([20,20,10]);
            }
        }
    // Thread
        rotate([180,0,0]) cylinder(d=d, h=l);
}
