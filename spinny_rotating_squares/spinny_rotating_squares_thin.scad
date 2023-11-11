include <../openscad_common/rounded_figures.scad>

height = 5;
width = 5;

roundness=1.5;

connector_base_height = height/2.9;
connector_base_width = height/2.5;
connector_radius=height/3;
connector_radius_negative=connector_radius*1.15;

spacing = 2;

module sphere_connector_positive() {

    // Make a half sphere

    translate([0, 0, 0]) {
        hull() {
            hull() {
                rotate([0, 90, 0]) translate([0, -connector_base_width/2, 0]) cylinder(h=0.05, r=connector_base_height, center=true, $fn=64);
                rotate([0, 90, 0]) translate([0, connector_base_width/2, 0]) cylinder(h=0.05, r=connector_base_height, center=true, $fn=64);
            }
            hull() {
                rotate([0, 90, 0]) translate([0, 0, 0]) cylinder(h=0.9, r=connector_base_height - 0.1, center=true, $fn=64);
            }
        }

        difference() {
            sphere(connector_radius, $fn=64);
            translate([connector_radius, 0, 0]) cube([connector_radius*2, connector_radius*2, connector_radius*2], center=true);
        }
    }
    
}

module sphere_connector_negative() {

    // Make a half sphere

    translate([0, 0, 0]) {
        difference() {
            sphere(connector_radius_negative, $fn=64);
            translate([connector_radius_negative, 0, 0]) cube([connector_radius_negative*2, connector_radius_negative*2, connector_radius_negative*2], center=true);
        }
    }
    
}


module spinny_square(size, final=false, outer_final=false) {
    difference() {
        rounded_cube([size, size, height], roundness);
        translate([width, width, 0]) rounded_cube([size - width*2, size - width*2, height], roundness, flat_minus_z=true, flat_plus_z=true);

        if (!final) {
            translate([size/2, width, height/2]) rotate([0, 0, 90]) sphere_connector_negative();
            translate([size/2, size - width, height/2]) rotate([0, 0, -90]) sphere_connector_negative();
        }


    }

    if (!outer_final) {
        translate([0, size/2, height/2]) sphere_connector_positive();
        translate([size, size/2, height/2]) rotate([0, 180, 0]) sphere_connector_positive();

    }


}

module draw_square_center(size, rotate=false, final=false, outer_final=false) {

    if (rotate) {
        rotate([0, 0, 90]) translate([-size / 2 , -size / 2, 0]) spinny_square(size, final=final, outer_final=outer_final);
    } else {
        translate([-size / 2 , -size / 2, 0]) spinny_square(size, final=final, outer_final=outer_final);
    }


}


// LARGE
// draw_square_center(size=20, final=true);
// draw_square_center(size=31.25, rotate=true);
// draw_square_center(size=42.5);
// draw_square_center(size=53.75, rotate=true);
// draw_square_center(size=65, outer_final=true);


// SMALL
draw_square_center(size=20, final=true);
draw_square_center(size=31.25, rotate=true);
draw_square_center(size=42.5, outer_final=true);
