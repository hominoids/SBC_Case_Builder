use <../sbc_case_builder_library.scad>;

// 30mm Mask Solid
fan_mask(30, 2, 2);

// // 30mm Mask Punchout
translate([0, 40, 0])
  difference() {
    cube([30, 30, 2]);
    fan_mask(30, 2, 2);
  }

// 40mm Mask Solid
translate([40, 0, 0])
  fan_mask(40, 2, 2);

// // 40mm Mask Punchout
translate([40, 50, 0])
  difference() {
    cube([40, 40, 2]);
    fan_mask(40, 2, 2);
  }

// 80mm Mask Solid
translate([90, 0, 0])
  fan_mask(80, 2, 2);

// 80mm Mask Punchout
translate([90, 90, 0])
  difference() {
    cube([80, 80, 2]);
    fan_mask(80, 2, 2);
  }