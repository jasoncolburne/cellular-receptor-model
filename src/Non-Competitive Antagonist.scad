include <braille-on-flat.scad>;
include <Neuroscience Receptor Kit Configuration.scad>;
include <Primitives.scad>;

module non_competitive_antagonist(pyramid_height, pyramid_base_width) {
    translate([0, 0, pyramid_height/2])
        rotate([0, 0, 45])
            pyramid(pyramid_height, pyramid_base_width);

    rotate([180,0,0])
        back(_braille_line_sep[1]*INCH/2)
            braille_on_flat(text="nca", $fn=50, size="large");
}

non_competitive_antagonist(stabbing_pyramid_height, stabbing_pyramid_base_width);
