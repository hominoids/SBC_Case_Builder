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


