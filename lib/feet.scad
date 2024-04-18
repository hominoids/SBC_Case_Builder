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

    feet (diameter, height)

*/


/*
           NAME: feet
    DESCRIPTION: creates simple case feet
           TODO: none

          USAGE: feet (diameter, height)

                       diameter = size of fan
                         height = thickness of cover

*/

module feet (diameter, height) {

    difference (){ 
        cylinder (d=diameter,h=height);
        translate([0,0,-1]) cylinder (d=3, h=height+2,$fn=90);
        translate ([0,0,-1]) cylinder(r=3.35,h=height-3,$fn=6);
    }
}
