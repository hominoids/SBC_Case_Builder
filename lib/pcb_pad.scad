/*
    pcb_pad(pads = 1, style = "round")

*/

// single row pcb pad
module pcb_pad(pads = 1, style = "round") {

    adjust = .01;
    $fn = 90;
    pad_size = 1.25;
    size_y = 2.54;
    size_x = 2.54 * (pads-1);                
    union() {
        for (i=[0:2.54:size_x]) {
            if(style == "round") {
                difference() {
                    color("#fee5a6") translate ([i,0,0]) cylinder(d=pad_size, h=.125);
                    color("dimgray") translate([i,0,-adjust]) cylinder(d=.625, h=.125+2*adjust);
                }
            }
            if(style == "square") {
                difference() {
                    color("#fee5a6") translate ([i-pad_size/2,-pad_size/2,0]) cube([pad_size, pad_size, .125]);
                    color("dimgray") translate([i,0,-adjust]) cylinder(d=.625, h=.125+2*adjust);
                }
            }
        }
    }
}
