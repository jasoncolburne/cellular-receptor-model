include <braille-on-flat.scad>;

module braille_test() {
    cube([50,50,1], center=true);
    translate([0,0,0.5])
    braille_on_flat(text="heroin", $fn=50, size="large");
}

braille_test();