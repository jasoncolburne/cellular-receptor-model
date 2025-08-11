include <BOSL2/std.scad>;

module tapered_pentagon(bottom_side_length, top_side_length, height) {
    bottom_radius=bottom_side_length/2*sin(2*PI/5);
    top_radius=top_side_length/2*sin(2*PI/5);
    cylinder(h=height, r1=bottom_radius, r2=top_radius, center=true, $fn=5);
}

module tapered_hexagon(bottom_radius, top_radius, height) {
    cylinder(r1=bottom_radius, r2=top_radius, h=height, center=true, $fn=6);
}

module pyramid(height, base_width) {
    cylinder(h=height, r1=sqrt(base_width*base_width/2), r2=0, $fn=4, center=true);
}

function make_offsets(widths, pad=0, start=0, idx=0, total=0, offsets=[]) =
    idx < len(widths)
        ? make_offsets(widths, pad, start, idx+1, total + (widths[idx] + pad), concat(offsets, [start + total]))
        : offsets;

module text_on_cone(label, depth, label_widths, label_offsets, bottom_radius, top_radius, height, center_angle, vertical_offset) {
    for (i = [0:len(label)-1]) {
        full_width = label_offsets[len(label)-1] + label_widths[len(label)-1];
    
        letter_metrics = textmetrics(label[i], size=font_size);
        offset = letter_metrics.ascent + letter_metrics.descent;

        z = vertical_offset + offset/2;
        radius_at_z_centered = bottom_radius + (vertical_offset / height) * (top_radius - bottom_radius);
        radius_at_z = bottom_radius + (z / height) * (top_radius - bottom_radius);

        circumference_centered = 2 * PI * radius_at_z_centered;
        
        start_angle = center_angle - 90 - 360 * full_width / circumference_centered / 2;
        slant_angle = atan((top_radius - bottom_radius) / height);

        angle = start_angle + 360 * (label_offsets[i] + label_widths[i]/2) / circumference_centered;

        echo(full_width, radius_at_z_centered, circumference_centered, start_angle, angle);
        rotate([0, 0, angle])
            translate([radius_at_z - depth, 0, z])
                rotate([0, slant_angle, 0])
                    rotate([90, 0, 90])
                        linear_extrude(depth)
                            text(label[i], size=font_size, valign="center", halign="center");
    }
}

module text_on_tapered_polyhedron_face(
    faces, bottom_radius, top_radius, height,
    face_index, label, vertical_position,
    font_size=8, depth=0.2
) {
    theta_face = 360 / faces * (face_index + 2) - ((faces % 2 == 1) ? 180 / 2 / faces : 0);
    t = vertical_position / height;
    r_z = bottom_radius + t * (top_radius - bottom_radius);
    apothem_z = r_z * cos(180 / faces);

    label_position = [
        apothem_z * sin(theta_face),
        -apothem_z * cos(theta_face),
        vertical_position
    ];

    face_tilt = atan(cos(180 / faces) * (top_radius - bottom_radius) / height);

    translate(label_position)
        rotate([0, 0, theta_face])
            rotate([90, 0, 0]) // orient text outward rather than upward
                rotate([face_tilt, 0, 0])
                    translate([0,0,-depth*0.999])
                        linear_extrude(depth)
                            text(label, size=font_size, halign="center", valign="center");
}
