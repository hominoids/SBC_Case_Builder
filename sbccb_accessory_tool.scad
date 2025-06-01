/*
    SBC Case Builder Accessory Tool Copyright 2025 Edward A. Kisiel hominoid@cablemi.com
    This file is part of SBC Case Builder https://github.com/hominoids/SBC_Case_Builder

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    Code released under GPLv3: http://www.gnu.org/licenses/gpl.html
    
    see https://github.com/hominoids/SBC_Case_Builder
*/

    include <./sbc_case_builder_library.scad>;

    /* [View] */
    // viewing mode "model", "platter"
    view = "model"; // [model, platter]
    individual_part = "bottom"; // [top, bottom, right, left, front, rear, io_shield, accessories]
    // section individual parts for panel cases
    section_part = false; // [true,false]
    accessory = "grommet"; // ["1u rack stand", "2.5 drive holder", "fan cover", "grommet", "washer"]

    /* [1U Rack Stand] */
    rack_width = 19; // [10, 19]
    rack_1u = 4; // [1 : 4]
    rack_fasteners = "nut"; // ["none", "nut", "insert"]

    /* [2.5" Drive Holder] */
    holder_length = 110; // [110, 145]
    holder_width = 101.6; // [101.6 : .1 : 150]

   /* [Fan Cover] */
    fan_style = "fan_hex"; // ["fan_open", "fan_1", "fan_2", "fan_hex"]
    fan_size = 40; // [25, 30, 40, 50, 60, 80, 92, 120]
    fan_cover_thickness = 2; // [2 : .25 : 5]

    /* [Grommet] */
    grommet_style = "sleeve"; // ["sleeve"]
    grommet_od = 10; // [6 : .25 : 20]
    grommet_id = 6; // [2 : .25 : 20]
    installation_wall_thickness = 2; // [2 : .25 : 5]

    /* [Washer] */
    washer_style = "flat"; // ["flat", "shouldered"]
    washer_od = 5; // [3 : .25 : 20]
    washer_id = 3; // [2 : .25 : 20]
    washer_thickness = 2; // [1 : .25 : 8]
    shoulder_height = 3; // [1 : .25 : 4]
    shoulder_countersunk = false; // [true,false]

    /* [Hidden] */
    mask = [true, 10, 2, "default"];
    nmask = [false, 10, 2, "default"];
    rack_depth = 150;

    adj = .01;
    $fn = 90;

    // model view
    if (view == "model") {    
        if(accessory == "1u rack stand") {
            rack_stand(rack_1u);
        }
        if(accessory == "2.5 drive holder") {
            hd35_25holder(holder_length, holder_width);
        }
        if(accessory == "fan cover") {
            fan_cover(fan_size, fan_cover_thickness, fan_style);
        }
        if(accessory == "grommet") {
            grommet("front", grommet_style, grommet_od, grommet_id, installation_wall_thickness, true, nmask);
        }
        if(accessory == "washer") {
            washer(washer_style, washer_id, washer_od, washer_thickness, shoulder_height, shoulder_countersunk, "silver");;
        }
    }


    // platter view
    if (view == "platter") {
        if(accessory == "1u rack stand") {
            rotate([0,270,0]) rack_stand(rack_1u);
        }
        if(accessory == "2.5 drive holder") {
            hd35_25holder(holder_length, holder_width);
        }
        if(accessory == "fan cover") {
            fan_cover(fan_size, fan_cover_thickness, fan_style);
        }
        if(accessory == "grommet" && grommet_style == "sleeve") {
            translate([0,0,0]) rotate([270,0,0]) difference() {
                grommet("bottom", grommet_style, grommet_od, grommet_id, installation_wall_thickness, false, nmask);
                translate([-grommet_od,-.125,-3]) cube([20,10,20]);
            }
            translate([0,20,0]) rotate([270,0,0]) difference() {
                grommet("bottom", grommet_style, grommet_od, grommet_id, installation_wall_thickness, false, nmask);
                translate([-grommet_od,-.125,-3]) cube([20,10,20]);
            }
            translate([0,-20,0])
                grommet_clip(grommet_style, grommet_od, grommet_id, installation_wall_thickness);
        }
        if(accessory == "washer") {
            washer(washer_style, washer_id, washer_od, washer_thickness, 
                shoulder_height, shoulder_countersunk, "silver");
        }
    }
