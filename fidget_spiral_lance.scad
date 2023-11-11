// VERY UGLY CODE WARNING !!!

blade_points = [
    [
        [-1.0, 7],
        [1.0, 7],
        [1.0, 1.0],
        [7, 1.0],
        [7, -1.0],
        [1.0, -1.0],
        [1.0, -7],
        [-1.0, -7],
        [-1.0, -1.0],
        [-7, -1.0],
        [-7, 1.0],
        [-1.0, 1.0]
    ],
    [
        [-3.5, 10],
        [3.5, 10],
        [3.5, 3.5],
        [10, 3.5],
        [10, -3.5],
        [3.5, -3.5],
        [3.5, -10],
        [-3.5, -10],
        [-3.5, -3.5],
        [-10, -3.5],
        [-10, 3.5],
        [-3.5, 3.5]
    ],
        [    
        [-6.0, 12.5],
        [6.0, 12.5],
        [6.0, 6.0],
        [12.5, 6.0],
        [12.5, -6.0],
        [6.0, -6.0],
        [6.0, -12.5],
        [-6.0, -12.5],
        [-6.0, -6.0],
        [-12.5, -6.0],
        [-12.5, 6.0],
        [-6.0, 6.0]
    ],

];


twist_period = 55;
periods = 3;
base_size = 1;

// $fn=512; // For a satisfying noise
$fn=256; // For smooth operation

module spiral() {



    difference() {

        scale_period = 0.03;

        union() for (i = [0:periods-1]) {

            scale_amount = 1 + (i + 1) * scale_period;

            prev_scale_start = 1 + (i) * scale_period;

            translate([0, 0, i*twist_period]) scale([prev_scale_start, prev_scale_start, 1]) linear_extrude(twist=90, height=twist_period, convexity=10, scale=[scale_amount/prev_scale_start, scale_amount/prev_scale_start]) difference() {
                offset(r=1) polygon(blade_points[0]);
                offset(r=0.2) polygon(blade_points[0]);
            }
        }

        translate([-25,-25,0]) cube([50, 50, 15]);

    }

    rotate([0, 180, -25]) translate([0, 0, -15]) scale([1.03, 1.03, 1]) linear_extrude(twist=30, height=15, convexity=10, scale=[0.5, 0.5]) difference() {
        offset(r=1) polygon(blade_points[0]);
    }

}

module outer_spiral() {

    for (i = [1:len(blade_points) - 1]) {


        scale_period = 0.03;

        for (j = [0:periods-1]) {

            scale_amount = 1 + (j + 1) * scale_period;

            prev_scale_start = 1 + (j) * scale_period;

            translate([0, 0, j*twist_period]) scale([prev_scale_start, prev_scale_start, 1]) linear_extrude(twist=90, height=twist_period, convexity=10, scale=[scale_amount/prev_scale_start, scale_amount/prev_scale_start]) difference() {
                offset(r=1) polygon(blade_points[i]);
                offset(r=0.2) polygon(blade_points[i]);
            }
        }


    }

}

spiral();

outer_spiral();