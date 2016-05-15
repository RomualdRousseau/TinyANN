include<global.scad>

use <hardware.scad>
use <electronic.scad>

module wheel()
{
    color("black") difference()
    {
        cylinder(d = 4.2, h = 1.8);
        translate([0, 0, -0.1]) cylinder(d = 2.8, h = 2);
    }
    color("white") translate([0, 0, 1.2]) difference()
    {
        cylinder(d = 2.8, h = 0.3);
        translate([0, 0, -0.1]) cylinder(d = 0.3, h = 0.5);
    }
}

module motor_n20()
{
    color("silver") difference()
    {
        cylinder(d = 1.2, h = 1.5);
        translate([-0.6, 0.5, -0.1]) cube([1.2, 0.11, 1.7]);
        translate([-0.6, -0.6, -0.1]) cube([1.2, 0.11, 1.7]);
    }
    color("gold") translate([0, 0, 1.95]) cube(size = [1.2, 1, 0.9], center = true);
    color("silver") translate([0, 0, -0.1]) cylinder(d = 0.3, h = 0.1 + 1.5 + 0.9 + 1);
}

module motor_n20_support()
{
    color("white")
    {
        translate([0.6, -0.5, 0]) union()
        {
            linear_extrude(height = 1.2) polygon([[0, 0.3], [0.2, 0.3], [0.2, 1.2], [-1.4, 1.2], [-1.4, 0.3], [-1.2, 0.3], [-1.2, 1], [0, 1]]);
            difference()
            {
                cube([0.7, 0.3, 01.2]);
                translate([0.35, 0.4, 0.6]) rotate([90, 0, 0]) cylinder(d = 0.2, h = 0.5);
                translate([0.35, 0.4, 0.6]) rotate([90, 0, 0]) cylinder(d = 0.4, h = 0.2);
            }
            difference()
            {
                translate([-1.9, 0, 0]) cube([0.7, 0.3, 01.2]);
                translate([-1.55, 0.4, 0.6]) rotate([90, 0, 0]) cylinder(d = 0.2, h = 0.5);
                translate([-1.55, 0.4, 0.6]) rotate([90, 0, 0]) cylinder(d = 0.4, h = 0.2);
            }
        }
    }
    color("black")
    {
        translate([-0.95, -0.7, 0.6]) rotate([90, 0, 0]) 
        {
            screw(d = 0.2, h = 0.6);
            translate([0, 0, -0.4]) nut(d = 0.2, h = 0.1);
        }
        translate([0.95, -0.7, 0.6]) rotate([90, 0, 0]) 
        {
            screw(d = 0.2, h = 0.6);
            translate([0, 0, -0.4]) nut(d = 0.2, h = 0.1);
        }
    }
}

module motor_block()
{
    motor_n20();
    translate([0, 0, 0.6]) motor_n20_support();
    translate([0, 0, 1.95]) wheel();
}

module roller()
{
    color("silver")
    {
        difference()
        {
            linear_extrude(height = 0.1) hull()
            {
                circle(1.6);
                translate([1.95,0,0]) circle(0.5);
                translate([-1.95,0,0]) circle(0.5);
            }
            translate([1.95, 0, -0.1]) cylinder(d = 0.3, h = 0.3);
            translate([-1.95, 0, -0.1]) cylinder(d = 0.3, h = 0.3);
        }
        rotate_extrude() polygon([[1.5, 0], [1.4, 0.2], [1.4, 1.4], [0.8, 1.9], [0.7, 1.9], [1.3, 1.4], [1.3, 0]]);
        translate([0, 0, 1.35]) sphere(d = 1.7);
        
        translate([1.95, 0, -0.6]) rotate([180, 0, 0]) screw(d = 0.3, h = 1);
        translate([1.95, 0, 0]) nut(d = 0.3, h = 0.4);
        translate([1.95, 0, 0.3]) nut(d = 0.3, h = 0.2);
        
        translate([-1.95, 0, -0.6]) rotate([180, 0, 0]) screw(d = 0.3, h = 1);
        translate([-1.95, 0, 0]) nut(d = 0.3, h = 0.4);
        translate([-1.95, 0, 0.3]) nut(d = 0.3, h = 0.2);
    }
}

module sensor_support()
{
    color("Gainsboro") difference()
    {
        union()
        {
            cube([2, 1, 0.2]);
            translate([1, 0.2, 0.5]) rotate([0, -90, 90]) cylinder(d = 2, h = 0.2, $fn = 3);
        }
        translate([0.5, 0.5, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([1.5, 0.5, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([1, 0.3, 1]) rotate([90, 0, 0]) cylinder(d = 0.3, h = 0.4);
    }

    color("silver") translate([1, 0.2, 1]) rotate([270, 0, 0])
    {
        screw(d = 0.3, h = 0.7);
        translate([0, 0, -0.4]) nut(d = 0.3, h = 0.2);
    }
}

module sensor_PCB()
{
    color("green") translate([0, -2, -0.3]) difference()
    {
        cube([2, 3, 0.1]);
        translate([0.5, 2.5, 0.2]) rotate([180, 0, 0]) cylinder(d = 0.3, h = 0.3);
        translate([1.5, 2.5, 0.2]) rotate([180, 0, 0]) cylinder(d = 0.3, h = 0.3);
    }
    color("black")
    {
        translate([0.75, -1.5, -0.8]) cube([0.5, 0.5, 0.5]);
        translate([0.5, 0.5, -0.3]) rotate([180, 0, 0])
        {
            translate([0, 0, -0.1]) nut(d = 0.3, h = 0.2);
        }
        translate([1.5, 0.5, -0.3]) rotate([180, 0, 0])
        {
            translate([0, 0, -0.1]) nut(d = 0.3, h = 0.2);
        }
    }
    color("silver")
    { 
        translate([0.5, 0.5, -0.3]) rotate([180, 0, 0])
        {
            screw(d = 0.3, h = 0.8);
            translate([0, 0, -0.5]) nut(d = 0.3, h = 0.2);
        }
        translate([1.5, 0.5, -0.3]) rotate([180, 0, 0])
        {
            screw(d = 0.3, h = 0.8);
            translate([0, 0, -0.5]) nut(d = 0.3, h = 0.2);
        }
    }
}

module main_PCB()
{
    color("green") difference()
    {
        cube([6, 9, 0.1]);
        translate([5, 8.6, -0.1]) cylinder(d = 0.3, h = 0.3);
        translate([1, 8.6, -0.1]) cylinder(d = 0.3, h = 0.3);
        translate([1.5, 3.2, -0.1]) cylinder(d = 0.3, h = 0.3);
        translate([4.5, 3.2, -0.1]) cylinder(d = 0.3, h = 0.3);
    }
    
    translate([5, 8.6, 0])
    {
        nut(d = 0.3, h = 1.1);
        translate([0, 0, -1.3]) rotate([180, 0, 0]) screw(d = 0.3, h = 0.7);
        translate([0, 0, 0.1]) screw(d = 0.3, h = 0.7);
    }
    translate([1, 8.6, 0])
    {
        nut(d = 0.3, h = 1.1);
        translate([0, 0, -1.3]) rotate([180, 0, 0]) screw(d = 0.3, h = 0.7);
        translate([0, 0, 0.1]) screw(d = 0.3, h = 0.7);
    }
    translate([4.5, 3.2, 0])
    {
        nut(d = 0.3, h = 1.1);
        translate([0, 0, -1.3]) rotate([180, 0, 0]) screw(d = 0.3, h = 0.7);
        translate([0, 0, 0.1]) screw(d = 0.3, h = 0.7);
    }
    translate([1.5, 3.2, 0])
    {
        nut(d = 0.3, h = 1.1);
        translate([0, 0, -1.3]) rotate([180, 0, 0]) screw(d = 0.3, h = 0.7);
        translate([0, 0, 0.1]) screw(d = 0.3, h = 0.7);
    }
}

module battery()
{
    color("silver") cube([2.9, 5.3, 1.7]);
}

module plate()
{
    color("DarkSlateGray") difference()
    {
        cylinder(d = 12.2, h = 0.2);
        translate([3.1, -2.3, -0.1]) cube(size = [2.3, 4.6, 0.4]);
        translate([-5.4, -2.3, -0.1]) cube(size = [2.3, 4.6, 0.4]);
        translate([3.8, 4.3, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([-3.8, 4.3, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([-3.8, -4.3, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([3.8, -4.3, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([-4.65, 3, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([0, 5.3, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([4.65, 3, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([-1.95, 5.2, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([1.95, 5.2, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([-1.95, -5.2, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([1.95, -5.2, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([2, 3.6, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([-2, 3.6, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([1.5, -1.8, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([-1.5, -1.8, -0.1]) cylinder(d = 0.3, h = 0.4);
        translate([2.5, -0.95, -0.1]) cylinder(d = 0.2, h = 0.4);
        translate([2.5, 0.95, -0.1]) cylinder(d = 0.2, h = 0.4);
        translate([-2.5, -0.95, -0.1]) cylinder(d = 0.2, h = 0.4);
        translate([-2.5, 0.95, -0.1]) cylinder(d = 0.2, h = 0.4);
        translate([0, 0, -0.1]) cylinder(d = 1.5, h = 0.4);
    }
}

module step1()
{
    plate();
    
    translate([1.3, 0, -0.5 - explode_dist / 4]) rotate([90, 180, 90]) motor_block();
    translate([-1.3, 0, -0.5 - explode_dist / 4]) rotate([90, 180, -90]) motor_block();

    translate([0, 5.2, -0.4 - explode_dist / 4]) rotate([180, 0, 0]) roller();
    translate([0, -5.2, -0.4 - explode_dist / 4]) rotate([180, 0, 0]) roller();
}

module step2()
{
    translate([-1.45, -6.1, 0.2 + explode_dist / 4]) battery();
    
    translate([3.8, 4.3, 2 + explode_dist / 4])
    {
        nut(d = 0.3, h = 1.8);
        color("silver") translate([0, 0, 0.2]) screw(d = 0.3, h = 0.7);
        color("silver") translate([0, 0, -2]) rotate([180, 0, 0]) screw(d = 0.3, h = 0.7);
    }
    translate([-3.8, 4.3, 2 + explode_dist / 4])
    {
        nut(d = 0.3, h = 1.8);
        color("silver")translate([0, 0, 0.2]) screw(d = 0.3, h = 0.7);
        color("silver")translate([0, 0, -2]) rotate([180, 0, 0]) screw(d = 0.3, h = 0.7);
    }
    translate([3.8, -4.3, 2 + explode_dist / 4])
    {
        nut(d = 0.3, h = 1.8);
        color("silver") translate([0, 0, 0.2]) screw(d = 0.3, h = 0.7);
        color("silver") translate([0, 0, -2]) rotate([180, 0, 0]) screw(d = 0.3, h = 0.7);
    }
    translate([-3.8, -4.3, 2 + explode_dist / 4])
    {
        nut(d = 0.3, h = 1.8);
        color("silver") translate([0, 0, 0.2]) screw(d = 0.3, h = 0.7);
        color("silver") translate([0, 0, -2]) rotate([180, 0, 0]) screw(d = 0.3, h = 0.7);
    }
}

module step3()
{
    translate([0, 0, 2 + explode_dist / 2]) plate();

    translate([-1, 6.3, 2.2 + explode_dist]) rotate([90, 0, 0]) { sensor_support(); sensor_PCB(); }
    translate([-6.05, 3, 2.2 + explode_dist]) rotate([90, 0, 45]) { sensor_support(); sensor_PCB(); }
    translate([4.65, 4.4, 2.2 + explode_dist]) rotate([90, 0, -45]) { sensor_support(); sensor_PCB(); }
}

module step4()
{
    translate([-3, -5, 3.3 + explode_dist]) main_PCB();
}

rotate([0, 0, 180])
{
    step1();
    step2();
    step3();
    step4();
}
