ColorBar
========

`ColorBar` is an interactive `ColorFunction` designer for _Mathematica_. The `ColorBar` function can be used with both built-in color functions and custom ones as:

1. `ColorBar["IslandColors"]` or `ColorBar[ColorData["IslandColors"]]` for built-ins.

2. `ColorBar[Blend[{Blue, Red}, #]&]` for custom color functions.

The following functionality is provided:

1. Click and drag the control points (triangles) to change the transition region

2. Click on a control point to change its color

3. Click while holding down Command (or Alt in Windows & Linux) to add a control point at that location.

4. Click on a control point while holding Shift to delete a control point (a minimum of 2 control points will always remain).

5. Use `Setting` to extract the corresponding color function.
