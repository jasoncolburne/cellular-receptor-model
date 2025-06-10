include <BOSL2/std.scad>;

module tapered_pentagon(bottom_side_length, top_side_length, height) {
    bottom_radius=bottom_side_length/2*sin(2*PI/5);
    top_radius=top_side_length/2*sin(2*PI/5);
    cylinder(h=height, r1=bottom_radius, r2=top_radius, center=true, $fn=5);
}

module tapered_hexagon(bottom_radius, top_radius, height) {
    cylinder(r1=bottom_radius, r2=top_radius, h=height, center=true, $fn=6);
}

module pyramid(height, base_width) {
    cylinder(h=height, r1=sqrt(base_width*base_width/2), r2=0, $fn=4, center=true);
}
