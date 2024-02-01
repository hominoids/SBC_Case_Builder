/*
    This file is part of SBC Case Builder https://github.com/hominoids/SBC_Case_Builder
    Copyright 2022,2023,2024 Edward A. Kisiel hominoid@cablemi.com

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

    vent(width, length, height, gap, rows, columns, orientation)
    vent_hex(cells_x, cells_y, thickness, cell_size, cell_spacing, orientation)
    vent_panel_hex(x, y, thick, cell_size, cell_spacing, border, borders);

*/

/*
           NAME: vent
    DESCRIPTION: creates vent mask patterns
           TODO: none

          USAGE: vent(width, length, height, gap, rows, columns, orientation)

                      width = coloumn size_x
                     length = column size_y
                     height = size_z
                        gap = space between 
                       rows = #row
                    columns = #columns
                orientation = "horizontal", "vertical"
*/

module vent(width, length, height, gap, rows, columns, orientation) {
    
    fillet = width/2;
    adjust = .01;
    $fn=90;
    
    // vertical orientation
    if(orientation == "vertical") { rotate([90,0,0])
        for (r=[0:length+gap:rows*(length+gap)-1]) {
            for (c=[0:width+(2*gap):(columns*(width+(2*gap)))-1]) {
                translate ([c,r,-1]) cube([width,length,height]);
            }
        }
    }
    // horizontal orientation
    if(orientation == "horizontal") {
        for (r=[0:length+(2*gap):rows*(length+gap)]) {
            for (c=[0:width+(2*gap):(columns*(width+(2*gap)))-1]) {
                translate ([c,r,-1]) cube([width,length,height]);
            }
        }
    }
}


/*
           NAME: vent_hex
    DESCRIPTION: creates hex vent mask patterns
           TODO: none

          USAGE: vent_hex(cells_x, cells_y, thickness, cell_size, cell_spacing, orientation)

                          cells_x = #rows
                          cells_y = #columns
                        thickness = pattern thickness
                        cell_size = size of hex
                     cell_spacing = space between hex
                      orientation = "horizontal", "vertical"

*/

module vent_hex(cells_x, cells_y, thickness, cell_size, cell_spacing, orientation) {
    xs = cell_size + cell_spacing;
    ys = xs * sqrt(3/4);
    rot = (orientation=="vertical") ? 90 : 0;

    rotate([rot,0,0]) translate([cell_size/2, cell_size*sqrt(1/3),-1]) {
        for (ix = [0 : ceil(cells_x/2)-1]) {
            for (iy = [0 : 2 : cells_y-1]) {
                translate([ix*xs, iy*ys,0]) rotate([0,0,90]) 
                    cylinder(r=cell_size/sqrt(3), h=thickness, $fn=6);
            }
        }
            for (ix = [0 : (cells_x/2)-1]) {
                for (iy = [1 : 2 : cells_y-1]) {
                translate([(ix+0.5)*xs, iy*ys,0]) rotate([0,0,90]) 
                    cylinder(r=cell_size/sqrt(3), h=thickness, $fn=6);
            }
        }
    }
}


/*
           NAME: vent_panel_hex
    DESCRIPTION: creates hex vent panel
           TODO: none

          USAGE: vent_panel_hex(x, y, thick, cell_size=8, cell_spacing=3, border=3, borders="default")

                                x = #rows
                                y = #columns
                            thick = pattern thickness
                        cell_size = size of hex
                     cell_spacing = space between hex
                           border = size of borber
                          borders = "none", "default"

*/

module vent_panel_hex(x, y, thick, cell_size=8, cell_spacing=3, border=3, borders="default") {
    hole = 3.2;
    xb = (borders == "y" || borders == "none") ? cell_spacing : border;
    yb = (borders == "x" || borders == "none") ? cell_spacing : border;
    hxb = max(yb/2, cell_spacing + hole);
    hyb = max(xb/2, cell_spacing + hole);

    cells_x = floor((2*(x-2*xb-cell_size)/(cell_size+cell_spacing))+1);
    cells_y = floor(((sqrt(12)*(y-2*yb)-4*cell_size)/(3*(cell_size+cell_spacing)))+1);
    csx = cell_size + (cells_x-1)*(cell_size+cell_spacing)/2;
    csy = sqrt(4/3)*cell_size + ((cell_size+cell_spacing)*sqrt(3/4)*(cells_y-1));

    difference() {
        color("grey",1) slab([x,y,thick],2);
        color("grey",1) translate([(x-csx)/2,(y-csy)/2,-1])
            vent_hex(cells_x, cells_y, thick+3, cell_size, cell_spacing, "horizontal");
        if (borders != "none") {
            color("grey",1) translate([    hxb,     hyb, -1]) cylinder(d=hole, h=thick+3);
            color("grey",1) translate([x - hxb,     hyb, -1]) cylinder(d=hole, h=thick+3);
            color("grey",1) translate([    hxb, y - hyb, -1]) cylinder(d=hole, h=thick+3);
            color("grey",1) translate([x - hxb, y - hyb, -1]) cylinder(d=hole, h=thick+3);
        }
    }
}
