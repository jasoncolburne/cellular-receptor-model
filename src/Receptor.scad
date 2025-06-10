include <braille-on-cylinder.scad>;
include <Neuroscience Receptor Kit Configuration.scad>;
include <Primitives.scad>;

// the cellular receptor is modeled with a space for ligands (molecules that bond to receptors).
//
// the center space (marked below with an x) is a binding site for some ligands (agonists and
// competitive antagonists of the receptor) to bond.
//
// top view:
//      ___
//    _/   \_
//    _  x  _    
//     \___/
//
// the slots on the side of the receptor can be thought of as activation pathways - when both
// are filled, the receptor is fully activated, producing a maximal response.
//
// top view:
//      ___
//    _/   \_
//    _     _<- activation pathway
//     \___/
//
// the different ligands that bind to these sites produce varying effects, and they compete to
// bond there.
//
// the hole in the bottom represents a spot that a non-competitive antagonist may bond to.
// like an off switch, it inhibits the activation of the receptor and cannot be overcome by
// increasing available agonists. this is modeled by inserting the non-competitive agonist in
// in the secondary bonding site, where it dislodges anything in the primary site. though the
// mechanics of biology differ, the model provides a good analog.
// 
// the components of the kit demonstrate interactions with various ligands. 
//
// full agonist - a molecule that bonds to the receptor and activates it with maximum efficacy.
//   in our model, the full agonist is a hexagon that fills the receptor's primary binding site
//   perfectly and activates all activation points.
//
// partial agonist - a molecule that bonds to the receptor and activates it with less than optimal
//   efficacy. in our model, the partial agonist is a pentagon that fits in the hexagon shaped
//   binding site, and activates a single activation point.
//
// competitive antagonist - a molecule that bonds to the receptor and produces no effect, reducing
//   the effect of agonists in the same system. in our model, the competitive antagonist is a circle
//   that activates neither activation point.
//
// non-competitive antagonist - a molecule that bonds to the receptor in an alternate location,
//   inhibiting the receptor's action. in our model, the non-competitive antagonist is a tall,
//   four-sided pyramid that is inserted through the exterior of the receptor.



// receptor class

module receptor(
    base_radius,
    base_height,
    radius,
    rim_height,
    top_wall_thickness,
    bottom_wall_thickness,
    cut_top_width,
    cut_bottom_width,
    cut_depth,
    pyramid_base_width,
    pyramid_height,
    resolution,
) {
    sphere_segment_height = sqrt(radius * radius - base_radius * base_radius);
    center_of_sphere = [0, 0, base_height + sphere_segment_height];

    module base() {
        translate([0, 0, base_height/2])
            cylinder(h=base_height, r=base_radius, center=true, $fn=resolution);
    }

    module translateToSphereHeight() { 
        translate(center_of_sphere)
            children();
    }
    
    module translateToRimHeight(object_height) {
        translateToSphereHeight() {
            translate([0, 0, rim_height-object_height/2.0])
                children();
        }
    }

    module punch(top_radius, bottom_radius, height) {
        tapered_hexagon(bottom_radius=bottom_radius, top_radius=top_radius, height=height);
    }

    module slice(radius, cut_depth, cut_top_width, cut_bottom_width) {
        prismoid(size1=[radius*2,cut_bottom_width], size2=[radius*2,cut_top_width], h=cut_depth, center=true);
    }

    module stab(height, base_width) {
        rotate([30, 0, 33])
            translate([0, 42, 32])
                rotate([0, 0, -45])
                    pyramid(height=height, base_width=base_width);
    }

    // the algorithm
    
    union() {

        base();
        
        // top rounded goblety part
        difference() {
            union() {
                // bottom bowl of goblety thing
                intersection() {
                    translateToSphereHeight() {
                        sphere(radius, $fn=resolution);
                    }
                    
                    translateToSphereHeight() {
                        translate([0, 0, -radius/2])
                            cube([radius*2, radius*2, radius], center=true);
                    }
                    
                    translateToSphereHeight() {
                        translate([0, 0, -sphere_segment_height/2])
                            cylinder(h=sphere_segment_height, r1=base_radius, r2=radius * 1.32, $fn=resolution, center=true);
                    }
                }
                
                // top of goblety bit
                translateToRimHeight(rim_height) {
                    cylinder(r=radius, h=rim_height, $fn=resolution, center=true);
                }
            }
        
            // punch out hexagon
            translateToRimHeight(cut_depth) {
                punch(radius-top_wall_thickness, radius-bottom_wall_thickness, cut_depth);
            }
            
            
            // slice out slot
            translateToRimHeight(cut_depth) {
                slice(radius, cut_depth, cut_top_width, cut_bottom_width);
            }
            
            // stab pyramid out
            stab(pyramid_height, pyramid_base_width);
        }
        

        braille_on_cylinder(text="receptor", $fn=50, size="large", radius=base_radius, height=base_height);
    }
}


// main program

receptor(
    base_radius,
    base_height,
    receptor_radius,
    receptor_rim_height,
    receptor_rim_top_thickness,
    receptor_rim_bottom_thickness,
    receptor_rim_cut_top_width,
    receptor_rim_cut_bottom_width,
    receptor_rim_cut_depth,
    stabbing_pyramid_base_width,
    stabbing_pyramid_height,
    resolution,
);
