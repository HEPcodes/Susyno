(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* Do not forget: we have Susyno`Models`NFlavours, Susyno`Models`DiscreteSym *)
BeginPackage["Susyno`Models`",{"Susyno`LieGroups`"},{"Susyno`ModelBuilding`"}]
{MSSM,NMSSM,RPVMSSM};

(* Field names *)
(*
{u,d,Q,e,L,Hu,Hd};
{u,d,Q,e,L,Hu,Hd,S};
{u,d,Q,e,L,Hu,Hd};
*)

(* Begin["Private`"] *)

(* Variables that have the complete input for the MSSM and NMSSM *)


(* XXXXXXXXXXXXXXXXXXXXXXXXXX   MSSM   XXXXXXXXXXXXXXXXXXXXXXXXXXX *)
author[MSSM]^="Renato Fonseca";
date[MSSM]^="18:30, 09/September/2013";

group[MSSM]^={U1,SU2,SU3};
reps[MSSM]^={{-(2/Sqrt[15]),{0},{0,1}},{1/Sqrt[15],{0},{0,1}},{1/(2 Sqrt[15]),{1},{1,0}},{Sqrt[3/5],{0},{0,0}},{-(Sqrt[(3/5)]/2),{1},{0,0}},{Sqrt[3/5]/2,{1},{0,0}},{-(Sqrt[(3/5)]/2),{1},{0,0}}};
nFlavs[MSSM]^={3,3,3,3,3,1,1};
discreteSym[MSSM]^={-1,-1,-1,-1,-1,1,1};
fieldNames[MSSM]^={"u","d","Q","e","L","Hu","Hd"};

(* XXXXXXXXXXXXXXXXXXXXXXXXXX   NMSSM   XXXXXXXXXXXXXXXXXXXXXXXXXXX *)
author[NMSSM]^="Renato Fonseca";
date[NMSSM]^="18:30, 09/September/2013";

group[NMSSM]^={U1,SU2,SU3};
reps[NMSSM]^={{-(2/Sqrt[15]),{0},{0,1}},{1/Sqrt[15],{0},{0,1}},{1/(2 Sqrt[15]),{1},{1,0}},{Sqrt[3/5],{0},{0,0}},{-(Sqrt[(3/5)]/2),{1},{0,0}},{Sqrt[3/5]/2,{1},{0,0}},{-(Sqrt[(3/5)]/2),{1},{0,0}},{0,{0},{0,0}}};
nFlavs[NMSSM]^={3,3,3,3,3,1,1,1};
discreteSym[NMSSM]^={-1,-1,-1,-1,-1,1,1,1};
fieldNames[NMSSM]^={"u","d","Q","e","L","Hu","Hd","S"};


(* XXXXXXXXXXXXXXXXXXXXXXXXXX  RPV MSSM   XXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* It is the same as the MSSM but with no R-parity *)

author[RPVMSSM]^="Renato Fonseca";
date[RPVMSSM]^="18:30, 09/September/2013";

group[RPVMSSM]^={U1,SU2,SU3};
reps[RPVMSSM]^={{-(2/Sqrt[15]),{0},{0,1}},{1/Sqrt[15],{0},{0,1}},{1/(2 Sqrt[15]),{1},{1,0}},{Sqrt[3/5],{0},{0,0}},{-(Sqrt[(3/5)]/2),{1},{0,0}},{Sqrt[3/5]/2,{1},{0,0}},{-(Sqrt[(3/5)]/2),{1},{0,0}}};
nFlavs[RPVMSSM]^={3,3,3,3,3,1,1};
discreteSym[RPVMSSM]^=ConstantArray[1,7];
fieldNames[RPVMSSM]^={"u","d","Q","e","L","Hu","Hd"};

(* End[] *)
EndPackage[]
