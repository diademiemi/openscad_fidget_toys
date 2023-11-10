include <openscad_common/rounded_figures.scad>

cube_size = 20;

cube_distance=0.5;

// connector_size = [12 + cube_distance, 10, 6];
connector_size = [12.4 + cube_distance, 11.5, 6];
connecector_roundness = 3;

radius = connector_size[2]/2;
height = 2.5;
connector_cone_size_modifier = 0.1;
connector_holes_size_modifier = 0.1;

negative_connector_size = [13 + cube_distance, 12.5, 7];

module cone_connector(radius, height) {
    hull() {
        translate([radius, height-0.1, radius]) rotate([-90, 0, 0]) cylinder(h=0.1, r=radius, $fn=64);
        translate([radius, 0, radius]) rotate([-90, 0, 0]) cylinder(h=0.1, r=connector_cone_size_modifier, $fn=64);
    }
}

module cone_hole(radius, height) {
    hull() {
        translate([radius, height-0.1, radius]) rotate([-90, 0, 0]) cylinder(h=0.1, r=radius, $fn=64);
        translate([radius, -1, radius]) rotate([-90, 0, 0]) cylinder(h=0.1, r=connector_holes_size_modifier, $fn=64);
    }

}

// Size = connector_size + connnector_cone_height
// In our case, 15
module connector(set_connector_size = connector_size, extra_width = cube_distance) {
    hole_radius = set_connector_size[2]/2 - 0.2;
    hole_height = 2.75;

    cone_radius = set_connector_size[2]/2;
    cone_height = 3.2;

    difference() {
        translate([0, height, 0]) rounded_cube([set_connector_size[0] + extra_width, set_connector_size[1], set_connector_size[2]], connecector_roundness, flat_minus_y=true, flat_plus_y=true);
        translate([0, set_connector_size[1], 0]) {
            cone_hole(cone_radius, cone_height);
            translate([set_connector_size[0] + extra_width - radius*2, 0, 0]) cone_hole(cone_radius, cone_height);                
        }
    }
    cone_connector(cone_radius, cone_height);
    translate([set_connector_size[0] + extra_width - cone_radius*2, 0, 0]) cone_connector(cone_radius, cone_height);
    
}

module negative_connector(extra_width = cube_distance,flat=false, other_flat=false) {
    hole_radius = negative_connector_size[2]/2 - 0.2;
    hole_height = 2.75;

    cone_radius = negative_connector_size[2]/2.25;
    cone_height = 3.1;
    
    difference() {
        translate([0, height, 0]) rounded_cube([negative_connector_size[0] + extra_width, negative_connector_size[1], negative_connector_size[2]], connecector_roundness /3, flat_minus_y=true, flat_plus_y=true, flat_minus_z=flat, flat_plus_z=other_flat);
        translate([(negative_connector_size[0] - connector_size[0])/4, negative_connector_size[1] + (cone_height - hole_height), 0]) {
            cone_hole(cone_radius, cone_height);
            translate([connector_size[0] + extra_width - radius*2, 0, 0]) cone_hole(cone_radius, cone_height);                
        }
    }
    cone_connector(cone_radius, cone_height);
    translate([negative_connector_size[0] + extra_width - cone_radius*2, 0, 0]) cone_connector(cone_radius, cone_height);    



}

module cube_pair() {
    // translate([0, 0, 0]) hulled_cube([cube_size, cube_size, cube_size], 2.5);
    // translate([cube_size+cube_distance, 0, 0]) hulled_cube([cube_size, cube_size, cube_size], 2.5);
    translate([0, 0, 0]) rounded_cube([cube_size, cube_size, cube_size], 3);
    translate([cube_size+cube_distance, 0, 0]) rounded_cube([cube_size, cube_size, cube_size], 3);
}


module cube_pair_connected() {
    union() {
        difference() {
            cube_pair();

            translate([(cube_size * 2)/2 - negative_connector_size[0]/2, (cube_size)/2 - negative_connector_size[0]*0.65, 0]) negative_connector(flat=true);
            
        }
        translate([(cube_size * 2)/2 - connector_size[0]/2, (cube_size)/2 - connector_size[0]*0.65, 0]) connector();
    }
}

difference() {

    union() {
        cube_pair_connected();
        translate([cube_size*2+cube_distance*2, 0, 0]) cube_pair_connected();
        translate([0, cube_size+cube_distance, 0]) cube_pair_connected();
        translate([cube_size*2+cube_distance*2, cube_size+cube_distance, 0]) cube_pair_connected();

    }

    // Put two connectors at the outer edges of the middle two cubes (between the two pairs). Should be rotated [90, 0, 0]
    translate([cube_size + cube_distance/2, 0, cube_size+1]) rotate([-90, 0, 0]) translate([(cube_size * 2)/2 - negative_connector_size[0]/2, (cube_size)/2 - negative_connector_size[0]*0.575, 0]) negative_connector(flat=true);

    translate([cube_size + cube_distance/2, (cube_size *2) - negative_connector_size[2] + cube_distance*2, cube_size+1]) rotate([-90, 0, 0]) translate([(cube_size * 2)/2 - negative_connector_size[0]/2, (cube_size)/2 - negative_connector_size[0]*0.575, 0]) negative_connector(flat=false, other_flat=true);

    // Top connectors
    translate([cube_size + cube_distance, 0, cube_size - negative_connector_size[2]]) rotate([0, 0, 90])  translate([(cube_size * 2)/2 - connector_size[0]/2, (cube_size)/2 - connector_size[0]*0.575, 0]) negative_connector(flat=true, other_flat=true);
    translate([(cube_size*4+cube_distance*6), 0, cube_size - negative_connector_size[2]]) rotate([0, 0, 90])  translate([(cube_size * 2)/2 - connector_size[0]/2, (cube_size)/2 - connector_size[0]*0.575, 0]) negative_connector(flat=true, other_flat=true);

}


// Sides
translate([cube_size + cube_distance/2, 0, cube_size+0.5]) rotate([-90, 0, 0])  translate([(cube_size * 2)/2 - connector_size[0]/2, (cube_size)/2 - connector_size[0]*0.575, 0]) connector(set_connector_size = [12.4 + cube_distance, 10.25, 6]);
translate([cube_size + cube_distance/2, (cube_size *2) - negative_connector_size[2] + cube_distance*3, cube_size+0.5]) rotate([-90, 0, 0]) translate([(cube_size * 2)/2 - connector_size[0]/2, (cube_size)/2 - connector_size[0]*0.575, 0]) connector(set_connector_size = [12.4 + cube_distance, 10.25, 6]);

// Put the connectors at the top
translate([cube_size+0.1, 0.5, cube_size - connector_size[2]]) rotate([0, 0, 90])  translate([(cube_size * 2)/2 - connector_size[0]/2 - 0.1, (cube_size)/2 - connector_size[0]*0.565, -0.65]) connector();
translate([(cube_size*4+cube_distance*5), 0.5, cube_size - connector_size[2]]) rotate([0, 0, 90])   translate([(cube_size * 2)/2 - connector_size[0]/2 - 0.1, (cube_size)/2 - connector_size[0]*0.575, -0.65]) connector();



// Snap off connectors
translate([36, -3.25, 0]) {
    
    cube([9.5, 3, 20]);
    translate([0, 0, 4.8]) cube([3, 3.7, 0.7]);
    translate([6.5, 0, 4.8]) cube([3, 3.7, 0.7]);
    translate([0, 0, 16]) cube([3, 3.7, 0.7]);
    translate([6.5, 0, 16]) cube([3, 3.7, 0.7]);

}

translate([36, 40.75, 0]) {
    
    cube([9.5, 3, 20]);
    translate([0, -0.7, 4.8]) cube([3, 3.7, 0.7]);
    translate([6.5, -0.7, 4.8]) cube([3, 3.7, 0.7]);
    translate([0, -0.7, 16]) cube([3, 3.7, 0.7]);
    translate([6.5, -0.7, 16]) cube([3, 3.7, 0.7]);

}

translate([8.2, 16, 12]) {
    cube([1, 1, 4]);

}
translate([8.2, 24, 12]) {
    cube([1, 1, 4]);

}

translate([70, 16, 12]) {
    cube([1, 1, 4]);

}
translate([70, 24, 12]) {
    cube([1, 1, 4]);

}