// Gets a list of SBCs from the SBC Model Framework for use with SBC Case Builder.
// After running this script, copy the output from the Echo command into the
// list of SBC boards in `sbc_case_builder.scad:80`

include <./SBC_Model_Framework/sbc_models.cfg>;

boards = [for(i=[0:1:len(sbc_data)-1]) sbc_data[i][0]];
echo(boards);