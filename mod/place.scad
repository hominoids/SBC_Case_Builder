/*

    place(x,y,z,size_x,size_y,rotation,side)

*/

/* placement module *must be first* for children() */
module place(x,y,z,size_x,size_y,rotation,side) {

    if (side == "top") {
        if (rotation == 0 || rotation == 90 || rotation == 180 || rotation == 270) {    
            if ((rotation >= 0 && rotation < 90) || (rotation < -270 && rotation > -360))
                translate([x,y,z]) rotate([0,0,-rotation]) children();

            if ((rotation >= 90 && rotation < 180) || (rotation < -180 && rotation >= -270))
                translate([x,y+size_x,z]) rotate([0,0,-rotation]) children();
           
            if ((rotation >= 180 && rotation < 270) || (rotation < -90 && rotation >= -180))
                translate([x+size_x,y+size_y,z]) rotate([0,0,-rotation]) children(0);
           
            if ((rotation >= 270 && rotation < 360) || (rotation < 0 && rotation >= -90))
                translate([x+size_y,y,z]) rotate([0,0,-rotation]) children(); }
        else {
            translate([x,y,z]) rotate([0,0,-rotation]) children();            
        }
    }   
    if (side == "bottom") {
        if (rotation == 0 || rotation == 90 || rotation == 180 || rotation == 270) {   
            if ((rotation >= 0 && rotation < 90) || (rotation < -270 && rotation > -360))
                translate([x+size_x,y,z]) rotate([0,180,rotation]) children();
           
            if ((rotation >= 90 && rotation < 180) || (rotation < -180 && rotation >= -270))
                translate([x+size_y,y+size_x,z]) rotate([0,180,rotation]) children();
               
            if ((rotation >= 180 && rotation < 270) || (rotation < -90 && rotation >= -180))
                translate([x,y+size_y,z]) rotate([0,180,rotation]) children();
           
            if ((rotation >= 270 && rotation < 360) || (rotation < 0 && rotation >= -90))
                translate([x,y,z]) rotate([0,180,rotation]) children(); }
        else {
            translate([x,y,z]) rotate([0,180,rotation]) children();
            
        }
    }    
    children([1:1:$children-1]);
}
