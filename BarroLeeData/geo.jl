using GeoStats

import CairoMakie as Mke

# attribute table
table = (; Z=[1.,0.,1.])

# coordinates for each row
coord = [(25.,25.), (50.,75.), (75.,50.)]

# georeference data
geotable = georef(table, coord)

# interpolation domain
grid = CartesianGrid(100, 100)

# choose an interpolation model
model = Kriging(GaussianVariogram(range=35.))

# perform interpolation over grid
interp = geotable |> Interpolate(grid, model)

# visualize the solution
viz(interp.geometry, color = interp.Z)