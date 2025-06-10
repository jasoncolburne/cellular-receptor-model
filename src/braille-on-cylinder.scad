module braille_on_cylinder(text,method="en-us-g2",size="small",style="sphere",radius,height,anchor,orient,spin)
{
  legal_styles = ["sphere"];
  legal_methods = ["en-us-g2"];
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
    for(i=[0:1:len(braille)-1])
      let(symbol=braille[i])
      if (symbol && symbol!="0") // skip if zero or empty string (space)
          for(ch=str(symbol)){
            assert(len(search(ch,"123456"))>0, str("Got invalid digit, \"",ch, "\", in braille dots."));
            let(n=ord(ch)-ord("1"))
            let(text_width = (len(braille) - 1) * _braille_cell_sep[ind] * INCH)
            let(text_height = _braille_line_sep[ind]*INCH)
            let(local = _braille_dot_sep[ind] * INCH * [floor(n/3), -n%3])
            let(x_cell = i * _braille_cell_sep[ind] * INCH)
            let(x = local[0] + x_cell - text_width/2)
            let(y = local[1] + _braille_dot_sep[ind]*INCH + height/2)
            let(theta = 360 * x / (2 * PI * radius))
            let(x_cyl = radius * cos(theta))
            let(y_cyl = radius * sin(theta))
            let(z_cyl = y)
            translate([x_cyl, y_cyl, z_cyl])
                // should take height into account
                sphere(_braille_r[ind]*INCH);
    }  children();
  }
}
