> ## ⚠️ THIS PACKAGE IS NOT MAINTAINED

ColorBar
========

`ColorBar` is an interactive `ColorFunction` designer for _Mathematica_. It allows you to easily modify existing color functions, change colors or vary the blending fraction and get the final result in other applications. You can also use it directly inside a plotting function.

### Installation & basic usage
Copy the `ColorBar.m` file to your `$UserBaseDirectory` and load it in via ``Needs["ColorBar`"]``. The `ColorBar` function can be used with  built-in color functions

![ColorBar usage: built-in](https://f.cloud.github.com/assets/2389211/2275910/4502c83e-9f2d-11e3-83d2-4117696028f2.png)

or with custom color functions

![ColorBar usage: custom](https://f.cloud.github.com/assets/2389211/2266386/9821c60a-9e97-11e3-9624-f348da7686be.png)

Use `Setting` to extract the corresponding color function.

![Setting](https://f.cloud.github.com/assets/2389211/2275909/45024cce-9f2d-11e3-8b1d-093d1fa80efb.png)

Use "Evaluate in place" on `ColorBar[]` to use the colorbar designer inside a plotting function.

### Modifying control points

 - Click and drag the control points (triangles) to change the transition region

 - Click on a control point to change its color

 - Click while holding down Command (or Alt in Windows & Linux) to add a control point at that location.

 - Click on a control point while holding Shift to delete a control point (a minimum of 2 control points will always remain).
