/*
    This file is part of SBC Case Builder https://github.com/hominoids/SBC_Case_Builder
    Copyright 2022,2023,2024,2025 Edward A. Kisiel hominoid@cablemi.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>
    Code released under GPLv3: http://www.gnu.org/licenses/gpl.html

    rack_end_bracket(side, size, thick)
    rack_rail(style, rack_1u, hole_dia, thick)
    rack_stand(rack_1u)

*/


/*
           NAME: rack_end_bracket
    DESCRIPTION: creates rack mounting ears
           TODO: none

          USAGE: rack_end_bracket(side, size, thick)

                             side = "left", "right"
                             size = "1u", "2u", "3u", "4u"
                            thick = thickness of bracket

*/


module rack_end_bracket(side, size, thick) {

    u1 = 44.45;
    depth = size == "1u" ? 44.45 : size == "1u+" ? 59.26 : size == "1u++" ? 74.07 : size == "2u" ? 2*44.45 : size == "3u" ? 3*44.45 : 4*44.45;
    mask = size == "1u" ? 44.45 : size == "1u+" ? 88.9 : size == "1u++" ? 88.9 : size == "2u" ? 2*44.45 : size == "3u" ? 3*44.45 : 4*44.45;
    c_fillet = 2;
    hole = 3.2;
    rack_hole = 6;
    tab_width = 15.875+thick;
    b_width = thick;
    b_depth = depth;
    b_height = thick;
    b_loc = [-thick,0,0];

    adjust = .01;
    $fn=90;

    if(side == "left") {
        translate([thick,0,0]) rotate([90,0,0]) 
        difference() {
            union() {
                translate([(-tab_width/2),(depth/2),thick/2]) 
                    cube_fillet_inside([tab_width,depth,thick], 
                        vertical=[0,c_fillet,c_fillet,0],top=[0,0,0,0],bottom=[0,0,0,0], $fn=90);
                translate([(b_width/2)+b_loc[0],(b_depth/2)+b_loc[1],(b_height/2)+b_loc[2]])         
                    cube_fillet_inside([b_width,b_depth,b_height], 
                        vertical=[0,0,0,0],top=[c_fillet,0,c_fillet,0],bottom=[0,0,0,0], $fn=90);
            }
            for(i=[0:u1:mask-u1]) {
                for(c=[6.35:15.875:44.45]) {
                    translate([(3-thick)-9-(15.875-9)/2,c+i,-adjust]) 
                        slot(rack_hole,3,thick+(adjust*2));
                }
            }
        }
    }
    if(side == "right") {
        translate([-thick,-thick,0]) rotate([270,180,0]) 
        difference() {
            union() {
                translate([(-tab_width/2),(depth/2),thick/2]) 
                    cube_fillet_inside([tab_width,depth,thick], 
                        vertical=[0,c_fillet,c_fillet,0],top=[0,0,0,0],bottom=[0,0,0,0], $fn=90);
                translate([(b_width/2)+b_loc[0],(b_depth/2)+b_loc[1],(b_height/2)+b_loc[2]])         
                    cube_fillet_inside([b_width,b_depth,b_height], 
                        vertical=[0,0,0,0],top=[c_fillet,0,c_fillet,0],bottom=[0,0,0,0], $fn=90);
            }
            for(i=[0:u1:mask-u1]) {
                for(c=[6.35:15.875:44.45]) {
                    translate([(3-thick)-9-(15.875-9)/2,c+i,-adjust]) slot(rack_hole,3,thick+(adjust*2));
                }
            }
        }
    }
}


/*
           NAME: rack_rail
    DESCRIPTION: creates rack rail lengths
           TODO: none

          USAGE: rack_rail(style, rack_1u, hole_dia, thick)

                           style = "none", "nut", "insert"
                         rack_1u = number of 1u
                        hole_dia = hole size to create
                           thick = thickness of bracket

*/

module rack_rail(style, rack_1u, hole_dia, thick) {

    1u = 44.45;
    mount_rail = 15.875;
    1u_hole_offset = 6.35;
    1u_hole_spacing = 15.875;
    height = rack_1u * 1u;

    difference() {
        union() {
            cube([mount_rail, thick, height]);
            if(style == "nut" || style == "insert") {
                fastner = style == "insert" ? "m3-insert" : "m3"; 
                for(i=[0:rack_1u-1]) {
                    translate([mount_rail/2, adj, i*1u]) {
                        translate([0,0,1u_hole_offset]) rotate([90,0,0]) 
                            nut_holder(fastner, "sloped", 7, mount_rail-1, 3, [false,10,2,"default"]);
                        translate([0,0,1u_hole_offset+1u_hole_spacing])
                            rotate([90,0,0]) nut_holder(fastner, "sloped", 7, mount_rail-1, 3, [false,10,2,"default"]);
                        translate([0,0,1u_hole_offset+2*1u_hole_spacing]) 
                            rotate([90,0,0]) nut_holder(fastner, "sloped", 7, mount_rail-1, 3, [false,10,2,"default"]);
                    }
                }
            }
        }
        for(i=[0:rack_1u-1]) {
            translate([mount_rail/2, -1, i*1u]) {
                translate([0,thick+2,1u_hole_offset]) rotate([90,0,0]) cylinder(d = hole_dia, h=thick+2);
                translate([0,thick+2,1u_hole_offset+1u_hole_spacing]) rotate([90,0,0]) cylinder(d = hole_dia, h=thick+2);
                translate([0,thick+2,1u_hole_offset+2*1u_hole_spacing]) rotate([90,0,0]) cylinder(d = hole_dia, h=thick+2);
            }
        }
        translate([-1,-1,height]) cube([mount_rail+2,thick+2,10]);
    }
}


/*
           NAME: rack_stand
    DESCRIPTION: creates rack stand of 1u hieght
           TODO: none

          USAGE: rack_stand(rack_1u)

                            rack_1u = number of 1u

*/

module rack_stand(rack_1u) {

    1u = 44.45;
    mount_rail = 15.875;
    thick = 5;
    height = rack_1u * 1u;
    height_offset = 25.4/2;
    hole_dia = 3.2;
    c_fillet = 9;
    rail_offset = 87.5;
    foot_length = 175;
    foot_thick = 4;
    $fn=180;

    // vertical rack rails
    translate([0, 0, height_offset-adj]) rack_rail(rack_fasteners, rack_1u, hole_dia, thick);

    // bottom feet
    translate([mount_rail/2, -rail_offset/2, foot_thick-2]) cube_fillet_inside([mount_rail, foot_length, foot_thick], 
            vertical=[0,0,0,0], top=[c_fillet,0,c_fillet,0], bottom=[0,0,0,0], $fn=90);

    // bottom connection piece
    translate([0, 0, 0]) cube([mount_rail, thick, height_offset]);

    // top extension piece
    ext_len = rack_1u == 4 ? thick : rack_1u == 3 ? thick : thick;
    translate([0, 0, height+height_offset-adj]) cube([mount_rail, thick, ext_len]);

    // support arc
    if(rack_1u > 0) {
        ext_adj = rack_1u == 4 ? 4.5*thick : rack_1u == 3 ? 3.5*thick : 2.5*thick;
        difference() {
            translate([0,(height/2)-5*thick,ext_adj])  rotate([0,90,0]) {
                difference() {
                    translate([0,0,0]) cylinder(d=(2*height)+(3*thick), h=mount_rail);
                    translate([0,0,-adj]) cylinder(d=(2*height)+thick+4, h=mount_rail+(2*adj));
                }
            }
            // top trim
            translate([-1, thick, height+height_offset-5]) cube([mount_rail+2, 300, 40]);
            // front trim
            translate([-1, 42.75, -175]) cube([mount_rail+2, 300, 400]);
            translate([-1, thick, foot_thick]) cube([mount_rail+2, 300, 400]);
            // bottom trim
            translate([-1, -150, -174.5]) cube([mount_rail+2, 300, 175]);
        }
    }
}