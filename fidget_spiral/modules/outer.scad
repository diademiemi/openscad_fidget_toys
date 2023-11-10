// VERY UGLY CODE WARNING !!!
outer_blade_points = [
    [-1.25, 4.5],
    [1.25, 4.5],
    [1.25, 1.25],
    [4.5, 1.25],
    [4.5, -1.25],
    [1.25, -1.25],
    [1.25, -4.5],
    [-1.25, -4.5],
    [-1.25, -1.25],
    [-4.5, -1.25],
    [-4.5, 1.25],
    [-1.25, 1.25]



];

twist_period = 30;
periods = 5;
base_size = 1;

// $fn=128; // For a satisfying noise
$fn=1024; // For smooth operation

module spiral_outer() {

    for (i = [0:base_size-1]) {

        translate([0, 0, i*twist_period]) linear_extrude(twist=90, height=twist_period, convexity=10) scale([1.15,1.15]) difference() {
            offset(r=1) scale(3) polygon(outer_blade_points);
            offset(r=0.2) scale(3) polygon(outer_blade_points);
        }

    }

}
