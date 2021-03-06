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

    20220202 Version 1.0.0    sbc case builder using sbc model framework
    20220206 Version 1.0.1    added tray-vu7 case style, other fixes
    20220212 Version 1.1.0    implemented sbc_case_builder.cfg config file,
                              sbc_case_builder_library.scad and basic accessory framework.
                              adjusted tray-vu7 tabs, adjusted tray-vu7 model alignment
                              minor fixes and other maintenance.
    20220220 Version 1.1.1    added .cfg commands add1,add2,model,platter
                              schema changes, extended standoff fixes, hd mounting acc.
                              acc. placement and other minor fixes, added raise_top setting
    20220227 Version 1.1.2    added sbc_off setting, fixed hdmi bottom placement
                              schema change, extended standoff detection, hd vertical mount, oled holder
                              access port, access cover, case feet and other fixes
    20220306 Version 1.1.3    added netcard, buttons, parametric access_port, other fixes and maintenance
    20220312 Version 1.2.0    added fillet array, button cutout style, hk_lcd35, other fixes and maintenance
    20220320 Version 1.2.1    added hk_boom bonnet model and accessories, hk_uart model, fixed uart opening,
                              enabled pcb_z, added tabs and fixed tray case top, other fixes and maintenance
    20220406 Version 1.2.2    added vu7c, vu8m and weatherboard2 models, other additions, fixes and maintenance    
    20220515 Version 1.2.3    added odroid-m1, jetson nano, rockpro64, completed mask(), improved docs
                              changed tray top design
                              
    see https://github.com/hominoids/SBC_Case_Builder
*/

use <./SBC_Model_Framework/sbc_models.scad>;
use <./sbc_case_builder_library.scad>;
use <./lib/fillets.scad>;
include <./SBC_Model_Framework/sbc_models.cfg>;
include <./sbc_case_builder.cfg>;

/* [Board and View] */
// case_name to load from sbc_case_builder.cfg
case_name = "rpi3b+_stacked"; // [c1+_shell,c1+_shell_boombox,c1+_panel,c1+_panel_boombox,c1+_panel_lcd3.5,c1+_desktop_lcd3.5,c1+_stacked,c1+_tray,c1+_tray_sides,c1+_tray_boombox,c1+_tray_vu5,c1+_tray_vu7,c2_shell,c2_shell_boombox,c2_panel,c2_panel_boombox,c2_panel_lcd3.5,c2_desktop_lcd3.5,c2_deskboom_lcd3.5,c2_stacked,c2_tray,c2_tray_sides,c2_tray_boombox,c2_tray_vu5,c2_tray_vu7,c4_shell,c4_shell_boombox,c4_shell_vu7c,c4_panel,c4_panel_lcd3.5,c4_desktop_lcd3.5,c4_deskboom_lcd3.5,c4_panel_boombox,c4_stacked,c4_tray,c4_tray_sides,c4_tray_boombox,c4_tray_vu5,c4_tray_vu7,xu4_shell,xu4_panel,xu4_stacked,xu4_tray,xu4_tray_sides,xu4_tray_vu5,xu4_tray_vu7,xu4q_shell,xu4q_panel,xu4q_stacked,xu4q_tray,xu4q_tray_sides,xu4q_tray_vu5,xu4q_tray_vu7,n1_shell,n1_panel,n1_stacked,n1_tray,n1_tray_sides,n1_tray_vu5,n1_tray_vu7,n2_panel,n2_tray,n2_tray_sides,n2_tray_vu5,n2_tray_vu7,n2+_panel,n2+_tray,n2+_tray_sides,n2+_tray_vu5,n2+_tray_vu7,n2+_tray_vu7_fan,m1_panel,m1_tray,m1_tray_drive,m1_tray_sides,m1_tray_vu5,m1_tray_vu7,h2_shell,h2_panel,h2_stacked,h2_tray,h2_tray_sides,h2_tray_vu5,h2_tray_vu7,h2_tray_router,h2_router_station,h2_lowboy,h2_lowboy_router,h2_shell_router,h2_shell_router-ssd,hc4_shell,hc4_panel,hc4_stacked,hc4_tray,hc4_tray_sides,hc4_tray_vu5,hc4_tray_vu7,hc4_tray_drivebox2.5,hc4_shell_drivebox2.5,hc4_shell_drivebox2.5v,hc4_shell_drivebox3.5,jetsonnano_shell,jetsonnano_panel,jetsonnano_stacked,jetsonnano_tray,jetsonnano_tray_sides,rockpro64_shell,rockpro64_panel,rockpro64_stacked,rockpro64_tray,rockpro64_tray_sides,show2_shell,rpi3b+_shell,rpi3b+_panel,rpi3b+_stacked,rpi3b+_tray,test]
// viewing mode "platter", "model", "debug"
view = "platter"; // [platter, model, debug]

/* [Adjustments] */
// enable highlight for subtarctive geometry (true or false)
highlight = false;
// sbc off in model view (true or false)
sbc_off = false;
// raises top mm in model view or < 0 = off
raise_top = 0;
// lowers bottom mm in model view or < 0 = off
lower_bottom = 0;
// move left side mm in model view or < 0 = off
move_leftside = 0;
// move right side mm in model view or < 0 = off
move_rightside = 0;
// move front mm in model view or < 0 = off
move_front = 0;
// move rear mm in model view or < 0 = off
move_rear = 0;

c = search([case_name],case_data);

case_design = case_data[c[0]][2];                   // "shell", "panel", "stacked", "tray"
case_style = case_data[c[0]][3];                    // style of case_design

sbc_model = case_data[c[0]][1];                     // any sbc from sbc model framework: "c1+","c2","c4","hc4"
                                                    // "xu4","xu4q","mc1","hc1","n1","n2","n2+","h2"
pcb_loc_x = case_data[c[0]][4];                     // sbc location x axis
pcb_loc_y = case_data[c[0]][5];                     // sbc location y axis
pcb_loc_z = case_data[c[0]][6];                     // sbc location z axis
case_offset_x = case_data[c[0]][7];                 // additional case x axis size
case_offset_y = case_data[c[0]][8];                 // additional case y axis size
case_offset_tz = case_data[c[0]][9];                // additional case top z axis size
case_offset_bz = case_data[c[0]][10];               // additional case bottom z axis size
wallthick = case_data[c[0]][11];                    // case wall thickness
floorthick = case_data[c[0]][12];                   // case floor thickness
sidethick = case_data[c[0]][13];                    // case side thickness
gap = case_data[c[0]][14];                          // distance between pcb and case
c_fillet = case_data[c[0]][15][0];                  // corner fillets
fillet = case_data[c[0]][15][1];                    // edge fillets
indents = case_data[c[0]][16];                      // enable indentations around io openings
sidewall_support = case_data[c[0]][17];             // enable wall support for standoffs
sbc_top_standoffs = case_data[c[0]][18];            // enable sbc top standoffs
sbc_bottom_standoffs = case_data[c[0]][19];         // enable sbc bottom standoffs
case_ext_standoffs = case_data[c[0]][20];           // enable case extended standoffs
sata_punchout = case_data[c[0]][21];                // enable sata punchout
gpio_opening = case_data[c[0]][22];                 // gpio openings "none","vent","open","punchout"
cooling = case_data[c[0]][23];                      // "none", "vents", "fan", "custom" using ./dxf/customfan.dxf
exhaust_vents = case_data[c[0]][24];                // exhaust vents "none","vent"
mode = case_data[c[0]][25];                         // special mode: "net_card"
vu_rotation = [15,0,0];

s = search([sbc_model],sbc_data);

pcb_width = sbc_data[s[0]][1];
pcb_depth = sbc_data[s[0]][2];
pcb_z = sbc_data[s[0]][3];
pcb_tmaxz = sbc_data[s[0]][5];
pcb_bmaxz = sbc_data[s[0]][6];

//c_fillet = sbc_data[s[0]][4];                   // corner fillets

width = pcb_width+(2*(wallthick+gap))+case_offset_x;
depth = pcb_depth+(2*(wallthick+gap))+case_offset_y;
top_height = pcb_tmaxz+floorthick+case_offset_tz;
bottom_height = pcb_bmaxz+floorthick+case_offset_bz;
case_z = bottom_height+top_height;

top_standoff =    [case_data[c[0]][26][0],      // diameter
                   top_height-pcb_loc_z,        // height top_height
                   case_data[c[0]][26][2],      // holesize
                   case_data[c[0]][26][3],      // supportsize
                   case_data[c[0]][26][4],      // supportheight
                   case_data[c[0]][26][5],      // 0=none, 1=countersink, 2=recessed hole, 3=nut holder, 4=blind hole
                   case_data[c[0]][26][6],      // standoff style 0=hex, 1=cylinder
                   case_data[c[0]][26][7],      // enable reverse standoff
                   case_data[c[0]][26][8],      // enable insert at top of standoff
                   case_data[c[0]][26][9],      // insert hole dia. mm
                   case_data[c[0]][26][10]];    // insert depth mm

bottom_standoff = [case_data[c[0]][27][0],      // diameter
                   bottom_height+pcb_loc_z-pcb_z, // height  bottom_height-pcb_z
                   case_data[c[0]][27][2],      // holesize
                   case_data[c[0]][27][3],      // supportsize
                   case_data[c[0]][27][4],      // supportheight
                   case_data[c[0]][27][5],      // 0=none, 1=countersink, 2=recessed hole, 3=nut holder, 4=blind hole
                   case_data[c[0]][27][6],      // standoff style 0=hex, 1=cylinder
                   case_data[c[0]][27][7],      // enable reverse standoff
                   case_data[c[0]][27][8],      // enable insert at top of standoff
                   case_data[c[0]][27][9],      // insert hole dia. mm
                   case_data[c[0]][27][10]];    // insert depth mm
top_ext_standoff =    [case_data[c[0]][28][0],  // radius
                   top_height,                  // height top_height
                   case_data[c[0]][28][2],      // holesize
                   case_data[c[0]][28][3],      // supportsize
                   case_data[c[0]][28][4],      // supportheight
                   case_data[c[0]][28][5],      // 0=none, 1=countersink, 2=recessed hole, 3=nut holder, 4=blind hole
                   case_data[c[0]][28][6],      // standoff style 0=hex, 1=cylinder
                   case_data[c[0]][28][7],      // enable reverse standoff
                   case_data[c[0]][28][8],      // enable insert at top of standoff
                   case_data[c[0]][28][9],      // insert hole dia. mm
                   case_data[c[0]][28][10]];    // insert depth mm

bottom_ext_standoff = [case_data[c[0]][29][0],  // diameter
                   bottom_height,               // height  bottom_height-pcb_z
                   case_data[c[0]][29][2],      // holesize
                   case_data[c[0]][29][3],      // supportsize
                   case_data[c[0]][29][4],      // supportheight
                   case_data[c[0]][29][5],      // 0=none, 1=countersink, 2=recessed hole, 3=nut holder, 4=blind hole
                   case_data[c[0]][29][6],      // standoff style 0=hex, 1=cylinder
                   case_data[c[0]][29][7],      // enable reverse standoff
                   case_data[c[0]][29][8],      // enable insert at top of standoff
                   case_data[c[0]][29][9],      // insert hole dia. mm
                   case_data[c[0]][29][10]];    // insert depth mm

/* [Hidden] */
adjust = .01;
$fn=90;

// platter view
if (view == "platter") {
    if(case_design == "shell") {
        case_bottom(case_design);
        translate([0,(2*depth)+20,case_z]) rotate([180,0,0]) case_top(case_design);
    }
    if(case_design == "panel") {
        case_bottom(case_design);
        translate([0,(2*depth)+5,bottom_height+top_height]) rotate([180,0,0]) case_top(case_design);
        translate([width+25,0,-gap]) rotate([-90,0,0]) case_side(case_design,case_style,"rear");
        translate([width+25,2*(bottom_height+top_height)+10,-depth+wallthick+gap+floorthick]) 
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
    // platter accessories
    for (i=[30:14:len(case_data[c[0]])-1]) {
        class = case_data[c[0]][i];
        type = case_data[c[0]][i+1];
        loc_x = case_data[c[0]][i+2];
        loc_y = case_data[c[0]][i+3];
        loc_z = case_data[c[0]][i+4];
        face = case_data[c[0]][i+5];
        rotation = case_data[c[0]][i+6];
        size_x = case_data[c[0]][i+7];
        size_y = case_data[c[0]][i+8];
        size_z = case_data[c[0]][i+9];
        data_1 = case_data[c[0]][i+10];
        data_2 = case_data[c[0]][i+11];
        data_3 = case_data[c[0]][i+12];
        data_4 = case_data[c[0]][i+13];
        
        if (class == "platter" && type != "button_top") {
            add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        if (class == "platter" && type == "button_top") {
            translate([loc_x,loc_y,loc_z+1.25]) rotate([-90,0,0]) button_plunger(data_3, size_x, size_z);
            translate([loc_x-20,loc_y-10,loc_z+3]) rotate([0,0,0]) button_top(data_3, size_x, size_z);
            translate([loc_x-20,loc_y-20,loc_z]) rotate([0,0,0]) button_clip(data_3);
        }
    }  
}

// model view
if (view == "model") {
//    translate([-width/2,-depth/2,0]) rotate([0,0,0]){
    if(case_design == "shell") {
        if(lower_bottom >= 0) {
            color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
        }
        if(sbc_off == false) {
            translate([pcb_loc_x ,pcb_loc_y,bottom_standoff[1]]) sbc(sbc_model);
        }
        if(raise_top >= 0) {
            color("grey",1) translate([0,0,raise_top]) case_top(case_design);
        }
    }
    if(case_design == "panel") {
        if(lower_bottom >= 0) {
            color("grey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
        }
        if(sbc_off == false) {
            translate([pcb_loc_x ,pcb_loc_y,bottom_standoff[1]]) sbc(sbc_model);
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
            translate([pcb_loc_x ,pcb_loc_y,bottom_standoff[1]]) sbc(sbc_model);
        }
        if(raise_top >= 0) {
            color("grey",1) translate([0,0,raise_top]) case_top(case_design);
        }
    }
    if(case_design == "tray") {
        if(lower_bottom >= 0) {
            color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
        }
        if(sbc_off == false) {
            translate([pcb_loc_x,pcb_loc_y,bottom_height-pcb_z]) sbc(sbc_model);
        }
        if(raise_top >= 0) {
            color("grey",1) translate([0,0,raise_top]) case_top(case_design);
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
    // model accessories
    for (i=[30:14:len(case_data[c[0]])-1]) {
        class = case_data[c[0]][i];
        type = case_data[c[0]][i+1];
        loc_x = case_data[c[0]][i+2];
        loc_y = case_data[c[0]][i+3];
        loc_z = case_data[c[0]][i+4];
        face = case_data[c[0]][i+5];
        rotation = case_data[c[0]][i+6];
        size_x = case_data[c[0]][i+7];
        size_y = case_data[c[0]][i+8];
        size_z = case_data[c[0]][i+9];
        data_1 = case_data[c[0]][i+10];
        data_2 = case_data[c[0]][i+11];
        data_3 = case_data[c[0]][i+12];
        data_4 = case_data[c[0]][i+13];
        
        if (class == "model" && face == "top" && raise_top > -1) {
            add(type,loc_x,loc_y,loc_z+raise_top,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
        }
        else {
            if (class == "model"&& face != "top" ) {
                add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
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
//}

// debug
if (view == "debug") {
    case_top(case_design);
//    case_bottom(case_design);
//    case_side(case_design,case_style,"rear");
//    case_side(case_design,case_style,"front");
//    case_side(case_design,case_style,"left");
//    case_side(case_design,case_style,"right");
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
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,bottom_height/2]) 
                                cube_fillet_inside([width,depth,bottom_height], 
                                    vertical=[0,0,0,0], top=[0,0,0,0], 
                                        bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
                            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,
                                (bottom_height/2)+floorthick]) 
                                    cube_fillet_inside([width-(wallthick*2),depth-(wallthick*2),bottom_height], 
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
                    // additive accessories
                    for (i=[30:14:len(case_data[c[0]])-1]) {
                        class = case_data[c[0]][i];
                        type = case_data[c[0]][i+1];
                        loc_x = case_data[c[0]][i+2];
                        loc_y = case_data[c[0]][i+3];
                        loc_z = case_data[c[0]][i+4];
                        face = case_data[c[0]][i+5];
                        rotation = case_data[c[0]][i+6];
                        size_x = case_data[c[0]][i+7];
                        size_y = case_data[c[0]][i+8];
                        size_z = case_data[c[0]][i+9];
                        data_1 = case_data[c[0]][i+10];
                        data_2 = case_data[c[0]][i+11];
                        data_3 = case_data[c[0]][i+12];
                        data_4 = case_data[c[0]][i+13];
                        
                        if (class == "add1" && face == "bottom") {
                            add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                        }
                    }
                }
                // side attachment holes
                if(case_design == "tray") {
                    // right side bottom attachment holes          
                    translate([width-2*(wallthick+gap)-sidethick-adjust,wallthick+gap+10,
                        ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adjust));
                    if(depth >= 75) {
                        translate([width-2*(wallthick+gap)-sidethick-adjust,depth-wallthick-gap-10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adjust));
                    }
                    else {
                        translate([width-2*(wallthick+gap)-sidethick-adjust,wallthick+gap+40,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adjust));
                    }

                    // left side bottom attachment holes
                    translate([-wallthick-gap-adjust,wallthick+gap+10,
                        ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adjust));
                    if(depth >= 75) {
                        translate([-wallthick-gap-adjust-6,depth-wallthick-gap-10,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adjust));
                    }
                    else {
                        translate([-wallthick-gap-adjust-6,wallthick+gap+40,
                            ((bottom_height+floorthick)/2)-1]) rotate([0,90,0]) cylinder(d=3, h=10+sidethick+(2*adjust));
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
                    if(sbc_model == "h2" && mode == "net_card" && (i == 7 || i ==13)) {
                        if (pcb_hole_x!=0 && pcb_hole_y!=0) {
                        bottom_standoff = [case_data[c[0]][27][0],      // diameter
                                           bottom_height-pcb_z-4,       // height  bottom_height-pcb_z
                                           case_data[c[0]][27][2],      // holesize
                                           case_data[c[0]][27][3],      // supportsize
                                           case_data[c[0]][27][4],      // supportheight
                                           case_data[c[0]][27][5],      // 1=countersink, 2=recessed hole, 3=nut holder, 4=blind
                                           case_data[c[0]][27][6],      // standoff style 0=hex, 1=cylinder
                                           case_data[c[0]][27][7],      // enable reverse standoff
                                           case_data[c[0]][27][8],      // enable insert at top of standoff
                                           case_data[c[0]][27][9],      // insert hole dia. mm
                                           case_data[c[0]][27][10]];    // insert depth mm

                            translate([pcb_hole_x,pcb_hole_y,0]) standoff(bottom_standoff);
                        }
                    }
                    else {
                        if (pcb_hole_x!=0 && pcb_hole_y!=0) {
                            translate([pcb_hole_x,pcb_hole_y,0]) standoff(bottom_standoff);
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
                    for (i=[7:3:16]) {
                        pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                        pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                        pcb_hole_size = sbc_data[s[0]][i+2];
                        if (pcb_hole_x!=0 && pcb_hole_y!=0 && i == 7 || i == 13) {
                            translate([pcb_hole_x-1, pcb_hole_y-(bottom_standoff[0]/2)-(gap+adjust)-1,0])
                                cube([2,gap+1.6,bottom_standoff[1]]);
                        }
                        if (pcb_hole_x!=0 && pcb_hole_y!=0 && i == 10 || i == 16) {
                            translate([pcb_hole_x-1, pcb_hole_y+(bottom_standoff[0]/2)-.6+adjust,0])
                                cube([2,gap+1.6,bottom_standoff[1]]);
                        }
                    }
                }
                else {
                    for (i=[7:3:16]) {
                        pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                        pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                        pcb_hole_size = sbc_data[s[0]][i+2];
                        if (pcb_hole_x!=0 && pcb_hole_y!=0 && i == 7 || i == 10) {
                            if(sbc_model == "h2" && mode == "net_card" && i == 7) {
                                bottom_standoff = [case_data[c[0]][27][0],      // diameter
                                                   bottom_height-pcb_z-4,       // height  bottom_height-pcb_z
                                                   case_data[c[0]][27][2],      // holesize
                                                   case_data[c[0]][27][3],      // supportsize
                                                   case_data[c[0]][27][4],      // supportheight
                                                   case_data[c[0]][27][5],      // 1=countersink, 2=recessed hole, 3=nut holder, 4=blind
                                                   case_data[c[0]][27][6],      // standoff style 0=hex, 1=cylinder
                                                   case_data[c[0]][27][7],      // enable reverse standoff
                                                   case_data[c[0]][27][8],      // enable insert at top of standoff
                                                   case_data[c[0]][27][9],      // insert hole dia. mm
                                                   case_data[c[0]][27][10]];    // insert depth mm
                                translate([pcb_hole_x-(bottom_standoff[0]/2)-2.6+adjust, pcb_hole_y-gap,0])
                                    cube([gap+1.6,2,bottom_standoff[1]]);
                            }
                            else {
                                translate([pcb_hole_x-(bottom_standoff[0]/2)-2.6+adjust, pcb_hole_y-gap,0])
                                    cube([gap+1.6,2,bottom_standoff[1]]);
                            }
                        }
                        if (pcb_hole_x!=0 && pcb_hole_y!=0 && i == 13 || i == 16) {
                            if(sbc_model == "h2" && mode == "net_card" && i == 13) {
                                bottom_standoff = [case_data[c[0]][27][0],      // diameter
                                                   bottom_height-pcb_z-4,       // height  bottom_height-pcb_z
                                                   case_data[c[0]][27][2],      // holesize
                                                   case_data[c[0]][27][3],      // supportsize
                                                   case_data[c[0]][27][4],      // supportheight
                                                   case_data[c[0]][27][5],      // 1=countersink, 2=recessed hole, 3=nut holder, 4=blind
                                                   case_data[c[0]][27][6],      // standoff style 0=hex, 1=cylinder
                                                   case_data[c[0]][27][7],      // enable reverse standoff
                                                   case_data[c[0]][27][8],      // enable insert at top of standoff
                                                   case_data[c[0]][27][9],      // insert hole dia. mm
                                                   case_data[c[0]][27][10]];    // insert depth mm     
                                translate([pcb_hole_x+(bottom_standoff[0]/2)-.5+adjust, pcb_hole_y-gap,0])
                                    cube([gap+1.5,2,bottom_standoff[1]]);
                            }
                            else {
                                translate([pcb_hole_x+(bottom_standoff[0]/2)-.5+adjust, pcb_hole_y-gap,0])
                                    cube([gap+1.5,2,bottom_standoff[1]]);
                            }
                        }
                    }                 
                }
            }
            // extended standoff sidewall support
            if(case_ext_standoffs == true && sidewall_support == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2)+(bottom_ext_standoff[0]/2)-.5,(c_fillet/2)-1,0]) 
                        cube([gap+adjust+2,2,bottom_ext_standoff[1]]);
                }
                // right-front standoff    
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || width-pcb_loc_x-pcb_width >= 10) {
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
                        depth-(c_fillet/2)-(2*(wallthick+gap))-1,0]) cube([gap+adjust+2,2,bottom_ext_standoff[1]]);
                }
            }

        }
        // subtractive accessories
            for (i=[30:14:len(case_data[c[0]])-1]) {
                class = case_data[c[0]][i];
                type = case_data[c[0]][i+1];
                loc_x = case_data[c[0]][i+2];
                loc_y = case_data[c[0]][i+3];
                loc_z = case_data[c[0]][i+4];
                face = case_data[c[0]][i+5];
                rotation = case_data[c[0]][i+6];
                size_x = case_data[c[0]][i+7];
                size_y = case_data[c[0]][i+8];
                size_z = case_data[c[0]][i+9];
                data_1 = case_data[c[0]][i+10];
                data_2 = case_data[c[0]][i+11];
                data_3 = case_data[c[0]][i+12];
                data_4 = case_data[c[0]][i+13];
            if ((class == "sub" && face == "bottom") || class == "suball") {
                if(highlight == false) {
                    sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
                else {
                    #sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
            }
            // create openings for additive 
            if (class == "add2" && face == "bottom" && type == "standoff") {
                sub("round",loc_x,loc_y,-.1,face,rotation,6.5,size_y,floorthick+1,data_1,data_2,data_3,data_4);
            }
            if ((class == "add1" || class == "add2") && type == "uart_holder") {
                if(highlight == false) {
                    translate([loc_x+5.25,loc_y-5,loc_z+4]) rotate(rotation) microusb_open();
                }
                else {
                    #translate([loc_x+5.25,loc_y-5,loc_z+4]) rotate(rotation) microusb_open();
                }
            }
            if ((class == "add1" || class == "add2") && face == "bottom" && type == "hc4_oled_holder") {
                sub("rectangle",loc_x+1,loc_y+1.75,loc_z+25.5,face,rotation,26.5,wallthick+gap+4,15,data_1,data_2,data_3,[.1,.1,.1,.1]);
            }
            if ((class == "add1" || class == "add2") && face == "bottom" && type == "access_port") {
                if(data_3 == "landscape") {
                    sub("rectangle",loc_x+6,loc_y-.5,loc_z-adjust,face,rotation,size_x-17,size_y-1,floorthick+1,
                        data_1,data_2,data_3,[.1,.1,.1,.1]);
                    sub("rectangle",loc_x+size_x-12.5,loc_y+(size_y/2)-6,loc_z-adjust,face,rotation,
                        5.5,10.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                }
                else {
                    sub("rectangle",loc_x+.5,loc_y+5.75,loc_z-adjust,face,rotation,size_x-1,size_y-17,floorthick+1,
                        data_1,data_2,data_3,[.1,.1,.1,.1]);
                    sub("rectangle",loc_x+(size_x/2)-5,loc_y+size_y-12.5,loc_z-adjust,face,rotation,
                        10.5,5.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]); 
                }
            }
            if ((class == "model") && face == "bottom" && type == "h2_netcard") {
                sub("rectangle",loc_x+25,loc_y-6,loc_z-14,face,rotation,
                    68.5,wallthick+3,14.5,data_1,data_2,data_3,[1,1,1,1]);
            }
            if ((class == "add1" || class == "add2") && face == "bottom" && type == "button") {
                if(data_3 == "recess") {
//                    sub("round",loc_x,loc_y,loc_z-1,face,rotation,size_x,size_y,5,data_1,data_2,data_3,0);
                    #translate([loc_x,loc_y,loc_z]) sphere(d=size_x);
                }
                if(data_3 == "cutout") {
                    translate([loc_x,loc_y,loc_z]) slab([size_x,size_y,size_z],.1);
                }
            }
        }                   

        // sbc openings
        open_io();        
        // clean fillets
        if(case_design == "shell") {
            translate([(width/2)-wallthick-gap,(depth/2)-wallthick-gap,bottom_height/2]) 
                cube_negative_fillet([width,depth,bottom_height], radius=-1,
                    vertical=[c_fillet,c_fillet,c_fillet,c_fillet], top=[0,0,0,0], 
                            bottom=[fillet,fillet,fillet,fillet,fillet], $fn=90);
        }
    }
    // additive accessories
    for (i=[30:14:len(case_data[c[0]])-1]) {
        class = case_data[c[0]][i];
        type = case_data[c[0]][i+1];
        loc_x = case_data[c[0]][i+2];
        loc_y = case_data[c[0]][i+3];
        loc_z = case_data[c[0]][i+4];
        face = case_data[c[0]][i+5];
        rotation = case_data[c[0]][i+6];
        size_x = case_data[c[0]][i+7];
        size_y = case_data[c[0]][i+8];
        size_z = case_data[c[0]][i+9];
        data_1 = case_data[c[0]][i+10];
        data_2 = case_data[c[0]][i+11];
        data_3 = case_data[c[0]][i+12];
        data_4 = case_data[c[0]][i+13];
        
        if (class == "add2" && face == "bottom") {
            add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
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
                                top_height+bottom_height-floorthick]) 
                                    cube([8,wallthick+2*adjust,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),depth-(2*wallthick)-gap-adjust,
                                top_height+bottom_height-floorthick]) 
                                    cube([8,wallthick+2*adjust,floorthick]);                   
                            translate([(width*(1/5))-8-(wallthick+gap),-wallthick-gap+adjust,
                                top_height+bottom_height-floorthick]) 
                                    cube([8,wallthick+2*adjust,floorthick]);
                            translate([width-(width*(1/5))-(wallthick+gap),-wallthick-gap+adjust,
                                top_height+bottom_height-floorthick]) 
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
                                cube_fillet_inside([width+2*wallthick+1,depth,bottom_height+top_height], 
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
                            translate([-2*wallthick-gap-2*adjust,wallthick+gap+10,
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
                    for (i=[30:14:len(case_data[c[0]])-1]) {
                        class = case_data[c[0]][i];
                        type = case_data[c[0]][i+1];
                        loc_x = case_data[c[0]][i+2];
                        loc_y = case_data[c[0]][i+3];
                        loc_z = case_data[c[0]][i+4];
                        face = case_data[c[0]][i+5];
                        rotation = case_data[c[0]][i+6];
                        size_x = case_data[c[0]][i+7];
                        size_y = case_data[c[0]][i+8];
                        size_z = case_data[c[0]][i+9];
                        data_1 = case_data[c[0]][i+10];
                        data_2 = case_data[c[0]][i+11];
                        data_3 = case_data[c[0]][i+12];
                        data_4 = case_data[c[0]][i+13];
                        
                        if (class == "add1" && face == "top") {
                            add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
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
                    if (pcb_hole_x!=0 && pcb_hole_y!=0) {
                            translate([pcb_hole_x,pcb_hole_y,top_height+bottom_height]) standoff(top_standoff);
                    }
                }
            }
            // extended standoffs
            if(case_ext_standoffs == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2),(c_fillet/2),top_height+bottom_height]) 
                        standoff(top_ext_standoff);
                }
                // right-front standoff    
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || width-pcb_loc_x-pcb_width >= 10) {
                    translate([width-(c_fillet/2)-(2*(wallthick+gap)),
                        depth-(c_fillet/2)-(2*(wallthick+gap)),top_height+bottom_height])
                            standoff(top_ext_standoff);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(c_fillet/2),(c_fillet/2),top_height+bottom_height]) standoff(top_ext_standoff);
                }              
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(c_fillet/2),depth-(c_fillet/2)-(2*(wallthick+gap)),
                        top_height+bottom_height]) standoff(top_ext_standoff);                
                }
            }
            // standoff sidewall support
            if(sidewall_support == true && sbc_top_standoffs == true) {
                if(pcb_width/pcb_depth >= 1.4) {
                    translate([0,pcb_depth,0]) rotate([180,0,0]) {
                        for (i=[7:3:16]) {
                            pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                            pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                            pcb_hole_size = sbc_data[s[0]][i+2];
                            if (pcb_hole_x!=0 && pcb_hole_y!=0 && i == 7 || i == 13) {
                                translate([pcb_hole_x-1, pcb_hole_y-(top_standoff[0]/2)-(gap-adjust)-1.4,
                                    -top_height-bottom_height]) cube([2,gap+1.6,top_standoff[1]]);
                            }
                            if (pcb_hole_x!=0 && pcb_hole_y!=0 && i == 10 || i == 16) {
                                translate([pcb_hole_x-1, pcb_hole_y+(top_standoff[0]/2)-.6+adjust,
                                    -top_height-bottom_height]) cube([2,gap+1.6,top_standoff[1]]);
                            }
                        }
                    }
                }
                else {
                     for (i=[7:3:16]) {
                        pcb_hole_x = sbc_data[s[0]][i]+pcb_loc_x;
                        pcb_hole_y = sbc_data[s[0]][i+1]+pcb_loc_y;
                        pcb_hole_size = sbc_data[s[0]][i+2];
                        if (pcb_hole_x!=0 && pcb_hole_y!=0 && i == 7 || i == 10) {
                            translate([pcb_hole_x-(top_standoff[0]/2)-gap-adjust-.45,pcb_hole_y-1,bottom_height+adjust])
                                cube([gap+adjust+1,2,top_standoff[1]]);
                        }
                        if (pcb_hole_x!=0 && pcb_hole_y!=0 && i == 13 || i == 16) {
                            translate([pcb_hole_x+(top_standoff[0]/2)-adjust-.45,pcb_hole_y-1,bottom_height+adjust])
                                cube([gap+adjust+1,2,top_standoff[1]]);
                        }
                    }
                }
            }
            // extended standoff sidewall support
            if(case_ext_standoffs == true && sidewall_support == true) {
                // right-rear standoff
                if(width-pcb_loc_x-pcb_width >= 10 || pcb_loc_y >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2)+(top_ext_standoff[0]/2)-.6,(c_fillet/2)-1,bottom_height]) 
                        cube([gap+adjust+2,2,top_standoff[1]]);
                }
                // right-front standoff    
                if((width-pcb_loc_x-pcb_width >= 10 && depth-pcb_loc_y-pcb_depth >= 10) || width-pcb_loc_x-pcb_width >= 10) {
                    translate([width-(2*(wallthick+gap))-(c_fillet/2)+(top_ext_standoff[0]/2)-.6,
                        depth-(c_fillet/2)-(2*(wallthick+gap))-1,bottom_height])
                            cube([gap+adjust+2,2,top_ext_standoff[1]]);
                }
                // left-rear standoff
                if(pcb_loc_x >= 10 || pcb_loc_y >= 10) {
                    translate([(c_fillet/2)-(wallthick+gap)-(top_ext_standoff[0]/2)+.6,(c_fillet/2)-1,
                        bottom_height]) cube([gap+adjust+2,2,top_ext_standoff[1]]);
                }              
                // left-front standoff
                if(pcb_loc_x >= 10 || depth-pcb_loc_y-pcb_depth >= 10) {
                    translate([(c_fillet/2)-(wallthick+gap)-(top_ext_standoff[0]/2)+.6,depth-(c_fillet/2)-(2*(wallthick+gap))-1,
                        bottom_height]) cube([gap+adjust+2,2,top_ext_standoff[1]]);
                }
            }
        }
        // subtractive accessories
        for (i=[30:14:len(case_data[c[0]])-1]) {
            class = case_data[c[0]][i];
            type = case_data[c[0]][i+1];
            loc_x = case_data[c[0]][i+2];
            loc_y = case_data[c[0]][i+3];
            loc_z = case_data[c[0]][i+4];
            face = case_data[c[0]][i+5];
            rotation = case_data[c[0]][i+6];
            size_x = case_data[c[0]][i+7];
            size_y = case_data[c[0]][i+8];
            size_z = case_data[c[0]][i+9];
            data_1 = case_data[c[0]][i+10];
            data_2 = case_data[c[0]][i+11];
            data_3 = case_data[c[0]][i+12];
            data_4 = case_data[c[0]][i+13];
            if ((class == "sub" && face == "top") || class == "suball") {
                if(highlight == false) {
                    sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
                else {
                    #sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
            }
            // create openings for additive 
            if (class == "add2" && face == "top" && type == "standoff") {
                sub("round",loc_x,loc_y,-.1,face,rotation,6.5,size_y,floorthick+1,data_1,data_2,data_3,data_4);
            }
            if ((class == "add1" || class == "add2") && face == "bottom" && type == "uart_holder") {
                if(highlight == false) {
                    translate([loc_x+5.25,loc_y-5,loc_z+4]) rotate(rotation) microusb_open();
                }
                else {
                    #translate([loc_x+5.25,loc_y-5,loc_z+4]) rotate(rotation) microusb_open();
                }
            }
            if ((class == "add1" || class == "add2") && face == "bottom" && type == "hc4_oled_holder") {
                sub("rectangle",loc_x+1,loc_y+1.75,loc_z+26,face,rotation,26.5,wallthick+gap+4,14.5,
                    data_1,data_2,data_3,[.1,.1,.1,.1]);
            }
            if ((class == "add1" || class == "add2") && face == "top" && type == "button") {
                if(data_3 == "recess") {
                    translate([loc_x,loc_y,loc_z]) sphere(d=size_x-1);
                }
                if(data_3 == "cutout") {
                    translate([loc_x-3,loc_y-4,loc_z-adjust]) slab([size_x,size_y+3,size_z+2*adjust],.1);
                }
            }
            if (class == "model" && face == "bottom" && type == "hk_boom" && 
                rotation[0] == 90 && rotation[1] == 0 && rotation[2] == 0) {
                    sub("round",loc_x+11,loc_y-4,loc_z,face,[0,0,0],5,size_y,80,data_1,data_2,data_3,data_4);
                    sub("slot",loc_x+37.5,loc_y-4.75,loc_z,face,[0,0,0],6,14,80,data_1,data_2,data_3,data_4);
            }
        }                   
        // sbc openings
        open_io();
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
    for (i=[30:14:len(case_data[c[0]])-1]) {
        class = case_data[c[0]][i];
        type = case_data[c[0]][i+1];
        loc_x = case_data[c[0]][i+2];
        loc_y = case_data[c[0]][i+3];
        loc_z = case_data[c[0]][i+4];
        face = case_data[c[0]][i+5];
        rotation = case_data[c[0]][i+6];
        size_x = case_data[c[0]][i+7];
        size_y = case_data[c[0]][i+8];
        size_z = case_data[c[0]][i+9];
        data_1 = case_data[c[0]][i+10];
        data_2 = case_data[c[0]][i+11];
        data_3 = case_data[c[0]][i+12];
        data_4 = case_data[c[0]][i+13];
        
        if (class == "add2" && face == "top") {
            add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
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
                                cube([width-2*wallthick,wallthick,top_height+bottom_height+2*floorthick]);
                            difference() {
                                translate([width-(2*wallthick)-gap-adjust,-wallthick-gap,
                                    ((top_height+bottom_height)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([width-(2*wallthick)-gap-adjust,-wallthick-gap-adjust,
                                    ((top_height+bottom_height)/2)-4-adjust]) 
                                        cube([wallthick+.25,wallthick+(2*adjust),4.25]);
                            }
                            difference() {
                                translate([-(2*wallthick)-gap-adjust,-wallthick-gap,
                                    ((top_height+bottom_height)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([-wallthick-gap-adjust-.25,-wallthick-gap-adjust,
                                    ((top_height+bottom_height)/2)-4-adjust]) 
                                        cube([wallthick+.25,wallthick+(2*adjust),4.25]);
                            }
                        }
                        // top slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),-wallthick-gap-adjust,
                            top_height+bottom_height-floorthick-.25]) 
                                cube([8.5,wallthick+2*adjust,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,-wallthick-gap-adjust,
                            top_height+bottom_height-floorthick-.25]) 
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
                                cube([width-2*wallthick,wallthick,top_height+bottom_height+2*floorthick]);
                            difference() {
                                translate([width-(2*wallthick)-gap-adjust,depth-2*(wallthick)-gap-adjust,
                                    ((top_height+bottom_height)/2)-4])
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([width-(2*wallthick)-gap-adjust,
                                    depth-2*(wallthick)-adjust-gap-adjust,((top_height+bottom_height)/2)-4-adjust])
                                        cube([wallthick+.25,wallthick+(2*adjust),4.25]);
                            }
                            difference() {
                                translate([-(2*wallthick)-gap-adjust,depth-2*(wallthick)-gap-adjust,(
                                    (top_height+bottom_height)/2)-4]) 
                                        cube([(2*wallthick)+.5,wallthick,8]);
                                translate([-wallthick-gap-adjust-.25,depth-2*(wallthick)-adjust-gap-adjust,
                                    ((top_height+bottom_height)/2)-4-adjust]) 
                                        cube([wallthick+.25,wallthick+(2*adjust),4.25]);
                            }
                        }
                        // top slots
                        translate([(width*(1/5))-8.25-(wallthick+gap),depth-2*wallthick-gap-adjust,
                            top_height+bottom_height-floorthick-.25]) 
                                cube([8.5,wallthick+2*adjust,floorthick+.5]);
                        translate([width-(width*(1/5))-(wallthick+gap)-.25,depth-2*wallthick-gap-adjust,
                            top_height+bottom_height-floorthick-.25]) 
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
                            cube([wallthick,depth+2*wallthick,top_height+bottom_height+(2*wallthick)]);
                        translate([width-(2*wallthick)-gap-adjust,-wallthick-gap-.25,
                            ((top_height+bottom_height)/2)]) cube([wallthick+2*adjust,wallthick+.5,8.5]);
                        translate([width-(2*wallthick)-gap-adjust,depth-2*(wallthick)-gap-.25,
                            ((top_height+bottom_height)/2)])
                                cube([wallthick+2*adjust,wallthick+.5,8.5]);
                    }
                }
                if(side == "left") {
                    difference() {
                        translate([-wallthick-gap,-(2*wallthick)-gap,-wallthick]) 
                            cube([wallthick,depth+2*wallthick,top_height+bottom_height+(2*wallthick)]);
                        translate([-wallthick-gap-adjust,-wallthick-gap-.25,((top_height+bottom_height)/2)])
                            cube([wallthick+2*adjust,wallthick+.5,8.5]);
                        translate([-wallthick-gap-adjust,depth-2*(wallthick)-gap-.25,
                            ((top_height+bottom_height)/2)])
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
                cheight = top_height+bottom_height+90;
                vesa = 75;
                vu_holder(case_style,side,vesa,cheight);
            }
            if(case_design == "tray" && case_style == "vu7") {
                cheight = top_height+bottom_height+122;
                vesa = 100;
                vu_holder(case_style,side,vesa,cheight);
            }         
            // additive accessories
            for (i=[30:14:len(case_data[c[0]])-1]) {
                class = case_data[c[0]][i];
                type = case_data[c[0]][i+1];
                loc_x = case_data[c[0]][i+2];
                loc_y = case_data[c[0]][i+3];
                loc_z = case_data[c[0]][i+4];
                face = case_data[c[0]][i+5];
                rotation = case_data[c[0]][i+6];
                size_x = case_data[c[0]][i+7];
                size_y = case_data[c[0]][i+8];
                size_z = case_data[c[0]][i+9];
                data_1 = case_data[c[0]][i+10];
                data_2 = case_data[c[0]][i+11];
                data_3 = case_data[c[0]][i+12];
                data_4 = case_data[c[0]][i+13];
                
                if (class == "add1" && face == side) {
                    add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
            }
        }
        for (i=[30:14:len(case_data[c[0]])-1]) {
            class = case_data[c[0]][i];
            type = case_data[c[0]][i+1];
            loc_x = case_data[c[0]][i+2];
            loc_y = case_data[c[0]][i+3];
            loc_z = case_data[c[0]][i+4];
            face = case_data[c[0]][i+5];
            rotation = case_data[c[0]][i+6];
            size_x = case_data[c[0]][i+7];
            size_y = case_data[c[0]][i+8];
            size_z = case_data[c[0]][i+9];
            data_1 = case_data[c[0]][i+10];
            data_2 = case_data[c[0]][i+11];
            data_3 = case_data[c[0]][i+12];
            data_4 = case_data[c[0]][i+13];
            if ((class == "sub" && face == side) || class == "suball") {
                if(highlight == false) {
                    sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
                else {
                    #sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
            }
            // create openings for additive 
            if ((class == "sub" && face == "bottom") || class == "suball") {
                if(highlight == false) {
                    sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
                else {
                    #sub(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
                }
            }
            // create openings for additive 
            if (class == "add2" && face == "bottom" && type == "standoff") {
                sub("round",loc_x,loc_y,-.1,face,rotation,6.5,size_y,floorthick+1,data_1,data_2,data_3,data_4);
            }
            if ((class == "add1" || class == "add2") && face == "bottom" && type == "uart_holder") {
                if(highlight == false) {
                    translate([loc_x+5.25,loc_y-5,loc_z+4]) rotate(rotation) microusb_open();
                }
                else {
                    #translate([loc_x+5.25,loc_y-5,loc_z+4]) rotate(rotation) microusb_open();
                }
            }
            if ((class == "add1" || class == "add2") && face == "bottom" && type == "hc4_oled_holder") {
                sub("rectangle",loc_x+1,loc_y+1.75,loc_z+25.5,face,rotation,26.5,wallthick+gap+4,15,data_1,data_2,data_3,[.1,.1,.1,.1]);
            }
            if ((class == "add1" || class == "add2") && face == "bottom" && type == "access_port") {
                if(data_3 == "landscape") {
                    sub("rectangle",loc_x+6,loc_y-.5,loc_z-adjust,face,rotation,size_x-17,size_y-1,floorthick+1,
                        data_1,data_2,data_3,[.1,.1,.1,.1]);
                    sub("rectangle",loc_x+size_x-12.5,loc_y+(size_y/2)-6,loc_z-adjust,face,rotation,
                        5.5,10.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]);
                }
                else {
                    sub("rectangle",loc_x+.5,loc_y+5.75,loc_z-adjust,face,rotation,size_x-1,size_y-17,floorthick+1,
                        data_1,data_2,data_3,[.1,.1,.1,.1]);
                    sub("rectangle",loc_x+(size_x/2)-5,loc_y+size_y-12.5,loc_z-adjust,face,rotation,
                        10.5,5.5,floorthick+.12,data_1,data_2,data_3,[5.5,5.5,5.5,5.5]); 
                }
            }
            if ((class == "model") && face == "bottom" && type == "h2_netcard") {
                sub("rectangle",loc_x+25,loc_y-6,loc_z-14,face,rotation,
                    68.5,wallthick+3,14.5,data_1,data_2,data_3,[1,1,1,1]);
            }
            if ((class == "add1" || class == "add2") && face == "bottom" && type == "button") {
                if(data_3 == "recess") {
//                    sub("round",loc_x,loc_y,loc_z-1,face,rotation,size_x,size_y,5,data_1,data_2,data_3,0);
                    #translate([loc_x,loc_y,loc_z]) sphere(d=size_x);
                }
                if(data_3 == "cutout") {
                    #translate([loc_x,loc_y,loc_z]) slab([size_x,size_y,size_z],.1);
                }
            }
        }                   
        // sbc openings
        open_io();
    }
    for (i=[30:14:len(case_data[c[0]])-1]) {
        class = case_data[c[0]][i];
        type = case_data[c[0]][i+1];
        loc_x = case_data[c[0]][i+2];
        loc_y = case_data[c[0]][i+3];
        loc_z = case_data[c[0]][i+4];
        face = case_data[c[0]][i+5];
        rotation = case_data[c[0]][i+6];
        size_x = case_data[c[0]][i+7];
        size_y = case_data[c[0]][i+8];
        size_z = case_data[c[0]][i+9];
        data_1 = case_data[c[0]][i+10];
        data_2 = case_data[c[0]][i+11];
        data_3 = case_data[c[0]][i+12];
        data_4 = case_data[c[0]][i+13];
        
        if (class == "add2" && face == side) {
            add(type,loc_x,loc_y,loc_z,face,rotation,size_x,size_y,size_z,data_1,data_2,data_3,data_4);
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
            if(type == "micro") {
                translate([loc_x-.6,loc_y-gap,bottom_height+pcb_loc_z+1.9]) rotate([90,0,0]) slot(6,8,2.1);
            }
            if(type == "hdmi_a" && side == "top") {            
                translate([loc_x+2.375,loc_y-gap,bottom_height+pcb_loc_z+3.75]) rotate([90,0,0]) slot(12,10,2.1);
            }
            if(type == "pwr5.5_7.5x11.5") {            
                translate([loc_x+4,loc_y-gap,bottom_height+pcb_loc_z+6.25]) 
                     rotate([90,0,0]) cylinder(d=10, h=sidethick+(2*adjust));
            }
            if(type == "pwr2.5_5x7.5") {            
                translate([loc_x+2.75,loc_y-gap-1,bottom_height+pcb_loc_z+2.1]) 
                     rotate([90,0,0]) cylinder(d=6, h=sidethick+(2*adjust));
            }
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
    
        
        // top cooling openings
        if(side == "top" && cooling == "fan" && class == "heatsink" 
            && type != "h2_oem" && type != "n2_oem" && type != "n2+_oem") {
                translate([loc_x+6,loc_y-28,case_z-(floorthick+adjust)]) 
                    fan_mask(40,floorthick+(2*adjust)+4,2);
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
                fan_mask(90,floorthick+3,2);
        }
        if(side == "top" && cooling == "vents" && class == "heatsink") {
            for(r=[loc_x+7:4:48]) {
                translate([r,loc_y-20,case_z-(floorthick+adjust)]) 
                    cube([2,25,floorthick+(adjust*2)]);
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
                           cube([2,wallthick+(2*adjust)+1,top_height-floorthick-4]);
                    }
        }
    
        // gpio opening
        if(side == "top" && class == "gpio" && type == "header_40" && rotation == 0) {
            if(gpio_opening == "vent") {
                for(r=[loc_x-2:4:40+loc_y]) {
                    translate([r,depth-(2*wallthick)-gap-adjust,bottom_height+2]) 
                        cube([2,wallthick+(2*adjust),top_height-floorthick-7]);
                }
            }
            if(gpio_opening == "open") {
                translate([loc_x-2,depth-(2*wallthick)-adjust-gap,bottom_height+3])
                    cube([54,wallthick+(2*adjust),top_height-floorthick-5]);
            }
            if(gpio_opening == "punchout") {
                translate([loc_x+1,depth-(2*wallthick)-adjust-gap,bottom_height+9])
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
                translate([loc_x+8,depth-15,bottom_height+9])
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
                translate([loc_x+1,depth-(2*wallthick)-adjust-gap,bottom_height+9])
                    rotate([-90,0,0]) punchout(34,11,2,wallthick+(2*adjust),3,"slot");
            }
        }
    
        // uart knockout opening
        if(side == "top" && type == "uart_micro" && rotation == 90) {
            translate([loc_x-wallthick-gap-4,loc_y-1,bottom_height+5]) rotate([90,0,90]) 
                punchout(15,8,1,sidethick+(2*adjust)+5,2,"rectangle");
        }
        if(side == "top" && type == "uart_micro" && rotation == -90) {
            translate([loc_x+2*(wallthick+gap)+1,loc_y-1,bottom_height+5]) rotate([90,0,90]) 
                punchout(15,8,1,wallthick+(2*adjust)+5,2,"rectangle");
        }
        if(side == "top" && type == "uart_micro" && rotation == 270) {
            translate([loc_x-2*(wallthick),loc_y-1,bottom_height+5]) rotate([90,0,90]) 
                punchout(15,8,1,wallthick+(2*adjust)+5,2,"rectangle");
        }
        
        // sata openings
        if(side == "top" && type == "sata_power_vrec" && sata_punchout == true) {
            translate([loc_x-3,loc_y+1.75,case_z-adjust-floorthick]) 
                punchout(42,7.5,2,floorthick+(2*adjust)+2,3,"slot");
        }
    }
}

module vu_holder(vu_model,side,vesa,cheight) {

//cheight = top_height+bottom_height+90;
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
                        slab_r([((width-vesa)/2)+4,10,sidethick], [.1,.1,3,3]);
                translate([(width/2)+((width-vesa)/2)+(vesa/2)-sidethick,depth-26,
                    case_z+31.5]) rotate([90-vu_rotation[0],180,0]) 
                        slab_r([((width-vesa)/2)+4,10,sidethick], [.1,.1,3,3]);
                
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
                translate([-sidethick-adjust+1,-.6,case_z+sidethick+2.5]) 
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
                translate([width/2-(vesa/2)-3,depth-36.75,case_z+vu7_height-19.75]) 
                    rotate([90+vu_rotation[0],0,0]) cylinder(d=3, h=sidethick+1);
                translate([width/2-(vesa/2)-3,depth-24.25,case_z+18]) 
                    rotate([90+vu_rotation[0],0,0])  cylinder(d=3, h=sidethick+1);
            }
            // vu7 shape and back cut
            if(case_style == "vu7") {
                translate([-sidethick-adjust+1,-.6,case_z+sidethick+2.5]) 
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