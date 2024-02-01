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

    m_insert(type="M3", icolor = "#ebdc8b")
    screw(screw_type)

*/

/*
           NAME: fan_cover
    DESCRIPTION: creates fan covers for fan openings
           TODO: none

          USAGE: m_insert(type="M3", icolor = "#ebdc8b")

                           type = "M3"
                         icolor = color of insert
*/

module m_insert(type="M3", icolor = "#ebdc8b") {    //#f4e6c3, #ebdc8b 
    
    odiam = type == "M3" ? 4.2 : 3.5;
    idiam = type == "M3" ? 3 : 2.5;
    iheight = 4;

    difference() {
        color(icolor,.6) cylinder(d=odiam, h=iheight);
        color(icolor,.6) translate([0,0,-1]) cylinder(d=idiam, h=iheight+2);
    }
    for(bearing = [0:10:360]) {
        color(icolor) translate([-.25+(odiam/2)*cos(bearing), -.25+(odiam/2)*sin(bearing), iheight-1.5]) 
            cube([.5, .5, 1.5]);
    }
}


/*
           NAME: screw
    DESCRIPTION: creates screws
           TODO: needs improvement

          USAGE: screw(screw_type)

                       screw_type = [d,l,style]
                                     d = thread diameter
                                     l = thread length
                                 style = screw head style, 0 = Mushroom head, 5mm diameter
*/

module screw(screw_type) {

    d = screw_type[0];
    l = screw_type[1];
    style = screw_type[2];

    if(style == 0) {
        difference() {
            translate([  0,  0, -0.3]) sphere(2.7);
            translate([-10,-10,-10]) cube([20,20,10]);
            translate([-10,-10,  2]) cube([20,20,10]);
        }
    }
    rotate([180,0,0]) cylinder(d=d, h=l);
}
