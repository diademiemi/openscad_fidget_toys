// VERY UGLY CODE WARNING !!!

blade_points = [
    [-1, 6],
    [1, 6],
    [1, 1],
    [6, 1],
    [6, -1],
    [1, -1],
    [1, -6],
    [-1, -6],
    [-1, -1],
    [-6, -1],
    [-6, 1],
    [-1, 1]

];

twist_period = 30;
periods = 4;
base_size = 1;

// $fn=128; // For a satisfying noise
$fn=768; // For smooth operation

module spiral() {


    // Compensate for the caps
    rotate([0, 0, 0]) translate([0, 0, periods * twist_period]) linear_extrude(twist=30, height=10, convexity=10) difference() {
        offset(r=1) scale(2) polygon(blade_points);
        // offset(r=0.2) scale(2) polygon(blade_points);
    }


    for (i = [0:periods-1])
    translate([0, 0, i*twist_period]) linear_extrude(twist=90, height=twist_period, convexity=10) difference() {
        offset(r=1) scale(2) polygon(blade_points);
        // offset(r=0.2) scale(2) polygon(blade_points);
    }


}
