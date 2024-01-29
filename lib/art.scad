/*

    art(scale_d1,type,size_z)

*/

/* art work module */
module art(scale_d1,size_z,type) {
    
    linear_extrude(height = size_z) import(file = type, scale=scale_d1);

}
