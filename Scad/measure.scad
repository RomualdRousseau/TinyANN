module measure(d, h, r = 0, width = 0.01)
{
    color("black") linear_extrude(width) rotate([0, 0, r])
    {
        translate([0, -d / 2, 0]) square(size = [h, width]);
        translate([0, d / 2, 0]) square(size = [h, width]);
        translate([h - 1 + width / 2, -d / 2, 0])
        {
            translate([-width / 2, 0, 0]) square(size = [width, d]);
            rotate([0, 0, -20]) translate([-width / 2, 0, 0]) square(size = [width, 0.5]);
            rotate([0, 0, 20]) translate([-width / 2, 0, 0]) square(size = [width, 0.5]);
            translate([0, d, 0]) rotate([0, 0, 180])
            {
                rotate([0, 0, -20]) translate([-width / 2, 0, 0]) square(size = [width, 0.5]);
                rotate([0, 0, 20]) translate([-width / 2, 0, 0]) square(size = [width, 0.5]);
            }
        }
        translate([h + (cos(r) * len(str(d * 10)) - 1) * 0.5, 0, 0]) rotate([0, 0, -r]) text(str(d * 10, "mm"), size = 0.5, halign = "center", valign = "center");
    }
}
