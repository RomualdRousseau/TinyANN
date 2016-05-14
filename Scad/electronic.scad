use <hardware.scad>

module micro_switch(length = 0.5)
{
    color("DarkSlateGray") translate([0, 0, 0.3]) cylinder(d1 = 0.3, d2 = 0.25, h = length);
    color("DarkSlateGray") translate([-0.30, -0.30, 0]) cube(size = [0.6, 0.6, 0.3]);
}

module switch(angle = 0, length = 1.1, thickness = 0.3)
{
    color("blue") translate([-0.6, -0.4, -1.1]) cube(size = [1.2, 0.8, 1]);
    color("silver") 
    {
        translate([0, 0, -0.1]) cylinder(d = 0.8, h = 0.1);
        difference()
        {
            translate([0, 0, 0]) cylinder(d = 0.6, h = 0.8);
            translate([0, 0, 0.4]) cylinder(d = 0.4, h = 0.5);
        }
        translate([0, 0, 0.4]) rotate([0, angle, 0]) cylinder(d1=0.25, d2 = 0.3, h = length + 0.4);
        // hardware
        translate([0, 0, thickness + 0.05]) washer(0.6);
        translate([0, 0, thickness + 0.25]) nut(0.2, 0.6);
    }
}

module switch_push(thickness = 0.3)
{
    color("blue") translate([0, 0, -1.1]) cylinder(d = 0.8, h = 1);
    color("DarkSlateGray") translate([0, 0, 1.1]) cylinder(d = 0.6, h = 0.3);
    color("silver") 
    {
        translate([0, 0, -0.1]) cylinder(d = 0.8, h = 0.1);
        difference()
        {
            translate([0, 0, 0]) cylinder(d = 0.6, h = 0.8);
            translate([0, 0, 0.4]) cylinder(d = 0.4, h = 0.5);
        }
        translate([0, 0, 0.4]) cylinder(d1=0.25, d2 = 0.3, h = 0.9);
        // hardware
        translate([0, 0, thickness + 0.05]) washer(0.6);
        translate([0, 0, thickness + 0.25]) nut(0.2, 0.6);
    }
}

module jumper(count = 1)
{
    n = count / 2;
    color("DarkSlateGray") translate([-0.25 * n, -0.15, 0]) cube(size = [0.25 * count, 0.3, 0.3]);
    color("gold") for(i = [0:count - 1]) translate([0.25 * (n - i) - 0.175, -0.05, 0]) cube(size = [0.1, 0.1, 0.9]);
}

module ft232rl()
{
    color("green") translate([-2, -1.5, -0.2]) cube(size = [4, 3, 0.2]);
    color("silver") translate([-2, -0.6, 0]) cube(size = [1.7, 1.2, 1.1]);
    translate([0.8, -1.2, 0]) jumper(8);
    translate([-0.7, -1.2, 0]) jumper(3);
    translate([0.8, 1.2, 0]) jumper(8);
    translate([-0.7, 1.2, 0]) jumper(3);
}

module rs232(thickness = 0.3)
{
    color("silver")
    {
        difference()
        {
            translate([-1.55, -0.6, -0.1]) cube(size = [3.1, 1.2, 0.1]);
            translate([-1.2, 0, -0.2]) cylinder(d = 0.3, h = 0.3);
            translate([1.2, 0, -0.2]) cylinder(d = 0.3, h = 0.3);
        }
        translate([-1, -0.55, -0.6]) cube(size = [2, 1.1, 0.5]);
        translate([-0.6, -0.4, 0]) cube(size = [1.2, 0.8, 0.6]);
        // hardware
        translate([-1.2, 0, 0])
        {
            screw(thickness + 0.4, 0.3);
            translate([0, 0, -thickness - 0.1]) nut(0.2, 0.3);
        }
        translate([1.2, 0, 0])
        {
            screw(thickness + 0.4, 0.3);
            translate([0, 0, -thickness - 0.1]) nut(0.2, 0.3);
        }
    }
}

module antenna()
{
    color("DarkSlateGray") cylinder(d1 = 1, d2 = 0.8, h = 11);
}

module battery()
{
    color("red") cube(size = [15.5, 2.2, 4.5]);
}

module led_green()
{
    color("green") cylinder(d = 0.3, h = 0.7);
}

module lcd_16x2(thickness = 0.3)
{
    translate([-4, -1.8, -0.5])
    {
        color("green") difference()
        {
            cube(size = [8, 3.6, 0.2]);
            translate([0.3, 0.3, -0.1]) cylinder(d = 0.3, h = 0.4);
            translate([7.7, 0.3, -0.1]) cylinder(d = 0.3, h = 0.4);
            translate([7.7, 3.3, -0.1]) cylinder(d = 0.3, h = 0.4);
            translate([0.3, 3.3, -0.1]) cylinder(d = 0.3, h = 0.4);
        }
        color("green") translate([0.6, 0.05, -0.4]) cube(size = [4.1, 2.4, 0.4]);
        color("black") translate([0.45, 0.6, 0.2]) difference()
        {
            cube(size = [7.1, 2.4, 0.7]);
            translate([0.3, 0.5, -0.1]) cube(size = [6.5, 1.4, 0.9]);
        }
        color("grey") translate([0.75, 1.1, 0.1]) cube(size = [6.5, 1.4, 0.75]);
        // hardware
        translate([0.3, 0.3, 0.55 + thickness])
        {
            screw(thickness + 0.8, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.05]) nut(0.3, 0.3);
            translate([0, 0, -thickness - 0.55]) nut(0.2, 0.3);
        }
        translate([7.7, 0.3, 0.55 + thickness])
        {
            screw(thickness + 0.8, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.05]) nut(0.3, 0.3);
            translate([0, 0, -thickness - 0.55]) nut(0.2, 0.3);
        }
        translate([7.7, 3.3, 0.55 + thickness])
        {
            screw(thickness + 0.8, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.05]) nut(0.3, 0.3);
            translate([0, 0, -thickness - 0.55]) nut(0.2, 0.3);
        }
        translate([0.3, 3.3, 0.55 + thickness])
        {
            screw(thickness + 0.8, 0.3);
            washer(0.3);
            translate([0, 0, -thickness - 0.05]) nut(0.3, 0.3);
            translate([0, 0, -thickness - 0.55]) nut(0.2, 0.3);
        }
    }
}

$fn = 20;
translate([-2, 0, 0]) micro_switch(0.9);
translate([2, 0, 0]) switch(10, 2.1);
translate([7, 0, 0]) ft232rl();
translate([13, 0, 0]) rs232();
translate([17, 0, 0]) antenna();
translate([25, 0, 0]) lcd_16x2();
translate([-5, 0, 0]) switch_push();


