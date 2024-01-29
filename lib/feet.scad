/*

    feet (height)

*/

/* case feet */
module feet (diameter,height) {
    
    difference (){ 
        cylinder (d=diameter,h=height);
        translate([0,0,-1]) cylinder (d=3, h=height+2,$fn=90);
        translate ([0,0,-1]) cylinder(r=3.35,h=height-3,$fn=6);       
    }
}
