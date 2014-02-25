(* ColorFunction designer for Mathematica *)
(* :Context: ColorBar` *)
(* :Author: rsmenon *)
(* :License: MIT *)
(* :Date: February 24, 2014 *)

BeginPackage["ColorBar`"]

ColorBar::usage = ""

Begin["`Private`"]
ColorBar[cf : _String | _ColorDataFunction | _Function] :=
        DynamicModule[
            {
                control, addControl, removeControl, controlPoints, defaultControlPoints, getControlPoints,
                controlColors, defaultControlColors, colorData, colorDataList, colorFunction, defaultColorFunction,
                getColorFunction, updateColorFunction, generateColorFunction, colorbar, triangle,
                getXPosition, initializeSettings, local = "ColorBar`Private`local"
            },

            colorDataList = ColorData["Gradients"];
            triangle = Polygon[{{# - 0.025, 0}, {#, -0.025 Sqrt[3]}, {# + 0.025, 0}}] &;
            colorbar = Raster[{Range[0, 100] / 100}, {{0, 0}, {1, 0.1}}, ColorFunction -> #] &;
            colorData = Switch[cf, _String, cf, _ColorDataFunction, First@cf, _Function, "Custom"];

            getColorFunction[cd_] := Switch[cd, "Custom", colorDataList = colorDataList ~Join~ cd;cf, _, ColorData[cd]];

            getControlPoints[cd_] :=
                    Block[{func},
                        func[c : {__List}] := c[[All, 1]];
                        func[c_List] := Array[# &, Length@c, {0, 1.}];
                        func[___] := Array[# &, 5, {0, 1.}];

                        Switch[cd,
                            "Custom",
                            defaultColorFunction /. HoldPattern[Function[___, Blend[x_, _], ___]] :> func@x,
                            _,
                            func@DataPaclets`ColorDataDump`getColorSchemeData[colorData][[5]]
                        ]
                    ];

            initializeSettings =
                    Function[x,
                        colorData = x;
                        defaultColorFunction = getColorFunction@colorData;
                        colorFunction = defaultColorFunction;

                        defaultControlPoints = getControlPoints@colorData;
                        controlPoints = Hold /@ Table[Unique@local, {Length@defaultControlPoints}];
                        Evaluate[ReleaseHold@controlPoints] = defaultControlPoints;

                        defaultControlColors = defaultColorFunction /@ defaultControlPoints;
                        controlColors = Hold /@ Table[Unique@local, {Length@defaultControlColors}];
                        Evaluate[ReleaseHold@controlColors] = defaultControlColors;
                    ];

            initializeSettings[colorData];

            getXPosition[] := Clip[First@MousePosition["Graphics"], {0,1}];

            SetAttributes[addControl, HoldAll];
            addControl[pos_] := With[{symP = Unique@local, symC = Unique@local},
                AppendTo[controlPoints, Hold@symP];
                AppendTo[controlColors, Hold@symC];
                symP = pos;
                symC = colorFunction[pos];
            ];

            SetAttributes[removeControl, HoldAll];
            removeControl[pos_] := ({controlPoints, controlColors} =
                    Transpose@{controlPoints, controlColors} /. {Hold[pos], _} :> Sequence[] // Transpose);


            generateColorFunction[pts_, cols_] := Blend[Transpose@{pts, cols}, #] &;

            updateColorFunction[] := colorFunction = generateColorFunction[ReleaseHold@controlPoints, ReleaseHold@controlColors];

            SetAttributes[control, HoldAll];
            control[pos_, color_] :=
                    EventHandler[
                        Dynamic@{FaceForm@color, EdgeForm[{Thin, Black}], triangle@pos},
                        {
                            "MouseClicked" :> If[
                                CurrentValue["ShiftKey"],

                                If[Length@controlPoints <= 2,
                                    Null,
                                    removeControl[pos];
                                    updateColorFunction[];
                                ],

                                color = If[# === $Canceled, color, #] &@SystemDialogInput["Color", color]; updateColorFunction[]
                            ],
                            "MouseDragged" :> (pos = getXPosition[]; updateColorFunction[])
                        }
                    ];

            Panel@Column[{
                Row[{

                    PopupMenu[Dynamic[colorData, initializeSettings], colorDataList],
                    Spacer@10,
                    Button["Generate", NotebookWrite[EvaluationCell[], generateColorFunction[ReleaseHold@controlPoints, ReleaseHold@controlColors]]]
                }],

                Column[{
                    EventHandler[
                        Graphics[
                            Dynamic[control @@@ Transpose[{controlPoints, controlColors}] // ReleaseHold],
                            PlotRange -> {{0, 1}, All}, PlotRangePadding -> 0,
                            ImageSize -> 300, ImagePadding -> {{10, 10}, {0, 0}}
                        ],
                        {"MouseClicked" :> If[CurrentValue["CommandKey"], addControl[getXPosition[]]]}
                    ],

                    Dynamic@Graphics[
                        colorbar@generateColorFunction[ReleaseHold@controlPoints, ReleaseHold@controlColors],
                        PlotRange -> {{0, 1}, All}, PlotRangePadding -> 0, ImageSize -> 300, ImagePadding -> {{10, 10}, {15, 0}},
                        Frame -> True, FrameTicks -> {True, False, False, False}, FrameTicksStyle -> Directive[FontSize -> 12]
                    ]
                }]
            }]
        ]

ColorBar[] := ColorBar[First@ColorData["Gradients"]]

End[]

EndPackage[]