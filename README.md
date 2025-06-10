# cellular-receptor-model

An accessible (braille) openSCAD teaching model of a cellular receptor and its ligands,
suitable for 3d printing.

The model was prototyped in Bambu Studio on a Bambu Lab A1 printer using standard settings
and no AMS, after generating STL files using openSCAD.

```
the cellular receptor is modeled with a space for ligands (molecules that bond to receptors).

the center space (marked below with an x) is a binding site for some ligands (agonists and
competitive antagonists of the receptor) to bond.

top view:
      ___
    _/   \_
    _  x  _    
     \___/

the slots on the side of the receptor can be thought of as activation pathways - when both
are filled, the receptor is fully activated, producing a maximal response.

top view:
      ___
    _/   \_
    _     _<- activation pathway
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
  perfectly and activates all activation points.

partial agonist - a molecule that bonds to the receptor and activates it with less than optimal
  efficacy. in our model, the partial agonist is a pentagon that fits in the hexagon shaped
  binding site, and activates a single activation point.

competitive antagonist - a molecule that bonds to the receptor and produces no effect, reducing
  the effect of agonists in the same system. in our model, the competitive antagonist is a circle
  that activates neither activation point.

non-competitive antagonist - a molecule that bonds to the receptor in an alternate location,
  inhibiting the receptor's action. in our model, the non-competitive antagonist is a tall,
  four-sided pyramid that is inserted through the exterior of the receptor.
```
