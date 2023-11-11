// OpenSCAD
outer_diameter = 60;
allowed_height = 15;
segments = 5;

inner_minimum_diameter = 25;

rounding = 0.5;
clearance = 0.835;

fn = 150;
round_corners = true;
minkowski_fn = 16;

ring_widths = (outer_diameter - inner_minimum_diameter/2) / segments - clearance + rounding; 
module spinny_toy() {
    rounding_final = rounding;

    translate([0,0,allowed_height/2]) {

        intersection() {
            cube([outer_diameter, outer_diameter, allowed_height], center=true);

            union() {
                for (i = [0 : segments - 2]) {
                    difference() {
                        sphere(r=((outer_diameter - ring_widths * i) - rounding_final * 2)/2, $fn=fn);
                        sphere(r=((outer_diameter - ring_widths * i) - ring_widths)/2 + clearance, $fn=fn);
                    }
                }

                difference() {
                    sphere(r=(inner_minimum_diameter)/2 - rounding_final * 3, $fn=fn);
                }
            }
        }
    }
}

if (round_corners) {

    minkowski($fn=minkowski_fn) {

        spinny_toy();


        sphere(rounding, $fn=minkowski_fn);

    }

} else {

        spinny_toy();

}
