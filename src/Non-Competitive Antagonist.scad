include <braille-on-flat.scad>;
include <Neuroscience Receptor Kit Configuration.scad>;
include <Primitives.scad>;

label = "nca";

label_size = 8;
label_depth = 0.2;

module non_competitive_antagonist(pyramid_height, pyramid_base_width) {
    label_metrics = textmetrics(label, size=label_size);
    x_offset = (pyramid_base_width - label_metrics.size[0])/2 - 0.5; // why is this 0.5 necessary?
    y_offset = (pyramid_base_width / 2 - label_metrics.size[1])/2 - pyramid_base_width / 4;
    
    difference() {
        translate([0, 0, pyramid_height/2])
            rotate([0, 0, 45])
                pyramid(pyramid_height, pyramid_base_width);
        translate([-pyramid_base_width/2, pyramid_base_width/2, 0])
            translate([x_offset, y_offset, label_depth])
                rotate([180, 0, 0])
                    linear_extrude(label_depth)
                        text(label, size=label_size);
    }

    rotate([180,0,0])
        back(_braille_line_sep[1]*INCH/2)
            braille_on_flat(text="nca", $fn=50, size="large");
}

non_competitive_antagonist(stabbing_pyramid_height, stabbing_pyramid_base_width);
