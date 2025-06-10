include <BOSL2/std.scad>;
include <brailleSCAD/en-us-g2.scad>;
include <brailleSCAD/braille.scad>;
include <Neuroscience Receptor Kit Configuration.scad>;

// read receptor.scad

module partial_agonist(bottom_radius, top_radius, hollow_radius, arm_bottom_width, arm_top_width, height) {
    union() {
        difference() {
            translate([0,0,height/2])
                cylinder(h=height, r1=bottom_radius, r2=top_radius, center=true, $fn=5);
                
            translate([0,0,height])
                sphere(hollow_radius/1.666);
        }

        translate([0,0,height/2])
            cube([bottom_radius*1.5, 20, height], center=true);
            
        translate([0,0,height])
            back(_braille_line_sep[1]*INCH/2)
            braille("partial", $fn=50, size="large");

        translate([0,0,height])
            fwd(_braille_line_sep[1]*INCH/2)
            braille("agonist", $fn=50, size="large");
            
        translate([top_radius*1.5/2,0,height/2])
            prismoid(size1=[top_radius*1.5*0.98,arm_bottom_width], size2=[top_radius*1.5,arm_top_width], h=height, center=true);
    }
}

hexagon_top_radius = receptor_radius - receptor_rim_top_thickness;
hexagon_bottom_radius = receptor_radius - receptor_rim_bottom_thickness;

pentagon_top_radius = 0.9107 * hexagon_top_radius;
pentagon_bottom_radius = 0.9107 * hexagon_bottom_radius;

hollow_radius =  (receptor_radius-receptor_rim_top_thickness)*sqrt(3)/2;

arm_bottom_width = receptor_rim_cut_bottom_width / tolerance;
arm_top_width = receptor_rim_cut_top_width / tolerance;
    
partial_agonist(pentagon_bottom_radius, pentagon_top_radius, hollow_radius, arm_bottom_width, arm_top_width, receptor_rim_cut_depth);
