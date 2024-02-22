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


           NAME: art
    DESCRIPTION: create 2d artwork using dxf or svf
           TODO: none

          USAGE: art(scale_d1, size_z, filename)

                     scale_d1 = amount to scale file
                       size_z = floor thickness
                     filename = file name


           NAME: stl_model
    DESCRIPTION: import 3d artwork using stl
           TODO: none

          USAGE: art(scale_d1, size_z, filename)

                     scale_d1 = amount to scale file
                       size_z = floor thickness
                     filename = file name
*/

module art(scale_d1, size_z, filename) {

    linear_extrude(height = size_z) import(file = filename, scale=scale_d1);

}

module stl_model(scale_d1, filename) {

    import(file = filename, scale=scale_d1);

}
