use<turtle.scad>
use<measure.scad>

projection()
{
    plate();
    measure(d = 12.2, h = 11, r = 0);
    measure(d = 4.6, h = 8, r = 0);
    translate([4.25, 0, 0]) measure(d = 2.3, h = 8, r = -90);
}

projection() translate([-13, 5, 0]) 
{
    rotate([0, 90, 0]) sensor_support();
    translate([0, 0.5, 0]) measure(d = 1, h = 3, r = 0);
    translate([0.75, 0, 0]) measure(d = 1.5, h = 2, r = -90);
}

projection() translate([-13, 0, 0])
{
    sensor_support();  
    translate([1, 0.5, 0]) measure(d = 1, h = 3, r = 0);
    translate([1, 0, 0]) measure(d = 2, h = 2, r = -90);
}

projection() translate([-13, -4, 0])
{
    rotate([90, 0, 0]) sensor_support();
    translate([1, -0.75, 0]) measure(d = 1.5, h = 3, r = 0);
    translate([1, 0, 0]) measure(d = 2, h = 3.5, r = -90);
}
