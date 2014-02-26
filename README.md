ColorBar
========

`ColorBar` is an interactive `ColorFunction` designer for _Mathematica_. It allows you to easily modify existing color functions, change colors or vary the blending fraction and get the final result in other applications. You can also use it directly inside a plotting function.

###Installation & basic usage
Copy the `ColorBar.m` file to your `$UserBaseDirectory` and load it in via ``Needs["ColorBar`"]``. The `ColorBar` function can be used with  built-in color functions

![ColorBar usage: built-in](https://f.cloud.github.com/assets/2389211/2266364/b382da98-9e96-11e3-9437-aa9ae55cab77.png)

or with custom color functions

![ColorBar usage: custom](https://f.cloud.github.com/assets/2389211/2266386/9821c60a-9e97-11e3-9624-f348da7686be.png)

Use `Setting` to extract the corresponding color function.

![Setting](https://f.cloud.github.com/assets/2389211/2266566/8bb890ec-9e9c-11e3-82d6-c11da209bb90.png)

###Modifying control points

 - Click and drag the control points (triangles) to change the transition region

 - Click on a control point to change its color

 - Click while holding down Command (or Alt in Windows & Linux) to add a control point at that location.

 - Click on a control point while holding Shift to delete a control point (a minimum of 2 control points will always remain).

###Example

Use "Evaluate in place" on `ColorBar[]` in the following code to use the colorbar designer inside a plotting function.

```ruby
DensityPlot[x^4 - 2 x^2 + y^4 - 2 y^2 + 1, {x, -2, 2}, {y, -2, 2}, 
	ColorFunction -> Setting@ColorBar[], PlotPoints -> 150, PlotRange -> {-2, 2}]
```

![Example](https://f.cloud.github.com/assets/2389211/2266692/b142697e-9ea0-11e3-8b25-51c7515b8d97.png)
