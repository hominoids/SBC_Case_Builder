
/* find correct tolerance and use for respective entry's data_1 value within sbc_case_builder.cfg */

use <./sbc_case_builder_library.scad>;

battery_tolerance = 0;
speaker_tolerance = 0;
volume_tolerance = 0;

$fn = 90;

translate([-33,0,0]) batt_holder(battery_tolerance);
difference() {
    translate([-17,-17,0]) cube([34,34,2]);
    translate([0,0,-1]) cylinder(d=24, h=4);
}
translate([0,0,1.99]) boom_speaker_holder("friction",speaker_tolerance);

translate([30,0,0]) boom_vring(volume_tolerance);

