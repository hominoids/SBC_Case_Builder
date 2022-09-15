use <../sbc_case_builder_library.scad>;

linear_extrude(2) text("30mm", 5);
// 30mm Mask Solid
echo("30mm Mask Solid");
translate([0, 10, 0]) fan_mask(30, 2, 2);

// 30mm Mask Punchout
echo("30mm Mask Punchout");
translate([0, 50, 0])
  difference() {
    cube([30, 30, 2]);
    fan_mask(30, 2, 2);
  }

linear_extrude(2) translate([40, 0, 0]) text("40mm", 5);
// 40mm Mask Solid
echo("40mm Mask Solid");
translate([40, 10, 0])
  fan_mask(40, 2, 2);

// 40mm Mask Punchout
echo("40mm Mask Punchout");
translate([40, 60, 0])
  difference() {
    cube([40, 40, 2]);
    fan_mask(40, 2, 2);
  }

linear_extrude(2) translate([90, 0, 0]) text("80mm", 5);
// 80mm Mask Solid
echo("80mm Mask Solid");
translate([90, 10, 0])
  fan_mask(80, 2, 2);

// 80mm Mask Punchout
echo("80mm Mask Punchout");
translate([90, 100, 0])
  difference() {
    cube([80, 80, 2]);
    fan_mask(80, 2, 2);
  }