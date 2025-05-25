/* Gets a list of SBCs from the SBC Model Framework and Accessory sets
   for use with SBC Case Builder.
   After running this script, copy the output from the first Echo command into the
   list of SBC boards in `sbc_case_builder.scad:32` and `sbc_case_builder.scad` 
   6 locations line 82,90,98,106,114,122 for the sbc selection for the rack case design.
   Also copy the output from the second Echo command into the list of case acceessory
   sets in `sbc_case_builder.scad:196`
*/
include <./SBC_Model_Framework/sbc_models.cfg>;
include <./sbc_case_builder_accessories.cfg>;
echo(" ");
boards = [for(i=[0:1:len(sbc_data)-1]) sbc_data[i][0]];
echo("Copy the following to `sbc_case_builder.scad` for the `sbc_model` variable");
echo(boards);
echo(" ");
accessory_sets = [for(i=[0:1:len(accessory_data)-1]) accessory_data[i][0]];
echo("Copy the following to `sbc_case_builder.scad` for the `accessory_name` variable");
echo(accessory_sets);
echo(" ");