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
    
    see https://github.com/hominoids/SBC_Case_Builder
*/

use <./SBC_Model_Framework_v2/sbc_models.scad>;
include <./sbc_case_builder_library.scad>;
include <./SBC_Model_Framework_v2/sbc_models.cfg>;
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

/* [adjustments] */
// base case design
case_design = "shell"; // [shell,panel,stacked,tray,round,hex,snap,fitted]
// base case style
case_style = "none"; // ["none","vu5","vu7","sides"]
// single board computer model
sbc_model = "c1+"; //  ["c1+", "c2", "c4", "hc4", "xu4", "xu4q", "mc1", "hc1", "n1", "n2", "n2+", "n2l", "n2lq", "m1", "m1s", "h2", "h2+", "h3", "h3+", "show2", "rpipico", "rpipicow", "rpicm4+ioboard", "rpicm1", "rpicm3", "rpicm3l", "rpicm3+", "rpicm4s", "rpicm4", "rpicm4l", "rpizero", "rpizerow", "rpizero2w", "rpi1a+", "rpi1b+", "rpi2b", "rpi3a+", "rpi3b", "rpi3b+", "rpi4b", "rpi5", "rock64", "rockpro64", "quartz64a", "quartz64b", "h64b", "star64", "rock4a", "rock4b", "rock4a+", "rock4b+", "rock4c", "rock4c+", "rock5b-v1.3", "rock5b", "rock5bq", "vim1", "vim2", "vim3", "vim3l", "vim4", "tinkerboard", "tinkerboard-s", "tinkerboard-2", "tinkerboard-2s", "tinkerboard-r2", "tinkerboard-r2s", "opizero", "opizero2", "opir1plus_lts", "opir1", "opi5", "jetsonnano", "lepotato", "sweetpotato", "tritium-h2+", "tritium-h3", "tritium-h5", "solitude", "alta", "atomicpi", "visionfive2", "licheerv+dock", "rak19007"]
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
floorthick = 2; //[1:.25:5]
// case side thickness
sidethick = 2; //[1:.5:5]
// distance between pcb and case
gap = 1; //[.5:.25:5]
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
// enable sata knockout
sata_knockout = false;
// gpio opening
gpio_opening = "default"; // [default,none,open,block,knockout,vent]
// heatsink opening
cooling = "default"; // [default,none,open,fan_open,fan_1,fan_2,fan_hex]
fan_size = 0; // [0,30,40,50,60,70,80,92]
// exhaust vent
exhaust_vents = "vent"; // [none,vent]
// uart opening
uart_opening = "default"; // [default,none,open,knockout]

// case accessory group to load
accessory_name = "none"; // ["none", "hk_uart", "c1+_shell_boombox", "c1+_panel_boombox", "c1+_panel_lcd3.5", "c1+_desktop_lcd3.5", "c1+_deskboom_lcd3.5", "c1+_tray_boombox", "c1+_round", "c1+_hex", "c2_shell_boombox", "c2_panel_boombox", "c2_panel_lcd3.5", "c2_desktop_lcd3.5", "c2_deskboom_lcd3.5", "c2_tray_boombox", "c2_round", "c2_hex", "c4_shell_boombox", "c4_panel_lcd3.5", "c4_desktop_lcd3.5", "c4_deskboom_lcd3.5", "c4_panel_boombox", "c4_tray_boombox", "c4_round", "c4_hex", "xu4_keyhole", "hc4_tray_drivebox2.5", "hc4_shell_drivebox2.5", "hc4_shell_drivebox2.5v", "hc4_shell_drivebox3.5", "n2l_tray", "n2l_gpio", "n2+_tray_vu7_fan", "m1s_shell", "m1s_shell_nvme", "m1s_shell_ups", "m1s_panel", "m1s_tray_nvme", "m1s_snap", "m1s_fitted", "m1_panel", "m1_tray", "m1_tray_ssd", "m1_tray_sides", "m1_tray_vu5", "m1_tray_vu7", "m1_fitted_drivebox2.5", "m1_fitted_drivebox3.5", "m1_fitted_pizzabox", "m1_fitted_drivebox3.5v", "h2_shell", "h2_shell_router", "h2_shell_router-ssd", "h2_lowboy", "h2_lowboy_router", "h2_tray", "h2_tray_sides", "h2_tray_router", "h2_router_station", "h2_round", "h2_hex", "h3_shell", "h3_lowboy", "h3_lowboy_router", "h3_tallboy", "h3_tallboy-ssd", "h3_ultimate", "h3_ultimate2", "h3_shell_drivebox2.5v", "jetsonnano_shell", "jetsonnano_panel", "jetsonnano_stacked", "jetsonnano_tray", "jetsonnano_tray_sides", "jetsonnano_round", "jetsonnano_hex", "jetsonnano_snap", "jetsonnano_fitted", "rock64_round", "rock64_hex", "rockpro64_shell", "rockpro64_panel", "rockpro64_stacked", "rockpro64_tray", "rockpro64_tray_sides", "rockpro64_round", "rockpro64_hex", "rockpro64_snap", "rockpro64_fitted", "star64_shell", "show2_shell", "rpi1b+_round", "rpi1b+_hex", "rpi3b_round", "rpi3b_hex", "rpi3b+_round", "rpi3b+_hex", "rpi4b_round", "rpi4b_hex", "rpi4b_shell_geeekpi_poe_hat", "rpi5_round", "rpi5_hex", "rock4b+_round", "rock4b+_hex", "rock4c_round", "rock4c_hex", "rock4c+_round", "rock4c+_hex", "rock5b", "rock5b_shell", "rock5bq", "rock5bq_shell", "rock5bq_tray", "rock5bq_tray_sides", "rock5bq_snap", "rock5bq_fitted", "rock5b-v1.3", "tinkerboard_round", "tinkerboard_hex", "tinkerboard-s_round", "tinkerboard-s_hex", "tinkerboard-2_round", "tinkerboard-2_hex", "tinkerboard-r2_round", "tinkerboard-r2_hex", "visonfive2_shell", "visonfive2_panel", "visonfive2_stacked", "visonfive2_tray", "visonfive2_snap", "visonfive2_fitted", "visonfive2q_shell", "visonfive2q_panel", "visonfive2q_stacked", "visonfive2q_tray", "visonfive2q_snap", "visonfive2q_fitted"]

a = search([accessory_name],accessory_data);
s = search([sbc_model],sbc_data);

pcb_id = sbc_data[s[0]][4];
pcb_width = sbc_data[s[0]][10][0];
pcb_depth = sbc_data[s[0]][10][1];
pcb_z = sbc_data[s[0]][10][2];
pcb_tmaxz = sbc_data[s[0]][11][5];
pcb_bmaxz = sbc_data[s[0]][11][6];
pcb_color = sbc_data[s[0]][11][1];
pcb_radius = sbc_data[s[0]][11][0];

width = pcb_width+2*(wallthick+gap)+case_offset_x;
depth = pcb_depth+2*(wallthick+gap)+case_offset_y;
top_height = pcb_tmaxz+floorthick+case_offset_tz;
bottom_height = pcb_bmaxz+floorthick+case_offset_bz;
case_z = bottom_height+top_height;
case_diameter = sqrt(pow(width-wallthick-gap,2)+pow(depth-wallthick-gap,2));
hex_diameter = sqrt(pow(width+2*(wallthick+gap),2)+pow(depth+2*(wallthick+gap),2));


/* [Hidden] */
adj = .01;
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
                        translate([width-gap-(2*wallthick)-adj,-gap-wallthick-1,-lower_bottom]) 
                            cube([gap+wallthick,depth+2,case_z+2]);
                    }
                }
            }
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
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
                        translate([width-gap-(2*wallthick)-adj,-gap-wallthick-1,raise_top]) 
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
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
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
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
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
                translate([pcb_loc_x,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
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
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
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
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
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