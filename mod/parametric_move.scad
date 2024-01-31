/*
    This file is part of SBC Case Builder https://github.com/hominoids/SBC_Case_Builder
    Copyright 2022,2023,2024 Edward A. Kisiel hominoid@cablemi.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>
    Code released under GPLv3: http://www.gnu.org/licenses/gpl.html


           NAME: parametric_move_add
    DESCRIPTION: places parametric additive objects 
           TODO: none

          USAGE: parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric[], size_x, size_y, size_z, data_1, data_2, data_3, data_4)

                           type = 
                          loc_x = 
                          loc_y = 
                          loc_z = 
                           face = 
                       rotation = 
                   parametric[] = 
                        size[0] = size_x
                        size[1] = size_y
                        size[2] = size_z
                        data[0] = 
                        data[1] = 
                        data[2] = 
                        data[3] = 

*/

module parametric_move_add(type, loc_x, loc_y, loc_z, face, rotation, parametric, size_x, size_y, size_z, data_1, data_2, data_3, data_4) {
    
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


/*
           NAME: parametric_move_sub
    DESCRIPTION: places parametric subtractive objects 
           TODO: none

          USAGE: parametric_move_sub(type, loc_x, loc_y, loc_z, face, rotation, parametric[], size_x, size_y, size_z, data_1, data_2, data_3, data_4)

                           type = 
                          loc_x = 
                          loc_y = 
                          loc_z = 
                           face = 
                       rotation = 
                   parametric[] = 
                        size[0] = size_x
                        size[1] = size_y
                        size[2] = size_z
                        data[0] = 
                        data[1] = 
                        data[2] = 
                        data[3] = 

*/

module parametric_move_sub(type, loc_x, loc_y, loc_z, face, rotation, parametric, size_x, size_y, size_z, data_1, data_2, data_3, data_4) {
    
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
