// Stephanie Shaltes
// https://github.com/StephS/i2_xends/blob/master/inc/fillets.scad
//
// 20200329 Additional maintenance and debug by hominoid @ www.forum.odroid.com

function poly_sides_r(r) = (max(round(4 * r),3)+1);

// 2d primitive for outside fillets.
module fillet_2d_o(fillet_r, fillet_angle=90, fillet_fn=0) {
  add=0.01;
  f_fn=(fillet_fn>0) ? fillet_fn*4 : (ceil(poly_sides_r(fillet_r)/4)*4);
  if (fillet_r>0) {
  intersection() {
    circle(r=fillet_r, $fn=f_fn);
    polygon([
      [0-add, 0-add],
      [0-add, fillet_r],
      [fillet_r * tan(fillet_angle/2), fillet_r],
      [fillet_r * sin(fillet_angle), fillet_r * cos(fillet_angle)-add]
    ]);
  }
  }
}

// 2d primitive for inside fillets.
module fillet_2d_i(fillet_r, fillet_angle=90, fillet_fn=0) {
  add=0.01;
  f_fn=(fillet_fn>0) ? fillet_fn*4 : (ceil(poly_sides_r(fillet_r)/4)*4);
  if (fillet_r>0) {
  translate([fillet_r * tan(fillet_angle/2), fillet_r, 0])
  difference() {
    polygon([
      [0, 0],
      [0, -fillet_r-add],
      [-fillet_r * tan(fillet_angle/2)-add, -fillet_r-add],
      [-fillet_r * sin(fillet_angle)-add, -fillet_r * cos(fillet_angle)]
    ]);
    circle(r=fillet_r, $fn=f_fn);
  }
  }
}

// 3d rotated outside fillet.
module fillet_polar_o(inner_r, fillet_r, fillet_angle=90, fillet_fn=0, rotate_fn=0) {
  if (fillet_r>0) {
  rotate_extrude(convexity=8, $fn=rotate_fn) {
    translate([inner_r, 0, 0]) {
      fillet_2d_o(fillet_r, fillet_angle, fillet_fn);
    }
  }
  }
}

// 3d rotated inside fillet.
module fillet_polar_i(inner_r, fillet_r, fillet_angle=90, fillet_fn=0, rotate_fn=0) {
    if (fillet_r>0) {
        rotate_extrude(convexity=8, $fn=rotate_fn) {
          translate([inner_r, 0, 0]) {
            fillet_2d_i(fillet_r, fillet_angle, fillet_fn); }
        }
    }
}

// 3d rotated inside fillet negative.
module fillet_polar_i_n(outer_r, fillet_r, fillet_angle=90, fillet_fn=0, rotate_fn=0) {
    if (fillet_r>0) {
        rotate_extrude(convexity=8, $fn=rotate_fn) {
          translate([outer_r, 0, 0]) {
            rotate(90) fillet_2d_i(fillet_r, fillet_angle, fillet_fn); }
        }
    }
}

// 3d linear outside fillet.
module fillet_linear_o(l, fillet_r, fillet_angle=90, fillet_fn=0, add=0.02) {
  if (fillet_r>0) {
translate([0,0,-add/2])
    linear_extrude(height=l+add, center=false) {
      fillet_2d_o(fillet_r, fillet_angle, fillet_fn);
    }
  }
}

// 3d linear inside fillet.
module fillet_linear_i(l, fillet_r, fillet_angle=90, fillet_fn=0, add=0.02) {
  if (fillet_r>0) {
    translate([0,0,-add/2])
    linear_extrude(height=l+add, center=false) {
      fillet_2d_i(fillet_r, fillet_angle, fillet_fn);
    }
  }
}

module cube_negative_fillet(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90, vertical_fn=[0,0,0,0], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]){

vertical_fn= ($fn>0) ? [$fn,$fn,$fn,$fn] : vertical_fn;
top_fn= ($fn>0) ? [$fn,$fn,$fn,$fn] : top_fn;
bottom_fn= ($fn>0) ? [$fn,$fn,$fn,$fn] : bottom_fn;


    j=[1,0,1,0];

    for (i=[0:3]) {
        if (radius > -1) {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) translate([0, 0, -size[2]/2]) rotate([0,0,180]) fillet_linear_i(l=size[2], fillet_r=radius, fillet_angle=90, fillet_fn=$fn); //fillet(radius, size[2], $fn=$fn);
        } else {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) translate([0, 0, -size[2]/2]) rotate([0,0,180]) fillet_linear_i(l=size[2], fillet_r=vertical[i], fillet_angle=90, fillet_fn=vertical_fn[i]); //fillet(vertical[i], size[2], $fn=$fn);
        }
        rotate([90*i, -90, 0]) translate([size[2]/2, size[j[i]]/2, 0 ]) translate([0, 0, -size[1-j[(i)]]/2]) rotate([0,0,180]) fillet_linear_i(l=size[1-j[(i)]], fillet_r=top[(i)], fillet_angle=90, fillet_fn=top_fn[i]); // fillet(top[i], size[1-j[i]], $fn=$fn);
        rotate([90*(4-i), 90, 0]) translate([size[2]/2, size[j[i]]/2, 0]) translate([0, 0, -size[1-j[(i)]]/2]) rotate([0,0,180]) fillet_linear_i(l=size[1-j[(i)]], fillet_r=bottom[(i)], fillet_angle=90, fillet_fn=bottom_fn[i]); //fillet(bottom[i], size[1-j[i]], $fn=$fn);

    }
}

module cube_positive_fillet(size, radius=-1, vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], vertical_angle=[90,90,90,90], top_angle=[90,90,90,90], bottom_angle=[90,90,90,90], vertical_flip=[0,0,0,0], top_flip=[0,0,0,0], bottom_flip=[0,0,0,0], $fn=0){

    j=[1,0,1,0];

    for (i=[0:3]) {
        if (radius > -1) {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) translate([0, 0, -size[2]/2]) rotate([0,0,90]) fillet_linear_i(l=size[2], fillet_r=radius, fillet_angle=90, fillet_fn=$fn); //fillet(radius, size[2], $fn=$fn);
        } else {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) translate([0, 0, -size[2]/2]) rotate([0,0,180-vertical_angle[i]+(90+vertical_angle[i])*vertical_flip[i]]) fillet_linear_i(l=size[2], fillet_r=vertical[i], fillet_angle=vertical_angle[i], fillet_fn=$fn); //fillet(vertical[i], size[2], $fn=$fn);
        }
        rotate([90*i, -90, 0]) translate([size[2]/2, size[j[i]]/2, 0 ]) translate([0, 0, -size[1-j[(i)]]/2]) rotate([0,0,(180-top_angle[i])+(90+top_angle[i])*top_flip[i]]) fillet_linear_i(l=size[1-j[(i)]], fillet_r=top[(i)], fillet_angle=180-top_angle[i], fillet_fn=$fn); // fillet(top[i], size[1-j[i]], $fn=$fn);
        rotate([90*(4-i), 90, 0]) translate([size[2]/2, size[j[i]]/2, 0]) translate([0, 0, -size[1-j[(i)]]/2]) rotate([0,0,180-bottom_angle[i]+(90+bottom_angle[i])*bottom_flip[i]]) fillet_linear_i(l=size[1-j[(i)]], fillet_r=bottom[(i)], fillet_angle=bottom_angle[i], fillet_fn=$fn); //fillet(bottom[i], size[1-j[i]], $fn=$fn);

    }
}

module cube_positive_fillet_corners(size, radius=-1, vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], vertical_angle=[90,90,90,90], top_angle=[90,90,90,90], bottom_angle=[90,90,90,90], vertical_flip=[0,0,0,0], top_flip=[0,0,0,0], bottom_flip=[0,0,0,0], $fn=90){

    j=[1,0,1,0];

//bottom
    for (i=[0:3]) {
render(convexity=4) intersection() {
/*
     if (radius > -1) {
     rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) translate([0, 0, -size[2]/2-radius]) rotate([0,0,90]) fillet_linear_i(l=size[2]+radius*2, r=radius, fillet_angle=90, fillet_fn=$fn); //fillet(radius, size[2], $fn=$fn);
     } else {
     rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) translate([0, 0, -size[2]/2-vertical[i]]) rotate([0,0,180-vertical_angle[i]+(90+vertical_angle[i])*vertical_flip[i]]) fillet_linear_i(l=size[2]+vertical[i]*2, r=vertical[i], fillet_angle=vertical_angle[i], fillet_fn=$fn); //fillet(vertical[i], size[2], $fn=$fn);
     }
     */
     rotate([90*(4-i), 90, 0]) translate([size[2]/2, size[j[i]]/2, 0]) translate([0, 0, -size[1-j[(i)]]/2-bottom[(i)]]) rotate([0,0,180-bottom_angle[i]+(90+bottom_angle[i])*bottom_flip[i]]) fillet_linear_i(l=size[1-j[(i)]]+bottom[(i)]*4, fillet_r=bottom[(i)], fillet_angle=bottom_angle[i], fillet_fn=$fn); //fillet(bottom[i], size[1-j[i]], $fn=$fn);
     rotate([90*(4-((i+1)%4)), 90, 0]) translate([size[2]/2, size[j[((i+1)%4)]]/2, 0]) translate([0, 0, -size[1-j[((i+1)%4)]]/2-bottom[((i+1)%4)]]) rotate([0,0,180-bottom_angle[((i+1)%4)]+(90+bottom_angle[((i+1)%4)])*bottom_flip[((i+1)%4)]]) fillet_linear_i(l=size[1-j[(((i+1)%4))]]+bottom[(((i+1)%4))]*4, fillet_r=bottom[(((i+1)%4))], fillet_angle=bottom_angle[((i+1)%4)], fillet_fn=$fn); //fillet(bottom[i], size[1-j[i]], $fn=$fn);
}
    }
    
    // top
    for (i=[0:3]) {
render(convexity=4) intersection() {
     rotate([90*i, -90, 0]) translate([size[2]/2, size[j[i]]/2, 0 ]) translate([0, 0, -size[1-j[(i)]]/2-top[(i)]]) rotate([0,0,(180-top_angle[i])+(90+top_angle[i])*top_flip[i]]) fillet_linear_i(l=size[1-j[(i)]]+top[(i)]*4, fillet_r=top[(i)], fillet_angle=180-top_angle[i], fillet_fn=$fn); // fillet(top[i], size[1-j[i]], $fn=$fn);
     rotate([90*((i+1)%4), -90, 0]) translate([size[2]/2, size[j[((i+1)%4)]]/2, 0 ]) translate([0, 0, -size[1-j[(((i+1)%4))]]/2-top[(((i+1)%4))]]) rotate([0,0,(180-top_angle[((i+1)%4)])+(90+top_angle[((i+1)%4)])*top_flip[((i+1)%4)]]) fillet_linear_i(l=size[1-j[(((i+1)%4))]]+top[(((i+1)%4))]*4, fillet_r=top[(((i+1)%4))], fillet_angle=180-top_angle[((i+1)%4)], fillet_fn=$fn); // fillet(top[i], size[1-j[i]], $fn=$fn);
}
    }
}

module cube_fillet_inside(size, radius=-1, vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90, vertical_fn=[0,0,0,0], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]){
    //makes CENTERED cube with round corners
    // if you give it radius, it will fillet vertical corners.
    //othervise use vertical, top, bottom arrays
    //when viewed from top, it starts in upper right corner (+x,+y quadrant) , goes counterclockwise
    //top/bottom fillet starts in direction of Y axis and goes CCW too

    if (radius == 0) {
        cube(size, center=true);
    } else {
        difference() {
            cube(size, center=true);
            cube_negative_fillet(size, radius, vertical, top, bottom, $fn, vertical_fn, top_fn, bottom_fn);
        }
    }
}

module cylinder_fillet_inside(h=10, r=10, top=3, bottom=3, $fn=0, fillet_fn=0, center=false) {
    c_fn=($fn>0) ? $fn : poly_sides_r(r);
    rotfix=(($fn>0) ? 0 : 180/c_fn);
    cent=(center) ? -h/2 : 0;
//    echo (c_fn);
    translate([0,0,cent]) 
        difference() {
            cylinder(h=h,r=r,$fn=c_fn);
            rotate ([0,0,rotfix]) {
              fillet_polar_i_n(outer_r=r, fillet_r=bottom, 
                fillet_angle=90, fillet_fn=fillet_fn, rotate_fn=c_fn);
            translate([0,0,h]) mirror ([0,0,1])
              fillet_polar_i_n(outer_r=r, fillet_r=top, 
                fillet_angle=90, fillet_fn=fillet_fn, rotate_fn=c_fn);
            }
        }
    }

module cylinder_fillet_outside(h=10, r=10, top=3, bottom=3, $fn=0, fillet_fn=0, center=false) {
    c_fn=($fn>0) ? $fn : poly_sides_r(r);
    rotfix=(($fn>0) ? 0 : 180/c_fn);
    cent=(center) ? -h/2 : 0;
//    echo (c_fn);
    translate([0,0,cent]) {
        cylinder(h=h,r=r,$fn=c_fn);
          rotate ([0,0,rotfix]) {
            fillet_polar_i(inner_r=r, fillet_r=bottom, fillet_angle=90,
              fillet_fn=fillet_fn, rotate_fn=c_fn);
        translate([0,0,h]) mirror ([0,0,1])
          fillet_polar_i(inner_r=r, fillet_r=top, fillet_angle=90,
            fillet_fn=fillet_fn, rotate_fn=c_fn);
        }
    }
}


//cube([20,20,20], center=true);
//cube_positive_fillet_corners([20,20,20], radius=-1, vertical=[0,0,0,0], top=[3,3,3,3], bottom=[3,3,3,3], top_angle=[90,90,90,90], top_flip=[0,0,0,0], $fn=10);
//cube_positive_fillet([20,20,20], radius=-1, vertical=[0,0,0,0], top=[3,3,3,3], bottom=[3,3,3,3], top_angle=[90,90,90,90], top_flip=[0,0,0,0], $fn=10);

//translate([-12,23,0]) cube_fillet_inside([20,20,20], vertical=[0,0,0,0], top=[3,3,3,3], bottom=[3,3,3,3], $fn=10);

//translate([23,-12,0]) cylinder_fillet_inside(h=20, r=10, top=3, bottom=3, $fn=0, fillet_fn=10, center=true);

//translate([0,0,23]) cylinder_fillet_outside(h=20, r=10, top=3, bottom=3, $fn=0, fillet_fn=10, center=true);

