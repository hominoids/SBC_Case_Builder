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

*/


/*
           NAME: m_insert
    DESCRIPTION: creates brass inserts for models
           TODO: none

          USAGE: m_insert(type="m3", icolor = "#ebdc8b")

                           type = "m3"
                         icolor = color of insert
*/

module m_insert(type="m3", icolor = "#ebdc8b") {    //#f4e6c3, #ebdc8b 
    
    odiam = type == "m3" ? 4.2 : 3.5;
    idiam = type == "m3" ? 3 : 2.5;
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
           NAME: washer
    DESCRIPTION: creates washers
           TODO: none

          USAGE: washer(type="round", id=3, od=6, iheight=2, sheight=2, countersunk, icolor = "#ebdc8b")

                        type = "round", "shouldered"
                          id = inside diameter
                          od = outside diameter
                     iheight = washer thickness
                     sheight = shoulder height
                 countersunk = true
                      icolor = color of washer
*/

module washer(type="round", id=3, od=6, iheight=2, sheight=2, countersunk = false, icolor = "#ebdc8b") {    //#f4e6c3, #ebdc8b 
    
    difference() {
        union() {
            color(icolor,.6) cylinder(d=od, h=iheight);
            if(type == "shouldered") {
                color(icolor,.6) cylinder(d=od+4, h=sheight);
            }
        }
        color(icolor,.6) translate([0,0,-1]) cylinder(d=id, h=od+sheight+2);
        if(type == "shouldered" && countersunk == true) {
            color(icolor,.6) translate([0,0,-.01]) cylinder(d2=id, d1=6, h=sheight);
        }
    }
}
