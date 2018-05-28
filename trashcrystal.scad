
width = 150;
height = 150;

translate([width / 2, width / 2, 0])
main();

module main() {
    nrings = 6;
    nringpts = nrings * 2;
    
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


module faceted_vase(nrings, nringpts, height, points) {
    tip_pts = [[0, 0, 0], [0, 0, height]];
    nt = len(tip_pts);
    polyhedron(
        convexity = 2,
        points = concat(
            tip_pts,
            points
        ),
        faces = flatten([
            for (ring0 = [-1:nrings - 1])
            let (ring1 = ring0 + 1)
            for (rp0 = [0:nringpts - 1])
            let (rp1 = (rp0 + 1) % nringpts)
            let (i00 = ring0 == -1 ? 0 : nt + ring0 * nringpts + rp0,
                 i01 = ring0 == -1 ? 0 : nt + ring0 * nringpts + rp1,
                 i10 = ring1 == nrings ? 1 : nt + ring1 * nringpts + rp0,
                 i11 = ring1 == nrings ? 1 : nt + ring1 * nringpts + rp1)
            [
                [i01, i00, i11],
                [i11, i00, i10]
            ]
        ])
    );
}


function flatten(vectors) = [for (v = vectors, element = v) element];
