# cellular-receptor-model

An accessible (braille) openSCAD teaching model of a cellular receptor and its ligands,
suitable for 3d/FDM printing.

![Cellular Receptor Model](./assets/Cellular%20Receptor%20Model.png)

## Rationale

This was created to support an effort by Team Visual Assist at Dalhousie University (Canada). This
design was inspired by [the original](https://github.com/FilipKosel/3DDrugReceptor).

## Process

The model was prototyped in Bambu Studio on a Bambu Lab A1 FDM printer using stock settings and no AMS
(three plates/colors), after generating STL files using openSCAD. The filament used was Eureka PLA.

### Braille

I tested various implementations and processes for printing the braille:

Implementations:
1. Spheres
2. Larger spheres
3. Larger spheres embedded deeper (smoothing attempt)
4. Cylinders with rounded tops

There wasn't a ton of difference in the jagged feel the top facing braille has. Braille on vertical
surfaces is far nicer, but the print doesn't really accomodate that for the three pieces containing
the most braille.

Processes:
1. Variable height layering (0.04mm (braille) -> 0.1mm (base) w/ 0.2mm nozzle)
2. Ironing

Ultimately, the results produced with the 0.2mm nozzle do not seem that much better than those
created with a 0.4mm nozzle. The print time is nearly 4x, so I would stick with the 0.4mm
and variable height layers. Ironing seemed to produce no appreciable effect, other than a better
finish.

## Learning Content

```
the cellular receptor is modeled with a space for ligands (molecules that bond to receptors).

the center space (marked below with an x) is a binding site for some ligands (agonists and
competitive antagonists of the receptor) to bond.

top view:
      ___
    _/   \_
    _  x  _    
     \___/

the slots on the side of the receptor can be thought of as (conceptual) activation points - when
both are filled, the receptor is fully activated, producing a maximal response. when one is filled,
this represents a partial state of activation that is somewhere between no response and the maximum.

top view:
      ___
    _/   \_
    _     _<- activation point
     \___/

the different ligands that bind to these sites produce varying effects, and they compete to
bond there.

the hole in the bottom represents a spot that a non-competitive antagonist may bond to.
like an off switch, it inhibits the activation of the receptor and cannot be overcome by
increasing available agonists. this is modeled by inserting the non-competitive agonist in
in the secondary bonding site, where it dislodges anything in the primary site. though the
mechanics of biology differ, the model provides a good analog.
 
the components of the kit demonstrate interactions with various ligands. 

full agonist - a molecule that bonds to the receptor and activates it with maximum efficacy.
  in our model, the full agonist is a hexagon that fills the receptor's primary binding site
  perfectly.

partial agonist - a molecule that bonds to the receptor and activates it with less than optimal
  efficacy. in our model, the partial agonist is a pentagon that fits in the hexagon shaped
  binding site, and activates a single activation point - representing a partial activation.

competitive antagonist - a molecule that bonds to the receptor and produces no effect, reducing
  the effect of agonists in the same system. in our model, the competitive antagonist is a circle
  that activates neither activation point.

non-competitive antagonist - a molecule that bonds to the receptor in an alternate location,
  inhibiting the receptor's action. in our model, the non-competitive antagonist is a tall,
  four-sided pyramid that is inserted through the exterior of the receptor.
```
