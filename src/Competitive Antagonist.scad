include <BOSL2/std.scad>;
include <brailleSCAD/en-us-g2.scad>;
include <brailleSCAD/braille.scad>;
include <Neuroscience Receptor Kit Configuration.scad>;

// read receptor.scad

module competitive_antagonist(bottom_radius, top_radius, height, resolution) {
    union() {
        difference() {
            translate([0,0,height/2])
                cylinder(h=height, r1=bottom_radius, r2=top_radius, $fn=resolution, center=true);

            translate([0,0,height])
                sphere(top_radius/1.666);
        }

        translate([0,0,height/2])
            cube([bottom_radius*1.5, 20, height], center=true);
            
        translate([0,0,height])
            back(_braille_line_sep[1]*INCH/2)
            braille("competitive", $fn=50, size="large");

        translate([0,0,height])
            fwd(_braille_line_sep[1]*INCH/2)
            braille("antagonist", $fn=50, size="large");
    }
}

top_radius = (receptor_radius-receptor_rim_top_thickness)*sqrt(3)/2;
bottom_radius = (receptor_radius-receptor_rim_bottom_thickness)*sqrt(3)/2;

competitive_antagonist(bottom_radius, top_radius, receptor_rim_cut_depth, resolution);
