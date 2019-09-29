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
