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

    depth = size == "1u" ? 44.45 : size == "1u+" ? 59.26 : size == "1u++" ? 74.07 : size == "2u" ? 2*44.45 : size == "3u" ? 3*44.45 : 4*44.45;
    c_fillet = 2;
    hole = 3.2;
    rack_hole = 6;
    tab_width = 15.875+thick;
    b_width = thick;
    b_depth = depth;
    b_height = 25;
    b_loc = [-thick,0,0];

    adjust = .01;
    $fn=90;

    if(side == "left") {
        translate([thick,-thick,depth]) rotate([270,0,0]) 
        difference() {
            union() {
                translate([(-tab_width/2),(depth/2),thick/2]) 
                    cube_fillet_inside([tab_width,depth,thick], 
                        vertical=[0,c_fillet,c_fillet,0],top=[0,0,0,0],bottom=[0,0,0,0], $fn=90);
                translate([(b_width/2)+b_loc[0],(b_depth/2)+b_loc[1],(b_height/2)+b_loc[2]])         
                    cube_fillet_inside([b_width,b_depth,b_height], 
                        vertical=[0,0,0,0],top=[c_fillet,0,c_fillet,0],bottom=[0,0,0,0], $fn=90);
            }
            for (c=[7.5:15:depth]) {
                translate([(3-thick)-9-(15.875-9)/2,c,-adjust]) slot(rack_hole,3,thick+(adjust*2));
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
            for (c=[7.5:15:depth]) {
                translate([(3-thick)-9-(15.875-9)/2,c,-adjust]) slot(rack_hole,3,thick+(adjust*2));
            }
        }
    }
}
