/*
    SBC Case Builder Copyright 2022 Edward A. Kisiel hominoid@cablemi.com

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

    20220202 Version 1.0.0    sbc case builder using sbc model framework.
    20220206 Version 1.0.1    added tray-vu7 case style, other fixes.
    20220212 Version 1.1.0    implemented sbc_case_builder.cfg config file,
                              sbc_case_builder_library.scad and basic accessory framework.
                              adjusted tray-vu7 tabs, adjusted tray-vu7 model alignment
                              minor fixes and other maintenance.
    20220220 Version 1.1.1    added .cfg commands add1,add2,model,platter
                              schema changes, extended standoff fixes, hd mounting acc.
                              acc. placement and other minor fixes, added raise_top setting.
    20220227 Version 1.1.2    added sbc_off setting, fixed hdmi bottom placement
                              schema change, extended standoff detection, hd vertical mount, oled holder
                              access port, access cover, case feet and other fixes.
    20220306 Version 1.1.3    added netcard, buttons, parametric access_port, other fixes and maintenance
    20220312 Version 1.2.0    added fillet array, button cutout style, hk_lcd35, other fixes and maintenance
    20220320 Version 1.2.1    added hk_boom bonnet model and accessories, hk_uart model, fixed uart opening,
                              enabled pcb_z, added tabs and fixed tray case top, other fixes and maintenance
    20220406 Version 1.2.2    added vu7c, vu8m and weatherboard2 models, other additions, 
                              fixes and maintenance.
    20220515 Version 1.2.3    added odroid-m1, jetson nano, rockpro64, completed mask(), improved docs
                              changed tray top design.
    20221005 Version 2.0.0    full customizer user interface,case configuration file changed to json,
                              accessories kept in sbc_case_builder_accessories.cfg, 
                              added round, hexagon, snap and fitted cases, setup additional sbc from 
                              SBC_Model_Framework, added components and masks, added multi-associative 
                              parametric positioning for accessories, added individual variable height 
                              sbc standoffs, added cutaway view when case face is not movable, finished 
                              indents for select components and orientations.
    20221011 Version 2.0.1    adjusted cases and accessories, updated README.md and SBC_Case_Builder_Cases.gif
    20221101 Version 2.0.2    updated sbc model framework, h3/h3+ model and rockpi5b adjustments
    20221207 Version 2.0.3    added part view to facilitate individual part prints, updated sbc model framework, 
                              added n2l and m1 cases
    2023xxxx Version 2.0.x    fixed standoff sidewall support misplacement on sbc move, fixed standoff auto
                              opening z height, fixed case top right side standoffs support,
                              fixed access_port and access_cover 180 rotation in portrait and landscape,
    
    see https://github.com/hominoids/SBC_Case_Builder
*/

use <./SBC_Model_Framework/sbc_models.scad>;
use <./sbc_case_builder_library.scad>;
use <./lib/fillets.scad>;
include <./SBC_Model_Framework/sbc_models.cfg>;
include <./sbc_case_builder_accessories.cfg>;

/* [View] */
// viewing mode "model", "platter", "part"
view = "model"; // [model, platter, part]
individual_part = "bottom"; // [top, bottom, right, left, front, rear, accessories]
// sbc off in model view
sbc_off = false;
// enable highlight for sbc component subtarctive geometry
sbc_highlight = false;
// enable highlight for accessory subtarctive geometry
accessory_highlight = false;
// raises top mm in model view or < 0 = off
raise_top = 0; // [-1:100]
// lowers bottom mm in model view or < 0 = off
lower_bottom = 0; // [-1:100]
// move left side mm in model view or < 0 = off
move_leftside = 0; // [-1:100]
// move right side mm in model view or < 0 = off
move_rightside = 0; // [-1:100]
// move front mm in model view or < 0 = off
move_front = 0; // [-1:100]
// move rear mm in model view or < 0 = off
move_rear = 0; // [-1:100]

/* [Adjustments] */
// base case design
case_design = "shell"; // [shell,panel,stacked,tray,round,hex,snap,fitted]
// base case style
case_style = "none"; // ["none","vu5","vu7","sides"]
// single board computer model
sbc_model = "c1+"; //  ["c1+", "c2", "c4", "xu4", "xu4q", "mc1", "hc1", "n1", "n2", "n2+", "n2+_noheatsink", "n2l", "n2lq", "m1", "m1_noheatsink", "h2", "h3", "hc4", "show2", "rpizero", "rpizero2w", "rpi1a+", "rpi1b+", "rpi3a+", "rpi3b", "rpi3b+", "rpi4b", "a64", "rock64", "rockpro64", "quartz64a", "quartz64b", "h64b", "star64", "atomicpi", "jetsonnano", "rockpi4b+", "rockpi4c", "rockpi4c+", "rockpi5b", "vim1", "vim2", "vim3", "vim3l", "vim4", "tinkerboard", "tinkerboard-s", "tinkerboard-2", "tinkerboard-r2", "opizero", "opizero2", "opir1plus_lts", "licheerv+dock", "test"]
// sbc location x axis
pcb_loc_x = 0; //[0:.5:300]
// sbc location y axis
pcb_loc_y = 0; //[0:.5:300]
// sbc location z axis
pcb_loc_z = 0; //[0:.25:100]
// additional x axis case size
case_offset_x = 0; //[0:.5:300]
// additional y axis case size
case_offset_y = 0; //[0:.5:300]
// additional z axis case top size
case_offset_tz = 0; //[0:.5:100]
// additional z axis case bottom size
case_offset_bz = 0; //[0:.5:100]
// case wall thickness
wallthick = 2; //[1:.5:5]
// case floor thickness
floorthick = 2; //[1:.5:5]
// case side thickness
sidethick = 2; //[1:.5:5]
// distance between pcb and case
gap = 1; //[.5:.5:5]
// corner fillets
c_fillet = 3; //[0:.5:9]
// edge fillets
fillet = 0; //[0:.5:6]
// tolerance for fitted surfaces
tol = .25; //[-.5:.0625:.5]

/* [Standoffs] */
// enable case top standoffs
sbc_top_standoffs = true;
// enable case bottom standoffs
sbc_bottom_standoffs = true;
// enable case extended standoffs
case_ext_standoffs = false;
// enable wall support for standoffs
sidewall_support = true;

// top case standoff - [diameter,height(not used),holesize,supportsize,supportheight,type(0=none, 1=countersink, 2=recessed, 3=nut holder, 4=blind),style(0=hex, 1=cylinder),reverse,insert,insert hole dia.,insert depth]
top_standoff = [5.75,18,2.5,10,4,4,0,1,0,4.5,5.1];
// case top - lower left standoff  
top_rear_left = 0; //[-20:.25:20]
// case top - upper left standoff  
top_front_left = 0; //[-20:.25:20]
// case top - lower right standoff  
top_rear_right = 0; //[-20:.25:20]
// case top - upper right standoff  
top_front_right = 0; //[-20:.25:20]

// bottom case standoff - [diameter,height(not used),holesize,supportsize,supportheight,type(0=none, 1=countersink, 2=recessed, 3=nut holder, 4=blind),style(0=hex, 1=cylinder),reverse,insert,insert hole dia.,insert depth]
bottom_standoff = [5.75,7,3.6,10,4,1,0,0,0,4.5,5.1];
// case bottom - rear left standoff  
bottom_rear_left = 0; //[-20:.25:20]
// case bottom - upper left standoff  
bottom_front_left = 0; //[-20:.25:20]
// case bottom - lower right standoff  
bottom_rear_right = 0; //[-20:.25:20]
// case bottom - upper right standoff  
bottom_front_right = 0; //[-20:.25:20]

// top case extened standoff - [diameter,height(not used),holesize,supportsize,supportheight,type(0=none, 1=countersink, 2=recessed, 3=nut holder, 4=blind),style(0=hex, 1=cylinder),reverse,insert,insert hole dia.,insert depth]
top_ext_standoff = [5.75,18,2.5,10,4,4,0,1,0,4.5,5.1];

// bottom case extended standoff - [diameter,height(not used),holesize,supportsize,supportheight,type(0=none, 1=countersink, 2=recessed, 3=nut holder, 4=blind),style(0=hex, 1=cylinder),reverse,insert,insert hole dia.,insert depth]
bottom_ext_standoff = [5.75,5,3.6,10,4,1,0,0,0,4.5,5.1];

/* [Features and Accessories] */
// enable indentations around io openings
indents = true;
// enable sata punchout
sata_punchout = false;
// gpio openings
gpio_opening = "none"; // [none,vent,open,punchout]
// cooling openings
cooling = "fan"; // [none,vents,fan,custom]
// exhaust vents
exhaust_vents = "vent"; // [none,vent]
// case accessory group to load

accessory_name = "none"; // ["none", "c1+_shell_boombox", "c1+_panel_boombox", "c1+_panel_lcd3.5", "c1+_desktop_lcd3.5", "c1+_deskboom_lcd3.5", "c1+_tray_boombox", "c1+_round", "c1+_hex", "c2_shell_boombox", "c2_panel_boombox", "c2_panel_lcd3.5", "c2_desktop_lcd3.5", "c2_deskboom_lcd3.5", "c2_tray_boombox", "c2_round", "c2_hex", "c4_shell_boombox", "c4_panel_lcd3.5", "c4_desktop_lcd3.5", "c4_deskboom_lcd3.5", "c4_panel_boombox", "c4_tray_boombox", "c4_round", "c4_hex", "xu4_keyhole", "hc4_tray_drivebox2.5", "hc4_shell_drivebox2.5", "hc4_shell_drivebox2.5v", "hc4_shell_drivebox3.5", "n1_round", "n1_hex", "n2l_tray", "n2l_gpio", "n2+_tray_vu7_fan", "m1_panel", "m1_tray", "m1_tray_ssd", "m1_tray_sides", "m1_tray_vu5", "m1_tray_vu7", "m1_fitted_drivebox2.5", "m1_fitted_drivebox3.5", "m1_fitted_pizzabox", "m1_fitted_drivebox3.5v", "h2_shell", "h2_shell_router", "h2_shell_router-ssd", "h2_lowboy", "h2_lowboy_router", "h2_tray", "h2_tray_sides", "h2_tray_router", "h2_router_station", "h2_round", "h2_hex", "h3_shell", "h3_lowboy", "h3_lowboy_router", "h3_tallboy", "h3_tallboy-ssd", "h3_ultimate", "h3_ultimate2", "h3_shell_drivebox2.5v", "jetsonnano_shell", "jetsonnano_panel", "jetsonnano_stacked", "jetsonnano_tray", "jetsonnano_tray_sides", "jetsonnano_round", "jetsonnano_hex", "jetsonnano_snap", "jetsonnano_fitted", "rock64_shell", "rock64_panel", "rock64_stacked", "rock64_tray", "rock64_tray_sides", "rock64_round", "rock64_hex", "rock64_snap", "rock64_fitted", "rockpro64_shell", "rockpro64_panel", "rockpro64_stacked", "rockpro64_tray", "rockpro64_tray_sides", "rockpro64_round", "rockpro64_hex", "rockpro64_snap", "rockpro64_fitted", "quartz64b_stacked_poe_hat", "star64_shell", "show2_shell", "rpi1a+_shell", "rpi1a+_panel", "rpi1a+_stacked", "rpi1a+_tray", "rpi1a+_tray_sides", "rpi1a+_round", "rpi1a+_hex", "rpi1a+_snap", "rpi1a+_fitted", "rpi1b+_shell", "rpi1b+_panel", "rpi1b+_stacked", "rpi1b+_tray", "rpi1b+_tray_sides", "rpi1b+_round", "rpi1b+_hex", "rpi1b+_snap", "rpi1b+_fitted", "rpi3a+_shell", "rpi3a+_panel", "rpi3a+_stacked", "rpi3a+_tray", "rpi3a+_tray_sides", "rpi3a+_round", "rpi3a+_hex", "rpi3a+_snap", "rpi3a+_fitted", "rpi3b_shell", "rpi3b_panel", "rpi3b_stacked", "rpi3b_tray", "rpi3b_tray_sides", "rpi3b_round", "rpi3b_hex", "rpi3b_snap", "rpi3b_fitted", "rpi3b+_shell", "rpi3b+_panel", "rpi3b+_stacked", "rpi3b+_tray", "rpi3b+_tray_sides", "rpi3b+_round", "rpi3b+_hex", "rpi3b+_snap", "rpi3b+_fitted", "rpi4b_shell", "rpi4b_shell_geeekpi_poe_hat", "rpi4b_panel", "rpi4b_stacked", "rpi4b_tray", "rpi4b_tray_sides", "rpi4b_round", "rpi4b_hex", "rpi4b_snap", "rpi4b_fitted", "rockpi4b+_shell", "rockpi4b+_panel", "rockpi4b+_stacked", "rockpi4b+_tray", "rockpi4b+_tray_sides", "rockpi4b+_round", "rockpi4b+_hex", "rockpi4b+_snap", "rockpi4b+_fitted", "rockpi4c_shell", "rockpi4c_panel", "rockpi4c_stacked", "rockpi4c_tray", "rockpi4c_tray_sides", "rockpi4c_round", "rockpi4c_hex", "rockpi4c_snap", "rockpi4c_fitted", "rockpi4c+_shell", "rockpi4c+_panel", "rockpi4c+_stacked", "rockpi4c+_tray", "rockpi4c+_tray_sides", "rockpi4c+_round", "rockpi4c+_hex", "rockpi4c+_snap", "rockpi4c+_fitted", "rockpi5b", "vim1_shell", "vim1_panel", "vim1_stacked", "vim1_tray", "vim1_tray_sides", "vim1_round", "vim1_hex", "vim1_snap", "vim1_fitted", "vim2_shell", "vim2_panel", "vim2_stacked", "vim2_tray", "vim2_tray_sides", "vim2_round", "vim2_hex", "vim2_snap", "vim2_fitted", "vim3l_shell", "vim3l_panel", "vim3l_stacked", "vim3l_tray", "vim3l_tray_sides", "vim3l_round", "vim3l_hex", "vim3l_snap", "vim3l_fitted", "vim3_shell", "vim3_panel", "vim3_stacked", "vim3_tray", "vim3_tray_sides", "vim3_round", "vim3_hex", "vim3_snap", "vim3_fitted", "vim4_shell", "vim4_panel", "vim4_stacked", "vim4_tray", "vim4_tray_sides", "vim4_round", "vim4_hex", "vim4_snap", "vim4_fitted", "tinkerboard_shell", "tinkerboard_panel", "tinkerboard_stacked", "tinkerboard_tray", "tinkerboard_tray_sides", "tinkerboard_round", "tinkerboard_hex", "tinkerboard_snap", "tinkerboard_fitted", "tinkerboard-s_shell", "tinkerboard-s_panel", "tinkerboard-s_stacked", "tinkerboard-s_tray", "tinkerboard-s_tray_sides", "tinkerboard-s_round", "tinkerboard-s_hex", "tinkerboard-s_snap", "tinkerboard-s_fitted", "tinkerboard-2_shell", "tinkerboard-2_panel", "tinkerboard-2_stacked", "tinkerboard-2_tray", "tinkerboard-2_tray_sides", "tinkerboard-2_round", "tinkerboard-2_hex", "tinkerboard-2_snap", "tinkerboard-2_fitted", "tinkerboard-r2_shell", "tinkerboard-r2_panel", "tinkerboard-r2_stacked", "tinkerboard-r2_tray", "tinkerboard-r2_tray_sides", "tinkerboard-r2_round", "tinkerboard-r2_hex", "tinkerboard-r2_snap", "tinkerboard-r2_fitted", "hk_uart"]

a = search([accessory_name],accessory_data);
s = search([sbc_model],sbc_data);

pcb_width = sbc_data[s[0]][1];
pcb_depth = sbc_data[s[0]][2];
pcb_z = sbc_data[s[0]][3];
pcb_tmaxz = sbc_data[s[0]][5];
pcb_bmaxz = sbc_data[s[0]][6];

width = pcb_width+2*(wallthick+gap)+case_offset_x;
depth = pcb_depth+2*(wallthick+gap)+case_offset_y;
top_height = pcb_tmaxz+floorthick+case_offset_tz;
bottom_height = pcb_bmaxz+floorthick+case_offset_bz;
case_z = bottom_height+top_height;
case_diameter = sqrt(pow(width-wallthick-gap,2)+pow(depth-wallthick-gap,2));
hex_diameter = sqrt(pow(width+2*(wallthick+gap),2)+pow(depth+2*(wallthick+gap),2));


/* [Hidden] */
adjust = .01;
$fn=90;
case_fn = 360;                                  // circle segments for round cases
case_ffn = 90;                                  // circle segments for fillet of round cases
lip = 5;
vu_rotation = [15,0,0];

// platter view
if (view == "platter") {
    if(case_design == "shell") {
        case_bottom(case_design);
        translate([0,(2*depth)+20,case_z]) rotate([180,0,0]) case_top(case_design);
    }
    if(case_design == "panel") {
        case_bottom(case_design);
        translate([0,(2*depth)+5,case_z]) rotate([180,0,0]) case_top(case_design);
        translate([width+25,0,-gap]) rotate([-90,0,0]) case_side(case_design,case_style,"rear");
        translate([width+25,2*(case_z)+10,-depth+wallthick+gap+floorthick]) 
            rotate([90,0,0]) case_side(case_design,case_style,"front");
        translate([2.5*width,0,-width+(2*wallthick)+gap]) rotate([0,-90,-90]) 
            case_side(case_design,case_style,"right");
        translate([-20,0,-gap]) rotate([0,90,90]) 
            case_side(case_design,case_style,"left");
    }
    if(case_design == "stacked") {
        case_bottom(case_design);
        translate([0,(2*depth)+20,case_z]) rotate([180,0,0]) case_top(case_design);
    }
    if(case_design == "tray") {
        case_bottom(case_design);
        translate([0,(2*depth)+10,case_z]) rotate([180,0,0]) case_top(case_design);
        if(case_style == "vu5" || case_style == "vu7" || case_style == "sides") {
            translate([3*width,0,width]) rotate([0,90,90]) 
                case_side(case_design,case_style,"right");
            translate([width+15,0,2*sidethick]) rotate([0,-90,-90]) 
                case_side(case_design,case_style,"left");
        }
    }
    if(case_design == "round") {
        case_bottom(case_design);
        translate([width+30,depth,case_z-floorthick-gap]) rotate([180,0,0]) case_top(case_design);
    }
    if(case_design == "hex") {
        case_bottom(case_design);
        translate([2*width,depth,case_z]) rotate([180,0,0]) case_top(case_design);
    }
    if(case_design == "snap") {
        case_bottom(case_design);
        translate([0,(2*depth)+20,case_z+2*floorthick]) rotate([180,0,0]) case_top(case_design);
    }
    if(case_design == "fitted") {
        case_bottom(case_design);
        translate([0,(2*depth)+20,case_z+floorthick]) rotate([180,0,0]) case_top(case_design);
    }
    // platter accessories
    if(accessory_name != "none") {
        for (i=[1:15:len(accessory_data[a[0]])-1]) {
            class = accessory_data[a[0]][i];
            type = accessory_data[a[0]][i+1];
            loc_x = accessory_data[a[0]][i+2];
            loc_y = accessory_data[a[0]][i+3];
            loc_z = accessory_data[a[0]][i+4];
            face = accessory_data[a[0]][i+5];
            rotation = accessory_data[a[0]][i+6];
            parametric = accessory_data[a[0]][i+7];
            size_x = accessory_data[a[0]][i+8];
            size_y = accessory_data[a[0]][i+9];
            size_z = accessory_data[a[0]][i+10];
            data_1 = accessory_data[a[0]][i+11];
            data_2 = accessory_data[a[0]][i+12];
            data_3 = accessory_data[a[0]][i+13];
            data_4 = accessory_data[a[0]][i+14];
            
            if (class == "platter" && type != "button_top") {
                add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
            }
            if (class == "platter" && type == "button_top") {
                translate([loc_x,loc_y,loc_z+1.25]) rotate([-90,0,0]) button_plunger(data_3, size_x, size_z);
                translate([loc_x-20,loc_y-10,loc_z+3]) rotate([0,0,0]) button_top(data_3, size_x, size_z);
                translate([loc_x-20,loc_y-20,loc_z]) rotate([0,0,0]) button_clip(data_3);
            }
            if (class == "platter" && type == "h3_port_extender_holder") {
                translate([loc_x,loc_y,loc_z]) rotate([0,0,0]) h3_port_extender_holder("bottom");
                translate([loc_x-20,loc_y+40,loc_z+36.5]) rotate([180,0,0]) h3_port_extender_holder("top");
            }
        }
    }
    if(case_design == "tray") {
        echo(width=width+2*sidethick,depth=depth,top=top_height,bottom=bottom_height);
    }
    else {
        echo(width=width,depth=depth,top=top_height,bottom=bottom_height);        
    }    
}

// model view
if (view == "model") {    
//    translate([(-width+(gap+wallthick))/2,(-depth+(gap+wallthick))/2,0]) rotate([0,0,0]){
        if(case_design == "shell") {
            if(lower_bottom >= 0) {
                difference() {
                    color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-gap-wallthick-2.01,-lower_bottom]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-gap-(2*wallthick)-adjust,-gap-wallthick-1,-lower_bottom]) 
                            cube([gap+wallthick,depth+2,case_z+2]);
                    }
                }
            }
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) sbc(sbc_model);
            }
            if(raise_top >= 0) {
                difference() {
                    color("grey",1) translate([0,0,raise_top]) case_top(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,raise_top]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-gap-wallthick-2.01,raise_top]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,raise_top]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-gap-(2*wallthick)-adjust,-gap-wallthick-1,raise_top]) 
                            cube([gap+wallthick,depth+2,case_z+2]);
                    }
                }
            }
        }
        if(case_design == "panel") {
            if(lower_bottom >= 0) {
                color("grey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
            }
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) sbc(sbc_model);
            }
            if(raise_top >= 0) {
                color("grey",1) translate([0,0,raise_top])case_top(case_design);
            }
            if(move_front >= 0) {
                color("grey",1) translate([0,move_front,0]) case_side(case_design,case_style,"front");
            }
            if(move_rear >= 0) {
                color("grey",1) translate([0,-move_rear,0]) case_side(case_design,case_style,"rear");
            }
            if(move_rightside >= 0) {
                color("grey",1) translate([move_rightside,0,0]) case_side(case_design,case_style,"right");
            }
            if(move_leftside >= 0) {
                color("grey",1) translate([-move_leftside,0,0]) case_side(case_design,case_style,"left");
            }
        }
        if(case_design == "stacked") {
            if(lower_bottom >= 0) {
                color("grey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
            }
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) sbc(sbc_model);
            }
            if(raise_top >= 0) {
                color("grey",1) translate([0,0,raise_top]) case_top(case_design);
            }
        }
        if(case_design == "tray") {
            if(lower_bottom >= 0) {
                difference() {
                    color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-gap-wallthick-2.01,-lower_bottom]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-gap-wallthick-2.01,-gap-wallthick-1,-lower_bottom]) 
                            cube([gap+wallthick+1,depth+2,case_z+2]);
                    }
                }
            }
            if(sbc_off == false) {
                translate([pcb_loc_x,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) sbc(sbc_model);
            }
            if(raise_top >= 0) {
                difference() {
                    color("grey",1) translate([0,0,raise_top]) case_top(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,raise_top]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-gap-wallthick-2.01,raise_top]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-2*wallthick-1,-gap-wallthick-1,raise_top]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-gap-wallthick-2.01,-gap-wallthick-1,raise_top]) 
                            cube([gap+2*wallthick+1,depth+2,case_z+2]);
                    }
                }
            }
            if(case_style == "sides" || case_style == "vu5" || case_style == "vu7") {
                if(move_rightside >= 0) {
                    color("grey",1) translate([move_rightside,0,0]) case_side(case_design,case_style,"right");
                }
                if(move_leftside >= 0) {
                    color("grey",1) translate([-move_leftside,0,0]) case_side(case_design,case_style,"left");
                }
            }
            if(case_style == "vu5") {
                color("darkgrey",.5) translate([width+((127.5-width)/2)-6.5-wallthick-gap,
                    depth-1,case_z+15.5]) rotate([-vu_rotation[0],0,180]) 
                        import(file = "stl/Vu5a_Case.stl");            
                // right speaker and bracket
                color("darkgrey",.5) 
                    translate([((127.5-75)/2)+(width/2)-wallthick-gap+30.5,depth-1,
                        case_z+15]) rotate([90-vu_rotation[0],0,180]) 
                            import(file = "stl/Vu5_Speaker_Bracket_Left.stl");
                color("darkgrey",.5) translate([((127.5-75)/2)+(width/2)-wallthick-gap+85,depth+15,
                    case_z+12.5]) rotate([-vu_rotation[0],0,180]) hk_speaker();
                // left speaker and bracket
                color("darkgrey",.5) translate([-((127.5-75)/2)+(width/2)-wallthick-gap-30.5,depth-1,
                    case_z+15]) rotate([90-vu_rotation[0],0,180])
                        import(file = "stl/Vu5_Speaker_Bracket_Right.stl");
                color("darkgrey",.5) translate([-((127.5-75)/2)+(width/2)-wallthick-gap-40.5,depth+15,
                    case_z+12.5]) rotate([-vu_rotation[0],0,180]) hk_speaker();
            }
            if(case_style == "vu7") {
                color("darkgrey",.5) translate([width+((192.90-width)/2)-wallthick-gap-20,
                    depth-1,case_z+15.5]) rotate([-vu_rotation[0],0,180]) 
                        import(file = "stl/Vu7a_Case.stl");            
                // right speaker and bracket
                color("darkgrey",.5) 
                    translate([((192.90-100)/2)+(width/2)-wallthick-gap+57.5,depth-4,
                        case_z+27]) rotate([90-vu_rotation[0],0,180]) 
                            import(file = "stl/Vu7_Speaker_Bracket_Left.stl");
                color("darkgrey",.5) translate([((192.90-100)/2)+(width/2)-wallthick-gap+97,depth+11.5,
                    case_z+27]) rotate([-vu_rotation[0],0,180]) hk_speaker();
                // left speaker and bracket
                color("darkgrey",.5) translate([-((192.90-100)/2)+(width/2)-wallthick-gap-58,depth-4,
                    case_z+27]) rotate([90-vu_rotation[0],0,180])
                        import(file = "stl/Vu7_Speaker_Bracket_Right.stl");
                color("darkgrey",.5) translate([-((192.90-100)/2)+(width/2)-wallthick-gap-53.5,depth+11.5,
                    case_z+27]) rotate([-vu_rotation[0],0,180]) hk_speaker();
            }
        } 
        if(case_design == "round" || case_design == "hex") {
            if(lower_bottom >= 0) {
                color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
            }
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) sbc(sbc_model);
            }
            if(raise_top >= 0) {
                color("grey",1) translate([0,0,raise_top]) case_top(case_design);
            }        
        }
        if(case_design == "snap" || case_design == "fitted") {
            if(lower_bottom >= 0) {
                difference() {
                    color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-gap-wallthick-2.01,-lower_bottom]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-gap-wallthick-2.01,-gap-wallthick-1,-lower_bottom]) 
                            cube([gap+wallthick+1,depth+2,case_z+2]);
                    }
                }
            }
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z]) sbc(sbc_model);
            }
            if(raise_top >= 0) {
                difference() {
                    color("grey",1) translate([0,0,raise_top]) case_top(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,raise_top]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-gap-wallthick-2.01,raise_top]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,raise_top]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-gap-wallthick-2.01,-gap-wallthick-1,raise_top]) 
                            cube([gap+wallthick+1,depth+2,case_z+2]);
                    }
                }
            }        
        }
        // model accessories
        if(accessory_name != "none") {
            for (i=[1:15:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size_x = accessory_data[a[0]][i+8];
                size_y = accessory_data[a[0]][i+9];
                size_z = accessory_data[a[0]][i+10];
                data_1 = accessory_data[a[0]][i+11];
                data_2 = accessory_data[a[0]][i+12];
                data_3 = accessory_data[a[0]][i+13];
                data_4 = accessory_data[a[0]][i+14];
                
                if (class == "model" && face == "top" && raise_top > -1) {
                    parametric_move_add(type,loc_x,loc_y,loc_z+raise_top,face,rotation,parametric,
                        size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
                else {
                    if (class == "model"&& face != "top" ) {
                    parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                        size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                }    
            }
        }
        if(case_design == "tray") {
            echo(width=width+2*sidethick,depth=depth,top=top_height,bottom=bottom_height);
        }
        else {
            echo(width=width,depth=depth,top=top_height,bottom=bottom_height);        
        }
    }
//}
// part
if (view == "part") {
    if(individual_part == "top") {
        if(case_design == "shell") {
            translate([0,depth,case_z]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "panel") {
            translate([0,depth,case_z]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "stacked") {
            translate([0,depth,case_z]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "tray") {
            translate([0,depth,case_z]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "round") {
            translate([width+30,depth,case_z-floorthick-gap]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "hex") {
            translate([2*width,depth,case_z]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "snap") {
            translate([0,depth,case_z+2*floorthick]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "fitted") {
            translate([0,depth,case_z+floorthick]) rotate([180,0,0]) case_top(case_design);
        }
    }
    if(individual_part == "bottom") {
        case_bottom(case_design);
    }
    if(individual_part == "front") {
        if(case_design == "panel") {
            translate([0,case_z,-depth+wallthick+gap+floorthick]) 
                rotate([90,0,0]) case_side(case_design,case_style,"front");
        }
    }
    if(individual_part == "rear") {
        if(case_design == "panel") {
            translate([0,0,-gap]) rotate([-90,0,0]) case_side(case_design,case_style,"rear");
        }
    }
    if(individual_part == "right") {
        if(case_design == "panel") {
            translate([gap,0,-width+(2*wallthick)+gap]) rotate([0,-90,-90]) 
                case_side(case_design,case_style,"right");
        }
        if(case_design == "tray") {
            if(case_style == "vu5" || case_style == "vu7" || case_style == "sides") {
                translate([depth,0,width-gap]) rotate([0,90,90]) 
                    case_side(case_design,case_style,"right");
            }
        }
    }
    if(individual_part == "left") {
        if(case_design == "panel") {
            translate([depth,0,-gap]) rotate([0,90,90]) 
                case_side(case_design,case_style,"left");
        }
        if(case_design == "tray") {
            if(case_style == "vu5" || case_style == "vu7" || case_style == "sides") {
                translate([gap,0,2*sidethick+gap]) rotate([0,-90,-90]) 
                    case_side(case_design,case_style,"left");
            }
        }
    }
    if(individual_part == "accessories") {
        if(accessory_name != "none") {
            for (i=[1:15:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size_x = accessory_data[a[0]][i+8];
                size_y = accessory_data[a[0]][i+9];
                size_z = accessory_data[a[0]][i+10];
                data_1 = accessory_data[a[0]][i+11];
                data_2 = accessory_data[a[0]][i+12];
                data_3 = accessory_data[a[0]][i+13];
                data_4 = accessory_data[a[0]][i+14];
                
                if (class == "platter" && type != "button_top") {
                    add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
                if (class == "platter" && type == "button_top") {
                    translate([loc_x,loc_y,loc_z+1.25]) rotate([-90,0,0]) button_plunger(data_3, size_x, size_z);
                    translate([loc_x-20,loc_y-10,loc_z+3]) rotate([0,0,0]) button_top(data_3, size_x, size_z);
                    translate([loc_x-20,loc_y-20,loc_z]) rotate([0,0,0]) button_clip(data_3);
                }
                if (class == "platter" && type == "h3_port_extender_holder") {
                    translate([loc_x,loc_y,loc_z]) rotate([0,0,0]) h3_port_extender_holder("bottom");
                    translate([loc_x-20,loc_y+40,loc_z+36.5]) rotate([180,0,0]) h3_port_extender_holder("top");
                }
            }
        }
    }
    if(case_design == "tray") {
        echo(width=width+2*sidethick,depth=depth,top=top_height,bottom=bottom_height);
    }
    else {
        echo(width=width,depth=depth,top=top_height,bottom=bottom_height);        
    }    
}


// case bottom
module case_bottom(case_design) {

    difference() {
        union() {
            difference() {
                union() {
                    if(case_design == "shell") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,bottom_height/2]) 
                                cube_fillet_inside([width,depth,bottom_height], 
                                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                        top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,(bottom_height/2)+floorthick]) 
                                    cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),bottom_height], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                            top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                        }
                    }
                    if(case_design == "panel") {
                       union() {
                           translate([-gap,-gap,0]) 
                                cube([width-(2*wallthick),depth-(2*wallthick),floorthick]);
                            translate([(width*(1/5))-8-(wallthick+gap),depth-(2*wallthick)-gap-adjust,0]) 
                                    cube([8,wallthick+2*adjust,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),depth-(2*wallthick)-gap-adjust,0])
                                    cube([8,wallthick+2*adjust,floorthick]);                   
                            translate([(width*(1/5))-8-(wallthick+gap),-wallthick-gap+adjust,0])
                                    cube([8,wallthick+2*adjust,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),-wallthick-gap+adjust,0])
                                    cube([8,wallthick+2*adjust,floorthick]);
                        }
                    }
                    if(case_design == "stacked") {
                        translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,floorthick/2]) 
                            cube_fillet_inside([width-(2*wallthick),depth-(2*wallthick),floorthick], 
                                vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                    top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                    }
                    if(case_design == "tray") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(bottom_height)/2]) 
                                cube_fillet_inside([width,depth,bottom_height], 
                                    vertical=[0,0,0,0], top=[0,0,0,0], 
                                        bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(bottom_height/2)+floorthick]) 
                                cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),bottom_height+adjust], 
                                    vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                        top=[0,0,0,0],bottom=[2,2,2,2], $fn=90);
                        }
                        // right side nuts          
                        translate([width-wallthick-gap-wallthick-4+adjust,wallthick+gap+10,
                                ((bottom_height+floorthick)/2)-1]) rotate([90,0,90]) 
                                    cylinder(d=10, h=4, $fn=6);
                        if(depth >= 75) {
                            translate([width-wallthick-gap-wallthick-4+adjust,depth-wallthick-gap-10,
                                    ((bottom_height+floorthick)/2)-1]) rotate([90,0,90]) 
                                        cylinder(d=10, h=4, $fn=6);
                        }
                        else {
                            
                            translate([width-wallthick-gap-wallthick-4+adjust,wallthick+gap+40,
                                    ((bottom_height+floorthick)/2)-1]) rotate([90,0,90]) 
                                        cylinder(d=10, h=4, $fn=6);
                        }
                        
                        
                        // left side nuts
                        translate([-adjust-gap,wallthick+gap+10,((bottom_height+floorthick)/2)-1]) 
                            rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                        if(depth >= 75) {
                            translate([-adjust-gap,depth-wallthick-gap-10,((bottom_height+floorthick)/2)-1]) 
                                rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);                        
                        }
                        else {
                            translate([-adjust-gap,wallthick+gap+40,((bottom_height+floorthick)/2)-1]) 
                                rotate([90,0,90]) cylinder(d=10, h=4, $fn=6);
                        }
                        // front panel
                        if(case_style == "sides" || case_style == "vu5" || case_style == "vu7") {
                            translate([-wallthick-gap,depth-(2*wallthick)-gap,bottom_height-adjust]) 
                                rotate([0,0,0]) cube([width,wallthick,top_height]);
                        }
                        else {
                            translate([-wallthick-gap,depth-(2*wallthick)-gap,bottom_height-adjust]) 
                                rotate([0,0,0]) cube([width,wallthick,top_height-floorthick]);
                        }
                        // rear panel
                        translate([-wallthick-gap,-wallthick-gap,bottom_height-adjust]) 
                            cube([width,wallthick,top_height-floorthick]);
                        
                    }                  
                    if(case_design == "round") {
                        difference() {
                            translate([pcb_width/2,pcb_depth/2,bottom_height/2]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=bottom_height, r=case_diameter/2, 
                                    top=0, bottom=fillet, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+floorthick]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=bottom_height+adjust, r=(case_diameter/2)-lip/2, 
                                    top=0, bottom=fillet-1, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,30]) 
                                    cylinder(h=lip+adjust, r=(case_diameter/2)+1, $fn=case_fn);
                                translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,30]) 
                                    cylinder(h=lip+2*adjust, r=(case_diameter/2)-lip/4, $fn=case_fn);
                            }
                        }
                        difference() {
                            translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+2*floorthick]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=bottom_height+adjust+floorthick+lip,
                                    r=(case_diameter/2)-lip/2,top=0,bottom=fillet-1, $fn=case_fn, 
                                        fillet_fn=case_ffn, center=true);
                            if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                               sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                    sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                                translate([-16,(depth/2)-150,-adjust])
                                    cube([width+10,300,case_z-2*floorthick-2]); 
                                translate([width-9,(depth/2)-62.5,bottom_height-2*adjust])
                                    cube([20,110,top_height-2*floorthick-2]);
                            }
                            else {
                                translate([-width/2,0,-adjust])
                                    cube([300,depth+100,case_z-2*floorthick-2]); 
                                translate([(-width+50)/2,-50,bottom_height-2*adjust])
                                    cube([width+50,50+adjust,top_height-2*floorthick-2]);
                            }
                        }
                    }                    
                    if(case_design == "hex") {
                        if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                            sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height/2]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=bottom_height, r=case_diameter/2, 
                                        top=0, bottom=fillet, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+floorthick]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=bottom_height+adjust,r=(case_diameter/2)-lip/2,top=0, 
                                        bottom=fillet-1,$fn=6,fillet_fn=case_ffn, center=true);
                                difference() {
                                    translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,30]) 
                                        cylinder(h=lip+adjust,r=(case_diameter/2)+1, $fn=6);
                                    translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,30]) 
                                        cylinder(h=lip+2*adjust,r=(case_diameter/2)-lip/4, $fn=6);
                                }
                            }
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+2*floorthick]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=bottom_height+adjust+floorthick+lip,
                                        r=(case_diameter/2)-lip/2,top=0, bottom=fillet-1, $fn=6, 
                                            fillet_fn=case_ffn, center=true);
                                translate([-16,(depth/2)-150,-adjust])
                                    cube([width+10,300,case_z-2*floorthick-2]); 
                                translate([width-9,(depth/2)-62.5,bottom_height-2*adjust])
                                    cube([20,110,top_height-2*floorthick-2]); 
                            }
                        }
                        else {
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height/2]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=bottom_height, r=hex_diameter/2, 
                                        top=0, bottom=fillet, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+floorthick]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=bottom_height+adjust,r=(hex_diameter/2)-lip/2,top=0, 
                                        bottom=fillet-1,$fn=6,fillet_fn=case_ffn, center=true);
                                difference() {
                                    translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,0]) 
                                        cylinder(h=lip+adjust,r=(hex_diameter/2)+1, $fn=6);
                                    translate([pcb_width/2,pcb_depth/2,bottom_height-lip]) rotate([0,0,0]) 
                                        cylinder(h=lip+2*adjust,r=(hex_diameter/2)-lip/4, $fn=6);
                                }
                            }
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,(bottom_height/2)+2*floorthick]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=bottom_height+adjust+floorthick+lip,
                                        r=(hex_diameter/2)-lip/2,top=0, bottom=fillet-1, $fn=6, 
                                            fillet_fn=case_ffn, center=true);
                                translate([-width/2,0,-adjust])
                                    cube([300,depth+100,case_z-2*floorthick-2]); 
                                translate([(-width+50)/2,-50,bottom_height-2*adjust])
                                    cube([width+50,50+adjust,top_height-2*floorthick-2]);
                            }                            
                        }
                    }                    
                    if(case_design == "snap") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(floorthick+case_z)/2]) 
                                cube_fillet_inside([width,depth,floorthick+case_z], 
                                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                        top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,floorthick+(floorthick+case_z)/2]) 
                                cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),case_z+floorthick], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                            top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            // snap top indent
                            translate([-gap-wallthick+.75,(depth/2)-(depth*.75)/2-gap-wallthick,case_z-.5]) 
                                rotate([0,45,0]) cube([4,depth*.75,4]);
                            translate([width-wallthick-gap-6.25,(depth/2)-(depth*.75)/2-gap-wallthick,case_z-.5])
                                rotate([0,45,0]) cube([4,depth*.75,4]);
                        }
                    }
                    if(case_design == "fitted") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z/2]) 
                                cube_fillet_inside([width,depth,case_z], 
                                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                        top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,(case_z/2)+floorthick]) 
                                    cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),case_z], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                            top=[0,0,0,0], bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            difference() {
                                translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-lip/2]) 
                                    cube_fillet_inside([width+adjust,depth+adjust,lip+adjust], 
                                        vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                            top=[0,0,0,0],bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                                
                                translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-lip/2]) 
                                    cube_fillet_inside([width-wallthick,depth-wallthick,lip+adjust], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],top=[0,0,0,0],
                                            bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            }
                        }
                    }
                    // additive accessories
                    if(accessory_name != "none") {
                        for (i=[1:15:len(accessory_data[a[0]])-1]) {
                            class = accessory_data[a[0]][i];
                            type = accessory_data[a[0]][i+1];
                            loc_x = accessory_data[a[0]][i+2];
                            loc_y = accessory_data[a[0]][i+3];
                            loc_z = accessory_data[a[0]][i+4];
                            face = accessory_data[a[0]][i+5];
                            rotation = accessory_data[a[0]][i+6];
                            parametric = accessory_data[a[0]][i+7];
                            size_x = accessory_data[a[0]][i+8];
                            size_y = accessory_data[a[0]][i+9];
                            size_z = accessory_data[a[0]][i+10];
                            data_1 = accessory_data[a[0]][i+11];
                            data_2 = accessory_data[a[0]][i+12];
                            data_3 = accessory_data[a[0]][i+13];
                            data_4 = accessory_data[a[0]][i+14];

                            if(class == "add1" && face == "bottom") {
                                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                                    size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                            }
                        }
                    }
                }
                // side attachment holes
                if(case_design == "tray") {
                    // right side bottom attachment holes          
                    translate([width-2*(wallthick+gap)-sidethick-adjust,wallthick+gap+10,
                        ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                            cylinder(d=3, h=10+sidethick+(2*adjust));
                    if(depth >= 75) {
                        translate([width-2*(wallthick+gap)-sidethick-adjust,depth-wallthick-gap-10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                cylinder(d=3, h=10+sidethick+(2*adjust));
                    }
                    else {
                        translate([width-2*(wallthick+gap)-sidethick-adjust,wallthick+gap+40,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                cylinder(d=3, h=10+sidethick+(2*adjust));
                    }

                    // left side bottom attachment holes
                    translate([-wallthick-gap-adjust,wallthick+gap+10,
                        ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                            cylinder(d=3, h=10+sidethick+(2*adjust));
                    if(depth >= 75) {
                        translate([-wallthick-gap-adjust-6,depth-wallthick-gap-10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                cylinder(d=3, h=10+sidethick+(2*adjust));
                    }
                    else {
                        translate([-wallthick-gap-adjust-6,wallthick+gap+40,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                cylinder(d=3, h=10+sidethick+(2*adjust));
                    }
                   // right side bottom nut inset          
                    translate([width-3.5-(2*wallthick)-gap-.6,wallthick+gap+10,
                        ((bottom_height+floorthick)/2)-1]) rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                    if(depth >= 75) {
                        translate([width-3.5-(2*wallthick)-gap-.6,depth-wallthick-gap-10,
                            ((bottom_height+floorthick)/2)-1])rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                    }
                    else {
                        translate([width-3.5-(2*wallthick)-gap-.6,wallthick+gap+40,
                            ((bottom_height+floorthick)/2)-1])rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                    }
                    // left side bottom nut inset
                    translate([-gap+.6,wallthick+gap+10,((bottom_height+floorthick)/2)-1]) 
                        rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                    if(depth >= 75) {
                        translate([-gap+.6,depth-wallthick-gap-10,((bottom_height+floorthick)/2)-1]) 
                            rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                    }
                    else {
                        translate([-gap+.6,wallthick+gap+40,((bottom_height+floorthick)/2)-1]) 
                            rotate([90,0,90]) cylinder(d=6.6, h=3.5, $fn=6);
                    }
                }
                // pcb standoff holes
                if(sbc_bottom_standoffs == true && bottom_standoff[5] != 4) {
                    for (i=[7:3:16]) {
                        pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                        pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                        pcb_hole_size = sbc_data[s[0]][i+2];
                        if (pcb_hole_x!=0 && pcb_hole_y!=0) {
                            translate([pcb_hole_x,pcb_hole_y,-1]) cylinder(d=6.5, h=bottom_height);
                        }
                    }
                }
                // extended standoff holes
                if(case_ext_standoffs == true) {
                    // right-rear standoff
                    if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                        translate([width-(2*(wallthick+gap))-(c_fillet/2),(c_fillet/2),-1]) cylinder(d=6.5, h=bottom_height);
                    }
                    // right-front standoff
                    if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(c_fillet/2)-(2*(wallthick+gap)),
                        depth-(c_fillet/2)-(2*(wallthick+gap)),-1]) cylinder(d=6.5, h=bottom_height);
                    }
                    // left-rear standoff
                    if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                        translate([(c_fillet/2),(c_fillet/2),-1]) cylinder(d=6.5, h=bottom_height);
                    }
                    // left-front standoff
                    if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                        translate([(c_fillet/2),depth-(c_fillet/2)-(2*(wallthick+gap)),-1]) 
                            cylinder(d=6.5, h=bottom_height);
                    }
                }
            }
            // pcb standoffs
            if(sbc_bottom_standoffs  == true) {
                for (i=[7:3:16]) {
                    pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                    pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                    pcb_hole_size = sbc_data[s[0]][i+2];
                    if(pcb_hole_x!=0 && pcb_hole_y!=0) {
                        if (i == 7) {
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_rear_left,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_standoff[7],
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10]];
                            translate([pcb_hole_x,pcb_hole_y,0]) standoff(normal_standoff);
                        }
                        if (i == 10) {
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_front_left,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_standoff[7],
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10]];
                            translate([pcb_hole_x,pcb_hole_y,0]) standoff(normal_standoff);
                        }
                        if (i == 13) {
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_rear_right,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_standoff[7],
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10]];
                            translate([pcb_hole_x,pcb_hole_y,0]) standoff(normal_standoff);
                        }
                        if (i == 16) {
                            normal_standoff = [bottom_standoff[0],
                                                bottom_height-pcb_z+pcb_loc_z+bottom_front_right,
                                                bottom_standoff[2],
                                                bottom_standoff[3],
                                                bottom_standoff[4],
                                                bottom_standoff[5],
                                                bottom_standoff[6],
                                                bottom_standoff[7],
                                                bottom_standoff[8],
                                                bottom_standoff[9],
                                                bottom_standoff[10]];
                            translate([pcb_hole_x,pcb_hole_y,0]) standoff(normal_standoff);
                        }
                    }
                }
            }
            // extended standoffs
            if(case_ext_standoffs == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2),(c_fillet/2),0]) standoff(bottom_ext_standoff);
                }
                // right-front standoff
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || width-pcb_loc_x-pcb_width >= 10) {
                    translate([width-(c_fillet/2)-(2*(wallthick+gap)),
                        depth-(c_fillet/2)-(2*(wallthick+gap)),0]) standoff(bottom_ext_standoff);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(c_fillet/2),(c_fillet/2),0]) standoff(bottom_ext_standoff);                
                }
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(c_fillet/2),depth-(c_fillet/2)-(2*(wallthick+gap)),0]) 
                        standoff(bottom_ext_standoff);                
                }
            }
            // standoff sidewall support
            if(sidewall_support == true && sbc_bottom_standoffs == true) {
                if(pcb_width/pcb_depth >= 1.4) {
                    for(i=[7:3:16]) {
                        pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                        pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                        pcb_hole_size = sbc_data[s[0]][i+2];
                        if(pcb_hole_x!=0 && pcb_hole_y!=0) {
                            if(i == 7) {
                                translate([pcb_hole_x-1, pcb_hole_y-(bottom_standoff[0]/2)-(gap+adjust)-1,0])
                                    cube([2,gap+1.6,bottom_height-pcb_z+pcb_loc_z+bottom_rear_left]);
                            }
                            if(i == 10) {
                                translate([pcb_hole_x-1, pcb_hole_y+(bottom_standoff[0]/2)-.6+adjust,0])
                                    cube([2,gap+1.6,bottom_height-pcb_z+pcb_loc_z+bottom_front_left]);
                            }
                            if(i == 13) {
                                translate([pcb_hole_x-1, pcb_hole_y-(bottom_standoff[0]/2)-(gap+adjust)-1,0])
                                    cube([2,gap+1.6,bottom_height-pcb_z+pcb_loc_z+bottom_rear_right]);
                            }
                            if(i == 16) {
                                translate([pcb_hole_x-1, pcb_hole_y+(bottom_standoff[0]/2)-.6+adjust,0])
                                    cube([2,gap+1.6,bottom_height-pcb_z+pcb_loc_z+bottom_front_right]);
                            }
                        }
                    }
                }
                else {
                    for (i=[7:3:16]) {
                        pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                        pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                        pcb_hole_size = sbc_data[s[0]][i+2];
                        if(pcb_hole_x!=0 && pcb_hole_y!=0) {
                            if(i == 7 && sbc_model != "n2l") {
                                translate([pcb_hole_x-(bottom_standoff[0]/2)-2.6+adjust, pcb_hole_y-gap,0])
                                    cube([gap+1.6,2,bottom_height-pcb_z+pcb_loc_z+bottom_rear_left]);
                            }
                            if (i == 7 && sbc_model == "n2l") {
                                translate([pcb_hole_x-1, pcb_hole_y-(bottom_standoff[0]/2)-(gap+adjust)-1,0])
                                    cube([2,gap+1.6,bottom_height-pcb_z+pcb_loc_z+bottom_rear_left]);
                            }
                            if(i == 10 && sbc_model != "n2l") {
                                translate([pcb_hole_x-(bottom_standoff[0]/2)-2.6+adjust, pcb_hole_y-gap,0])
                                    cube([gap+1.6,2,bottom_height-pcb_z+pcb_loc_z+bottom_front_left]);
                            }
                            if(i == 10 && sbc_model == "n2l") {
                                translate([pcb_hole_x-1, pcb_hole_y+(bottom_standoff[0]/2)-.6+adjust,0])
                                    cube([2,gap+1.6,bottom_height-pcb_z+pcb_loc_z+bottom_front_left]);
                            }
                            if (i == 13) {
                                translate([pcb_hole_x+(bottom_standoff[0]/2)-.5+adjust, pcb_hole_y-gap,0])
                                    cube([gap+1.5,2,bottom_height-pcb_z+pcb_loc_z+bottom_rear_right]);
                            }
                            if (i == 16) {
                                translate([pcb_hole_x+(bottom_standoff[0]/2)-.5+adjust, pcb_hole_y-gap,0])
                                    cube([gap+1.5,2,bottom_height-pcb_z+pcb_loc_z+bottom_front_right]);
                            }
                        }
                    }                 
                }
            }
            // extended standoff sidewall support
            if(case_ext_standoffs == true && sidewall_support == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2)+(bottom_ext_standoff[0]/2)-.5,
                        (c_fillet/2)-1,0]) cube([gap+adjust+2,2,bottom_ext_standoff[1]]);
                }
                // right-front standoff    
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) 
                    || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(2*(wallthick+gap))-(c_fillet/2)+(bottom_ext_standoff[0]/2)-.5,
                            depth-(c_fillet/2)-(2*(wallthick+gap))-1,0])
                                cube([gap+adjust+2,2,bottom_ext_standoff[1]]);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(c_fillet/2)-(wallthick+gap)-(bottom_ext_standoff[0]/2)+.6,
                        (c_fillet/2)-1,0]) cube([gap+adjust+2,2,bottom_ext_standoff[1]]);
                }              
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(c_fillet/2)-(wallthick+gap)-(bottom_ext_standoff[0]/2)+.6,
                        depth-(c_fillet/2)-(2*(wallthick+gap))-1,0]) 
                            cube([gap+adjust+2,2,bottom_ext_standoff[1]]);
                }
            }
        }
        // subtractive accessories
        if(accessory_name != "none") {
            for (i=[1:15:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size_x = accessory_data[a[0]][i+8];
                size_y = accessory_data[a[0]][i+9];
                size_z = accessory_data[a[0]][i+10];
                data_1 = accessory_data[a[0]][i+11];
                data_2 = accessory_data[a[0]][i+12];
                data_3 = accessory_data[a[0]][i+13];
                data_4 = accessory_data[a[0]][i+14];
                
                if ((class == "sub" && face == "bottom") || class == "suball") {
                    if(accessory_highlight == false) {
                        parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                    else {
                        #parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);

                    }
                }
                // create openings for additive 
                if (class == "add2" && face == "bottom" && type == "standoff") {
                    parametric_move_sub("round",loc_x,loc_y,loc_z-.1,face,rotation,parametric,
                        6.5,size_y,floorthick+1,data_1,data_2,data_3,data_4);
                }
                if ((class == "add1" || class == "add2") && type == "uart_holder") {
                    if(accessory_highlight == false) {
                            parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,
                                0,0,0,data_1,data_2,data_3,data_4);
                    }
                    else {
                            #parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,
                                0,0,0,data_1,data_2,data_3,data_4);
                    }
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "hc4_oled_holder") {
                    parametric_move_sub("rectangle",loc_x+1,loc_y+1.75,loc_z+25.5,face,rotation,parametric,
                        26.5,wallthick+gap+4,15,data_1,data_2,data_3,[.1,.1,.1,.1]);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "access_port") {
                    if(data_3 == "landscape") {
                        if(rotation[2] == 180) {
                            parametric_move_sub("rectangle",loc_x-6+size_x,loc_y+.5+size_y,loc_z-adjust,face,rotation,
                                parametric,size_x-17,size_y-1,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                            parametric_move_sub("rectangle",loc_x-size_x+12.5+size_x,loc_y-(size_y/2)+6+size_y,loc_z-adjust,
                                face,rotation,parametric,5.5,10.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                        }
                        else {
                            parametric_move_sub("rectangle",loc_x+6,loc_y-.5,loc_z-adjust,face,rotation,
                                parametric,size_x-17,size_y-1,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                            parametric_move_sub("rectangle",loc_x+size_x-12.5,loc_y+(size_y/2)-6,loc_z-adjust,face,rotation,
                                parametric,5.5,10.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                            
                        }
                    }
                    else {
                        if(rotation[2] == 180) {
                            if(data_3 == "portrait") {
                                parametric_move_sub("rectangle",loc_x+size_x-.5,loc_y+size_y-5.75,loc_z-adjust,face,
                                    rotation,parametric,size_x-1,size_y-17,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                                parametric_move_sub("rectangle",loc_x-(size_x/2)+5+size_x,loc_y-size_y+12.5+size_y,
                                    loc_z-adjust,face,rotation,parametric,10.5,5.5,floorthick+.12,data_1,data_2,data_3,
                                        [5.5,5.5,5.5,5.5]);
                            }
                            else {
                                parametric_move_sub("rectangle",loc_x-.5,loc_y-5.75,loc_z-adjust,face,rotation,
                                    parametric,size_x-1,size_y-17,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                                parametric_move_sub("rectangle",loc_x-(size_x/2)+5,loc_y-size_y+12.5,loc_z-adjust,face,
                                rotation,parametric,10.5,5.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                            }
                        }
                        else {
                            parametric_move_sub("rectangle",loc_x+.5,loc_y+5.75,loc_z-adjust,face,rotation,
                                parametric,size_x-1,size_y-17,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                            parametric_move_sub("rectangle",loc_x+(size_x/2)-5,loc_y+size_y-12.5,loc_z-adjust,face,rotation,
                                parametric,10.5,5.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                        }
                    }
                }
                if ((class == "model") && face == "bottom" && type == "h2_netcard") {
                    parametric_move_sub("rectangle",loc_x+25,loc_y-6,loc_z-14,face,rotation,
                        parametric,68.5,wallthick+3,14.5,data_1,data_2,data_3,[1,1,1,1]);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "button") {
                    if(data_3 == "recess") {
                        #parametric_move_sub("sphere",loc_x,loc_y,loc_z,face,rotation,
                            parametric,size_x-1,size_y,size_z,data_1,data_2,data_3,0);
                    }
                    if(data_3 == "cutout") {
                        parametric_move_sub("rectangle",loc_x+10,loc_y+4,loc_z-adjust,face,rotation,
                            parametric,size_x+2,size_y+1,size_z+2*adjust,data_1,data_2,data_3,[.1,.1,.1,.1]);
                    }
                }
            }                   
        }
        // sbc openings
        if(sbc_highlight == true) {
            #open_io();
        }
        else {
            open_io();
        }
        // clean fillets
        if(case_design == "shell") {
            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,bottom_height/2]) 
                cube_negative_fillet([width,depth,bottom_height], radius=-1,
                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], top=[0,0,0,0], 
                            bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
        }
    }
    // additive accessories
    if(accessory_name != "none") {
        for (i=[1:15:len(accessory_data[a[0]])-1]) {
            class = accessory_data[a[0]][i];
            type = accessory_data[a[0]][i+1];
            loc_x = accessory_data[a[0]][i+2];
            loc_y = accessory_data[a[0]][i+3];
            loc_z = accessory_data[a[0]][i+4];
            face = accessory_data[a[0]][i+5];
            rotation = accessory_data[a[0]][i+6];
            parametric = accessory_data[a[0]][i+7];
            size_x = accessory_data[a[0]][i+8];
            size_y = accessory_data[a[0]][i+9];
            size_z = accessory_data[a[0]][i+10];
            data_1 = accessory_data[a[0]][i+11];
            data_2 = accessory_data[a[0]][i+12];
            data_3 = accessory_data[a[0]][i+13];
            data_4 = accessory_data[a[0]][i+14];
            
            if(class == "add2" && face == "bottom") {
                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                    size_x,size_y,size_z,data_1,data_2,data_3,data_4);
            }
        }
    }
}


// case top
module case_top(case_design) {

    difference() {
        union() {
            difference() {
                union() {
                    if(case_design == "shell") {
                        difference() {
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,bottom_height+(top_height/2)]) 
                                    cube_fillet_inside([width,depth,top_height], 
                                        vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                            top=[fillet,fillet,fillet,fillet,fillet], 
                                                bottom=[0,0,0,0], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,
                                bottom_height+(top_height/2)-floorthick]) 
                                    cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),top_height], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                            top=[fillet,fillet,fillet,fillet,fillet],
                                                bottom=[0,0,0,0], $fn=90);
                        }
                    }
                    if(case_design == "panel") {
                        union() {
                           translate([-gap,-gap,case_z-floorthick]) 
                                cube([width-(2*wallthick),depth-(2*wallthick),floorthick]);
                            translate([(width*(1/5))-8-(wallthick+gap),depth-(2*wallthick)-gap-adjust,
                                case_z-floorthick]) 
                                    cube([8,wallthick+2*adjust,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),depth-(2*wallthick)-gap-adjust,
                                case_z-floorthick]) 
                                    cube([8,wallthick+2*adjust,floorthick]);                   
                            translate([(width*(1/5))-8-(wallthick+gap),-wallthick-gap+adjust,
                                case_z-floorthick]) 
                                    cube([8,wallthick+2*adjust,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),-wallthick-gap+adjust,
                                case_z-floorthick]) 
                                    cube([8,wallthick+2*adjust,floorthick]);
                        }                
                    }
                    if(case_design == "stacked") {
                        translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,
                            case_z-(floorthick/2)]) 
                             cube_fillet_inside([width-(2*wallthick),depth-(2*wallthick),floorthick], 
                                 vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                     top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                        }
                    if(case_design == "tray" && (case_style == "vu5" || case_style == "vu7" || case_style == "sides")) {
                        translate([-wallthick-gap+.5,-wallthick-gap,case_z])
                            cube([width-1,depth,floorthick]);
                        translate([-wallthick-gap+.5,-wallthick-gap,
                            case_z-floorthick+adjust]) cube([width-1,wallthick,wallthick]);
                    }
                    if(case_design == "tray" && case_style == "none") {
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z/2]) 
                                cube_fillet_inside([width+2*wallthick+1,depth,case_z], 
                                    vertical=[0,0,0,0], top=[0,fillet,0,fillet,fillet], 
                                        bottom=[0,0,0,0], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,(case_z/2)-floorthick+.25]) 
                                cube_fillet_inside([width+1,depth+(wallthick*2),case_z], 
                                    vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                        top=[0,0,0,0],bottom=[0,0,0,0], $fn=90);
                            // right side bottom attachment holes          
                            translate([width-2*(wallthick+gap)-sidethick-adjust,wallthick+gap+10,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adjust));
                            if(depth >= 75) {
                               translate([width-2*(wallthick+gap)-sidethick-adjust,depth-wallthick-gap-10,
                                    ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                        cylinder(d=3, h=10+sidethick+(2*adjust));
                            }
                            else {
                               translate([width-2*(wallthick+gap)-sidethick-adjust,wallthick+gap+40,
                                    ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                        cylinder(d=3, h=10+sidethick+(2*adjust));
                            }
                            // left side bottom attachment holes
                            translate([-2*(wallthick+gap)-sidethick-adjust,wallthick+gap+10,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adjust));
                            if(depth >= 75) {
                                translate([-wallthick-gap-adjust-6,depth-wallthick-gap-10,
                                    ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                        cylinder(d=3, h=10+sidethick+(2*adjust));
                            }
                            else {
                                translate([-wallthick-gap-adjust-6,wallthick+gap+40,
                                    ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                        cylinder(d=3, h=10+sidethick+(2*adjust));
                            }
                        }
                    }
                    if(case_design == "round") {
                        difference() {
                            translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-lip/2]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=top_height+lip, r=case_diameter/2, 
                                    top=fillet, bottom=0, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-floorthick-lip/2]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=top_height+lip, r=(case_diameter/2)-wallthick, 
                                    top=fillet-1, bottom=0, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            translate([pcb_width/2,pcb_depth/2,bottom_height-adjust-lip/2]) rotate([0,0,30]) 
                                cylinder_fillet_inside(h=lip+2*adjust, r=(case_diameter/2)-wallthick/2+tol/2, 
                                    top=fillet-1, bottom=0, $fn=case_fn, fillet_fn=case_ffn, center=true);
                            // io cutout
                            if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                                sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                    sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                                translate([width,(depth/2)-wallthick-gap,bottom_height-lip+top_height/2-floorthick])
                                    cube_fillet_inside([18,depth-2*(wallthick+gap)-1,top_height+lip+2], 
                                        vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                            }
                            else {
                                translate([(width/2)-wallthick-gap,-20,bottom_height-lip+top_height/2-floorthick])
                                    cube_fillet_inside([width-2*(wallthick+gap)-1,40,top_height+lip+2], 
                                        vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                            }
                        }
                        if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                            sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                            translate([width-2*wallthick-gap-.95,depth/2-wallthick-gap-(depth-2*(floorthick+gap))/2,
                                bottom_height]) cube([wallthick-adjust,depth-2*(floorthick+gap),top_height+adjust]);
                        }
                        else {
                            translate([-.95,depth/2-2*wallthick-gap-(depth-2*(floorthick+gap))/2,
                                bottom_height]) cube([width-2*(floorthick+gap),wallthick-adjust,top_height+adjust]);
                        }
                    }
                    if(case_design == "hex") {
                        if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                            sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" && 
                                sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-lip/2]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=top_height+lip, r=case_diameter/2, 
                                        top=fillet, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-floorthick-lip/2]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=top_height+lip, r=(case_diameter/2)-wallthick, 
                                        top=fillet-1, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height-adjust-lip/2]) rotate([0,0,30]) 
                                    cylinder_fillet_inside(h=lip+2*adjust, r=(case_diameter/2)-wallthick/2+tol/2, 
                                        top=fillet-1, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                            // io cutout
                            translate([width,(depth/2)-wallthick-gap,bottom_height-lip+top_height/2-floorthick])
                                cube_fillet_inside([18,depth-2*(wallthick+gap)-1,top_height+lip+2], 
                                    vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                            }
                        }
                        else {
                            difference() {
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-lip/2]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=top_height+lip, r=hex_diameter/2, 
                                        top=fillet, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height+(top_height/2)-floorthick-lip/2])
                                    rotate([0,0,0]) cylinder_fillet_inside(h=top_height+lip, r=(hex_diameter/2)-wallthick, 
                                        top=fillet-1, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                translate([pcb_width/2,pcb_depth/2,bottom_height-adjust-lip/2]) rotate([0,0,0]) 
                                    cylinder_fillet_inside(h=lip+2*adjust, r=(hex_diameter/2)-wallthick/2+tol/2, 
                                        top=fillet-1, bottom=0, $fn=6, fillet_fn=case_ffn, center=true);
                                // io cutout
                                translate([(width/2)-wallthick-gap,-23,bottom_height-lip+top_height/2-floorthick])
                                    cube_fillet_inside([width-2*(wallthick+gap),40,top_height+lip+2], 
                                        vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=90);
                            }
                        }
                        if(width/depth >= 1.4 && sbc_model != "vim1" && sbc_model != "vim2" && 
                            sbc_model != "vim3l" && sbc_model != "vim3" && sbc_model != "vim4" &&
                                sbc_model != "rpizero" && sbc_model != "rpizero2w") {
                            translate([width-2*wallthick-gap-.95,depth/2-wallthick-gap-(depth-2*(floorthick+gap))/2,
                                bottom_height]) cube([wallthick-adjust,depth-2*(floorthick+gap),top_height+adjust]);
                        }
                        else {
                            translate([0,depth/2-2.25*(wallthick+gap)-(depth-2*(floorthick+gap))/2,
                                bottom_height]) cube([width-2*(floorthick+gap),wallthick-adjust,top_height+adjust]);
                        }
                    }
                    if(case_design == "snap") {
                        translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,floorthick*1.5+case_z])
                            cube_fillet_inside([width,depth,floorthick], 
                                vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                    top=[0,0,0,0],bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                        difference() {
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-adjust]) 
                                cube_fillet_inside([width-2*wallthick-tol,depth-2*wallthick-tol,2*floorthick+1.5], 
                                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                        top=[0,0,0,0],bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-adjust]) 
                                cube_fillet_inside([width-(3*wallthick),depth-(3*wallthick),2*floorthick+1.5+adjust], 
                                    vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],top=[0,0,0,0],
                                        bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                        }
                        // snap top outdent
                        difference() {
                            translate([-1.90+tol,(depth/2)-((depth*.75)/2)+2.5-gap-wallthick,case_z-.5]) 
                                rotate([0,45,0]) cube([4,(depth*.75)-5,4]);
                            translate([-.75,(depth/2)-((depth*.75)/2)+1.25-gap-wallthick,case_z+floorthick-5.75]) 
                                rotate([0,0,0]) cube([6,(depth*.75)-2,6]);
                        }
                        difference() {
                            translate([width-wallthick-gap-6.8-tol,(depth/2)-((depth*.75)/2)+2.5-gap-wallthick,case_z-.5])
                                rotate([0,45,0]) cube([4,(depth*.75)-5,4]);
                            translate([width-wallthick-gap-8.5,(depth/2)-((depth*.75)/2)+1.25-gap-wallthick,case_z+floorthick-5.75])
                                rotate([0,0,0]) cube([6,(depth*.75)-2,6]);
                        }
                    }
                    if(case_design == "fitted") {
                        difference() {
                            translate([(width/2)-wallthick-gap,
                                (depth/2)-wallthick-gap,case_z+floorthick/2-(lip)/2]) 
                                    cube_fillet_inside([width,depth,lip+floorthick], 
                                        vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                                            top=[fillet,fillet,fillet,fillet,fillet], 
                                                bottom=[0,0,0,0], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,case_z-floorthick-1]) 
                                    cube_fillet_inside([width-wallthick+tol,depth-wallthick+tol,lip+floorthick], 
                                        vertical=[c_fillet-1,c_fillet-1,c_fillet-1,c_fillet-1],
                                            top=[fillet,fillet,fillet,fillet,fillet],
                                                bottom=[0,0,0,0], $fn=90);
                        }
                    }
                    if(accessory_name != "none") {
                        for (i=[1:15:len(accessory_data[a[0]])-1]) {
                            class = accessory_data[a[0]][i];
                            type = accessory_data[a[0]][i+1];
                            loc_x = accessory_data[a[0]][i+2];
                            loc_y = accessory_data[a[0]][i+3];
                            loc_z = accessory_data[a[0]][i+4];
                            face = accessory_data[a[0]][i+5];
                            rotation = accessory_data[a[0]][i+6];
                            parametric = accessory_data[a[0]][i+7];
                            size_x = accessory_data[a[0]][i+8];
                            size_y = accessory_data[a[0]][i+9];
                            size_z = accessory_data[a[0]][i+10];
                            data_1 = accessory_data[a[0]][i+11];
                            data_2 = accessory_data[a[0]][i+12];
                            data_3 = accessory_data[a[0]][i+13];
                            data_4 = accessory_data[a[0]][i+14];
                            
                            if (class == "add1" && face == "top") {
                                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,
                                    parametric,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                            }
                        }
                    }                  
                }
                // pcb standoff holes
                if(top_standoff[5] != 4 && sbc_top_standoffs == true) {
                    for (i=[7:3:16]) {
                        pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                        pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                        pcb_hole_size = sbc_data[s[0]][i+2];
                        if (pcb_hole_x!=0 && pcb_hole_y!=0) {
                            translate([pcb_hole_x,pcb_hole_y,top_height+1]) cylinder(d=6.5, h=top_height);
                        }
                    }
                }
                // extended standoff holes
                if(case_ext_standoffs == true) {
                    // right-rear standoff
                    if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                        translate([width-(2*(wallthick+gap))-(c_fillet/2),(c_fillet/2),top_height+1]) 
                            cylinder(d=6.5, h=top_height);
                    }
                    // right-front standoff    
                    if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(c_fillet/2)-(2*(wallthick+gap)),
                            depth-(c_fillet/2)-(2*(wallthick+gap)),top_height+1]) cylinder(d=6.5, h=top_height);
                    }
                    // left-rear standoff
                    if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                        translate([(c_fillet/2),(c_fillet/2),top_height+1]) cylinder(d=6.5, h=top_height);
                    }              
                    // left-front standoff
                    if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                        translate([+(c_fillet/2),depth-(c_fillet/2)-(2*(wallthick+gap)),
                            top_height+1]) cylinder(d=6.5, h=top_height+1);
                    }
                }
            }           
            // pcb standoffs
            if(sbc_top_standoffs == true) {
                for (i=[7:3:16]) {
                    pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                    pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                    pcb_hole_size = sbc_data[s[0]][i+2];
                    if(pcb_hole_x!=0 && pcb_hole_y!=0) {
                        if (i == 7) {
                            normal_standoff = [top_standoff[0],
                                                top_height+pcb_loc_z+top_rear_left,
                                                top_standoff[2],
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_standoff[7],
                                                top_standoff[8],
                                                top_standoff[9],
                                                top_standoff[10]];
                            translate([pcb_hole_x,pcb_hole_y,case_z]) standoff(normal_standoff);
                        }
                        if (i == 10) {
                            normal_standoff = [top_standoff[0],
                                                top_height+pcb_loc_z+top_front_left,
                                                top_standoff[2],
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_standoff[7],
                                                top_standoff[8],
                                                top_standoff[9],
                                                top_standoff[10]];
                            translate([pcb_hole_x,pcb_hole_y,case_z]) standoff(normal_standoff);
                        }
                        if (i == 13) {
                            normal_standoff = [top_standoff[0],
                                                top_height+pcb_loc_z+top_rear_right,
                                                top_standoff[2],
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_standoff[7],
                                                top_standoff[8],
                                                top_standoff[9],
                                                top_standoff[10]];
                            translate([pcb_hole_x,pcb_hole_y,case_z]) standoff(normal_standoff);
                        }
                        if (i == 16) {
                            normal_standoff = [top_standoff[0],
                                                top_height+pcb_loc_z+top_front_right,
                                                top_standoff[2],
                                                top_standoff[3],
                                                top_standoff[4],
                                                top_standoff[5],
                                                top_standoff[6],
                                                top_standoff[7],
                                                top_standoff[8],
                                                top_standoff[9],
                                                top_standoff[10]];
                            translate([pcb_hole_x,pcb_hole_y,case_z]) standoff(normal_standoff);
                        }
                    }                    
                }
            }
            // extended standoffs
            if(case_ext_standoffs == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2),(c_fillet/2),case_z]) 
                        standoff(top_ext_standoff);
                }
                // right-front standoff    
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) 
                    || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(c_fillet/2)-(2*(wallthick+gap)),
                            depth-(c_fillet/2)-(2*(wallthick+gap)),case_z]) standoff(top_ext_standoff);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(c_fillet/2),(c_fillet/2),case_z]) standoff(top_ext_standoff);
                }              
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(c_fillet/2),depth-(c_fillet/2)-(2*(wallthick+gap)),
                        case_z]) standoff(top_ext_standoff);                
                }
            }
            // standoff sidewall support
            if(sidewall_support == true && sbc_top_standoffs == true) {
                if(pcb_width/pcb_depth >= 1.4) {
                    for (i=[7:3:16]) {
                        pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                        pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                        pcb_hole_size = sbc_data[s[0]][i+2];
                        if(pcb_hole_x!=0 && pcb_hole_y!=0) {
                            if (i == 7) {
                                translate([pcb_hole_x-1, pcb_hole_y-(top_standoff[0]/2)-(gap-adjust)-1.4,
                                    case_z-top_height-top_rear_left]) cube([2,gap+1.6,top_height+top_rear_left]);
                            }
                            if (i == 10) {
                                translate([pcb_hole_x-1, pcb_hole_y+(top_standoff[0]/2)-.6+adjust,case_z-top_height-top_front_left]) 
                                    cube([2,gap+1.6,top_height+top_front_left]);
                            }
                            if (i == 13) {
                                translate([pcb_hole_x-1, pcb_hole_y-(top_standoff[0]/2)-(gap-adjust)-1.4,
                                    case_z-top_height-top_rear_right]) cube([2,gap+1.6,top_height+top_rear_right]);
                            }
                            if (i == 16) {
                                translate([pcb_hole_x-1, pcb_hole_y+(top_standoff[0]/2)-.6+adjust,case_z-top_height-top_front_right]) 
                                    cube([2,gap+1.6,top_height+top_front_right]);
                            }
                        }
                    }
                }
                else {
                     for (i=[7:3:16]) {
                        pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                        pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                        pcb_hole_size = sbc_data[s[0]][i+2];
                        if(pcb_hole_x!=0 && pcb_hole_y!=0) {
                            if (i == 7 && sbc_model != "n2l") {
                                translate([pcb_hole_x-(top_standoff[0]/2)-gap-adjust-1,pcb_hole_y-1,
                                    bottom_height-top_rear_left]) cube([gap+adjust+1.6,2,top_height+top_rear_left]);
                            }
                            if (i == 7 && sbc_model == "n2l") {
                                translate([pcb_hole_x-1, pcb_hole_y-(top_standoff[0]/2)-(gap-adjust)-1.4,
                                    case_z-top_height-top_rear_left]) cube([2,gap+1.6,top_height+top_rear_left]);
                                
                            }
                            if (i == 10 && sbc_model != "n2l") {
                                translate([pcb_hole_x-(top_standoff[0]/2)-gap-adjust-1,pcb_hole_y-1,
                                    bottom_height-top_front_left]) cube([gap+adjust+1.6,2,top_height+top_front_left]);
                            }
                            if (i == 10 && sbc_model == "n2l") {
                                translate([pcb_hole_x-1, pcb_hole_y+(top_standoff[0]/2)-.6+adjust,case_z-top_height-top_front_left]) 
                                    cube([2,gap+1.6,top_height+top_front_left]);
                                
                            }
                            if (i == 13) {
                                translate([pcb_hole_x+(top_standoff[0]/2)-adjust-.45,pcb_hole_y-1,
                                    bottom_height-top_rear_right]) cube([gap+adjust+1.6,2,top_height+top_rear_right]);
                            }
                            if (i == 16) {
                                translate([pcb_hole_x+(top_standoff[0]/2)-adjust-.45,pcb_hole_y-1,
                                    bottom_height-top_front_right]) cube([gap+adjust+1.6,2,top_height+top_front_right]);
                            }
                        }
                    }
                }
            }
            // extended standoff sidewall support
            if(case_ext_standoffs == true && sidewall_support == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2)+(top_ext_standoff[0]/2)-.6,
                        (c_fillet/2)-1,bottom_height]) cube([gap+adjust+2,2,top_height]);
                }
                // right-front standoff    
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) 
                    || width-pcb_loc_x-pcb_width >= 10) {
                        translate([width-(2*(wallthick+gap))-(c_fillet/2)+(top_ext_standoff[0]/2)-.6,
                            depth-(c_fillet/2)-(2*(wallthick+gap))-1,bottom_height])
                                cube([gap+adjust+2,2,top_height]);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(c_fillet/2)-(wallthick+gap)-(top_ext_standoff[0]/2)+.6,(c_fillet/2)-1,
                        bottom_height]) cube([gap+adjust+2,2,top_height]);
                }              
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(c_fillet/2)-(wallthick+gap)-(top_ext_standoff[0]/2)+.6,
                        depth-(c_fillet/2)-(2*(wallthick+gap))-1, bottom_height]) 
                            cube([gap+adjust+2,2,top_height]);
                }
            }
        }
        // subtractive accessories
        if(accessory_name != "none") {
            for (i=[1:15:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size_x = accessory_data[a[0]][i+8];
                size_y = accessory_data[a[0]][i+9];
                size_z = accessory_data[a[0]][i+10];
                data_1 = accessory_data[a[0]][i+11];
                data_2 = accessory_data[a[0]][i+12];
                data_3 = accessory_data[a[0]][i+13];
                data_4 = accessory_data[a[0]][i+14];
                
                if ((class == "sub" && face == "top") || class == "suball") {
                    if(accessory_highlight == false) {
                        parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,
                            parametric,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                    else {
                        #parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,
                            parametric,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                }
                // create openings for additive 
                if (class == "add2" && face == "top" && type == "standoff") {
                    parametric_move_sub("round",loc_x,loc_y,loc_z,face,rotation,parametric,
                        6.5,size_y,floorthick+1,data_1,data_2,data_3,data_4);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "uart_holder") {
                    if(accessory_highlight == false) {
                        parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,
                            0,0,0,data_1,data_2,data_3,data_4);
                    }
                    else {
                        #parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,
                            0,0,0,data_1,data_2,data_3,data_4);
                    }
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "hc4_oled_holder") {
                    parametric_move_sub("rectangle",loc_x+1,loc_y+1.75,loc_z+26,face,rotation,
                        parametric,26.5,wallthick+gap+4,14.5,data_1,data_2,data_3,[.1,.1,.1,.1]);
                }
                if ((class == "add1" || class == "add2") && face == "top" && type == "button") {
                    if(data_3 == "recess") {
                        parametric_move_sub("sphere",loc_x,loc_y,loc_z,face,rotation,
                            parametric,size_x-1,size_y,size_z,data_1,data_2,data_3,0);
                    }
                    if(data_3 == "cutout") {
                        parametric_move_sub("rectangle",loc_x+10,loc_y+4,loc_z-adjust,face,rotation,
                            parametric,size_x+2,size_y+1,size_z+2*adjust,data_1,data_2,data_3,[.1,.1,.1,.1]);
                    }
                }
                if (class == "model" && face == "bottom" && type == "hk_boom" && 
                    rotation[0] == 90 && rotation[1] == 0 && rotation[2] == 0) {
                        parametric_move_sub("round",loc_x+11,loc_y-4,loc_z,face,[0,0,0],
                            parametric,5,size_y,80,data_1,data_2,data_3,data_4);
                        parametric_move_sub("slot",loc_x+37.5,loc_y-4.75,loc_z,face,[0,0,0],
                            parametric,6,14,80,data_1,data_2,data_3,data_4);
                }
            }
        }            
        // sbc openings
        if(sbc_highlight == true) {
            #open_io();
        }
        else {
            open_io();
        }
        // clean fillets
        if(case_design == "shell") {
            translate(([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,
                bottom_height+(top_height/2)]) ) 
                    cube_negative_fillet([width,depth,top_height], radius=-1,
                        vertical=[c_fillet,c_fillet,c_fillet,c_fillet], 
                            top=[fillet,fillet,fillet,fillet,fillet], 
                                bottom=[0,0,0,0], $fn=90);
        }
    }
    // additive accessories
    if(accessory_name != "none") {
        for (i=[1:15:len(accessory_data[a[0]])-1]) {
            class = accessory_data[a[0]][i];
            type = accessory_data[a[0]][i+1];
            loc_x = accessory_data[a[0]][i+2];
            loc_y = accessory_data[a[0]][i+3];
            loc_z = accessory_data[a[0]][i+4];
            face = accessory_data[a[0]][i+5];
            rotation = accessory_data[a[0]][i+6];
            parametric = accessory_data[a[0]][i+7];
            size_x = accessory_data[a[0]][i+8];
            size_y = accessory_data[a[0]][i+9];
            size_z = accessory_data[a[0]][i+10];
            data_1 = accessory_data[a[0]][i+11];
            data_2 = accessory_data[a[0]][i+12];
            data_3 = accessory_data[a[0]][i+13];
            data_4 = accessory_data[a[0]][i+14];
            
            if (class == "add2" && face == "top") {
                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                    size_x,size_y,size_z,data_1,data_2,data_3,data_4);
            }
        }
    }
}

// case side
module case_side(case_design,case_style,side) {
    
    difference() {
        union() {
            if(case_design == "panel") {
                if(side == "rear") {
                    difference() {
                        union() {
                            translate([-gap,-wallthick-gap,-floorthick]) 
                                cube([width-2*wallthick,wallthick,case_z+2*floorthick]);
                            // right hook
                            difference() {
                                translate([width-(2*wallthick)-gap-adjust,-wallthick-gap,
                                    ((case_z)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([width-(2*wallthick)-gap-adjust,-wallthick-gap-adjust,
                                    ((case_z)/2)-4-adjust]) 
                                        cube([wallthick+.25,wallthick+(2*adjust),4.25]);
                            }
                            // left hook
                            difference() {
                                translate([-(2*wallthick)-gap-adjust-.25,-wallthick-gap,
                                    ((case_z)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([-wallthick-gap-adjust-.25,-wallthick-gap-adjust,
                                    ((case_z)/2)-4-adjust]) 
                                        cube([wallthick+.25,wallthick+(2*adjust),4.25]);
                            }
                        }
                        // top slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),-wallthick-gap-adjust,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adjust,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,-wallthick-gap-adjust,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adjust,floorthick+.5]);
                        // bottom slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),-wallthick-gap-adjust,-.25]) 
                                cube([8.5,wallthick+2*adjust,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,-wallthick-gap-adjust,-.25]) 
                                cube([8.5,wallthick+2*adjust,floorthick+.5]);
                    }
                }
                if(side == "front") {
                    difference() {
                        union() {
                            translate([-gap,depth-2*(wallthick)-gap,-floorthick]) 
                                cube([width-2*wallthick,wallthick,case_z+2*floorthick]);
                            // right hook
                            difference() {
                                translate([width-(2*wallthick)-gap-adjust,depth-2*(wallthick)-gap-adjust,
                                    ((case_z)/2)-4])
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([width-(2*wallthick)-gap-adjust,
                                    depth-2*(wallthick)-adjust-gap-adjust,((case_z)/2)-4-adjust])
                                        cube([wallthick+.25,wallthick+(2*adjust),4.25]);
                            }
                            // left hook
                            difference() {
                                translate([-(2*wallthick)-gap-adjust-.25,depth-2*(wallthick)-gap-adjust,(
                                    (case_z)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([-wallthick-gap-adjust-.25,depth-2*(wallthick)-adjust-gap-adjust,
                                    ((case_z)/2)-4-adjust]) 
                                        cube([wallthick+.25,wallthick+(2*adjust),4.25]);
                            }
                        }
                        // top slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),depth-2*wallthick-gap-adjust,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adjust,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,depth-2*wallthick-gap-adjust,
                            case_z-floorthick-.25]) 
                                cube([8.5,wallthick+2*adjust,floorthick+.5]);
                        // bottom slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),depth-2*wallthick-gap-adjust,-.25]) 
                                cube([8.5,wallthick+2*adjust,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,
                            depth-2*wallthick-gap-adjust,-.25]) cube([8.5,wallthick+2*adjust,floorthick+.5]);
                    }
                }
                if(side == "right") {
                    difference() {
                        translate([width-(2*wallthick)-gap,-(2*wallthick)-gap,-wallthick]) 
                            cube([wallthick,depth+2*wallthick,case_z+(2*wallthick)]);
                        translate([width-(2*wallthick)-gap-adjust,-wallthick-gap-.25,
                            ((case_z)/2)]) cube([wallthick+2*adjust,wallthick+.5,8.5]);
                        translate([width-(2*wallthick)-gap-adjust,depth-2*(wallthick)-gap-.25,
                            ((case_z)/2)])
                                cube([wallthick+2*adjust,wallthick+.5,8.5]);
                    }
                }
                if(side == "left") {
                    difference() {
                        translate([-wallthick-gap,-(2*wallthick)-gap,-wallthick]) 
                            cube([wallthick,depth+2*wallthick,case_z+(2*wallthick)]);
                        translate([-wallthick-gap-adjust,-wallthick-gap-.25,((case_z)/2)])
                            cube([wallthick+2*adjust,wallthick+.5,8.5]);
                        translate([-wallthick-gap-adjust,depth-2*(wallthick)-gap-.25,
                            ((case_z)/2)])
                                cube([wallthick+2*adjust,wallthick+.5,8.5]);
                    }
                }
            }
            if(case_design == "tray" && case_style == "sides") {
                if(side == "right") {
                    difference() {
                        union() {
                            translate([width-wallthick-gap,-(2*wallthick)-gap,0]) 
                                cube([sidethick,depth+2*wallthick,case_z+(2*wallthick)]);
                            translate([width-gap-wallthick-1+adjust,depth-2*(wallthick+gap)-.5,case_z+(2*wallthick)-2]) 
                                cube([1,6,2]);
                            translate([width-gap-wallthick-1+adjust,-2*(wallthick+gap)+1.5,case_z+(2*wallthick)-2]) 
                                cube([1,6,2]);
                            // top rail
                            translate([width-6.9-adjust,-gap,case_z-floorthick-.5])
                                cube([4,depth-2*(wallthick+gap),2]);
                        }
                        // right side bottom attachment holes          
                        translate([width-2*(wallthick+gap)-sidethick-adjust,wallthick+gap+10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adjust));
                        if(depth >= 75) {                        
                            translate([width-2*(wallthick+gap)-sidethick-adjust,depth-wallthick-gap-10,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adjust));
                        }
                        else {
                            translate([width-2*(wallthick+gap)-sidethick-adjust,wallthick+gap+40,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adjust));
                        }
                    }
                }
                if(side == "left") {
                    difference() {
                        union() {
                            translate([-wallthick-gap-sidethick,-(2*wallthick)-gap,0]) 
                                cube([sidethick,depth+2*wallthick,case_z+(2*wallthick)]);
                            translate([-gap-wallthick-adjust,depth-2*(wallthick+gap)-.5,case_z+(2*wallthick)-2])
                                cube([1,6,2]);
                            translate([-gap-wallthick-adjust,-2*(wallthick+gap)+1.5,case_z+(2*wallthick)-2]) 
                                cube([1,6,2]);
                            // top rail
                            translate([-wallthick-gap-adjust,-gap,case_z-floorthick-.5]) 
                                cube([4,depth-2*(wallthick+gap),2]);
                        }
                        // left side bottom attachment holes
                        translate([-wallthick-gap-adjust-5,wallthick+gap+10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adjust));
                        if(depth >= 75) {
                            translate([-wallthick-gap-adjust-6,depth-wallthick-gap-10,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adjust));
                        }
                        else {
                            translate([-wallthick-gap-adjust-6,wallthick+gap+40,
                                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) 
                                    cylinder(d=3, h=10+sidethick+(2*adjust));
                        }
                    }
                }
            }
            if(case_design == "tray" && case_style == "vu5") {
                cheight = case_z+90;
                vesa = 75;
                vu_holder(case_style,side,vesa,cheight);
            }
            if(case_design == "tray" && case_style == "vu7") {
                cheight = case_z+122;
                vesa = 100;
                vu_holder(case_style,side,vesa,cheight);
            }         
            // additive accessories
            if(accessory_name != "none") {
                for (i=[1:15:len(accessory_data[a[0]])-1]) {
                    class = accessory_data[a[0]][i];
                    type = accessory_data[a[0]][i+1];
                    loc_x = accessory_data[a[0]][i+2];
                    loc_y = accessory_data[a[0]][i+3];
                    loc_z = accessory_data[a[0]][i+4];
                    face = accessory_data[a[0]][i+5];
                    rotation = accessory_data[a[0]][i+6];
                    parametric = accessory_data[a[0]][i+7];
                    size_x = accessory_data[a[0]][i+8];
                    size_y = accessory_data[a[0]][i+9];
                    size_z = accessory_data[a[0]][i+10];
                    data_1 = accessory_data[a[0]][i+11];
                    data_2 = accessory_data[a[0]][i+12];
                    data_3 = accessory_data[a[0]][i+13];
                    data_4 = accessory_data[a[0]][i+14];
                    
                    if (class == "add1" && face == side) {
                        parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                }
            }
        }
        if(accessory_name != "none") {
            for (i=[1:15:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size_x = accessory_data[a[0]][i+8];
                size_y = accessory_data[a[0]][i+9];
                size_z = accessory_data[a[0]][i+10];
                data_1 = accessory_data[a[0]][i+11];
                data_2 = accessory_data[a[0]][i+12];
                data_3 = accessory_data[a[0]][i+13];
                data_4 = accessory_data[a[0]][i+14];
                
                if ((class == "sub" && face == side) || class == "suball") {
                    if(accessory_highlight == false) {
                        parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                    else {
                        #parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                }
                // create openings for additive 
                if ((class == "sub" && face == "bottom") || class == "suball") {
                    if(accessory_highlight == false) {
                        parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                    else {
                        #parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                    }
                }
                // create openings for additive 
                if (class == "add2" && face == "bottom" && type == "standoff") {
                    parametric_move_sub("round",loc_x,loc_y,-.1,face,rotation,parametric,
                        6.5,size_y,floorthick+1,data_1,data_2,data_3,data_4);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "uart_holder") {
                    if(accessory_highlight == false) {
                        parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,
                            0,0,0,data_1,data_2,data_3,data_4);
                    }
                    else {
                        #parametric_move_sub("microusb",loc_x+5.25,loc_y-5,loc_z+4,face,rotation,parametric,
                            0,0,0,data_1,data_2,data_3,data_4);
                    }
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "hc4_oled_holder") {
                    parametric_move_sub("rectangle",loc_x+1,loc_y+1.75,loc_z+25.5,face,rotation,
                        parametric,26.5,wallthick+gap+4,15,data_1,data_2,data_3,[.1,.1,.1,.1]);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "access_port") {
                    if(data_3 == "landscape") {
                        parametric_move_sub("rectangle",loc_x+6,loc_y-.5,loc_z-adjust,face,rotation,
                            parametric,size_x-17,size_y-1,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                        parametric_move_sub("rectangle",loc_x+size_x-12.5,loc_y+(size_y/2)-6,loc_z-adjust,face,rotation,
                            parametric,5.5,10.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                    }
                    else {
                        parametric_move_sub("rectangle",loc_x+.5,loc_y+5.75,loc_z-adjust,face,rotation,parametric,
                            size_x-1,size_y-17,floorthick+1,data_1,data_2,data_3,[.1,.1,.1,.1]);
                        parametric_move_sub("rectangle",loc_x+(size_x/2)-5,loc_y+size_y-12.5,loc_z-adjust,face,rotation,
                            parametric,10.5,5.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]); 
                    }
                }
                if ((class == "model") && face == "bottom" && type == "h2_netcard") {
                    parametric_move_sub("rectangle",loc_x+25,loc_y-6,loc_z-14,face,rotation,
                        parametric,68.5,wallthick+3,14.5,data_1,data_2,data_3,[1,1,1,1]);
                }
                if ((class == "add1" || class == "add2") && face == "bottom" && type == "button") {
                    if(data_3 == "recess") {
                    parametric_move_sub("sphere",loc_x,loc_y,loc_z,face,rotation,
                        parametric,size_x-1,size_y,size_z,data_1,data_2,data_3,0);
                    }
                    if(data_3 == "cutout") {
                        parametric_move_sub("rectangle",loc_x+10,loc_y+4,loc_z-adjust,face,rotation,
                            parametric,size_x+2,size_y+1,size_z+2*adjust,data_1,data_2,data_3,[.1,.1,.1,.1]);
                    }
                }
            }
        }
        // sbc openings
        if(sbc_highlight == true) {
            #open_io();
        }
        else {
            open_io();
        }
    }
    if(accessory_name != "none") {
        for (i=[1:15:len(accessory_data[a[0]])-1]) {
            class = accessory_data[a[0]][i];
            type = accessory_data[a[0]][i+1];
            loc_x = accessory_data[a[0]][i+2];
            loc_y = accessory_data[a[0]][i+3];
            loc_z = accessory_data[a[0]][i+4];
            face = accessory_data[a[0]][i+5];
            rotation = accessory_data[a[0]][i+6];
            parametric = accessory_data[a[0]][i+7];
            size_x = accessory_data[a[0]][i+8];
            size_y = accessory_data[a[0]][i+9];
            size_z = accessory_data[a[0]][i+10];
            data_1 = accessory_data[a[0]][i+11];
            data_2 = accessory_data[a[0]][i+12];
            data_3 = accessory_data[a[0]][i+13];
            data_4 = accessory_data[a[0]][i+14];
            
            if (class == "add2" && face == side) {
                parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                    size_x,size_y,size_z,data_1,data_2,data_3,data_4);
            }
        }
    }
}

// sbc openings
module open_io() {

    for (i=[69:6:len(sbc_data[s[0]])-1]) {   
        loc_x = sbc_data[s[0]][i]+pcb_loc_x;
        loc_y = sbc_data[s[0]][i+1]+pcb_loc_y;
        rotation = sbc_data[s[0]][i+2];
        side = sbc_data[s[0]][i+3];
        class = sbc_data[s[0]][i+4];
        type = sbc_data[s[0]][i+5];
    
        mask(loc_x,loc_y,bottom_height+pcb_loc_z-adjust,rotation,side,class,type,wallthick,gap,floorthick,pcb_z);
        
        // indents
        if(indents == true) {
            indent(loc_x,loc_y,bottom_height+pcb_loc_z-adjust,rotation,side,class,type,wallthick,gap,floorthick,pcb_z);
        }
        
        // bottom cooling openings
        if(side == "bottom" && cooling == "fan" && class == "heatsink") {
            translate([loc_x+12,loc_y-28,-adjust]) 
                fan_mask(40,floorthick+(2*adjust),2);
        }
        if(side == "bottom" && cooling == "vents" && class == "heatsink") {
            for(r=[loc_x+13:4:54]) {
                translate([r,loc_y-20,-adjust]) 
                    cube([2,25,floorthick+(adjust*2)]);
            }
        }
        if(side == "bottom" && cooling == "custom" && class == "heatsink") {
            translate([loc_x+12,loc_y-14,-(floorthick-adjust)]) 
                linear_extrude(height = wallthick+(2*adjust)) import(file = "./dxf/customfan.dxf");
        }   
        if(side == "bottom" && exhaust_vents == "vent" && (cooling == "fan" || cooling == "vents" 
            || cooling == "custom") && class == "heatsink" && gpio_opening != "vent" && gpio_opening != "open" 
                && gpio_opening != "punchout") {
            for(r=[loc_x+7:4:46+loc_x]) {
                translate([r,depth-(2*wallthick)-adjust-2,floorthick+2]) 
                   cube([2,wallthick+(2*adjust)+1,top_height-floorthick-6]);
            }
        }    
        // top cooling openings
        if(side == "top" && cooling == "fan" && class == "heatsink" && type != "h3_oem" 
            && type != "h2_oem" && type != "n2_oem" && type != "n2+_oem") {
                translate([loc_x+6,loc_y-28,case_z-(floorthick+adjust)-5]) 
                    fan_mask(40,floorthick+(2*adjust)+8,2);
        }
        if(side == "top" && cooling == "fan" && class == "heatsink" && (type == "n2_oem" || type == "n2+_oem")) {
            translate([loc_x+4,loc_y+5.5,-adjust]) 
                fan_mask(80,floorthick+(2*adjust),2);
            if(sbc_model == "n2") {
                translate([pcb_loc_x+7,pcb_loc_y+15,-adjust]) cylinder(d=3,h=floorthick+(adjust*2));  
                translate([pcb_loc_x+82,pcb_loc_y+6,-adjust]) cylinder(d=3,h=floorthick+(adjust*2));
                translate([pcb_loc_x+8,pcb_loc_y+75,-adjust]) cylinder(d=3,h=floorthick+(adjust*2));
                translate([pcb_loc_x+82,pcb_loc_y+75,-adjust]) cylinder(d=3,h=floorthick+(adjust*2));
            }
        }
        if(side == "top" && cooling == "fan" && class == "heatsink" && type == "h2_oem") {
            translate([loc_x-28,loc_y-28,case_z-(floorthick+adjust)]) 
                fan_mask(90,floorthick+6,2);
        }
        if(side == "top" && cooling == "fan" && class == "heatsink" && type == "h3_oem" ) {
            translate([loc_x-5,loc_y-16,case_z-(floorthick+adjust)]) 
                fan_mask(90,floorthick+6,2);
        }
        if(side == "top" && cooling == "vents" && class == "heatsink") {
            for(r=[loc_x+7:4:48+loc_x]) {
                translate([r,loc_y-20,case_z-(floorthick+adjust)-6]) 
                    cube([2,25,floorthick+(adjust*2)+8]);
            }
        }
        if(side == "top" && cooling == "custom" && class == "heatsink") {
            translate([loc_x+6,loc_y-14,case_z-(floorthick+adjust)]) 
                linear_extrude(height = wallthick+(2*adjust)) import(file = "./dxf/customfan.dxf");
        }
        if(side == "top" && exhaust_vents == "vent" && (cooling == "fan" || cooling == "vents" 
            || cooling == "custom") && class == "heatsink" && gpio_opening != "vent" && gpio_opening != "open" 
                && gpio_opening != "punchout") {
                    for(r=[loc_x+7:4:46+loc_x]) {
                        translate([r,depth-(2*wallthick)-adjust-2,bottom_height+2]) 
                           cube([2,wallthick+(2*adjust)+1,top_height-floorthick-6]);
                    }
        }
    
        // gpio opening
        if(side == "top" && class == "gpio" && type == "header_40" && rotation == 0) {
            if(gpio_opening == "vent") {
                for(r=[loc_x-2:4:50+loc_x]) {
                    translate([r,depth-(2*wallthick)-gap-adjust,bottom_height+2]) 
                        cube([2,wallthick+(2*adjust),top_height-floorthick-7]);
                }
            }
            if(gpio_opening == "open") {
                translate([loc_x-2,depth-(2*wallthick)-adjust-gap,bottom_height+3])
                    cube([54,wallthick+(2*adjust),top_height-floorthick-5]);
            }
            if(gpio_opening == "punchout") {
                translate([loc_x+1,depth-(2*wallthick)-adjust-gap,bottom_height+7.5])
                    rotate([-90,0,0]) punchout(50,11,2,wallthick+(2*adjust),c_fillet,"slot");
            }
        }
        if(side == "top" && class == "gpio" && type == "header_40" && rotation == 90) {
            if(gpio_opening == "vent") {
                for(r=[loc_y-2:4:50+loc_y]) {
                    translate([width-2*(wallthick+gap)-adjust,depth-r,bottom_height+2]) 
                        rotate([0,0,0]) cube([6,wallthick+(2*adjust),top_height-floorthick-7]);
                }
            }
            if(gpio_opening == "open") {
                translate([loc_x+8,depth-13,bottom_height+4])
                    rotate([0,0,-90]) cube([54,wallthick+(2*adjust),top_height-floorthick-5]);
            }
            if(gpio_opening == "punchout") {
                translate([loc_x+8,depth-15,bottom_height+7.5])
                    rotate([-90,0,-90]) punchout(50,11,2,wallthick+(2*adjust),c_fillet,"slot");
            }
        }
        if(side == "top" && class == "gpio" && type == "encl_header_30") {
            if(gpio_opening == "vent") {
                for(r=[loc_x-2:4:39+loc_x]) {
                    translate([r,depth-(2*wallthick)-adjust,bottom_height+2]) 
                        cube([2,wallthick+(2*adjust),top_height-floorthick-4]);
                }
            }
            if(gpio_opening == "open") {
                translate([loc_x-2,depth-(2*wallthick)-adjust,bottom_height+3])
                    cube([41,wallthick+(2*adjust),top_height-floorthick-5]);
            }
            if(gpio_opening == "punchout") {
                translate([loc_x+1,depth-(2*wallthick)-adjust-gap,bottom_height+8])
                    rotate([-90,0,0]) punchout(34,11,2,wallthick+(2*adjust),3,"slot");
            }
        }
    
        // uart knockout opening
        if(side == "top" && type == "uart_micro" && rotation == 90) {
            translate([loc_x-wallthick-gap-8.5,loc_y-1,bottom_height+5]) rotate([90,0,90]) 
                punchout(15,8,1,wallthick+(2*adjust)+10,2,"rectangle");
        }
        if(side == "top" && type == "uart_micro" && rotation == -90) {
            translate([loc_x+2*(wallthick+gap)+1,loc_y-1,bottom_height+5]) rotate([90,0,90]) 
                punchout(15,8,1,wallthick+(2*adjust)+5,2,"rectangle");
        }
        if(side == "top" && type == "uart_micro" && rotation == 270) {
            translate([loc_x-2*(wallthick),loc_y-1,bottom_height+5]) rotate([90,0,90]) 
                punchout(15,8,1,wallthick+(2*adjust)+12,2,"rectangle");
        }
        
        // sata openings
        if(side == "top" && type == "sata_power_vrec" && sata_punchout == true) {
            translate([loc_x-3,loc_y+1.75,case_z-adjust-floorthick]) 
                punchout(42,7.5,2,floorthick+(2*adjust)+6,3,"slot");
        }
    }
}

module vu_holder(vu_model,side,vesa,cheight) {

//cheight = case_z+90;
v_fillet = 3;
    
vu5_case_x_offset = 6.5;                // for uniform front vu5=6.5, vu7=20
vu5_pcb_width = 121;
vu5_pcb_height = 93.31;
vu5_width = vu5_pcb_width + vu5_case_x_offset;
vu5_height = vu5_pcb_height + 9.75;
    
vu7_case_x_offset = 20;                 // for uniform front vu5=6.5, vu7=20
vu7_pcb_width = 172.90;
vu7_pcb_height = 124.27;
vu7_width = vu7_pcb_width + vu7_case_x_offset;
vu7_height = vu7_pcb_height + 9.75;

        difference() {
        union() {
            if(side == "right") {
                translate([width-wallthick-gap,-(2*wallthick)-gap,0]) 
                    cube([sidethick,depth+2*wallthick,cheight]);
                // right tabs for vu5 attachment
                if(case_style == "vu5") {
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick,depth-39,
                        case_z+80]) rotate([90-vu_rotation[0],180,0]) 
                            slab_r([((width-vesa)/2)+4.5,10,sidethick], [.1,.1,3,3]);
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick,depth-26,
                        case_z+31.5]) rotate([90-vu_rotation[0],180,0]) 
                            slab_r([((width-vesa)/2)+4.5,10,sidethick], [.1,.1,3,3]);
                
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick,depth-41.85-adjust,
                        case_z+79.25]) rotate([90-vu_rotation[0],180,0]) 
                    difference() { 
                        cube([sidethick,10,sidethick]);
                        translate([0,-adjust,sidethick]) rotate([0,45,0]) 
                            cube([2*sidethick,10+(2*adjust),sidethick]);
                    }
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick,depth-28.85-adjust,
                        case_z+30.75]) rotate([90-vu_rotation[0],180,0])
                    difference() { 
                        cube([sidethick,10,sidethick]);
                        translate([0,-adjust,sidethick]) rotate([0,45,0]) 
                            cube([2*sidethick,10+(2*adjust),sidethick]);
                    }
                }
                // right tabs for vu7 attachment
                if(case_style == "vu7") {
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick-1,depth-49.40,
                        case_z+vu7_height-15]) rotate([90-vu_rotation[0],180,0]) 
                            slab_r([((width-vesa)/2)+12,10,sidethick], [.1,.1,3,3]);
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick-1,depth-23.60,
                        case_z+22.5]) rotate([90-vu_rotation[0],180,0]) 
                            slab_r([((width-vesa)/2)+12,10,sidethick], [.1,.1,3,3]);
                    
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick,depth-52.25,
                        case_z+vu7_height-15.75]) rotate([90-vu_rotation[0],180,0]) 
                            difference() { 
                                cube([sidethick,10,sidethick]);
                                translate([0,-adjust,sidethick]) rotate([0,45,0]) 
                                    cube([2*sidethick,10+(2*adjust),sidethick]);
                            }
                    translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick,depth-26.5,
                        case_z+21.8]) rotate([90-vu_rotation[0],180,0])
                            difference() { 
                                cube([sidethick,10,sidethick]);
                                translate([0,-adjust,sidethick]) rotate([0,45,0]) 
                                    cube([2*sidethick,10+(2*adjust),sidethick]);
                            }
                }
                // top rail
                    translate([width-6.9-adjust,-gap,case_z-floorthick-.5])
                    cube([4,depth-2*(wallthick+gap),2]);
            }
            if(side == "left") {
                translate([-wallthick-gap-sidethick,-(2*wallthick)-gap,0]) 
                    cube([sidethick,depth+2*wallthick,cheight]);
                // left tabs for vu5 attachment
                if(case_style == "vu5") {
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adjust,depth-36.4,
                        case_z+70]) rotate([90+vu_rotation[0],0,0]) 
                            slab_r([((width-vesa)/2)+4,10, sidethick], [.1,.1,3,3]);
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adjust,depth-23.5,
                        case_z+22]) rotate([90+vu_rotation[0],0,0]) 
                            slab_r([((width-vesa)/2)+4,10,sidethick], [.1,.1,3,3]);
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adjust,depth-39.35+adjust,
                        case_z+69.25]) rotate([90+vu_rotation[0],0,0])
                            difference() { 
                                cube([sidethick,10,sidethick]);
                                translate([0,-adjust,sidethick]) rotate([0,45,0]) 
                                    cube([2*sidethick,10+(2*adjust),2*sidethick]);
                            }                
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-3.5-adjust,depth-26.4+adjust,
                        case_z+21.25]) rotate([90+vu_rotation[0],0,0])  
                        difference() { 
                            cube([sidethick,10,sidethick]);
                            translate([0,-adjust,sidethick]) rotate([0,45,0]) 
                                cube([2*sidethick,10+(2*adjust),2*sidethick]);
                        }
                }           
                // left tabs for vu7 attachment
                if(case_style == "vu7") {
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-4.25-adjust,depth-46.85,
                        case_z+vu7_height-24.5]) rotate([90+vu_rotation[0],0,0]) 
                            slab_r([((width-vesa)/2),10, sidethick], [.1,.1,3,3]);
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-4.25-adjust,depth-21,
                        case_z+13]) rotate([90+vu_rotation[0],0,0]) 
                            slab_r([((width-vesa)/2),10,sidethick], [.1,.1,3,3]);
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-4-adjust,depth-49.75+adjust,
                        case_z+vu7_height-25.25]) rotate([90+vu_rotation[0],0,0])
                            difference() { 
                                cube([sidethick,10,sidethick]);
                                translate([0,-adjust,sidethick]) rotate([0,45,0]) 
                                    cube([2*sidethick,10+(2*adjust),2*sidethick]);
                            }                
                    translate([-((width-vesa)/2)+(width/2)-(vesa/2)-4-adjust,depth-23.75+adjust,
                        case_z+12.25]) rotate([90+vu_rotation[0],0,0])  
                        difference() { 
                            cube([sidethick,10,sidethick]);
                            translate([0,-adjust,sidethick]) rotate([0,45,0]) 
                                cube([2*sidethick,10+(2*adjust),2*sidethick]);
                        }
                }
                // top rail
                translate([-wallthick-gap-adjust,-gap,case_z-floorthick-.5]) 
                        cube([4,depth-2*(wallthick+gap),2]);
            }
        }

        if(side == "right") {
            // vu5 shape and back cut
            if(case_style == "vu5") {
                translate([width+sidethick-2,-.6,case_z+sidethick+2.5]) 
                    rotate([0,-90,0]) 
                    linear_extrude(height = 2*sidethick) 
                        polygon(points = [ [-sidethick,-sidethick-wallthick-5],
                            [cheight-bottom_height-top_height-3,-sidethick-wallthick-5], 
                            [cheight-bottom_height-top_height-3,depth-53], 
                            [-sidethick,depth-33]]);
                
                translate([width-(sidethick/2),depth-8,case_z+(121/2)]) 
                    rotate([vu_rotation[0],0,0]) 
                        cube_fillet_inside([10,50,110],vertical=[v_fillet,v_fillet,v_fillet,v_fillet],
                            top=[0,0,0,0],bottom=[3,3,3,3], $fn=90);
                // tab holes
                translate([width/2+(vesa/2)-3,depth-37,
                    case_z+75]) rotate([90-vu_rotation[0],180,0]) cylinder(d=3, h=sidethick+1);
                translate([width/2+(vesa/2)-3,depth-24,
                    case_z+26.75]) rotate([90-vu_rotation[0],180,0]) cylinder(d=3, h=sidethick+1);
            }
            // vu7 shape and back cut
            if(case_style == "vu7") {
                translate([width+sidethick-2,-.6,case_z+sidethick+2.5]) 
                    rotate([0,-90,0]) 
                    linear_extrude(height = 2*sidethick) 
                        polygon(points = [ [-sidethick,-sidethick-wallthick-5],
                            [cheight-bottom_height-top_height-3,-sidethick-wallthick-5], 
                            [cheight-bottom_height-top_height-3,depth-63], 
                            [-sidethick,depth-33]]);
                
                translate([width-(sidethick/2),depth-10.5,case_z+70.5]) 
                    rotate([vu_rotation[0],0,0]) 
                        cube_fillet_inside([10,50,130],vertical=[v_fillet,v_fillet,v_fillet,v_fillet],
                            top=[0,0,0,0],bottom=[3,3,3,3], $fn=90);
                // tab holes
                translate([width/2+(vesa/2)-10,depth-47,case_z+vu7_height-19.75]) 
                    rotate([90-vu_rotation[0],180,0]) cylinder(d=3, h=sidethick+4);
                translate([width/2+(vesa/2)-10,depth-21.25,case_z+18]) 
                    rotate([90-vu_rotation[0],180,0]) cylinder(d=3, h=sidethick+4);
            }
            // bottom attachment holes                         
            translate([width-wallthick-gap-adjust-5,wallthick+gap+10,
                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adjust)+10);
            translate([width-wallthick-gap-adjust-5,depth-wallthick-gap-10,
                ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adjust)+10);
        }

        if(side == "left") {
            // vu5 shape and back cut
            if(case_style == "vu5") {
                translate([-sidethick-adjust,-.6,case_z+sidethick+2.5]) 
                    rotate([0,-90,0]) 
                        linear_extrude(height = 2*sidethick) 
                            polygon(points = [ [-sidethick,-sidethick-wallthick-5],
                                [cheight-bottom_height-top_height-3,-sidethick-wallthick-5], 
                                [cheight-bottom_height-top_height-3,depth-53], 
                                [-sidethick,depth-33]]);
                
                translate([-wallthick-gap-(sidethick/2),depth-8,case_z+(121/2)]) 
                    rotate([vu_rotation[0],0,0]) 
                        cube_fillet_inside([10,50,110],vertical=[v_fillet,v_fillet,v_fillet,v_fillet],
                            top=[0,0,0,0],bottom=[3,3,3,3], $fn=90);
                // tab holes
                translate([width/2-(vesa/2)-3,depth-36.75,case_z+75]) 
                    rotate([90+vu_rotation[0],0,0]) cylinder(d=3, h=sidethick+1);
                translate([width/2-(vesa/2)-3,depth-24.25,case_z+26.75]) 
                    rotate([90+vu_rotation[0],0,0])  cylinder(d=3, h=sidethick+1);
            }
            // vu7 shape and back cut
            if(case_style == "vu7") {
                translate([-sidethick-adjust,-.6,case_z+sidethick+2.5]) 
                    rotate([0,-90,0]) 
                        linear_extrude(height = 2*sidethick) 
                            polygon(points = [ [-sidethick,-sidethick-wallthick-5],
                                [cheight-bottom_height-top_height-3,-sidethick-wallthick-5], 
                                [cheight-bottom_height-top_height-3,depth-63], 
                                [-sidethick,depth-33]]);
                
                translate([-wallthick-gap-(sidethick/2),depth-10.5,case_z+70.5]) 
                    rotate([vu_rotation[0],0,0]) 
                        cube_fillet_inside([10,50,130],vertical=[v_fillet,v_fillet,v_fillet,v_fillet],
                            top=[0,0,0,0],bottom=[3,3,3,3], $fn=90);
                // tab holes
                translate([width/2-(vesa/2)-10,depth-48,case_z+vu7_height-19.75]) 
                    rotate([90+vu_rotation[0],0,0]) cylinder(d=3, h=sidethick+4);
                translate([width/2-(vesa/2)-10,depth-22.25,case_z+18]) 
                    rotate([90+vu_rotation[0],0,0])  cylinder(d=3, h=sidethick+4);
            }
            // bottom attachment holes
            translate([-sidethick-adjust-6,wallthick+gap+10,((bottom_height+floorthick)/2)-1]) 
                rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adjust)+10);
            if(depth >= 75) {
                translate([-sidethick-adjust-6,depth-wallthick-gap-10,
                    ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adjust)+10);
            }
            else {
                translate([-sidethick-adjust-6,wallthick+gap+40.5,((bottom_height+floorthick)/2)-1])
                    rotate([0,90,0]) cylinder(d=3, h=sidethick+(2*adjust)+10);                        
            }
        }
    }
}

module parametric_move_add(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4) {
    
    // absolute no parametrics
    if(parametric[1] == false && parametric[2] == false && parametric[3] == false) {        
        add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
    }
    // x axis accessory parametrics
    if(parametric[1] == true && parametric[2] == false && parametric[3] == false) {
        if(parametric[0] == "case") {
            add(type,loc_x+case_offset_x,loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            add(type,loc_x+pcb_loc_x,loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // y axis accessory parametrics
    if(parametric[1] == false && parametric[2] == true && parametric[3] == false) {
        if(parametric[0] == "case") {
            add(type,loc_x,loc_y+case_offset_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            add(type,loc_x,loc_y+pcb_loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // z axis accessory parametrics
    if(parametric[1] == false && parametric[2] == false && parametric[3] == true) {
        if(parametric[0] == "case" && face == "top") {
            add(type,loc_x,loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face == "bottom") {
            add(type,loc_x,loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face != "bottom" && face != "top") {
            add(type,loc_x,loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            add(type,loc_x,loc_y,loc_z+pcb_loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "top") {
            add(type,loc_x,loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "bottom") {
            add(type,loc_x,loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // xy axis accessory parametrics
    if(parametric[1] == true && parametric[2] == true && parametric[3] == false) {
        if(parametric[0] == "case") {
            add(type,loc_x+case_offset_x,loc_y+case_offset_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            add(type,loc_x+pcb_loc_x,loc_y+pcb_loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // xz axis accessory parametrics
    if(parametric[1] == true && parametric[2] == false && parametric[3] == true) {
        if(parametric[0] == "case" && face == "top") {
            add(type,loc_x+case_offset_x,loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face == "bottom") {
            add(type,loc_x+case_offset_x,loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face != "bottom" && face != "top") {
            add(type,loc_x+case_offset_x,loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            add(type,loc_x+pcb_loc_x,loc_y,loc_z+pcb_loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "top") {
            add(type,loc_x+pcb_loc_x,loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "bottom") {
            add(type,loc_x+pcb_loc_x,loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // yz axis accessory parametrics
    if(parametric[1] == false && parametric[2] == true && parametric[3] == true) {
        if(parametric[0] == "case" && face == "top") {
            add(type,loc_x,loc_y+case_offset_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face == "bottom") {
            add(type,loc_x,loc_y+case_offset_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face != "bottom" && face != "top") {
            add(type,loc_x,loc_y+case_offset_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            add(type,loc_x,loc_y+pcb_loc_y,loc_z+pcb_loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "top") {
            add(type,loc_x,loc_y+pcb_loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "bottom") {
            add(type,loc_x,loc_y+pcb_loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // xyz axis accessory parametrics
    if(parametric[1] == true && parametric[2] == true && parametric[3] == true) {
        if(parametric[0] == "case" && face == "top") {
            add(type,loc_x+case_offset_x,loc_y+case_offset_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face == "bottom") {
            add(type,loc_x+case_offset_x,loc_y+case_offset_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face != "bottom" && face != "top") {
            add(type,loc_x+case_offset_x,loc_y+case_offset_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            add(type,loc_x+pcb_loc_x,loc_y+pcb_loc_y,loc_z+pcb_loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "top") {
            add(type,loc_x+pcb_loc_x,loc_y+pcb_loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "bottom") {
            add(type,loc_x+pcb_loc_x,loc_y+pcb_loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
}



module parametric_move_sub(type,loc_x,loc_y,loc_z,face,rotation,parametric,
                            size_x,size_y,size_z,data_1,data_2,data_3,data_4) {
    
    // absolute no parametrics
    if(parametric[1] == false && parametric[2] == false && parametric[3] == false) {        
        sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
    }
    // x axis accessory parametrics
    if(parametric[1] == true && parametric[2] == false && parametric[3] == false) {
        if(parametric[0] == "case") {
            sub(type,loc_x+case_offset_x,loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            sub(type,loc_x+pcb_loc_x,loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // y axis accessory parametrics
    if(parametric[1] == false && parametric[2] == true && parametric[3] == false) {
        if(parametric[0] == "case") {
            sub(type,loc_x,loc_y+case_offset_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            sub(type,loc_x,loc_y+pcb_loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // z axis accessory parametrics
    if(parametric[1] == false && parametric[2] == false && parametric[3] == true) {
        if(parametric[0] == "case" && face == "top") {
            sub(type,loc_x,loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face == "bottom") {
            sub(type,loc_x,loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face != "bottom" && face != "top") {
            sub(type,loc_x,loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            sub(type,loc_x,loc_y,loc_z+pcb_loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "top") {
            sub(type,loc_x,loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "bottom") {
            sub(type,loc_x,loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // xy axis accessory parametrics
    if(parametric[1] == true && parametric[2] == true && parametric[3] == false) {
        if(parametric[0] == "case") {
            sub(type,loc_x+case_offset_x,loc_y+case_offset_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            sub(type,loc_x+pcb_loc_x,loc_y+pcb_loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // xz axis accessory parametrics
    if(parametric[1] == true && parametric[2] == false && parametric[3] == true) {
        if(parametric[0] == "case" && face == "top") {
            sub(type,loc_x+case_offset_x,loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face == "bottom") {
            sub(type,loc_x+case_offset_x,loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face != "bottom" && face != "top") {
            sub(type,loc_x+case_offset_x,loc_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            sub(type,loc_x+pcb_loc_x,loc_y,loc_z+pcb_loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "top") {
            sub(type,loc_x+pcb_loc_x,loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "bottom") {
            sub(type,loc_x+pcb_loc_x,loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // yz axis accessory parametrics
    if(parametric[1] == false && parametric[2] == true && parametric[3] == true) {
        if(parametric[0] == "case" && face == "top") {
            sub(type,loc_x,loc_y+case_offset_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face == "bottom") {
            sub(type,loc_x,loc_y+case_offset_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face != "bottom" && face != "top") {
            sub(type,loc_x,loc_y+case_offset_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            sub(type,loc_x,loc_y+pcb_loc_y,loc_z+pcb_loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "top") {
            sub(type,loc_x,loc_y+pcb_loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "bottom") {
            sub(type,loc_x,loc_y+pcb_loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
    // xyz axis accessory parametrics
    if(parametric[1] == true && parametric[2] == true && parametric[3] == true) {
        if(parametric[0] == "case" && face == "top") {
            sub(type,loc_x+case_offset_x,loc_y+case_offset_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face == "bottom") {
            sub(type,loc_x+case_offset_x,loc_y+case_offset_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "case" && face != "bottom" && face != "top") {
            sub(type,loc_x+case_offset_x,loc_y+case_offset_y,loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc") {
            sub(type,loc_x+pcb_loc_x,loc_y+pcb_loc_y,loc_z+pcb_loc_z,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "top") {
            sub(type,loc_x+pcb_loc_x,loc_y+pcb_loc_y,loc_z+case_offset_tz+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if(parametric[0] == "sbc-case_z" && face == "bottom") {
            sub(type,loc_x+pcb_loc_x,loc_y+pcb_loc_y,loc_z+case_offset_bz,
                face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
    }
}


/* indent module */
module indent(loc_x,loc_y,loc_z,rotation,side,class,type,wallthick,gap,floorthick,pcb_z) {
    
    adjust = .01;
    $fn=90;
    
    // hdmi indent
    if(class == "video" && type == "hdmi_a" && side == "top" && rotation == 0) {
        place(loc_x+2.375,-(wallthick+gap)+wallthick/2,loc_z+3.75,12,10,rotation,side) 
             rotate([90,0,0]) slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "top" && rotation == 90) {
        place(-gap-wallthick/2,loc_y,loc_z+3.75,12,10,rotation,side)
             rotate([90,0,0]) slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "top" && rotation == 180) {
        place(loc_x,depth-(wallthick+gap)-10-wallthick/2,loc_z+3.75,12,10,rotation,side)
             rotate([90,0,0]) slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "top" && rotation == 270) {
        place(width-(wallthick+gap)-10-wallthick/2,loc_y+2.375,loc_z+3.75,12,10,rotation,side)
             rotate([90,0,0]) slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "bottom" && rotation == 0) {
        place(loc_x,-(wallthick+gap)+wallthick/2,loc_z-pcb_z-3.75,12,10,rotation,side)
             rotate([90,0,0]) slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "bottom" && rotation == 90) {
        place(width-(wallthick+gap)-10-wallthick/2,loc_y,loc_z-5.25,12,10,rotation,side)
             rotate([90,0,0]) slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "bottom" && rotation == 180) {
        place(loc_x+2.375,depth-(wallthick+gap)-10-wallthick/2,loc_z-pcb_z-3.75,12,10,rotation,side)
             rotate([90,0,0]) slot(12,10,wallthick);
    }
    if(class == "video" && type == "hdmi_a" && side == "bottom" && rotation == 270) {
        place(-gap-wallthick/2,loc_y+1.75,loc_z-pcb_z-3.75,12,10,rotation,side)
             rotate([90,0,0]) slot(12,10,wallthick);
    }
    // hdmi micro indent
    if(class == "video" && type == "hdmi_micro" && rotation == 0 && side == "top") {
        place(loc_x-.5,-(wallthick+gap)+wallthick/2,loc_z+1.5,6,8,rotation,side) 
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y+1.5,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 180 && side == "top") {
        place(loc_x+1,depth-(wallthick+gap)-8-wallthick/2,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y-.75,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 0 && side == "bottom") {
        place(loc_x+1.5,-(wallthick+gap)+wallthick/2,loc_z-3,6,8,rotation,side) 
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 90 && side == "bottom") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+1.25,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);

    }
    if(class == "video" && type == "hdmi_micro" && rotation == 180 && side == "bottom") {
        place(loc_x-1,depth-(wallthick+gap)-8-wallthick/2,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_micro" && rotation == 270 && side == "bottom") {
        place(-gap-wallthick/2,loc_y-.5,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    // hdmi mini indent
    if(class == "video" && type == "hdmi_mini" && rotation == 0 && side == "top") {
        place(loc_x+.5,loc_y-gap-wallthick/2+1,loc_z+1.5,6,10,rotation,side) 
            rotate([90,0,0]) slot(6,10,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 90 && side == "top") {
        place(loc_x-wallthick/2,loc_y+3.5,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);

    }
    if(class == "video" && type == "hdmi_mini" && rotation == 180 && side == "top") {
        place(loc_x+4.5,loc_y-wallthick/2,loc_z+1.5,6,10,rotation,side)
            rotate([90,0,0]) slot(6,10,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 270 && side == "top") {
        place(loc_x+wallthick/2,loc_y+1.5,loc_z+1.5,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 0 && side == "bottom") {
        place(loc_x+4.5,loc_y-gap-wallthick/2+1,loc_z-3,6,10,rotation,side) 
            rotate([90,0,0]) slot(6,10,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 90 && side == "bottom") {
        place(loc_x+wallthick/2,loc_y+3.5,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);

    }
    if(class == "video" && type == "hdmi_mini" && rotation == 180 && side == "bottom") {
        place(loc_x+.5,loc_y-wallthick/2,loc_z-3,6,10,rotation,side)
            rotate([90,0,0]) slot(6,10,wallthick);
    }
    if(class == "video" && type == "hdmi_mini" && rotation == 270 && side == "bottom") {
        place(loc_x-wallthick/2,loc_y+1.5,loc_z-3,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    // power plug indent
    if(type == "pwr5.5_7.5x11.5" && rotation == 0 && side == "top") {
        place(loc_x+3.75,-(wallthick+gap)+wallthick/2,loc_z+6.25,10,10,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(type == "pwr5.5_7.5x11.5" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y-6.25,loc_z+6.25,10,10,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(type == "pwr5.5_7.5x11.5" && rotation == 180 && side == "top") {
        place(loc_x-6.5,depth-10-(wallthick+gap)-wallthick/2,loc_z+6.25,10,10,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(type == "pwr5.5_7.5x11.5" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-10-wallthick/2,loc_y+3.75,loc_z+6.25,10,10,rotation,side) 
            rotate([90,0,0]) cylinder(d=10, h=wallthick);
    }
    if(type == "pwr2.5_5x7.5" && rotation == 0 && side == "top") {
        place(loc_x+2.75,-(wallthick+gap)+wallthick/2,loc_z+2.1,7,7,rotation,side) 
            rotate([90,0,0]) cylinder(d=7, h=wallthick);
    }
    if(type == "pwr2.5_5x7.5" && rotation == 90 && side == "top") {
        place(-(wallthick+gap)+wallthick/2,loc_y-4.5,loc_z+2,7,7,rotation,side) 
            rotate([90,0,0]) cylinder(d=7, h=wallthick);
    }
    if(type == "pwr2.5_5x7.5" && rotation == 180 && side == "top") {
        place(loc_x-4.5,depth-(wallthick+gap)-7-wallthick/2,loc_z+2,7,7,rotation,side) 
            rotate([90,0,0]) cylinder(d=7, h=wallthick);
    }
    if(type == "pwr2.5_5x7.5" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-7-wallthick/2,loc_y+2.5,loc_z+2,7,7,rotation,side) 
            rotate([90,0,0]) cylinder(d=7, h=wallthick);
    }
    // micro usb indent
    if(class == "usb2" && type == "micro" && rotation == 0 && side == "top") {
        place(loc_x-.5,-(wallthick+gap)+wallthick/2,loc_z+1.9,6,8,rotation,side) 
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y+1.5,loc_z+1.9,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);

    }
    if(class == "usb2" && type == "micro" && rotation == 180 && side == "top") {
        place(loc_x+1.5,depth-(wallthick+gap)-8-wallthick/2,loc_z+1.9,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y-.5,loc_z+1.9,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 0 && side == "bottom") {
        place(loc_x+1.5,-(wallthick+gap)+wallthick/2,loc_z-3.25,6,8,rotation,side) 
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 90 && side == "bottom") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+1.5,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);

    }
    if(class == "usb2" && type == "micro" && rotation == 180 && side == "bottom") {
        place(loc_x-.5,depth-(wallthick+gap)-8-wallthick/2,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usb2" && type == "micro" && rotation == 270 && side == "bottom") {
        place(-gap-wallthick/2,loc_y-.5,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    // single horizontal usbc indent
    if(class == "usbc" && type == "single_horizontal" && rotation == 0 && side == "top") {
        place(loc_x+.5,-(wallthick+gap)+wallthick/2,loc_z+1.75,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y+2.5,loc_z+1.75,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 180 && side == "top") {
        place(loc_x+2.5,depth-(wallthick+gap)-8-wallthick/2,loc_z+2,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+.5,loc_z+1.75,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 0 && side == "bottom") {
        place(loc_x+2.75,-(wallthick+gap)+wallthick/2,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 90 && side == "bottom") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+2.5,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick-(wallthick+gap)+wallthick/2);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 180 && side == "bottom") {
        place(loc_x+.5,depth-(wallthick+gap)-8-wallthick/2,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    if(class == "usbc" && type == "single_horizontal" && rotation == 270 && side == "bottom") {
        place(-gap-wallthick/2,loc_y+.5,loc_z-3.25,6,8,rotation,side)
            rotate([90,0,0]) slot(6,8,wallthick);
    }
    // audio jack indent
    if(class == "audio" && type == "jack_3.5" && rotation == 0 && side == "top") {
        place(loc_x+3.15,-(wallthick+gap)+wallthick/2,loc_z+2,8,8,rotation,side) 
            rotate([90,0,0]) cylinder(d=8, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 90 && side == "top") {
        place(-gap-wallthick/2,loc_y-4.6,loc_z+2,8,8,rotation,side)
            rotate([90,0,0]) cylinder(d=8, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 180 && side == "top") {
        place(loc_x-4.6,depth-(wallthick+gap)-8-wallthick/2,loc_z+2,8,8,rotation,side) 
            rotate([90,0,0]) cylinder(d=8, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 270 && side == "top") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y+3.15,loc_z+2,8,8,rotation,side)
            rotate([90,0,0]) cylinder(d=8, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 0 && side == "bottom") {
        place(loc_x-4.6,-(wallthick+gap)+wallthick/2,loc_z-3.5,8,8,rotation,side) 
            rotate([90,0,0]) cylinder(d=8, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 90 && side == "bottom") {
        place(width-(wallthick+gap)-8-wallthick/2,loc_y-4.6,loc_z-3.5,8,8,rotation,side)
            rotate([90,0,0]) cylinder(d=8, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 180 && side == "bottom") {
        place(loc_x+3.15,depth-(wallthick+gap)-8-wallthick/2,loc_z-3.5,8,8,rotation,side) 
            rotate([90,0,0]) cylinder(d=8, h=wallthick);
    }
    if(class == "audio" && type == "jack_3.5" && rotation == 270 && side == "bottom") {
        place(-gap-wallthick/2,loc_y+3.15,loc_z-3.5,8,8,rotation,side)
            rotate([90,0,0]) cylinder(d=8, h=wallthick);
    }
}
