module screw(h, d)
{
    difference()
    {
        cylinder(d = d + 0.2, h = d / 2);
        rotate([0, 0, 45]) translate([-d, -0.05, d / 4]) cube(size = [d * 2, 0.1, d / 4 + 0.001]);
    }
    translate([0, 0, -h]) cylinder(d = d, h = h);  
}

module washer(d)
{
    translate([0, 0, -0.05]) difference()
    {
        cylinder(d = d + 0.4, h = 0.05);
        translate([0, 0, -0.1]) cylinder(d = d + 0.001, h = 0.3);
    }
}

module nut(h, d)
{
    color("gold") translate([0, 0, -h]) difference()
    {
        cylinder(d = d + 0.2, h = h, $fn = 8);
        translate([0, 0, -0.1]) cylinder(d = d + 0.001, h = h + 0.2);
    }
}

module foot()
{
    n = min(60 / ($fn / 4), 45);
    a = [[0.15, 0], [0.75, 0], [0.65, -0.5]];
    b = [for (a = [30: n: 90]) [0.4 + 0.25 * cos(-a), -0.5 + 0.30 * sin(-a)]]; //[[0.4 + 0.25 * cos(-22), -0.5 + 0.30 * sin(-22)], [0.4 + 0.25 * cos(-45), -0.5 + 0.30 * sin(-45)], [0.4 + 0.25 * cos(-67), -0.5 + 0.30 * sin(-67)]];
    c = [[0.4, -0.8], [0.3, -0.8], [0.3, -0.2], [0.15, -0.2]];
    color("black") rotate_extrude() polygon(points = concat(a, b, c));
}

module test()
{
    $fn = 20;
    translate([-2, 0, 0])
    {
        screw(1, 0.2);
        translate([0, 0, -0.2]) washer(0.2);
        translate([0, 0, -0.5]) nut(0.2, 0.2);
    }
    translate([2, 0, 0]) foot();
}

test();




