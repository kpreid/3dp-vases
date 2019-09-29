// This is intended to be printed with no bottom as well as no top, making a hoop.

include <common.scad>

width = 150;
height = 40;

nlobes = 20;


main();


module main() {
    nrings = height / 5;
    nringpts = nlobes * 16;
    
    // TODO: Make this more reusable (e.g. factor out all the point increment computations)
    faceted_vase(
        nrings=nrings,
        nringpts=nringpts,
        height=height,
        points = [
            for (ring = [0:nrings - 1])
            let (advance = -ring * (360 / nringpts) / 2)
            for (ringpt = [0:nringpts - 1])
            let (angle = advance + ringpt * 360 / nringpts,
                 z = height / (nrings - 1) * ring,
                 r = radiusfn(angle, z),
                 angle2 = anglefn(angle, z) + angle)
            [r * sin(angle2), r * cos(angle2), z]
        ]
    );
    
    function radiusfn(angle, z) = 
        width / 2
        * 1.2 * (0.9 + 0.1 * cos((angle + 45) * nlobes));
    
    function anglefn(angle, z) = 
        2 * sin((angle + 45) * nlobes * 2);
}
