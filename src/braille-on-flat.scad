include <BOSL2/std.scad>;
include <brailleSCAD/en-us-g2.scad>;
include <brailleSCAD/braille.scad>;

module braille_on_flat(text,method="en-us-g2",size="small",style="sphere",anchor,orient,spin)
{
  legal_styles = ["cyl","cone","sphere"];
  legal_methods = ["dots", "en-us-g2", "unicode"];
  dummy0 = assert(in_list(method, legal_methods), str("method must be one of ",legal_methods))
           assert(in_list(style,legal_styles), str(style,"style must be one of ",legal_styles));
  braille = method=="dots" ? text
          : method=="unicode" ? braille_unicode(text)
          : braille_transcribe(text);
  dummy=  assert(method!="dots" || is_list(text), "text must be a list of numbers or text strings with \"dots\" method")
          assert(in_list(size,["small","large"]),"size must be \"small\" or \"large\"");
  ind = size=="small" ? 0 : 1;
  attachable(anchor=anchor,orient=orient,spin=spin,
             size=[len(braille)*_braille_cell_sep[ind]*INCH, _braille_line_sep[ind]*INCH, _braille_height[ind]*INCH]){
  back(_braille_dot_sep[ind]*INCH)
  left(_braille_dot_sep[ind]/2*INCH+(len(braille)-1)*_braille_cell_sep[ind]/2*INCH)
    for(i=[0:1:len(braille)-1])
      if (braille[i] && braille[i]!="0") // skip if zero or empty string (space)
        right(i*_braille_cell_sep[ind]*INCH)
          for(ch=str(braille[i])){
            assert(len(search(ch,"123456"))>0, str("Got invalid digit, \"",ch, "\", in braille dots."));
            let(n=ord(ch)-ord("1"))
            translate(_braille_dot_sep[ind]*INCH*[floor(n/3),-n%3])
               sphere(_braille_r[ind]*INCH);
          }
  children();
  }
}

