/*
    SBC Case Builder Copyright 2022, 2023, 2024, 2025 Edward A. Kisiel hominoid@cablemi.com

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

use <./SBC_Model_Framework/sbc_models.scad>;
include <./sbc_case_builder_library.scad>;
include <./SBC_Model_Framework/sbc_models.cfg>;
include <./sbc_case_builder_accessories.cfg>;

/* [View] */
// viewing mode "model", "platter", "part"
view = "model"; // [model, platter, part]
individual_part = "bottom"; // [top, bottom, right, left, front, rear, io_shield, accessories]
// section individual parts for panel cases
section_part = false; // [true,false]
// single board computer model
sbc_model = "c1+"; //  ["c1+", "c2", "c4", "hc4", "c5", "xu4", "xu4q", "mc1", "hc1", "n1", "n2", "n2+", "n2l", "n2lq", "m1", "m1s", "m2", "h2", "h2+", "h3", "h3+", "h4", "h4+", "h4_ultra", "show2", "rpipico", "rpipicow", "rpicm4+ioboard", "rpicm1", "rpicm3", "rpicm3l", "rpicm3+", "rpicm4s", "rpicm4", "rpicm4l", "rpizero", "rpizerow", "rpizero2w", "rpi1a+", "rpi1b+", "rpi2b", "rpi3a+", "rpi3b", "rpi3b+", "rpi4b", "rpi5", "a64", "a64lts", "rock64", "rockpro64", "quartz64a", "quartz64b", "h64b", "star64", "soedge_a-baseboard", "soedge_rk1808", "rock4a", "rock4b", "rock4a+", "rock4b+", "rock4c", "rock4c+", "rock5b-v1.3", "rock5b", "rock5bq", "rock5b+", "nio12l", "vim1", "vim2", "vim3", "vim3l", "vim4", "tinkerboard", "tinkerboard-s", "tinkerboard-2", "tinkerboard-2s", "tinkerboard-r2", "tinkerboard-r2s", "opizero", "opizero2", "opir1plus_lts", "opir1", "opi5", "opi5max", "opi3b-v2.1", "jetsonnano", "lepotato", "sweetpotato", "tritium-h2+", "tritium-h3", "tritium-h5", "solitude", "alta", "atomicpi", "visionfive2", "visionfive2q", "bpif3", "milk-v_duos", "licheerv+dock", "rak19007", "cnano-avr128da48", "nodemcu-32s", "cs-solarmeter", "feather-m0_express", "feather-m0_wifi", "feather-m4_express", "ssi-eeb", "ssi-ceb", "atx", "micro-atx", "dtx", "flex-atx", "mini-dtx", "mini-itx", "mini-itx_thin", "mini-stx", "mini-stx_thin", "nano-itx", "nuc", "pico-itx"]

// sbc off in model view
sbc_off = false;
// sbc information display
sbc_information = false;
// enable highlight for sbc component subtractive geometry
sbc_highlight = false;
// enable highlight for accessory subtractive geometry
accessory_highlight = false;
// base case design
case_design = "shell"; // [shell,panel,panel_nas,stacked,tray,tray_sides,tray_vu5,tray_vu7,round,hex,snap,fitted,rack,paper_split-top,paper_full-top,adapter_ssi-eeb,adapter_ssi-ceb,adapter_atx,adapter_micro-atx,adapter_dtx,adapter_flex-atx,adapter_mini-dtx,adapter_mini-itx,adapter_mini-itx_thin,adapter_mini-stx,adapter_mini-stx_thin]

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

/* [Folded Case Adjustments] */
// material thickness in mm
material_thickness = .5; //[.1:.01:3]
// bend allowance
bend_allowance = 1; //[0:.01:5]
// bottom clearence
bottom_clearence = 3.5; //[-10:.01:10]
// enable flat blank section for export
flat_blank_section =  false;

/* [Standard Motherboard Case Adjustments] */
// adjustment for ssi-eeb, ssi-ceb, atx, micro-atx, dtx, flex-atx, mini-dtx, mini-itx, mini-stx, nano-itx,nuc, pico-itx PCB thickness from 2mm default//
standard_motherboard_thickness =  0; //[-3:.01:3]
// rear io plate opening for standard form motherboards
rear_io_shield = false;
// sbc rotation on the adapter
adapter_sbc_rotation = 0; //[0:90:270]

/* [Rack Mount Case Adjustments] */
// size of rack 10" or 19" //
rack_width =  19; //[10,19]
// size of rack mount cases 1U or 2U //
rack_size =  "1u"; //["1u","1u+","1u++","2u"]
removable_bay_height = 0; // [-4 : .5 : 0]
// bay sbc device
Rack_Bay1 = "none"; //  ["none", "c1+", "c2", "c4", "hc4", "c5", "xu4", "xu4q", "mc1", "hc1", "n1", "n2", "n2+", "n2l", "n2lq", "m1", "m1s", "m2", "h2", "h2+", "h3", "h3+", "h4", "h4+", "h4_ultra", "show2", "rpipico", "rpipicow", "rpicm4+ioboard", "rpicm1", "rpicm3", "rpicm3l", "rpicm3+", "rpicm4s", "rpicm4", "rpicm4l", "rpizero", "rpizerow", "rpizero2w", "rpi1a+", "rpi1b+", "rpi2b", "rpi3a+", "rpi3b", "rpi3b+", "rpi4b", "rpi5", "a64", "a64lts", "rock64", "rockpro64", "quartz64a", "quartz64b", "h64b", "star64", "soedge_a-baseboard", "soedge_rk1808", "rock4a", "rock4b", "rock4a+", "rock4b+", "rock4c", "rock4c+", "rock5b-v1.3", "rock5b", "rock5bq", "rock5b+", "nio12l", "vim1", "vim2", "vim3", "vim3l", "vim4", "tinkerboard", "tinkerboard-s", "tinkerboard-2", "tinkerboard-2s", "tinkerboard-r2", "tinkerboard-r2s", "opizero", "opizero2", "opir1plus_lts", "opir1", "opi5", "opi5max", "opi3b-v2.1", "jetsonnano", "lepotato", "sweetpotato", "tritium-h2+", "tritium-h3", "tritium-h5", "solitude", "alta", "atomicpi", "visionfive2", "visionfive2q", "bpif3", "milk-v_duos", "licheerv+dock", "rak19007", "cnano-avr128da48", "nodemcu-32s", "cs-solarmeter", "feather-m0_express", "feather-m0_wifi", "feather-m4_express"]
rack_bay1_xyz_loc = [0,0,0]; // [0:.5:450]
rack_bay1_rotation = 0; // [0:90:270]
rack_bay1_face = "fixed"; // ["open","fixed","removable","vent"]
rack_bay1_wall = false; // [true,false]
rack_bay1_rear_fan = false; // [true,false]
rack_bay1_rear_conduit = "none"; // ["none","conduit","grommet","grommets-vertical"]

Rack_Bay2 = "none"; //  ["none", "c1+", "c2", "c4", "hc4", "c5", "xu4", "xu4q", "mc1", "hc1", "n1", "n2", "n2+", "n2l", "n2lq", "m1", "m1s", "m2", "h2", "h2+", "h3", "h3+", "h4", "h4+", "h4_ultra", "show2", "rpipico", "rpipicow", "rpicm4+ioboard", "rpicm1", "rpicm3", "rpicm3l", "rpicm3+", "rpicm4s", "rpicm4", "rpicm4l", "rpizero", "rpizerow", "rpizero2w", "rpi1a+", "rpi1b+", "rpi2b", "rpi3a+", "rpi3b", "rpi3b+", "rpi4b", "rpi5", "a64", "a64lts", "rock64", "rockpro64", "quartz64a", "quartz64b", "h64b", "star64", "soedge_a-baseboard", "soedge_rk1808", "rock4a", "rock4b", "rock4a+", "rock4b+", "rock4c", "rock4c+", "rock5b-v1.3", "rock5b", "rock5bq", "rock5b+", "nio12l", "vim1", "vim2", "vim3", "vim3l", "vim4", "tinkerboard", "tinkerboard-s", "tinkerboard-2", "tinkerboard-2s", "tinkerboard-r2", "tinkerboard-r2s", "opizero", "opizero2", "opir1plus_lts", "opir1", "opi5", "opi5max", "opi3b-v2.1", "jetsonnano", "lepotato", "sweetpotato", "tritium-h2+", "tritium-h3", "tritium-h5", "solitude", "alta", "atomicpi", "visionfive2", "visionfive2q", "bpif3", "milk-v_duos", "licheerv+dock", "rak19007", "cnano-avr128da48", "nodemcu-32s", "cs-solarmeter", "feather-m0_express", "feather-m0_wifi", "feather-m4_express"]
rack_bay2_xyz_loc = [0,0,0]; // [0:.5:450]
rack_bay2_rotation = 0; // [0:90:270]
rack_bay2_face = "fixed"; //["open","fixed","removable","vent"]
rack_bay2_wall = false; // [true,false]
rack_bay2_rear_fan = false; //[true,false]
rack_bay2_rear_conduit =  "none"; //["none","conduit","grommet","grommets-vertical"]

Rack_Bay3 = "none"; //  ["none", "c1+", "c2", "c4", "hc4", "c5", "xu4", "xu4q", "mc1", "hc1", "n1", "n2", "n2+", "n2l", "n2lq", "m1", "m1s", "m2", "h2", "h2+", "h3", "h3+", "h4", "h4+", "h4_ultra", "show2", "rpipico", "rpipicow", "rpicm4+ioboard", "rpicm1", "rpicm3", "rpicm3l", "rpicm3+", "rpicm4s", "rpicm4", "rpicm4l", "rpizero", "rpizerow", "rpizero2w", "rpi1a+", "rpi1b+", "rpi2b", "rpi3a+", "rpi3b", "rpi3b+", "rpi4b", "rpi5", "a64", "a64lts", "rock64", "rockpro64", "quartz64a", "quartz64b", "h64b", "star64", "soedge_a-baseboard", "soedge_rk1808", "rock4a", "rock4b", "rock4a+", "rock4b+", "rock4c", "rock4c+", "rock5b-v1.3", "rock5b", "rock5bq", "rock5b+", "nio12l", "vim1", "vim2", "vim3", "vim3l", "vim4", "tinkerboard", "tinkerboard-s", "tinkerboard-2", "tinkerboard-2s", "tinkerboard-r2", "tinkerboard-r2s", "opizero", "opizero2", "opir1plus_lts", "opir1", "opi5", "opi5max", "opi3b-v2.1", "jetsonnano", "lepotato", "sweetpotato", "tritium-h2+", "tritium-h3", "tritium-h5", "solitude", "alta", "atomicpi", "visionfive2", "visionfive2q", "bpif3", "milk-v_duos", "licheerv+dock", "rak19007", "cnano-avr128da48", "nodemcu-32s", "cs-solarmeter", "feather-m0_express", "feather-m0_wifi", "feather-m4_express"]
rack_bay3_xyz_loc = [0,0,0]; // [0:.5:450]
rack_bay3_rotation = 0; // [0:90:270]
rack_bay3_face = "fixed"; //["open","fixed","removable","vent"]
rack_bay3_wall = false; // [true,false]
rack_bay3_rear_fan = false; //[true,false]
rack_bay3_rear_conduit =  "none"; //["none","conduit","grommet","grommets-vertical"]

Rack_Bay4 = "none"; //  ["none", "c1+", "c2", "c4", "hc4", "c5", "xu4", "xu4q", "mc1", "hc1", "n1", "n2", "n2+", "n2l", "n2lq", "m1", "m1s", "m2", "h2", "h2+", "h3", "h3+", "h4", "h4+", "h4_ultra", "show2", "rpipico", "rpipicow", "rpicm4+ioboard", "rpicm1", "rpicm3", "rpicm3l", "rpicm3+", "rpicm4s", "rpicm4", "rpicm4l", "rpizero", "rpizerow", "rpizero2w", "rpi1a+", "rpi1b+", "rpi2b", "rpi3a+", "rpi3b", "rpi3b+", "rpi4b", "rpi5", "a64", "a64lts", "rock64", "rockpro64", "quartz64a", "quartz64b", "h64b", "star64", "soedge_a-baseboard", "soedge_rk1808", "rock4a", "rock4b", "rock4a+", "rock4b+", "rock4c", "rock4c+", "rock5b-v1.3", "rock5b", "rock5bq", "rock5b+", "nio12l", "vim1", "vim2", "vim3", "vim3l", "vim4", "tinkerboard", "tinkerboard-s", "tinkerboard-2", "tinkerboard-2s", "tinkerboard-r2", "tinkerboard-r2s", "opizero", "opizero2", "opir1plus_lts", "opir1", "opi5", "opi5max", "opi3b-v2.1", "jetsonnano", "lepotato", "sweetpotato", "tritium-h2+", "tritium-h3", "tritium-h5", "solitude", "alta", "atomicpi", "visionfive2", "visionfive2q", "bpif3", "milk-v_duos", "licheerv+dock", "rak19007", "cnano-avr128da48", "nodemcu-32s", "cs-solarmeter", "feather-m0_express", "feather-m0_wifi", "feather-m4_express"]
rack_bay4_xyz_loc = [0,0,0]; // [0:.5:450]
rack_bay4_rotation = 0; // [0:90:270]
rack_bay4_face = "fixed"; //["open","fixed","removable","vent"]
rack_bay4_wall = false; // [true,false]
rack_bay4_rear_fan = false; //[true,false]
rack_bay4_rear_conduit =  "none"; //["none","conduit","grommet","grommets-vertical"]

Rack_Bay5 = "none"; //  ["none", "c1+", "c2", "c4", "hc4", "c5", "xu4", "xu4q", "mc1", "hc1", "n1", "n2", "n2+", "n2l", "n2lq", "m1", "m1s", "m2", "h2", "h2+", "h3", "h3+", "h4", "h4+", "h4_ultra", "show2", "rpipico", "rpipicow", "rpicm4+ioboard", "rpicm1", "rpicm3", "rpicm3l", "rpicm3+", "rpicm4s", "rpicm4", "rpicm4l", "rpizero", "rpizerow", "rpizero2w", "rpi1a+", "rpi1b+", "rpi2b", "rpi3a+", "rpi3b", "rpi3b+", "rpi4b", "rpi5", "a64", "a64lts", "rock64", "rockpro64", "quartz64a", "quartz64b", "h64b", "star64", "soedge_a-baseboard", "soedge_rk1808", "rock4a", "rock4b", "rock4a+", "rock4b+", "rock4c", "rock4c+", "rock5b-v1.3", "rock5b", "rock5bq", "rock5b+", "nio12l", "vim1", "vim2", "vim3", "vim3l", "vim4", "tinkerboard", "tinkerboard-s", "tinkerboard-2", "tinkerboard-2s", "tinkerboard-r2", "tinkerboard-r2s", "opizero", "opizero2", "opir1plus_lts", "opir1", "opi5", "opi5max", "opi3b-v2.1", "jetsonnano", "lepotato", "sweetpotato", "tritium-h2+", "tritium-h3", "tritium-h5", "solitude", "alta", "atomicpi", "visionfive2", "visionfive2q", "bpif3", "milk-v_duos", "licheerv+dock", "rak19007", "cnano-avr128da48", "nodemcu-32s", "cs-solarmeter", "feather-m0_express", "feather-m0_wifi", "feather-m4_express"]
rack_bay5_xyz_loc = [0,0,0]; // [0:.5:450]
rack_bay5_rotation = 0; // [0:90:270]
rack_bay5_face = "fixed"; //["open","fixed","removable","vent"]
rack_bay5_wall = false; // [true,false]
rack_bay5_rear_fan = false; //[true,false]
rack_bay5_rear_conduit =  "none"; //["none","conduit","grommet","grommets-vertical"]

Rack_Bay6 = "none"; //  ["none", "c1+", "c2", "c4", "hc4", "c5", "xu4", "xu4q", "mc1", "hc1", "n1", "n2", "n2+", "n2l", "n2lq", "m1", "m1s", "m2", "h2", "h2+", "h3", "h3+", "h4", "h4+", "h4_ultra", "show2", "rpipico", "rpipicow", "rpicm4+ioboard", "rpicm1", "rpicm3", "rpicm3l", "rpicm3+", "rpicm4s", "rpicm4", "rpicm4l", "rpizero", "rpizerow", "rpizero2w", "rpi1a+", "rpi1b+", "rpi2b", "rpi3a+", "rpi3b", "rpi3b+", "rpi4b", "rpi5", "a64", "a64lts", "rock64", "rockpro64", "quartz64a", "quartz64b", "h64b", "star64", "soedge_a-baseboard", "soedge_rk1808", "rock4a", "rock4b", "rock4a+", "rock4b+", "rock4c", "rock4c+", "rock5b-v1.3", "rock5b", "rock5bq", "rock5b+", "nio12l", "vim1", "vim2", "vim3", "vim3l", "vim4", "tinkerboard", "tinkerboard-s", "tinkerboard-2", "tinkerboard-2s", "tinkerboard-r2", "tinkerboard-r2s", "opizero", "opizero2", "opir1plus_lts", "opir1", "opi5", "opi5max", "opi3b-v2.1", "jetsonnano", "lepotato", "sweetpotato", "tritium-h2+", "tritium-h3", "tritium-h5", "solitude", "alta", "atomicpi", "visionfive2", "visionfive2q", "bpif3", "milk-v_duos", "licheerv+dock", "rak19007", "cnano-avr128da48", "nodemcu-32s", "cs-solarmeter", "feather-m0_express", "feather-m0_wifi", "feather-m4_express"]
rack_bay6_xyz_loc = [0,0,0]; // [0:.5:450]
rack_bay6_rotation = 0; // [0:90:270]
rack_bay6_face = "fixed"; //["open","fixed","removable","vent"]
rack_bay6_rear_fan = false; //[true,false]
rack_bay6_rear_conduit =  "none"; //["none","conduit","grommet","grommets-vertical"]

/* [3D Case Adjustments] */
// sbc location x axis
pcb_loc_x = 0; //[0:.01:300]
// sbc location y axis
pcb_loc_y = 0; //[0:.01:300]
// sbc location z axis
pcb_loc_z = 0; //[0:.01:100]
// additional x axis case size
case_offset_x = 0; //[0:.01:300]
// additional y axis case size
case_offset_y = 0; //[0:.01:300]
// additional z axis case top size
case_offset_tz = 0; //[-50:.01:300]
// additional z axis case bottom size
case_offset_bz = 0; //[-50:.01:300]
// case wall thickness
wallthick = 2; //[1:.25:5]
// case floor and ceiling thickness
floorthick = 2; //[1:.25:5]
// side wall thickness for tray_side and panel_nas cases only
sidethick = 2; //[1:.25:5]
// distance between pcb and case
gap = 1; //[.5:.25:5]
// corner fillets
corner_fillet = 3; //[0:.5:9]
// edge fillets
edge_fillet = 0; //[0:.5:6]
// tolerance for fitted surfaces
tol = .25; //[-.5:.0625:.5]

/* [Fan and Vent Openings] */
// top cover pattern
top_cover_pattern = "solid"; //[solid,hex_5mm,hex_8mm,linear_vertical,linear_horizontal,astroid]
// front cover pattern for nas cases
front_cover_pattern = "solid"; //[solid,hex_5mm,hex_8mm,linear_vertical,linear_horizontal,astroid]
// bottom cover pattern
bottom_cover_pattern = "solid"; //[solid,hex_5mm,hex_8mm,linear_vertical,linear_horizontal,astroid]
// heatsink opening
cooling = "default"; // [default,none,open,fan_open,fan_1,fan_2,fan_hex,vent,vent_hex_5mm,vent_hex_8mm,custom]
fan_size = 0; // [0,25,30,40,50,60,70,80,92]
// number of rear fans for nas cases
rear_fan = 1; // [1:2]
// rear fan x-axis center
rear_fan_center = false; // [true,false]
// rear fan opening
rear_cooling = "fan_hex"; // [fan_open,fan_1,fan_2,fan_hex,custom]
rear_fan_size = 80; // [0,25,30,40,50,60,70,80,92]
// rear fan z-axis position
rear_fan_position = 0; // [0:1:300]
// space between dual rear fans
rear_dualfan_spacing = 6; // [0:1:50]

/* [Bottom Access Panel] */
bottom_access_panel_enable = false;
access_panel_size = [70,30]; //[10:.01:120]
access_panel_orientation = "landscape"; //[landscape,portrait]
access_panel_location = [10,15]; //[-10:.01:200]
access_panel_rotation = 0; //[0:90:270]

/* [Options and Accessories] */
// gpio opening
gpio_opening = "default"; // [default,none,open,block,knockout,vent]
// uart opening
uart_opening = "default"; // [default,none,open,knockout]
// enable indentations around io openings
indents = true;
// nas sbc location
nas_sbc_location = "top"; // ["top","bottom"]
// number of nas drive bays
hd_bays = 2; // [1:6]
// rotate hd 180 degrees in the z-axis
hd_reverse = false; // [true, false]
// center hd in the x-axis
hd_center = false; // [true, false]
// distance between drives
hd_space = 10; // [1:50]
hd_y_position = 25; // [0:300]
hd_z_position = 40; // [0:300]

// case accessory group to load
accessory_name = "none"; // ["none", "hk_uart", "c4_shell_boombox", "c4_desktop_lcd3.5", "c4_deskboom_lcd3.5", "c4_panel_boombox", "c4_panel_lcd3.5", "c4_tray_boombox", "c4_round", "c4_hex", "c-series_rack19-1u", "xu4_shifter_shield", "xu4_keyhole", "hc4_panel_nas", "hc4_shell_drivebox2.5", "hc4_shell_drivebox2.5v", "hc4_shell_drivebox3.5", "hc4_tray_drivebox2.5", "n-series_rack19-1u", "n1_rack10-1u", "m2_shell", "m2_eyespi_eink1.54", "m2_eyespi_lcd2.8", "m1s_shell_nvme", "m1s_shell_ups", "m1s_tray_nvme", "m1_tray_ssd", "m1_fitted_pizzabox2.5", "m1_fitted_pizzabox3.5", "h3_shell", "h3_shell_router", "h3_lowboy", "h3_lowboy_router", "h3_panel_nas", "h3_ultimate", "h3_ultimate2", "h4_panel_nas", "h4_rack_nas", "show2_shell", "rpi5_m2hat", "rpi5_bottom_m2hat", "rock5b", "adapter_mini-stx_m1s", "nas", "cs_solarmeter", "n2l_env_sensors", "avr_env_sensors", "env_sensors", "adafruit_solar_charger"]

// sbc information text color
text_color = "Green"; // [Green, Black, Dimgrey, White, Yellow, Orange, Red, DarkbBlue]
// sbc information text font
text_font = "Nimbus Mono PS"; // [Nimbus Mono PS, Liberation Mono, Noto Sans Mono]

/* [SBC Top Standoff Global Settings] */
// enable case top standoffs
sbc_top_standoffs = true;
// reverse standoff vertical orientation
top_standoff_reverse = true;
// enable wall support for standoffs
top_sidewall_support = false;
top_standoff_size = "m3"; //[m2_tap, m2, m2+, m2.5_tap, m2.5, m2.5+, m3_tap, m3, m3+, m4_tap, m4, m4+, custom]
top_standoff_type = "blind"; //[none, countersunk, recessed, nut holder, blind]
top_standoff_pillar = "hex"; //[hex, round]
top_standoff_diameter = 5.75; //[0:.01:10]
top_standoff_hole_size = 2.75; //[0:.01:5]
top_standoff_support_size = 10; //[0:.01:25]
top_standoff_support_height = 4; //[0:.01:50]
top_standoff_insert = false;
top_standoff_insert_dia = 4.2; //.01
top_standoff_insert_height = 5.1; //.01

/* [SBC Top Standoff Individual Settings] */
// case top - lower left standoff settings
top_rear_left_enable = true;
top_rear_left_adjust = 0; //[-30:.01:30]
top_rear_left_support = "rear"; //[none,left,rear,front,right]
// case top - upper left standoff settings
top_front_left_enable = true;
top_front_left_adjust = 0; //[-30:.01:30]
top_front_left_support = "front"; //[none,left,rear,front,right]
// case top - lower right standoff settings
top_rear_right_enable = true;
top_rear_right_adjust = 0; //[-30:.01:30]
top_rear_right_support = "rear"; //[none,left,rear,front,right]
// case top - upper right standoff settings
top_front_right_enable = true;
top_front_right_adjust = 0; //[-30:.01:30]
top_front_right_support = "front";  //[none,left,rear,front,right]

/* [    Extended Case Top Standoffs] */
// enable case extended standoffs
ext_top_standoffs = false;
ext_top_standoff_reverse = true;
// enable wall support for extended standoffs
ext_top_sidewall_support = true;
ext_top_standoff_size = "m3"; //[m2_tap, m2, m2+, m2.5_tap, m2.5, m2.5+, m3_tap, m3, m3+, m4_tap, m4, m4+, custom]
ext_top_standoff_type = "blind"; //[none, countersunk, recessed, nut holder, blind]
ext_top_standoff_pillar = "hex"; //[hex, round]
ext_top_standoff_diameter = 5.75; //[0:.01:10]
ext_top_standoff_hole_size = 2.75; //[0:.01:5]
ext_top_standoff_support_size = 10; //[0:.01:25]
ext_top_standoff_support_height = 4; //[0:.01:50]
ext_top_standoff_insert = false;
ext_top_standoff_insert_dia = 4.2; //.01
ext_top_standoff_insert_height = 5.1; //.01

/* [    Extended Case Top Standoff Individual Settings] */
// extended case top - lower left standoff settings
ext_top_rear_left_enable = true;
ext_top_rear_left_adjust = 0; //[-20:.01:20]
ext_top_rear_left_support = "rear"; //[none,left,rear,front,right]
// extended case top - upper left standoff settings
ext_top_front_left_enable = true;
ext_top_front_left_adjust = 0; //[-20:.01:20]
ext_top_front_left_support = "front"; //[none,left,rear,front,right]
// extended case top - lower right standoff settings
ext_top_rear_right_enable = true;
ext_top_rear_right_adjust = 0; //[-20:.01:20]
ext_top_rear_right_support = "rear"; //[none,left,rear,front,right]
// extended case top - upper right standoff settings
ext_top_front_right_enable = true;
ext_top_front_right_adjust = 0; //[-20:.01:20]
ext_top_front_right_support = "front";  //[none,left,rear,front,right]

/* [    Multiple PCB Top Standoffs] */
// enable multiple pcb standoffs
multipcb_top_standoffs = false;
multipcb_top_standoff_reverse = true;
// enable wall support for multiple pcb
multipcb_top_sidewall_support = false;
multipcb_top_standoff_size = "m2.5"; //[m2_tap, m2, m2+, m2.5_tap, m2.5, m2.5+, m3_tap, m3, m3+, m4_tap, m4, m4+, custom]
multipcb_top_standoff_type = "blind"; //[none, countersunk, recessed, nut holder, blind]
multipcb_top_standoff_pillar = "hex"; //[hex, round]
multipcb_top_standoff_diameter = 5.75; //[0:.01:10]
multipcb_top_standoff_hole_size = 2.75; //[0:.01:5]
multipcb_top_standoff_support_size = 7; //[0:.01:25]
multipcb_top_standoff_support_height = 4; //[0:.01:50]
multipcb_top_standoff_insert = false;
multipcb_top_standoff_insert_dia = 4.2; //.01
multipcb_top_standoff_insert_height = 5.1; //.01

/* [    Multiple PCB Top Standoff Individual Settings] */
// multiple pcb top - lower left standoff settings
multipcb_top_rear_left_enable = true;
multipcb_top_rear_left_adjust = 0; //[-20:.01:20]
multipcb_top_rear_left_support = "rear"; //[none,left,rear,front,right]
// multiple pcb - upper left standoff settings
multipcb_top_front_left_enable = true;
multipcb_top_front_left_adjust = 0; //[-20:.01:20]
multipcb_top_front_left_support = "front"; //[none,left,rear,front,right]
// multiple pcb top - lower right standoff settings
multipcb_top_rear_right_enable = true;
multipcb_top_rear_right_adjust = 0; //[-20:.01:20]
multipcb_top_rear_right_support = "rear"; //[none,left,rear,front,right]
// multiple pcb top - upper right standoff settings
multipcb_top_front_right_enable = true;
multipcb_top_front_right_adjust = 0; //[-20:.01:20]
multipcb_top_front_right_support = "front";  //[none,left,rear,front,right]

/* [SBC Bottom Standoff Global Settings] */
// enable case bottom standoffs
sbc_bottom_standoffs = true;
// reverse standoff vertical orientation
bottom_standoff_reverse = false;
// enable wall support for standoffs
bottom_sidewall_support = false;
bottom_standoff_size = "m3"; //[m2_tap, m2, m2+, m2.5_tap, m2.5, m2.5+, m3_tap, m3, m3+, m4_tap, m4, m4+, custom]
bottom_standoff_type = "countersunk"; //[none, countersunk, recessed, nut holder, blind]
bottom_standoff_pillar = "hex"; //[hex, round]
bottom_standoff_diameter = 5.75; //[2:.01:10]
bottom_standoff_hole_size = 3.4; //[0:.01:5]
bottom_standoff_support_size = 10; //[1:.01:25]
bottom_standoff_support_height = 4; //[0:.01:50]
bottom_standoff_insert = false;
bottom_standoff_insert_dia = 4.2; //.01
bottom_standoff_insert_height = 5.1; //.01

/* [SBC Bottom Standoff Individual Settings] */
// case bottom - rear left standoff settings
bottom_rear_left_enable = true;
bottom_rear_left_adjust = 0; //[-30:.01:30]
bottom_rear_left_support = "rear"; //[none,left,rear,front,right]
// case bottom - upper left standoff settings
bottom_front_left_enable = true;
bottom_front_left_adjust = 0; //[-30:.01:30]
bottom_front_left_support = "front"; //[none,left,rear,front,right]
// case bottom - lower right standoff settings
bottom_rear_right_enable = true;
bottom_rear_right_adjust = 0; //[-30:.01:30]
bottom_rear_right_support = "rear"; //[none,left,rear,front,right]
// case bottom - upper right standoff settings
bottom_front_right_enable = true;
bottom_front_right_adjust = 0; //[-30:.01:30]
bottom_front_right_support = "front"; //[none,left,rear,front,right]

/* [    Extended Case Bottom Standoffs] */
// enable case bottom extended standoffs
ext_bottom_standoffs = false;
ext_bottom_standoff_reverse = false;
// enable wall support for extended standoffs
ext_bottom_sidewall_support = true;
ext_bottom_standoff_size = "m3"; //[m2_tap, m2, m2+, m2.5_tap, m2.5, m2.5+, m3_tap, m3, m3+, m4_tap, m4, m4+, custom]
ext_bottom_standoff_type = "countersunk"; //[none, countersunk, recessed, nut holder, blind]
ext_bottom_standoff_pillar = "hex"; //[hex, round]
ext_bottom_standoff_diameter = 5.75; //[2:.01:10]
ext_bottom_standoff_hole_size = 3.4; //[0:.01:5]
ext_bottom_standoff_support_size = 10; //[1:.01:25]
ext_bottom_standoff_support_height = 4; //[0:.01:50]
ext_bottom_standoff_insert = false;
ext_bottom_standoff_insert_dia = 4.2; //.01
ext_bottom_standoff_insert_height = 5.1; //.01

/* [    Extended Case Bottom Standoff Individual Settings] */
// extended case bottom - rear left standoff settings
ext_bottom_rear_left_enable = true;
ext_bottom_rear_left_adjust = 0; //[-20:.01:20]
ext_bottom_rear_left_support = "rear"; //[none,left,rear,front,right]
// extended case bottom - upper left standoff settings
ext_bottom_front_left_enable = true;
ext_bottom_front_left_adjust = 0; //[-20:.01:20]
ext_bottom_front_left_support = "front"; //[none,left,rear,front,right]
// extended case bottom - lower right standoff settings
ext_bottom_rear_right_enable = true;
ext_bottom_rear_right_adjust = 0; //[-20:.01:20]
ext_bottom_rear_right_support = "rear"; //[none,left,rear,front,right]
// extended case bottom - upper right standoff settings
ext_bottom_front_right_enable = true;
ext_bottom_front_right_adjust = 0; //[-20:.01:20]
ext_bottom_front_right_support = "front"; //[none,left,rear,front,right]

/* [    Multiple PCB Bottom Standoffs] */
// enable multiple pcb extended standoffs
multipcb_bottom_standoffs = false;
multipcb_bottom_standoff_reverse = false;
// enable wall support for multiple pcb standoffs
multipcb_bottom_sidewall_support = false;
multipcb_bottom_standoff_size = "m2.5"; //[m2_tap, m2, m2+, m2.5_tap, m2.5, m2.5+, m3_tap, m3, m3+, m4_tap, m4, m4+, custom]
multipcb_bottom_standoff_type = "countersunk"; //[none, countersunk, recessed, nut holder, blind]
multipcb_bottom_standoff_pillar = "hex"; //[hex, round]
multipcb_bottom_standoff_diameter = 5.75; //[2:.01:10]
multipcb_bottom_standoff_hole_size = 3.4; //[0:.01:5]
multipcb_bottom_standoff_support_size = 7; //[1:.01:25]
multipcb_bottom_standoff_support_height = 4; //[0:.01:50]
multipcb_bottom_standoff_insert = false;
multipcb_bottom_standoff_insert_dia = 4.2; //.01
multipcb_bottom_standoff_insert_height = 5.1; //.01

/* [    Multiple PCB Bottom Standoff Individual Settings] */
// multiple pcb bottom - rear left standoff settings
multipcb_bottom_rear_left_enable = true;
multipcb_bottom_rear_left_adjust = 0; //[-20:.01:20]
multipcb_bottom_rear_left_support = "rear"; //[none,left,rear,front,right]
// multiple pcb bottom - upper left standoff settings
multipcb_bottom_front_left_enable = true;
multipcb_bottom_front_left_adjust = 0; //[-20:.01:20]
multipcb_bottom_front_left_support = "front"; //[none,left,rear,front,right]
// multiple pcb bottom - lower right standoff settings
multipcb_bottom_rear_right_enable = true;
multipcb_bottom_rear_right_adjust = 0; //[-20:.01:20]
multipcb_bottom_rear_right_support = "rear"; //[none,left,rear,front,right]
// multiple pcb bottom - upper right standoff settings
multipcb_bottom_front_right_enable = true;
multipcb_bottom_front_right_adjust = 0; //[-20:.01:20]
multipcb_bottom_front_right_support = "front"; //[none,left,rear,front,right]

/* [Hidden] */
a = search([accessory_name],accessory_data);
s = search([sbc_model],sbc_data);

pcb_id = sbc_data[s[0]][4];
pcb_width = sbc_data[s[0]][10][0];
pcb_depth = sbc_data[s[0]][10][1];
pcb_z_orig = sbc_data[s[0]][10][2];
pcb_tmaxz = sbc_data[s[0]][11][5];
pcb_bmaxz = sbc_data[s[0]][11][6];
pcb_color = sbc_data[s[0]][11][1];
pcb_radius = sbc_data[s[0]][11][0];

pcb_z = sbc_model == "ssi-eeb" || sbc_model == "ssi-ceb" || sbc_model == "atx" || sbc_model == "micro-atx" || sbc_model == "dtx" || sbc_model == "flex-atx" || sbc_model == "mini-dtx" || sbc_model == "mini-itx" || sbc_model == "mini-itx_thin" || sbc_model == "mini-stx" || sbc_model == "mini-stx_thin" || sbc_model == "nano-itx" || sbc_model == "nuc" || sbc_model == "pico-itx" ? pcb_z_orig + standard_motherboard_thickness : pcb_z_orig;
width = case_design == "panel_nas" && pcb_width <= 100 ? pcb_width+2*(sidethick+gap)+case_offset_x+(101.6-pcb_width) : case_design == "panel_nas" && pcb_width > 100 ? pcb_width+2*(sidethick+gap)+case_offset_x : case_design == "rack" && rack_width == 19 ? 450 : case_design == "rack" && rack_width == 10 ? 221.5 : pcb_width+(2*(wallthick+gap))+case_offset_x;
depth = case_design == "panel_nas" ? pcb_depth+2*(wallthick+gap)+case_offset_y + 147-pcb_depth+hd_y_position : case_design == "rack" ? 100+case_offset_y : pcb_depth+2*(wallthick+gap)+case_offset_y;
top_height = pcb_tmaxz+floorthick+case_offset_tz+pcb_loc_z;
bottom_height = (case_design == "tray" || case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") ? pcb_z+pcb_bmaxz+floorthick+case_offset_bz+4 : pcb_z+pcb_bmaxz+floorthick+case_offset_bz;
case_z = case_design == "panel_nas" ? bottom_height+top_height+hd_z_position+(hd_bays * (hd_space + 26.1)) : case_design == "rack" && rack_size == "1u" ? 44.45+floorthick : case_design == "rack" && rack_size == "1u+" ? 59.26+floorthick : case_design == "rack" && rack_size == "1u++" ? 74.07+floorthick : case_design == "rack" && rack_size == "2u" ? 88.90+floorthick : bottom_height+top_height;
case_diameter = sqrt(pow(width-wallthick-gap,2)+pow(depth-wallthick-gap,2));
hex_diameter = sqrt(pow(width+2*(wallthick+gap),2)+pow(depth+2*(wallthick+gap),2));
hd_spacer = case_design == "panel_nas" && pcb_width > 100 ? (pcb_width+case_offset_x+2*gap)-101.6 : 
    case_design == "panel_nas" && pcb_width <= 100 ? (width-2*(sidethick+gap)-101.6) : 0;

top_standoff = [top_standoff_size,
                top_standoff_diameter,
                18,
                top_standoff_hole_size,
                top_standoff_support_size,
                top_standoff_support_height,
                top_standoff_type,
                top_standoff_pillar,
                top_rear_left_support,
                top_standoff_reverse,
                top_standoff_insert,
                top_standoff_insert_dia,
                top_standoff_insert_height];

bottom_standoff = [bottom_standoff_size,
                   bottom_standoff_diameter,
                   6,
                   bottom_standoff_hole_size,
                   bottom_standoff_support_size,
                   bottom_standoff_support_height,
                   bottom_standoff_type,
                   bottom_standoff_pillar,
                   bottom_rear_left_support,
                   bottom_standoff_reverse,
                   bottom_standoff_insert,
                   bottom_standoff_insert_dia,
                   bottom_standoff_insert_height];
                   
ext_top_standoff = [ext_top_standoff_size,
                    ext_top_standoff_diameter,
                    18,
                    ext_top_standoff_hole_size,
                    ext_top_standoff_support_size,
                    ext_top_standoff_support_height,
                    ext_top_standoff_type,
                    ext_top_standoff_pillar,
                    ext_top_rear_left_support,
                    ext_top_standoff_reverse,
                    ext_top_standoff_insert,
                    ext_top_standoff_insert_dia,
                    ext_top_standoff_insert_height];
                    
ext_bottom_standoff = [ext_bottom_standoff_size,
                       ext_bottom_standoff_diameter,
                       6,
                       ext_bottom_standoff_hole_size,
                       ext_bottom_standoff_support_size,
                       ext_bottom_standoff_support_height,
                       ext_bottom_standoff_type,
                       ext_bottom_standoff_pillar,
                       ext_bottom_rear_left_support,
                       ext_bottom_standoff_reverse,
                       ext_bottom_standoff_insert,
                       ext_bottom_standoff_insert_dia,
                       ext_bottom_standoff_insert_height];
                       
multipcb_top_standoff = [multipcb_top_standoff_size,
                multipcb_top_standoff_diameter,
                18,
                multipcb_top_standoff_hole_size,
                multipcb_top_standoff_support_size,
                multipcb_top_standoff_support_height,
                multipcb_top_standoff_type,
                multipcb_top_standoff_pillar,
                multipcb_top_rear_left_support,
                multipcb_top_standoff_reverse,
                multipcb_top_standoff_insert,
                multipcb_top_standoff_insert_dia,
                multipcb_top_standoff_insert_height];
                
multipcb_bottom_standoff = [multipcb_bottom_standoff_size,
                   multipcb_bottom_standoff_diameter,
                   6,
                   multipcb_bottom_standoff_hole_size,
                   multipcb_bottom_standoff_support_size,
                   multipcb_bottom_standoff_support_height,
                   multipcb_bottom_standoff_type,
                   multipcb_bottom_standoff_pillar,
                   multipcb_bottom_rear_left_support,
                   multipcb_bottom_standoff_reverse,
                   multipcb_bottom_standoff_insert,
                   multipcb_bottom_standoff_insert_dia,
                   multipcb_bottom_standoff_insert_height];

rack_bay_sbc = [Rack_Bay1,Rack_Bay2,Rack_Bay3,Rack_Bay4,Rack_Bay5,Rack_Bay6];

rack_bay_xyz_loc = [[rack_bay1_xyz_loc[0],rack_bay1_xyz_loc[1],rack_bay1_xyz_loc[2]], 
                    [rack_bay2_xyz_loc[0],rack_bay2_xyz_loc[1],rack_bay2_xyz_loc[2]],
                    [rack_bay3_xyz_loc[0],rack_bay3_xyz_loc[1],rack_bay3_xyz_loc[2]],
                    [rack_bay4_xyz_loc[0],rack_bay4_xyz_loc[1],rack_bay4_xyz_loc[2]],
                    [rack_bay5_xyz_loc[0],rack_bay5_xyz_loc[1],rack_bay5_xyz_loc[2]],
                    [rack_bay6_xyz_loc[0],rack_bay6_xyz_loc[1],rack_bay6_xyz_loc[2]]];

rack_bay_rotation = [rack_bay1_rotation, rack_bay2_rotation, rack_bay3_rotation, rack_bay4_rotation, rack_bay5_rotation, rack_bay6_rotation];
rack_bay_face = [rack_bay1_face, rack_bay2_face, rack_bay3_face, rack_bay4_face, rack_bay5_face, rack_bay6_face];
rack_bay_wall = [rack_bay1_wall, rack_bay2_wall, rack_bay3_wall, rack_bay4_wall, rack_bay5_wall, false];
rack_bay_rear_fan = [rack_bay1_rear_fan, rack_bay2_rear_fan, rack_bay3_rear_fan, rack_bay4_rear_fan, rack_bay5_rear_fan, rack_bay6_rear_fan];
rack_bay_rear_conduit = [rack_bay1_rear_conduit, rack_bay2_rear_conduit, rack_bay3_rear_conduit, rack_bay4_rear_conduit, rack_bay5_rear_conduit, rack_bay6_rear_conduit];
baysize = (450-(2*wallthick))/6;
bay_height = rack_size == "1u" ? 44.45-floorthick : 
            rack_size == "1u+" ? (44.45/3)+44.45-floorthick : 
            rack_size == "1u++" ? 2*(44.45/3)+44.45-floorthick : (2 * 44.45)-floorthick;

adj = .01;
$fn=90;

// platter view
if (view == "platter") {
    if(case_design == "shell") {
        case_bottom(case_design);
        translate([0,(2*depth)+20,case_z]) rotate([180,0,0]) case_top(case_design);
    }
    if(case_design == "panel" || case_design == "panel_nas") {
        case_bottom(case_design);
        translate([0,(2*depth)+5,case_z]) rotate([180,0,0]) case_top(case_design);
        translate([width+25,0,-gap]) rotate([-90,0,0]) case_side(case_design,"rear");
        translate([width+25,2*(case_z)+10,-depth+wallthick+gap+floorthick]) 
            rotate([90,0,0]) case_side(case_design,"front");
        translate([2.5*width,0,-width+(3*sidethick)+gap]) rotate([0,-90,-90]) 
            case_side(case_design,"right");
        translate([-20,0,-gap]) rotate([0,90,90]) 
            case_side(case_design,"left");
        // nas hd spacers
        if(case_design == "panel_nas" && (pcb_width > 100 || width > 112)) {
            if(hd_center == false) {
                translate([0,-35,0]) rotate([270,0,0]) cableholder_spacer(hd_spacer-9.4);
            }
            else {
                translate([0,-35,0]) rotate([270,0,0]) cableholder_spacer(hd_spacer/2-9.4);
            }
        }
    }
    if(case_design == "stacked") {
        case_bottom(case_design);
        translate([0,(2*depth)+20,case_z]) rotate([180,0,0]) case_top(case_design);
    }
    if(case_design == "tray" || case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
        case_bottom(case_design);
        translate([0,(2*depth)+10,case_z]) rotate([180,0,0]) case_top(case_design);
        if(case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
            translate([3.5*width,0,width]) rotate([0,90,90]) 
                case_side(case_design,"right");
            translate([width+15,0,2*sidethick]) rotate([0,-90,-90]) 
                case_side(case_design,"left");
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
    if(case_design == "rack") {
        case_rack(case_design,"bottom");
        translate([0,(2*depth)+20,case_z+floorthick]) rotate([180,0,0]) case_rack(case_design,"top");
        // rear fan covers
        ucount = rack_width == 10 ? 3 : len(rack_bay_sbc)-1;
        for(r = [0:ucount-1]) {
            fan_offset = -75+(75-rear_fan_size)/2;
            if(rack_bay_rear_fan[r] == true) {
                translate([-gap-wallthick-1+.125+75*(r+1)+fan_offset+8,
                    -80,(case_z-rear_fan_size)/2])
                        fan_cover(rear_fan_size, wallthick, rear_cooling);
            }
        }
        // rear grommets
        for(r = [0:len(rack_bay_sbc)-1]) {
            grommet_offset = -75+11;
            if(rack_bay_rear_conduit[r] == "grommet") {
                translate([0,-50,0]) rotate([270,0,0]) difference() {
                translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset,0,0])
                    grommet("bottom", "sleeve", 10, r+2, wallthick, false, [false,10,0,"default"]);
                    translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset-10,-.125,-3]) cube([20,10,20]);
                }
                translate([0,-30,0]) rotate([270,0,0]) difference() {
                translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset,0,0])
                    grommet("bottom", "sleeve", 10, r+2, wallthick, false, [false,10,0,"default"]);
                    translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset-10,-.125,-3]) cube([20,10,20]);
                }
                translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset,-70,0])
                    grommet_clip("sleeve", 10, r+2, wallthick);
            }
        }
        for(r = [0:ucount-1]) {
            if(rack_bay_face[r] == "removable") {
                translate([-gap-wallthick-1+(75*(r))+8,-300,0]) bay_tray(depth-2*wallthick-gap-.5-tol,r);
            }
        }
    }
    if(case_design == "adapter_mini-stx_thin" || case_design == "adapter_mini-stx" || case_design == "adapter_mini-itx_thin" || case_design == "adapter_mini-itx" || case_design == "adapter_flex-atx" || case_design == "adapter_mini-dtx" || case_design == "adapter_dtx" || case_design == "adapter_micro-atx" || case_design == "adapter_atx" || case_design == "adapter_ssi-ceb" || case_design == "adapter_ssi-eeb") {
        color("dimgrey",1) case_adapter(case_design);
        color("dimgrey",1) translate([-180, 0, 4]) rotate([270,0,0]) io_shield();
    }
    // ui access panel
    if(bottom_access_panel_enable == true) {
        if(access_panel_rotation == 0) {
            translate([0,-1.25*depth, 0]) rotate([0,0,access_panel_rotation]) 
                access_cover([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation);
        }
    }
    // platter accessories
    if(accessory_name != "none") {
        for (i=[1:11:len(accessory_data[a[0]])-1]) {
            class = accessory_data[a[0]][i];
            type = accessory_data[a[0]][i+1];
            loc_x = accessory_data[a[0]][i+2];
            loc_y = accessory_data[a[0]][i+3];
            loc_z = accessory_data[a[0]][i+4];
            face = accessory_data[a[0]][i+5];
            rotation = accessory_data[a[0]][i+6];
            parametric = accessory_data[a[0]][i+7];
            size_x = accessory_data[a[0]][i+8][0];
            size_y = accessory_data[a[0]][i+8][1];
            size_z = accessory_data[a[0]][i+8][2];
            data_1 = accessory_data[a[0]][i+9][0];
            data_2 = accessory_data[a[0]][i+9][1];
            data_3 = accessory_data[a[0]][i+9][2];
            data_4 = accessory_data[a[0]][i+9][3];
            mask = accessory_data[a[0]][i+10];
            
            if (class == "platter" && type != "button_assembly") {
                add(type, loc_x, loc_y, loc_z, face, rotation, [size_x, size_y, size_z], [data_1, data_2, data_3, data_4], mask);
            }
            if (class == "platter" && type == "button_assembly") {
                translate([loc_x,loc_y,loc_z+1.25]) rotate([-90,0,0]) button_plunger(data_1, size_x, size_z);
                translate([loc_x-20,loc_y-10,loc_z+3]) rotate([0,0,0]) button_top(data_1, size_x, size_z);
                translate([loc_x-20,loc_y-20,loc_z]) rotate([0,0,0]) button_clip(data_1);
            }
            if (class == "platter" && type == "h3_port_extender_holder") {
                translate([loc_x,loc_y,loc_z]) rotate([0,0,0]) h3_port_extender_holder("bottom");
                translate([loc_x-20,loc_y+40,loc_z+36.5]) rotate([180,0,0]) h3_port_extender_holder("top");
            }
        }
    }
    if(case_design == "paper_split-top" || case_design == "paper_full-top") {
        case_folded(case_design);
    }
}

// model view
if (view == "model") {    
//    translate([(-width+(gap+wallthick))/2,(-depth+(gap+wallthick))/2,0]) rotate([0,0,0]){
    text_offset = 25;
    text_height = case_z + (len(sbc_data[s[0]][1]) * 7);
    text_indent = [0,-32.5,4,0,-20.5,-8,4,4,4,4,-12,-16,-4,-12.5,-8,-4,-12,0,4,0,4,8,-.5,-12.5,-4.5,-8.5,0,-8];
    ctext_offset = 15;
    ctext_height = 130;

        if(case_design == "shell") {
            if(lower_bottom >= 0) {
                difference() {
                    color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-2*(gap+wallthick),-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-2*(gap+wallthick),-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1,depth+2,case_z+2]);
                    }
                }
            }
            if(raise_top >= 0) {
                difference() {
                    color("grey",1) translate([0,0,raise_top]) case_top(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-2*(gap+wallthick),-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-2*(gap+wallthick),-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1,depth+2,case_z+2]);
                    }
                }
            }
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
            }
        }
        if(case_design == "panel") {
            if(lower_bottom >= 0) {
                color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
            }
            if(raise_top >= 0) {
                color("grey",1) translate([0,0,raise_top])case_top(case_design);
            }
            if(move_front >= 0) {
                color("grey",1) translate([0,move_front,0]) case_side(case_design,"front");
            }
            if(move_rear >= 0) {
                color("grey",1) translate([0,-move_rear,0]) case_side(case_design,"rear");
            }
            if(move_rightside >= 0) {
                color("grey",1) translate([move_rightside,0,0]) case_side(case_design,"right");
            }
            if(move_leftside >= 0) {
                color("grey",1) translate([-move_leftside,0,0]) case_side(case_design,"left");
            }
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
            }
        }
        if(case_design == "panel_nas") {
            if(lower_bottom >= 0) {
                color("grey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
            }
            if(raise_top >= 0) {
                color("grey",1) translate([0,0,raise_top])case_top(case_design);
            }
            if(move_front >= 0) {
                color("grey",1) translate([0,move_front,0]) case_side(case_design,"front");
            }
            if(move_rear >= 0) {
                color("grey",1) translate([0,-move_rear,0]) case_side(case_design,"rear");
            }
            if(move_rightside >= 0) {
                color("dimgrey",1) translate([move_rightside,0,0]) case_side(case_design,"right");
            }
            if(move_leftside >= 0) {
                color("dimgrey",1) translate([-move_leftside,0,0]) case_side(case_design,"left");
            }
            if(sbc_off == false && nas_sbc_location == "bottom") {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
            }
            if(sbc_off == false && nas_sbc_location == "top") {
                translate([pcb_loc_x ,pcb_loc_y,case_z-(top_height+pcb_loc_z+(2*floorthick))+.5])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
            }
            for( i=[0:1:hd_bays-1]) {
                if(hd_reverse == false) {
                    if(hd_center == false) {
                        translate([-gap,-(3*wallthick)-gap+hd_y_position,hd_z_position+(hd_space+27.1)*i]) 
                            hd35("portrait", [false,0,0,"default"]);
                        if(pcb_width > 100 || width-2*(sidethick+gap) > 101.6) {
                            translate([101.6-gap+hd_spacer-9.4,
                                28.5-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer-9.4);

                            translate([101.6-gap+hd_spacer-9.4,
                                -31-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer-9.4);

                            translate([101.6-gap+hd_spacer-9.4,
                                -73-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer-9.4);
                        }
                    }
                    if(hd_center == true) {
                        translate([-gap+hd_spacer/2,
                            -(3*wallthick)-gap+hd_y_position,hd_z_position+(hd_space+27.1)*i]) 
                                hd35("portrait", [false,0,0,"default"]);
                        if(pcb_width > 100 || width-2*(sidethick+gap) > 101.6) {
                            // right side spacers
                            translate([101.6-gap+hd_spacer-9.4,
                                28.5-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer/2-9.4);

                            translate([101.6-gap+hd_spacer-9.4,
                                -31-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer/2-9.4);

                            translate([101.6-gap+hd_spacer-9.4,
                                -73-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer/2-9.4);
                            // left side spacers
                            translate([-(hd_spacer/2-9.4)-gap+hd_spacer/2,
                                28.5-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) rotate([0,0,180]) 
                                        cableholder_spacer(hd_spacer/2-9.4);

                            translate([-(hd_spacer/2-9.4)-gap+hd_spacer/2,
                                -31-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) rotate([0,0,180]) 
                                        cableholder_spacer(hd_spacer/2-9.4);

                            translate([-(hd_spacer/2-9.4)-gap+hd_spacer/2,
                                -73-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) rotate([0,0,180]) 
                                        cableholder_spacer(hd_spacer/2-9.4);
                        }
                    }
                }
                if(hd_reverse == true) {
                    if(hd_center == false) {
                        translate([101.6-gap,-(3*wallthick)-gap+hd_y_position+147,
                            hd_z_position+(hd_space+27.1)*i]) 
                                rotate([0,0,180]) hd35("portrait", [false,0,0,"default"]);
                        if(pcb_width > 100 || width-2*(sidethick+gap) > 101.6) {
                            translate([101.6-gap+hd_spacer-9.4,
                                17-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer-9.4);

                            translate([101.6-gap+hd_spacer-9.4,
                                -25-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer-9.4);
                            translate([101.6-gap+hd_spacer-9.4,
                                -84.5-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer-9.4);
                        }
                    }
                    if(hd_center == true) {
                        translate([101.6-gap+hd_spacer/2,
                            -(3*wallthick)-gap+hd_y_position+147,
                                hd_z_position+(hd_space+27.1)*i]) 
                                    rotate([0,0,180]) hd35("portrait", [false,0,0,"default"]);
                        if(pcb_width > 100 || width-2*(sidethick+gap) > 101.6) {
                            // right side spacers
                            translate([101.6-gap+hd_spacer-9.4,
                                17-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer/2-9.4);

                            translate([101.6-gap+hd_spacer-9.4,
                                -25-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer/2-9.4);

                            translate([101.6-gap+hd_spacer-9.4,
                                -84.5-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) 
                                        cableholder_spacer(hd_spacer/2-9.4);
                            // left side spacers
                            translate([-(hd_spacer/2-9.4)-gap+hd_spacer/2,
                                17-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) rotate([0,0,180]) 
                                        cableholder_spacer(hd_spacer/2-9.4);

                            translate([-(hd_spacer/2-9.4)-gap+hd_spacer/2,
                                -25-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) rotate([0,0,180]) 
                                        cableholder_spacer(hd_spacer/2-9.4);

                            translate([-(hd_spacer/2-9.4)-gap+hd_spacer/2,
                                -84.5-(3*wallthick)-gap+hd_y_position+101.6,
                                    hd_z_position+6.5+(hd_space+27.1)*i]) rotate([0,0,180]) 
                                        cableholder_spacer(hd_spacer/2-9.4);
                        }
                    }
                }
            }
            if(move_rear >= 0) {
                fan_model = rear_fan_size == 92 ? "box92x10" : rear_fan_size == 80 ? "box80x10" : rear_fan_size == 60 ? "box60x10" : "box40x10";
                if(rear_fan == 1 || rear_fan == 2) {
                    if(rear_fan_center == false) {
                        translate([-1+(101.6-rear_fan_size)/2,10-wallthick,rear_fan_position]) 
                            rotate([90,0,0]) fans(fan_model,[false,0,0,"default"]);
                    }
                    if(rear_fan_center == true) {
                        translate([-1+(101.6-rear_fan_size)/2+(width-2*(sidethick+gap)-101.6)/2,
                            10-wallthick,rear_fan_position]) rotate([90,0,0]) 
                                fans(fan_model,[false,0,0,"default"]);
                    }
                }
                if(rear_fan == 2) {
                    if(rear_fan_center == false) {
                        translate([-1+(101.6-rear_fan_size)/2,10-wallthick,
                            rear_fan_position+rear_dualfan_spacing+rear_fan_size]) 
                                rotate([90,0,0]) fans(fan_model,[false,0,0,"default"]);
                    }
                    if(rear_fan_center == true) {
                        translate([-1+(101.6-rear_fan_size)/2+(width-2*(sidethick+gap)-101.6)/2,
                            10-wallthick,rear_fan_position+rear_dualfan_spacing+rear_fan_size]) 
                                rotate([90,0,0]) fans(fan_model,[false,0,0,"default"]);
                    }
                }
            }
        }
        if(case_design == "stacked") {
            if(lower_bottom >= 0) {
                color("grey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
            }
            if(raise_top >= 0) {
                color("grey",1) translate([0,0,raise_top]) case_top(case_design);
            }
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
            }
        }
        if(case_design == "tray" || case_design == "tray_sides" || case_design == "tray_vu5" || case_design == "tray_vu7") {
            if(lower_bottom >= 0) {
                difference() {
                    color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-sidethick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([width+2*sidethick+2,gap+wallthick+1.01,case_z+5]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-sidethick-1,depth-2*(gap+wallthick),-lower_bottom-1]) 
                            cube([width+2*sidethick+2,gap+wallthick+1.01,case_z+5]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-sidethick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+2*sidethick+1.01,depth+2,case_z+5]);
                    }
                    if(move_rightside < 0) {
                        translate([width-sidethick-2*(gap+wallthick),-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+2*sidethick+1,depth+2,case_z+5]);
                    }
                }
            }
            if(raise_top >= 0) {
                difference() {
                    color("grey",1) translate([0,0,raise_top]) case_top(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-sidethick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([width+2*sidethick+2,gap+wallthick+1.01,case_z+5]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-sidethick-1,depth-2*(gap+wallthick),-lower_bottom-1]) 
                            cube([width+2*sidethick+2,gap+wallthick+1.01,case_z+5]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-sidethick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+2*sidethick+1.01,depth+2,case_z+5]);
                    }
                    if(move_rightside < 0) {
                        translate([width-sidethick-2*(gap+wallthick),-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+2*sidethick+1,depth+2,case_z+5]);
                    }
                }
            }
            if(case_design == "tray_sides" || case_design == "tray_vu5" || case_design == "tray_vu7") {
                if(move_rightside >= 0) {
                    color("grey",1) translate([move_rightside,0,0]) case_side(case_design,"right");
                }
                if(move_leftside >= 0) {
                    color("grey",1) translate([-move_leftside,0,0]) case_side(case_design,"left");
                }
            }
            if(case_design == "tray_vu5") {
                color("darkgrey",.5) translate([width+((127.5-width)/2)-6.5-wallthick-gap,
                    depth-1,case_z+15.5]) rotate([-15,0,180]) 
                        import(file = "stl/Vu5a_Case.stl");            
                // right speaker and bracket
                color("darkgrey",.5) 
                    translate([((127.5-75)/2)+(width/2)-wallthick-gap+30.5,depth-1,
                        case_z+15]) rotate([75,0,180]) 
                            import(file = "stl/Vu5_Speaker_Bracket_Left.stl");
                color("darkgrey",.5) translate([((127.5-75)/2)+(width/2)-wallthick-gap+85,depth+15,
                    case_z+12.5]) rotate([-15,0,180]) hk_speaker();
                // left speaker and bracket
                color("darkgrey",.5) translate([-((127.5-75)/2)+(width/2)-wallthick-gap-30.5,depth-1,
                    case_z+15]) rotate([75,0,180])
                        import(file = "stl/Vu5_Speaker_Bracket_Right.stl");
                color("darkgrey",.5) translate([-((127.5-75)/2)+(width/2)-wallthick-gap-40.5,depth+15,
                    case_z+12.5]) rotate([-15,0,180]) hk_speaker();
            }
            if(case_design == "tray_vu7") {
                color("darkgrey",.5) translate([width+((192.90-width)/2)-wallthick-gap-20,
                    depth-1,case_z+15.5]) rotate([-15,0,180]) 
                        import(file = "stl/Vu7a_Case.stl");            
                // right speaker and bracket
                color("darkgrey",.5) 
                    translate([((192.90-100)/2)+(width/2)-wallthick-gap+57.5,depth-4,
                        case_z+27]) rotate([75,0,180]) 
                            import(file = "stl/Vu7_Speaker_Bracket_Left.stl");
                color("darkgrey",.5) translate([((192.90-100)/2)+(width/2)-wallthick-gap+97,depth+11.5,
                    case_z+27]) rotate([-15,0,180]) hk_speaker();
                // left speaker and bracket
                color("darkgrey",.5) translate([-((192.90-100)/2)+(width/2)-wallthick-gap-58,depth-4,
                    case_z+27]) rotate([75,0,180])
                        import(file = "stl/Vu7_Speaker_Bracket_Right.stl");
                color("darkgrey",.5) translate([-((192.90-100)/2)+(width/2)-wallthick-gap-53.5,depth+11.5,
                    case_z+27]) rotate([-15,0,180]) hk_speaker();
            }
            if(sbc_off == false) {
                translate([pcb_loc_x,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
            }
        } 
        if(case_design == "round" || case_design == "hex") {
            if(lower_bottom >= 0) {
                color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
            }
            if(raise_top >= 0) {
                color("grey",1) translate([0,0,raise_top]) case_top(case_design);
            }        
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
            }
        }
        if(case_design == "snap" || case_design == "fitted") {
            if(lower_bottom >= 0) {
                difference() {
                    color("dimgrey",1) translate([0,0,-lower_bottom]) case_bottom(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-2*(gap+wallthick),-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-2*(gap+wallthick),-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1,depth+2,case_z+2]);
                    }
                }
            }
            if(raise_top >= 0) {
                difference() {
                    color("grey",1) translate([0,0,raise_top]) case_top(case_design);
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-2*(gap+wallthick),-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-2*(gap+wallthick),-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1,depth+2,case_z+2]);
                    }
                }
            }        
            if(sbc_off == false) {
                translate([pcb_loc_x ,pcb_loc_y,bottom_height-pcb_z+pcb_loc_z-adj])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
            }
        }
        if(case_design == "rack") {
            if(lower_bottom >= 0) {
                difference() {
                    color("dimgrey",1) translate([0,0,-lower_bottom]) case_rack(case_design,"bottom");
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-2*(gap+wallthick),-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-2*(gap+wallthick),-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1,depth+2,case_z+2]);
                    }
                }
            }
            if(raise_top >= 0) {
                difference() {
                    color("dimgrey",1) translate([0,0,raise_top]) case_rack(case_design,"top");
                    if(move_rear < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_front < 0) {
                        translate([-gap-wallthick-1,depth-2*(gap+wallthick),-lower_bottom-1]) 
                            cube([width+2,gap+wallthick+1.01,case_z+2]);
                    }
                    if(move_leftside < 0) {
                        translate([-gap-wallthick-1,-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1.01,depth+2,case_z+2]);
                    }
                    if(move_rightside < 0) {
                        translate([width-2*(gap+wallthick),-gap-wallthick-1,-lower_bottom-1]) 
                            cube([gap+wallthick+1,depth+2,case_z+2]);
                    }
                }
            } 
            ucount = rack_width == 10 ? 2 : len(rack_bay_sbc)-1;
            // rear fan covers
            for(r = [0:ucount]) {
                fan_offset = -75+(75-rear_fan_size)/2;
                if(rack_bay_rear_fan[r] == true) {
                    translate([-gap-wallthick-1+.125+75*(r+1)+fan_offset+8,
                        depth-gap,(case_z-rear_fan_size)/2])
                            rotate([90,0,0]) fan_cover(rear_fan_size, wallthick, rear_cooling);
                }
            // rear grommets
            grommet_offset = -75+11;
            if(rack_bay_rear_conduit[r] == "grommet" || rack_bay_rear_conduit[r] == "grommets-vertical") {
                translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset+4,depth-wallthick-gap,13])
                    color("lightgrey") grommet("front", "sleeve", 10, 4, wallthick, true, [false,10,0,"default"]);
            }
            if(rack_bay_rear_conduit[r] == "grommets-vertical") {
                translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset+4,depth-wallthick-gap,30])
                    color("lightgrey") grommet("front", "sleeve", 10, 4, wallthick, true, [false,10,0,"default"]);
            }
            
            // bay inserts
            bayadj = r == 0 ? -75.5 : r == 5 ? -74.75: -75;
            if(rack_bay_face[r] == "removable" && r ==0 && rack_bay_sbc[r] != "none") {
                color("gray") translate([bayadj+75*(r+1),0,floorthick]) 
                    bay_tray(depth-2*wallthick-gap-.5-tol,r);
            }
            if(rack_bay_face[r] == "removable" && r !=0 && rack_bay_sbc[r] != "none") {
                color("gray") translate([bayadj+75*(r+1),0,floorthick]) 
                    bay_tray(depth-2*wallthick-gap-.5-tol,r);
            }
        }
        // sbc placement
        if(sbc_off == false) {
            for(i = [0:len(rack_bay_sbc)-1]) {
                if(rack_bay_sbc[i] != "none" && rack_bay_face[i] != "removable") {
                    s = search([rack_bay_sbc[i]],sbc_data);
                    pcb_id = sbc_data[s[0]][4];
                    pcb_width = sbc_data[s[0]][10][0];
                    pcb_depth = sbc_data[s[0]][10][1];
                    pcb_z_orig = sbc_data[s[0]][10][2];
                    pcb_tmaxz = sbc_data[s[0]][11][5];
                    pcb_bmaxz = sbc_data[s[0]][11][6];

                    pcb_loc_x = rack_bay_rotation[i] == 90 ? rack_bay_xyz_loc[i][0] + pcb_width : rack_bay_rotation[i] == 180 ? rack_bay_xyz_loc[i][0] + pcb_width : rack_bay_xyz_loc[i][0];
                    pcb_loc_y = rack_bay_rotation[i] == 270 ? rack_bay_xyz_loc[i][1]+pcb_width : rack_bay_rotation[i] == 180 ? rack_bay_xyz_loc[i][1]+pcb_depth : rack_bay_xyz_loc[i][1];
                    pcb_loc_z = rack_bay_sbc[i] == "n2+" ? rack_bay_xyz_loc[i][2]+1.5 : rack_bay_xyz_loc[i][2];

                    translate([pcb_loc_x ,pcb_loc_y,pcb_bmaxz+floorthick+case_offset_bz+pcb_loc_z]) 
                        rotate([0,0,rack_bay_rotation[i]])
                            sbc(rack_bay_sbc[i], cooling, fan_size, gpio_opening, uart_opening, false);
                }
                if(rack_bay_sbc[i] != "none" && rack_bay_face[i] == "removable") {
                    bayadj = i == 0 ? -75.5 : i == 5 ? -74.75: -75;
                    s = search([rack_bay_sbc[i]],sbc_data);
                    pcb_id = sbc_data[s[0]][4];
                    pcb_width = sbc_data[s[0]][10][0];
                    pcb_depth = sbc_data[s[0]][10][1];
                    pcb_z_orig = sbc_data[s[0]][10][2];
                    pcb_tmaxz = sbc_data[s[0]][11][5];
                    pcb_bmaxz = sbc_data[s[0]][11][6];

                    pcb_loc_x = rack_bay_rotation[i] == 90 ? rack_bay_xyz_loc[i][0] + pcb_width : 
                        rack_bay_rotation[i] == 180 ? rack_bay_xyz_loc[i][0] + pcb_width : 
                        rack_bay_xyz_loc[i][0];
                    pcb_loc_y = rack_bay_rotation[i] == 270 ? rack_bay_xyz_loc[i][1]+pcb_width : 
                        rack_bay_rotation[i] == 180 ? rack_bay_xyz_loc[i][1]+pcb_depth : 
                        rack_bay_xyz_loc[i][1];
                    pcb_loc_z = rack_bay_xyz_loc[i][2];

                    translate([pcb_loc_x+bayadj+75*(i+1) ,pcb_loc_y+wallthick+gap, 
                        pcb_bmaxz+floorthick+case_offset_bz+pcb_loc_z+1]) rotate([0,0,rack_bay_rotation[i]])
                            sbc(rack_bay_sbc[i], cooling, fan_size, gpio_opening, uart_opening, false);
                    }
                }
            }
        }
        if(case_design == "adapter_mini-stx_thin" || case_design == "adapter_mini-stx" || case_design == "adapter_mini-itx_thin" || case_design == "adapter_mini-itx" || case_design == "adapter_flex-atx" || case_design == "adapter_mini-dtx" || case_design == "adapter_dtx" || case_design == "adapter_micro-atx" || case_design == "adapter_atx" || case_design == "adapter_ssi-ceb" || case_design == "adapter_ssi-eeb") {
            color("dimgrey",1) case_adapter(case_design);
            if(sbc_off == false) {
                pcbloc_x = adapter_sbc_rotation == 90 ? pcb_loc_x + pcb_depth : 
                    adapter_sbc_rotation == 180 ? pcb_loc_x + pcb_width : pcb_loc_x;
                pcbloc_y = adapter_sbc_rotation == 270 ? pcb_loc_y+pcb_width : 
                    adapter_sbc_rotation == 180 ? pcb_loc_y+pcb_depth : pcb_loc_y;
                pcbloc_z = sbc_model == "n2" || sbc_model == "m1" ? pcb_loc_z-6 : 
                    sbc_model == "n2+" ? pcb_loc_z-4.5 : pcb_loc_z;
                translate([pcbloc_x ,pcbloc_y,bottom_height-case_offset_bz-pcb_z+pcbloc_z]) rotate([0,0,adapter_sbc_rotation])
                    sbc(sbc_model, cooling, fan_size, gpio_opening, uart_opening, false);
            }
            if(rear_io_shield == true) {
                if(case_design == "adapter_mini-stx_thin" || case_design == "adapter_mini-stx") {
                    color("dimgrey",1) translate([-1.2,-4.5,-2]) io_shield();
                }
                else {
                    color("dimgrey",1) translate([-10.79,-4.5,-2]) io_shield();
                }
            }
        }
        // ui access panel
        if(bottom_access_panel_enable == true) {
            if(access_panel_rotation == 0) {
                translate([access_panel_location[0],access_panel_location[1], 0]) rotate([0,0,access_panel_rotation]) 
                    color("grey",1) access_cover([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation);
            }
            if(access_panel_rotation == 90) {
                translate([access_panel_location[0]+access_panel_size[1],access_panel_location[1], 0]) rotate([0,0,access_panel_rotation]) 
                    color("grey",1) access_cover([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation);
            }
            if(access_panel_rotation == 180) {
                translate([access_panel_location[0]+access_panel_size[0],access_panel_location[1]+access_panel_size[1],0]) rotate([0,0,access_panel_rotation]) 
                    color("grey",1) access_cover([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation);
            }
            if(access_panel_rotation == 270) {
                translate([access_panel_location[0],access_panel_location[1]+access_panel_size[0], 0]) rotate([0,0,access_panel_rotation]) 
                    color("grey",1) access_cover([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation);
            }
        }
        // model accessories
        if(accessory_name != "none") {
            for (i=[1:11:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size = accessory_data[a[0]][i+8];
                data = accessory_data[a[0]][i+9];
                mask = accessory_data[a[0]][i+10];

                if (class == "model" && face == "top" && raise_top > -1) {
                    parametric_move_add(type, loc_x, loc_y, loc_z+raise_top, face, rotation, parametric, size, data, [false,mask[1],mask[2],mask[3]]);
                }
                else {
                    if (class == "model" && face != "top" ) {
                        parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric, size, data, [false,mask[1],mask[2],mask[3]]);
                    }
                }    
            }
        }
        if((case_design == "paper_split-top" || case_design == "paper_full-top") && flat_blank_section == false) {
            case_folded(case_design);
        }
        if((case_design == "paper_split-top" || case_design == "paper_full-top") && flat_blank_section == true) {
            projection() case_folded(case_design);
        }
        // create sbc information text
        if(sbc_information == true) {
            for (i=[0:1:len(sbc_data[s[0]][1])-1]) {
                color(text_color) 
                    translate([text_offset + text_indent[i], depth, (text_height-i*7)+raise_top]) 
                        rotate([90, 0, 0]) text(str(sbc_data[s[0]][1][i]), 5,  font = text_font);
            }
        }
    }
//}
// part
if (view == "part") {
    if(individual_part == "top") {
        if(case_design == "shell") {
            translate([0,depth,case_z]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "panel" || case_design == "panel_nas") {
            if(section_part == false) {
                translate([0,depth,case_z]) rotate([180,0,0]) case_top(case_design);
            }
            else {
                projection() translate([0,depth,case_z]) rotate([180,0,0]) case_top(case_design);
            }
        }
        if(case_design == "stacked") {
            translate([0,depth,case_z]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "tray" || case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
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
        if(case_design == "shell" || case_design == "stacked" || case_design == "round" || case_design == "hex"
             || case_design == "round" || case_design == "snap" || case_design == "fitted") {
                case_bottom(case_design);
        }
        if(case_design == "tray" || case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
            translate([0,depth,case_z]) rotate([180,0,0]) case_top(case_design);
        }
        if(case_design == "adapter_mini-stx_thin" || case_design == "adapter_mini-stx" || case_design == "adapter_mini-itx_thin" || case_design == "adapter_mini-itx" || case_design == "adapter_flex-atx" || case_design == "adapter_mini-dtx" || case_design == "adapter_dtx" || case_design == "adapter_micro-atx" || case_design == "adapter_atx" || case_design == "adapter_ssi-ceb" || case_design == "adapter_ssi-eeb") {
            case_adapter(case_design);
        }
        if(case_design == "rack") {
            difference() {
                translate([-150,0,-lower_bottom]) case_rack(case_design,"bottom");
                translate([-gap-wallthick-450,-gap-wallthick-1,-adj]) cube([450,depth+2,case_z+2*adj]);
                translate([150-gap-wallthick,-gap-wallthick-1,-adj]) cube([450,depth+2,case_z+2*adj]);
            }
        }
        if(case_design == "panel" || case_design == "panel_nas") {
             if(section_part == false) {
                case_bottom(case_design);
            }
            else {
                projection() case_bottom(case_design);
            }
        }
    }
    if(individual_part == "front") {
        if(case_design == "panel" || case_design == "panel_nas") {
            if(section_part == false) {
                translate([0,case_z,-depth+wallthick+gap+floorthick]) 
                    rotate([90,0,0]) case_side(case_design,"front");
            }
            else {
                projection() translate([0,case_z,-depth+wallthick+gap+floorthick]) 
                    rotate([90,0,0]) case_side(case_design,"front");

            }
        }
    }
    if(individual_part == "rear") {
        if(case_design == "panel" || case_design == "panel_nas") {
           if(section_part == false) {
                translate([0,0,-gap]) rotate([-90,0,0]) case_side(case_design,"rear");
            }
            else {
                projection() translate([0,0,-gap]) rotate([-90,0,0]) case_side(case_design,"rear");
            }
        }
    }
    if(individual_part == "right") {
        if(case_design == "panel" || case_design == "panel_nas") {
           if(section_part == false) {
                translate([gap,0,-width+(2*wallthick)+gap]) rotate([0,-90,-90]) 
                    case_side(case_design,"right");
            }
            else {
                projection() translate([gap,0,-width+(2*wallthick)+gap]) rotate([0,-90,-90]) 
                    case_side(case_design,"right");
            }
        }
        if(case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
            translate([depth,0,width-gap]) rotate([0,90,90]) case_side(case_design,"right");
        }
        if(case_design == "rack" && rack_width == 19) {
            difference() {
                translate([-300,0,-lower_bottom]) case_rack(case_design,"bottom");
                translate([-gap-wallthick-450,-gap-wallthick-1,-adj]) cube([450,depth+2,case_z+2*adj]);
            }
        }
        if(case_design == "rack" && rack_width == 10) {
            difference() {
                translate([-150,0,-lower_bottom]) case_rack(case_design,"bottom");
                translate([-gap-wallthick-450,-gap-wallthick-1,-adj]) cube([450,depth+2,case_z+2*adj]);
            }
        }
    }
    if(individual_part == "left") {
        if(case_design == "panel" || case_design == "panel_nas") {
           if(section_part == false) {
                translate([depth,0,-gap]) rotate([0,90,90]) 
                    case_side(case_design,"left");
            }
            else {
                projection() translate([depth,0,-gap]) rotate([0,90,90]) 
                    case_side(case_design,"left");

            }
        }
        if(case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
            translate([gap,0,2*sidethick+gap]) rotate([0,-90,-90]) 
                case_side(case_design,"left");
        }
        if(case_design == "rack") {
            difference() {
                translate([0,0,-lower_bottom]) case_rack(case_design,"bottom");
                translate([150-gap-wallthick,-gap-wallthick-1,-adj]) cube([450,depth+2,case_z+2*adj]);

            }
        }
    }
    if(individual_part == "io_shield") {
        if(case_design == "adapter_mini-stx_thin" || case_design == "adapter_mini-stx" || case_design == "adapter_mini-itx_thin" || case_design == "adapter_mini-itx" || case_design == "adapter_flex-atx" || case_design == "adapter_mini-dtx" || case_design == "adapter_dtx" || case_design == "adapter_micro-atx" || case_design == "adapter_atx" || case_design == "adapter_ssi-ceb" || case_design == "adapter_ssi-eeb") {
            translate([0, 0, 4]) rotate([270,0,0]) io_shield();
        }
    }
    if(individual_part == "accessories") {
        // nas hd spacers
        if(case_design == "panel_nas" && (pcb_width > 100 || width > 101.6)) {
            rotate([270,0,0]) cableholder_spacer(hd_spacer-9.4);
        }
        if(case_design == "rack") {
            // rear fan covers
            ucount = rack_width == 10 ? 3 : len(rack_bay_sbc);
            for(r = [0:ucount-1]) {
                fan_offset = -75+(75-rear_fan_size)/2;
                if(rack_bay_rear_fan[r] == true) {
                    translate([-gap-wallthick-1+.125+75*(r+1)+fan_offset+8,0,0])
                            fan_cover(rear_fan_size, wallthick, rear_cooling);
                }
            }
            // rear grommets
            for(r = [0:ucount-1]) {
                grommet_offset = -75+11;
                if(rack_bay_rear_conduit[r] == "grommet") {
                    translate([0,0,0]) rotate([270,0,0]) difference() {
                    translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset,0,0])
                        grommet("bottom", "sleeve", 10, r+1, wallthick, false, [false,10,0,"default"]);
                        translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset-10,-.125,-3]) cube([20,10,20]);
                    }
                    translate([0,20,0]) rotate([270,0,0]) difference() {
                        translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset,0,0])
                            grommet("bottom", "sleeve", 10, r+1, wallthick, false, [false,10,0,"default"]);
                        translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset-10,-.125,-3]) cube([20,10,20]);
                    }
                    translate([-gap-wallthick-1+.125+75*(r+1)+grommet_offset,-20,0])
                        grommet_clip("sleeve", 10, r+2, wallthick);
                }
            }
            for(r = [0:ucount-1]) {
                if(rack_bay_face[r] == "removable") {
                    translate([-gap-wallthick-1+(75*(r))+8,-300,0]) bay_tray(depth-2*wallthick-gap-.5-tol,r);
                }
            }
        }
       // ui access panel
        if(bottom_access_panel_enable == true) {
            if(access_panel_rotation == 0) {
                translate([access_panel_location[0],-access_panel_location[1], 0]) rotate([0,0,access_panel_rotation]) 
                    access_cover([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation);
            }
            if(access_panel_rotation == 90) {
                translate([access_panel_location[0]+access_panel_size[1],-access_panel_location[1], 0]) rotate([0,0,access_panel_rotation]) 
                    access_cover([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation);
            }
            if(access_panel_rotation == 180) {
                translate([access_panel_location[0]+access_panel_size[0],-access_panel_location[1]+access_panel_size[1],0]) rotate([0,0,access_panel_rotation]) 
                    access_cover([access_panel_size[0],-access_panel_size[1],floorthick], access_panel_orientation);
            }
            if(access_panel_rotation == 270) {
                translate([access_panel_location[0],-access_panel_location[1]+access_panel_size[0], 0]) rotate([0,0,access_panel_rotation]) 
                    access_cover([access_panel_size[0],access_panel_size[1],floorthick], access_panel_orientation);
            }
        }
        if(accessory_name != "none") {
            for (i=[1:11:len(accessory_data[a[0]])-1]) {
                class = accessory_data[a[0]][i];
                type = accessory_data[a[0]][i+1];
                loc_x = accessory_data[a[0]][i+2];
                loc_y = accessory_data[a[0]][i+3];
                loc_z = accessory_data[a[0]][i+4];
                face = accessory_data[a[0]][i+5];
                rotation = accessory_data[a[0]][i+6];
                parametric = accessory_data[a[0]][i+7];
                size_x = accessory_data[a[0]][i+8][0];
                size_y = accessory_data[a[0]][i+8][1];
                size_z = accessory_data[a[0]][i+8][2];
                data_1 = accessory_data[a[0]][i+9][0];
                data_2 = accessory_data[a[0]][i+9][1];
                data_3 = accessory_data[a[0]][i+9][2];
                data_4 = accessory_data[a[0]][i+9][3];
                mask = accessory_data[a[0]][i+10];
                
                if (class == "platter" && type != "button_assembly") {
                    add(type, loc_x, loc_y, loc_z, face, rotation, [size_x, size_y, size_z], [data_1, data_2, data_3, data_4], mask);
                }
                if (class == "platter" && type == "button_assembly") {
                    translate([loc_x,loc_y,loc_z+1.25]) rotate([-90,0,0]) button_plunger(data_1, size_x, size_z);
                    translate([loc_x-20,loc_y-10,loc_z+3]) rotate([0,0,0]) button_top(data_1, size_x, size_z);
                    translate([loc_x-20,loc_y-20,loc_z]) rotate([0,0,0]) button_clip(data_1);
                }
                if (class == "platter" && type == "h3_port_extender_holder") {
                    translate([loc_x,loc_y,loc_z]) rotate([0,0,0]) h3_port_extender_holder("bottom");
                    translate([loc_x-20,loc_y+40,loc_z+36.5]) rotate([180,0,0]) h3_port_extender_holder("top");
                }
            }
        }
    }
}
if(case_design == "tray" || case_design == "tray_vu5" || case_design == "tray_vu7" || case_design == "tray_sides") {
    echo(width=width+2*sidethick,depth=depth,top=top_height,bottom=bottom_height);
}
else {
    if(case_design == "panel_nas") {
        echo(width=width+hd_spacer,depth=depth,top=top_height,bottom=bottom_height, height=case_z+(3*wallthick));
        echo(drive_spacer=hd_spacer);
    }
    else {
        echo(width=width,depth=depth,top=top_height,bottom=bottom_height);
    }
}
