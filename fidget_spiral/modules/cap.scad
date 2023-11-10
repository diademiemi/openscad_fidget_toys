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

heights = 30;

// $fn=128; // For a satisfying noise
$fn=1024; // For smooth operation

module cap() {

    difference() {
        cylinder(r=20, h=5);
            translate([0, 0, 2]) linear_extrude(twist=90, height=heights, convexity=10, scale=[1.15,1.15]) difference() {
                offset(r=1.05) scale(2) polygon(blade_points);
            }

    }

}
