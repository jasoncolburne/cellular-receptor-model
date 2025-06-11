include <braille-on-flat.scad>;
include <Neuroscience Receptor Kit Configuration.scad>;

module full_agonist(bottom_radius, top_radius, hollow_radius, arm_bottom_width, arm_top_width, height) {
    union() {
        difference() {
            translate([0,0,height/2])
                cylinder(h=height, r1=bottom_radius, r2=top_radius, center=true, $fn=6);
                
            translate([0,0,height])
                sphere(hollow_radius/1.666, $fn=resolution);
        }

        translate([0,0,height/2])
            cube([bottom_radius*1.5, 20, height], center=true);
            
        translate([0,0,height])
            back(_braille_line_sep[1]*INCH/2)
            braille_on_flat("full", $fn=50, size="large");

        translate([0,0,height])
            fwd(_braille_line_sep[1]*INCH/2)
            braille_on_flat("agonist", $fn=50, size="large");
            
        translate([0,0,height/2])
            prismoid(size1=[top_radius*3*0.98,arm_bottom_width], size2=[top_radius*3,arm_top_width], h=height, center=true);
    }
}

hexagon_top_radius = receptor_radius - receptor_rim_top_thickness;
hexagon_bottom_radius = (receptor_radius - receptor_rim_bottom_thickness) / tolerance;

hollow_radius =  (receptor_radius-receptor_rim_top_thickness)*sqrt(3)/2;

arm_bottom_width = receptor_rim_cut_bottom_width / tolerance;
arm_top_width = receptor_rim_cut_top_width / tolerance;
    
full_agonist(hexagon_bottom_radius, hexagon_top_radius, hollow_radius, arm_bottom_width, arm_top_width, receptor_rim_cut_depth);
