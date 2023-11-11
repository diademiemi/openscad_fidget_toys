// VERY UGLY CODE WARNING !!!

// Define the points of the blade blade shape
inner_blade_points = [
    [0, 13], // Top of the diamond
    [2, 0], // Right corner
    [0, -13], // Bottom of the diamond
    [-2, 0]  // Left corner
];

blade_points = [
    [-1.2, 14], // Top of the diamond
    [0, 14.5], // Top of the diamond
    [1.2, 14], // Top of the diamond
    [3.25, 0], // Right corner
    [1.2, -14], // Bottom of the diamond
    [0, -14.5], // Bottom of the diamond
    [-1.2, -14], // Bottom of the diamond
    [-3.25, 0]  // Left corner
];
outer_blade_points  = [
    [-2.25, 15.75], // Top of the diamond
    [0, 17], // Top of the diamond
    [2.25, 15.75], // Top of the diamond
    [5, 0], // Right corner
    [2.25, -15.75], // Bottom of the diamond
    [0, -17], // Bottom of the diamond
    [-2.25, -15.75], // Bottom of the diamond
    [-5, 0]  // Left corner
];

outer_outer_blade_points = [
    [-3.25, 19], // Top of the diamond
    [0, 20], // Top of the diamond
    [3.25, 19], // Top of the diamond
    [7, 0], // Right corner
    [3.25, -19], // Bottom of the diamond
    [0, -20], // Bottom of the diamond
    [-3.25, -19], // Bottom of the diamond
    [-7, 0]  // Left corner

];

outer_outer_outer_blade_points = [
    [-4.5, 22], // Top of the diamond
    [0, 23.5], // Top of the diamond
    [4.5, 22], // Top of the diamond
    [9, 0], // Right corner
    [4.5, -22], // Bottom of the diamond
    [0, -23.5], // Bottom of the diamond
    [-4.5, -22], // Bottom of the diamond
    [-9, 0]  // Left corner

];

heights = 120;

module new_rounded_blade() {
    linear_extrude(height=heights, convexity=10, $fn=100, scale=[1.05,1.14])difference() {
        offset(r=1) polygon(outer_outer_outer_blade_points);
        offset(r=0.2) polygon(outer_outer_outer_blade_points);
    }

    linear_extrude(height=heights, convexity=10, $fn=100, scale=[1.05,1.18])difference() {
        offset(r=1) polygon(outer_outer_blade_points);
        offset(r=0.2) polygon(outer_outer_blade_points);
    }
    linear_extrude(height=heights, convexity=10, $fn=100, scale=[1.05,1.18])difference() {
        offset(r=1) polygon(outer_blade_points);
        offset(r=0.2) polygon(outer_blade_points);
    }
    linear_extrude(height=heights, convexity=10, $fn=100, scale=[1.05,1.14])difference() {
        offset(r=1) polygon(blade_points);
        offset(r=0.2) polygon(blade_points);
    }

    hull () {
        translate([0, 0, 15]) linear_extrude(height=heights - 15, convexity=10, $fn=100, scale=[1.05,1.1])difference() {
            offset(r=1) polygon(inner_blade_points);
            offset(r=0.2) polygon(inner_blade_points);
        }
        translate([0, 0, 0.5]) cube([4.5, 9, 1], center=true);
    
    }

}


module case() {
    points = [
        [-8, 28], // Top of the diamond
        [0, 32], // Top of the diamond
        [8, 28], // Top of the diamond
        [12, 0], // Right corner
        [8, -28], // Bottom of the diamond
        [0, -32], // Bottom of the diamond
        [-8, -28], // Bottom of the diamond
        [-12, 0]  // Left corner
    ];


    difference() {

        ridge_size = 2;
        union() for (i = [1:heights/2+1]) {
            hull() {
                echo(i);
                for (j = [0:len(points) - 1]) {
                    
                    translate([points[j][0], points[j][1], i * ridge_size]) sphere(r=ridge_size, $fn=32);
                }
            }
        }

        scale([1.13, 1.13, 1]) linear_extrude(height=heights + 2, convexity=10, $fn=100, scale=[1.07,1.19]) offset(r=1) polygon(outer_outer_outer_blade_points);
        scale([1.18, 1.18, 1]) translate([0, 0, heights - 5]) linear_extrude(height=4, convexity=10, $fn=100) offset(r=1) polygon(outer_outer_outer_blade_points);


    }

}

module sword_handles() {

    points = [
        [-8, 70], // Top of the diamond
        [0, 90], // Top of the diamond
        [8, 70], // Top of the diamond
        [17, 0], // Right corner
        [8, -70], // Bottom of the diamond
        [0, -90], // Bottom of the diamond
        [-8, -70], // Bottom of the diamond
        [-17, 0]  // Left corner
    ];

    difference() {

        ridge_size = 2;
        union() for (i = [1:12]) {
            hull() {
                echo(i);
                for (j = [0:len(points) - 1]) {
                    
                    translate([points[j][0], points[j][1], i * ridge_size]) sphere(r=ridge_size, $fn=32);
                }
            }
        }

        scale([1.09, 1.09, 1]) linear_extrude(height=50, convexity=10, $fn=100, scale=[1.05,1.18]) offset(r=1) polygon(outer_outer_outer_blade_points);
        scale([1.16, 1.16, 1]) translate([0, 0, 47]) linear_extrude(height=5, convexity=10, $fn=100) offset(r=1) polygon(outer_outer_outer_blade_points);


    }

}

case();
sword_handles();
new_rounded_blade();
