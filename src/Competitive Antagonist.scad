include <braille-on-flat.scad>;
include <Neuroscience Receptor Kit Configuration.scad>;
include <Primitives.scad>;

top_label = "competitive";
bottom_label = "antagonist";

top_widths = [for (i=[0:len(top_label)-1]) textmetrics(top_label[i], size=font_size).size[0]];
bottom_widths = [for (i=[0:len(bottom_label)-1]) textmetrics(bottom_label[i], size=font_size).size[0]];

top_offsets = make_offsets(top_widths, pad=0.2);
bottom_offsets = make_offsets(bottom_widths, pad=0.2);

module competitive_antagonist(bottom_radius, top_radius, height, resolution) {
    union() {
        difference() {
            translate([0,0,height/2])
                cylinder(h=height, r1=bottom_radius, r2=top_radius, $fn=resolution, center=true);

            text_on_cone(top_label, label_depth, top_widths, top_offsets, bottom_radius, top_radius, height, 0, 14);
            text_on_cone(bottom_label, label_depth, bottom_widths, bottom_offsets, bottom_radius, top_radius, height, 0, 5);
                
            translate([0,0,height])
                sphere(top_radius/1.666, $fn=resolution);
        }

        translate([0,0,height/2])
            cube([bottom_radius*1.5, 20, height], center=true);
            
        translate([0,0,height])
            back(_braille_line_sep[1]*INCH/2)
            braille_on_flat("competitive", $fn=50, size="large");

        translate([0,0,height])
            fwd(_braille_line_sep[1]*INCH/2)
            braille_on_flat("antagonist", $fn=50, size="large");
    }
}

top_radius = (receptor_radius-receptor_rim_top_thickness)*sqrt(3)/2;
bottom_radius = (receptor_radius-receptor_rim_bottom_thickness)*sqrt(3)/2;

competitive_antagonist(bottom_radius, top_radius, receptor_rim_cut_depth, resolution);
