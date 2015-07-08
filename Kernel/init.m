(* ::Package:: *)

(* Mathematica Init File *)

Block[{result},
result={};
AppendTo[result,Style["XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Susyno XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",{GrayLevel[0.5]}]];
AppendTo[result,Row[{Style["Version: 3.0 ; Author: Renato Fonseca\nFor help, use the ",{GrayLevel[0.5]}],Hyperlink["Susyno Tutorial","paclet:Susyno/tutorial/SusynoTutorial"],Style[" and the built-in documentation.",{GrayLevel[0.5]}]}]];

AppendTo[result,Style["XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",{GrayLevel[0.5]}]];

Print[Row[result,"\n",BaseStyle->(FontFamily->"Consolas")]];
];


ClearAll["Susyno`LieGroups`*"];
ClearAll["Susyno`SusyRGEs`*"];
(* ClearAll["Susyno`Susyno`*"]; *)
(* ClearAll["Susyno`SSB`*"]; *)
ClearAll["Susyno`IO`*"];
ClearAll["Susyno`ModelBuilding`*"];
ClearAll["Susyno`Models`"];
ClearAll["Susyno`SimplifyEinsteinNotation`"];
ClearAll["Susyno`SymmetryBreaking`*"];

Get["Susyno`LieGroups`"];
Get["Susyno`ModelBuilding`"];
(* Get["Susyno`SSB`"]; *)
(* Get["Susyno`Susyno`"]; *)
Get["Susyno`SusyRGEs`"];
Get["Susyno`Models`"];
Get["Susyno`IO`"];
Get["Susyno`SimplifyEinsteinNotation`"];
Get["Susyno`SymmetryBreaking`"];
