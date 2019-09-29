include <common.scad>

width = 150;
height = 150;

translate([width / 2, width / 2, 0])
main();

module main() {
    nrings = 6;
    nringpts = nrings * 2;
    
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
                 r = radiusfn(angle, z))
            [r * sin(angle), r * cos(angle), z]
        ]
    );
    
    function radiusfn(angle, z) = 
        width / 2
        * 1.2 * (0.9 + 0.1 * cos((angle + 45) * 4))
        * 0.9 * (1 + 0.2 * cos(z / height * 300 - 60));
}
