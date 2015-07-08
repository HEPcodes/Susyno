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



(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

(* Method that transposes flavoured tensors *)
Trs[matrix_,perm_]:=Module[{n,aux1,aux2,result},
n=Length[perm];
aux1=Table[ToExpression["f"<>ToString[i]],{i,n}];
aux2=Table[aux1[[i]]->aux1[[perm[[i]]]],{i,n}];
result=SparseArray[(Transpose[matrix,perm]//ArrayRules) /.aux2,Dimensions[matrix]];
Return[result];
];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

CalculateSusyY[cm_,listRep_,hypercharges_,numberOfFlavours_,discreteCharges_]:=CalculateSusyY[cm,listRep,hypercharges,numberOfFlavours,discreteCharges]=Module[{sum,hyperSum,discreteChargesSum,vector,aux1,matrix,vectorContent,tableVariables,partialTable,vectorA,vectorB,vectorC},

(* Build the sum of invariants and change some names *)
sum=0;

Do[
hyperSum=hypercharges[[i1]]+hypercharges[[i2]]+hypercharges[[i3]];
discreteChargesSum=discreteCharges[[i1]]discreteCharges[[i2]]discreteCharges[[i3]];
If[hyperSum==0 hyperSum && discreteChargesSum==0discreteChargesSum+1,
aux1=Invariants[cm,listRep[[i1]],listRep[[i2]],listRep[[i3]],False];

(*Kills some antisymmetric terms with 1 flavour*)
 Do[
If[i1==i2&&NumberQ[numberOfFlavours[[i1]]]==True&&numberOfFlavours[[i1]]==1&&IsSymmetric[aux1[[i]],{a,b}]==2,aux1[[i]]=0];
If[i1==i3&&NumberQ[numberOfFlavours[[i1]]]==True&&numberOfFlavours[[i1]]==1&&IsSymmetric[aux1[[i]],{a,c}]==2,aux1[[i]]=0];
If[i2==i3&&NumberQ[numberOfFlavours[[i2]]]==True&&numberOfFlavours[[i2]]==1&&IsSymmetric[aux1[[i]],{b,c}]==2,aux1[[i]]=0];
,{i,Length[aux1]}];
(*/Kills some antisymmetric terms with 1 flavour*)

aux1=aux1 /. {a:>Subscript[a, i1],b:>Subscript[b, i2],c:>Subscript[c, i3]};
sum+=Sum[y[i1,i2,i3,i,f1,f2,f3]aux1[[i]],{i,Length[aux1]}];
];
,{i1,Length[listRep]},{i2,i1,Length[listRep]},{i3,i2,Length[listRep]}];

(*Creating the vector with all the a's, b's and c's that show up in the invariants *)
vectorContent[rep_]:=Subscript[a, rep][Table[j[group],{group,Length[cm]}] /.{x__}:>x];
tableVariables[rep_]:=Table[{j[group],DimR[cm[[group]],listRep[[rep,group]]]},{group,Length[cm]}]/.{x__}:>x;
partialTable[rep_]:=Table[vectorContent[rep],Evaluate[tableVariables[rep]]];

vectorA=Flatten[Table[partialTable[rep],{rep,Length[listRep]}]];
vectorB =vectorA /.a->b;
vectorC =vectorA /.a->c;

vector=Join[vectorA,vectorB,vectorC];
(*[END]Creating the vector with all the a's, b's and c's that show up in the invariants[END] *)


If[Length[sum]!=0,
matrix=CoefficientArrays[sum,vector,"Symmetric"->True][[4]];
(* factor 6...see the definition of superpotential W and Lsoft *)
matrix=6  matrix[[1;;Length[vector]/3,Length[vector]/3+1;;2Length[vector]/3,2Length[vector]/3+1;;Length[vector]]];

matrix=matrix+Trs[matrix,{1,3,2}]+Trs[matrix,{2,1,3}]+Trs[matrix,{2,3,1}]+Trs[matrix,{3,1,2}]+Trs[matrix,{3,2,1}];

matrix=SparseArray[Expand[ArrayRules[matrix]]/.x_+y__:>Length[x+y]x,Dimensions[matrix]];
,
matrix=SparseArray[{},{Length[vector]/3,Length[vector]/3,Length[vector]/3}];
];

Return[matrix];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

CalculateSusyH[cm_,listRep_,hypercharges_,numberOfFlavours_,discreteCharges_]:=Module[{aux},
aux=CalculateSusyY[cm,listRep,hypercharges,numberOfFlavours,discreteCharges];
Return[SparseArray[(ArrayRules[aux]/.y->h),Dimensions[aux]]];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

CalculateSusyMu[cm_,listRep_,hypercharges_,numberOfFlavours_,discreteCharges_]:=CalculateSusyMu[cm,listRep,hypercharges,numberOfFlavours,discreteCharges]=Module[{sum,hyperSum,discreteChargesSum,vector,aux1,matrix,vectorContent,tableVariables,partialTable,vectorA,vectorB},

(* Build the sum of invariants and change some names *)
sum=0;


Do[
hyperSum=hypercharges[[i1]]+hypercharges[[i2]];
discreteChargesSum=discreteCharges[[i1]]discreteCharges[[i2]];
If[hyperSum==0 hyperSum && discreteChargesSum==0discreteChargesSum+1,
aux1=Invariants[cm,listRep[[i1]],listRep[[i2]],False];
(*Kills some antisymmetric terms with 1 flavour*)
Do[
If[i1==i2&&NumberQ[numberOfFlavours[[i1]]]==True&&numberOfFlavours[[i1]]==1&&IsSymmetric[aux1[[i]],{a,b}]==2,aux1[[i]]=0];
,{i,Length[aux1]}];
(*/Kills some antisymmetric terms with 1 flavour*)
aux1=aux1 /. {a:>Subscript[a, i1],b:>Subscript[b, i2]};
sum+=Sum[mu[i1,i2,i,f1,f2]aux1[[i]],{i,Length[aux1]}];
];
,{i1,Length[listRep]},{i2,i1,Length[listRep]}];


(*Creating the vector with all the a's, b's and c's that show up in the invariants *)
vectorContent[rep_]:=Subscript[a, rep][Table[j[group],{group,Length[cm]}] /.{x__}:>x];
tableVariables[rep_]:=Table[{j[group],DimR[cm[[group]],listRep[[rep,group]]]},{group,Length[cm]}]/.{x__}:>x;
partialTable[rep_]:=Table[vectorContent[rep],Evaluate[tableVariables[rep]]];

vectorA=Flatten[Table[partialTable[rep],{rep,Length[listRep]}]];
vectorB =vectorA /.a->b;

vector=Join[vectorA,vectorB];
(*[END]Creating the vector with all the a's, b's and c's that show up in the invariants[END] *)

If[Length[sum]!=0,
matrix=CoefficientArrays[sum,vector,"Symmetric"->True][[3]];
(* factor 2...see the definition of superpotential W and Lsoft *)
matrix=2  matrix[[1;;Length[vector]/2,Length[vector]/2+1;;Length[vector]]];

matrix=matrix+Trs[matrix,{2,1}];
matrix=SparseArray[Expand[ArrayRules[matrix]]/.x_+y__:>Length[x+y]x,Dimensions[matrix]];
,
matrix=SparseArray[{},{Length[vector]/2,Length[vector]/2}];
];

Return[matrix];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

CalculateSusyL[cm_,listRep_,hypercharges_,numberOfFlavours_,discreteCharges_]:=CalculateSusyL[cm,listRep,hypercharges,numberOfFlavours,discreteCharges]=Module[{aux1,aux2,aux3,position,result},
aux1=0 listRep[[1]]; (*Invariant representation under the non abelian groups *)
aux2=0 hypercharges[[1]];  (*Invariant representation under the U (1)'s *)
aux3=0 discreteCharges[[1]]+1; 

aux1=Position[listRep,aux1];
aux2=Position[hypercharges,aux2];
aux3==Position[discreteCharges,aux3];
aux1=Intersection[aux1,aux2]; (*just finds at most one position with an invariant under all gauge groups*)
result=SparseArray[{},{Sum[Times@@DimR[cm,listRep[[i]]],{i,Length[listRep]}]}];
If[aux1!={},
position=Sum[Times@@DimR[cm,listRep[[i]]],{i,aux1[[1,1]]}];
result[[position]]=l[aux1[[1,1]],1,f1];
result=SparseArray[result];
];

Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

CalculateSusyB[cm_,listRep_,hypercharges_,numberOfFlavours_,discreteCharges_]:=Module[{aux},
aux=CalculateSusyMu[cm,listRep,hypercharges,numberOfFlavours,discreteCharges];
Return[SparseArray[(ArrayRules[aux]/.mu->b),Dimensions[aux]]];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

CalculateSusyM2[cm_,listRep_,hypercharges_,numberOfFlavours_,discreteCharges_]:=CalculateSusyM2[cm,listRep,hypercharges,numberOfFlavours,discreteCharges]=Module[{sum,hyperSum,discreteChargesSum,vector,vectorHeads,aux1,sub1,sub2,matrix,vectorContent,tableVariables,partialTable,vectorA,vectorB},

(* Build the sum of invariants and change some names *)
sum=0;

Do[
hyperSum=hypercharges[[i1]]-hypercharges[[i2]];
discreteChargesSum=discreteCharges[[i1]]/discreteCharges[[i2]];
If[hyperSum==0 hyperSum && discreteChargesSum==0discreteChargesSum+1,
aux1=Invariants[cm,listRep[[i1]],listRep[[i2]],True];
aux1=aux1 /. {a:>Subscript[\[Phi], i1],b:>Subscript[\[Phi]c, i2]};
sum+=Sum[m2[i1,i2,i,f1,f2]aux1[[i]],{i,Length[aux1]}];
];
,{i1,Length[listRep]},{i2,i1,Length[listRep]}];

(*Creating the vector with all the a's, b's and c's that show up in the invariants *)
vectorContent[rep_]:=Subscript[\[Phi], rep][Table[j[group],{group,Length[cm]}] /.{x__}:>x];
tableVariables[rep_]:=Table[{j[group],DimR[cm[[group]],listRep[[rep,group]]]},{group,Length[cm]}]/.{x__}:>x;
partialTable[rep_]:=Table[vectorContent[rep],Evaluate[tableVariables[rep]]];

vectorA=Flatten[Table[partialTable[rep],{rep,Length[listRep]}]];
vectorB =vectorA /.\[Phi]->\[Phi]c;

vector=Join[vectorA,vectorB];
(*[END]Creating the vector with all the a's, b's and c's that show up in the invariants[END] *)


If[Length[sum]!=0,
matrix=CoefficientArrays[sum,vector,"Symmetric"->True][[3]];
(* The factor would be 2 = 2(we lost 1/2 of the true sum) x 2...see the definition of Lsoft in "Two-Loop Renormalization group equations for soft supersymmetry-breaking couplings" x 1/2 (the other half of the result goes to "h.c."). *)
matrix=2 matrix[[1;;Length[vector]/2,Length[vector]/2+1;;Length[vector]]]; 
,
matrix=SparseArray[{},{Length[vector]/2,Length[vector]/2}];
];

Return[matrix];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

CalculateSusyS[cm_,listRep_,hypercharges_,numberOfFlavours_,discreteCharges_]:=Module[{aux},
aux=CalculateSusyL[cm,listRep,hypercharges,numberOfFlavours,discreteCharges];
Return[SparseArray[(ArrayRules[aux]/.l->s),Dimensions[aux]]];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)


IsSymmetric[invariant_,vars_]:=Module[{aux1,result},
result=0;
aux1=invariant/.{vars[[1]]->vars[[2]],vars[[2]]->vars[[1]]};
If[invariant-aux1==0,result=1]; (*symmetric*)
If[invariant+aux1==0,result=2]; (*antisymmetric*)
Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

SetSymmetryAtributes[cm_,listReps_,matrices_,numberOfFlavours_]:=Module[{l1,l2,l3,l4,l5,l6,l7,aux1,aux2,aux3,listParameters,res,res2,head,newHead},
Clear[y,y2,mu,mu2,l,l2,h,h2,b,b2,s,s2,m2,m22];

l1=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[1]]],y[x__,x1_,x2_,x3_]:>y[x],-1]]];
l2=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[2]]],mu[x__,x1_,x2_]:>mu[x],-1]]];
l3=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[3]]],l[x__,x1_]:>l[x],-1]]];
l4=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[4]]],h[x__,x1_,x2_,x3_]:>h[x],-1]]];
l5=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[5]]],b[x__,x1_,x2_]:>b[x],-1]]];
l6=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[6]]],s[x__,x1_]:>s[x],-1]]];
l7=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[7]]],m2[x__,x1_,x2_]:>m2[x],-1]]];


listParameters=Join[l1,l2,l3,l4,l5,l6,l7];

Do[
head=listParameters[[m]]//Head;
newHead=ToExpression[ToString[head]<>"2"];


If[Length[listParameters[[m]]]==4, (*y e h*)
aux1=Invariants[cm,listReps[[listParameters[[m,1]]]],listReps[[listParameters[[m,2]]]],listReps[[listParameters[[m,3]]]],False][[listParameters[[m,4]]]];
aux2=IsSymmetric[aux1,{a,b}];
aux3=IsSymmetric[aux1,{b,c}];

res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1_,x2_,x3_]]<>":="<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1,x2,x3]];

If[aux2==0&&aux3==1&&listParameters[[m,2]]==listParameters[[m,3]],
res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1_,x2_,x3_]]<>":="<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1,"(Sort[{x2,x3}]/.List\[Rule]Sequence)"]];
];
If[aux2==0&&aux3==2&&listParameters[[m,2]]==listParameters[[m,3]],
res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1_,x2_,x3_]]<>":="<>"Signature[{x2,x3}]"<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1,"(Sort[{x2,x3}]/.List\[Rule]Sequence)"]];
];

If[aux2==1&&aux3==0&&listParameters[[m,1]]==listParameters[[m,2]],
res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1_,x2_,x3_]]<>":="<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],"(Sort[{x1,x2}]/.List\[Rule]Sequence)",x3]];
];
If[aux2==2&&aux3==0&&listParameters[[m,1]]==listParameters[[m,2]],
res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1_,x2_,x3_]]<>":="<>"Signature[{x1,x2}]"<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],"(Sort[{x1,x2}]/.List\[Rule]Sequence)",x3]];
];

If[aux2==1&&aux3==1&&listParameters[[m,1]]==listParameters[[m,2]]==listParameters[[m,3]],
res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1_,x2_,x3_]]<>":="<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],"(Sort[{x1,x2,x3}]/.List\[Rule]Sequence)"]];
];
If[aux2==2&&aux3==2&&listParameters[[m,1]]==listParameters[[m,2]]==listParameters[[m,3]],
res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],x1_,x2_,x3_]]<>":="<>"Signature[{x1,x2,x3}]"<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],listParameters[[m,4]],"(Sort[{x1,x2,x3}]/.List\[Rule]Sequence)"]];
];
];

If[Length[listParameters[[m]]]==3,  (* mu, b, m2 (in this case...dont impose symmetries) *)

res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],x1_,x2_]]<>":="<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],x1,x2]];

If[ToString[head]!="m2",
aux1=Invariants[cm,listReps[[listParameters[[m,1]]]],listReps[[listParameters[[m,2]]]],False][[listParameters[[m,3]]]];
aux2=IsSymmetric[aux1,{a,b}];

If[aux2==1&&listParameters[[m,1]]==listParameters[[m,2]],
res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],x1_,x2_]]<>":="<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],"(Sort[{x1,x2}]/.List\[Rule]Sequence)"]];
];
If[aux2==2&&listParameters[[m,1]]==listParameters[[m,2]],
res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],x1_,x2_]]<>":="<>"Signature[{x1,x2}]"<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],listParameters[[m,3]],"(Sort[{x1,x2}]/.List\[Rule]Sequence)"]];
];
];
];

If[Length[listParameters[[m]]]==2,  (* l,s (in this case...dont impose symmetries) *)

res=ToString[head[listParameters[[m,1]],listParameters[[m,2]],x1_]]<>":="<>ToString[newHead[listParameters[[m,1]],listParameters[[m,2]],x1]];

];

ToExpression[res];

(* Useless flavour indices are killed here provided that the user has given the number of flavours  *)
res=ToExpression[StringSplit[res,"="][[2]]];
res2=StringReplace[ToString[res],{"x1"->"x1_","x2"->"x2_","x3"->"x3_"}];
aux1={};
Do[
If[NumberQ[numberOfFlavours[[k]]]==True&&numberOfFlavours[[k]]==1,
aux1=Join[aux1, Position[res,k]];
];
,{k,Length[numberOfFlavours]}];

aux1=DeleteDuplicates[aux1];
aux1=DeleteCases[aux1,{x_}/; x>Length[res]/2];

If[aux1!={},
aux2=ToString[Delete[res,aux1+(Length[res]+1)/2]];
ToExpression[res2<>":=" <>aux2];
];


,{m,Length[listParameters]}];
];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

(* Eleminates KroneckerDelta's that appear in the beta's of m2 if there is only one flavour for the indices *)
KillKroneckers[expression_,entry_]:=If[Length[entry]==3,expression/.KroneckerDelta[x__]:>1,expression];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* Auxiliar method - given an 'expression' it will use SetSymmetryAtributes, KillKroneckers and CanonicalForm to simplify it *)
ApplySymmetries[expression_,flag_, passOnArguments__]:=Module[{result,entry,coefficient,betaFuctionResult,betaFuctionResult2},

Switch[flag,1, (* for g am M parameters; expression if of the form {\[Beta]1,\[Beta]2}  *)
SetSymmetryAtributes[passOnArguments];
result=expression /.{y2->y3,mu2->mu3,l2->l3,h2->h3,b2->b3,s2->s3,m22->m23};
Clear[y,y2,mu,mu2,l,l2,h,h2,b,b2,m2,s,s2, m22];
result=CanonicalForm/@Expand[(result /.{y3->y,mu3->mu,l3->l,h3->h,b3->b,s3->s,m23->m2}) ];

,2, (* for all other parameters; expression is of the form {parameter,\[Beta]1,\[Beta]2} *)

SetSymmetryAtributes[passOnArguments]; (* Make Mathematica aware of the symmetries of the parameters of the model *)

coefficient=1;
entry=expression[[1]];
If[Head[entry]==Times,coefficient=entry/Cases[entry,_y2 | _mu2|_l2|_h2|_b2|_s2|_m22] /.List->Times];

result=Expand[expression/coefficient  /.{y2->y3,mu2->mu3,l2->l3,h2->h3,b2->b3,s2->s3,m22->m23}] ;

(* Make Mathematica forget the symmetries of the parameters of the model *)
Clear[y,y2,mu,mu2,l,l2,h,h2,b,b2,s,s2,m2,m22];
result=KillKroneckers[result,entry];
result=CanonicalForm/@Expand[(result /.{y3->y,mu3->mu,l3->l,h3->h,b3->b,s3->s,m23->m2}) ];

];

 (*some final simplification of the flavour variables*)
Return[result/.{f1->i,f2->j,f3->k,\[Alpha][i_]:>FromCharacterCode[108+i]}];
];


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

StandardInitialization[cm_,listReps_,hypercharges_,numberOfFlavours_,discreteCharges_]:=Module[{nReps,matrixY,matrixMu,matrixL,matrixH,matrixB,matrixM2,matrixS,numberFlavours,nFields,dR,dRU1,cR,sR,cG,nnonU1,representationMatrices,nHyper,hyperchargesList,hyperchargesSquare,hyperchargesSquareList},
nReps=Length[listReps];
nHyper=Length[hypercharges[[1]]];

matrixY= CalculateSusyY[cm,listReps,hypercharges,numberOfFlavours,discreteCharges];
matrixMu= CalculateSusyMu[cm,listReps,hypercharges,numberOfFlavours,discreteCharges];
matrixL=CalculateSusyL[cm,listReps,hypercharges,numberOfFlavours,discreteCharges];
matrixH=CalculateSusyH[cm,listReps,hypercharges,numberOfFlavours,discreteCharges];
matrixB=CalculateSusyB[cm,listReps,hypercharges,numberOfFlavours,discreteCharges];
matrixS=CalculateSusyS[cm,listReps,hypercharges,numberOfFlavours,discreteCharges];
matrixM2=CalculateSusyM2[cm,listReps,hypercharges,numberOfFlavours,discreteCharges];

numberFlavours={};


dR={};
cR={};

(*Setting dR,cR,cG,sR,representationMatrices for the non-abelian groups*)

Do[
dR=Join[dR,Table[DimR[cm,listReps[[i]]],{j,Times@@DimR[cm,listReps[[i]]]}]];
numberFlavours=Join[numberFlavours,Table[numberOfFlavours[[i]],{j,Times@@DimR[cm,listReps[[i]]]}]];
cR=Join[cR,Table[Casimir[cm,listReps[[i]]],{j,Times@@DimR[cm,listReps[[i]]]}]];

,{i,nReps}];

cG=Thread[Casimir[cm,Adjoint[cm]]];
sR=#/Thread[DimR[cm,Adjoint[cm]]]&/@dR cR;


(*Adding to dR,cR,cG,sR,representationMatrices the contribution from the U (1) groups*)
cG=Join[Table[0,{i,nHyper}],cG];

hyperchargesList=Flatten[Table[hypercharges[[i]],{i,nReps},{j,Times@@DimR[cm,listReps[[i]]]}],1];
hyperchargesList={SparseArray[#]}&/@DiagonalMatrix/@Transpose[hyperchargesList];
representationMatrices=hyperchargesList;

nFields=Sum[Times@@DimR[cm,listReps[[i]]],{i,nReps}];
(* For the simple groups, the representation matrices can be set to 0 *)
representationMatrices=Join[representationMatrices,Table[SparseArray[{},{nFields,nFields}],{i,Length[cm]},{j,DimR[cm[[i]],Adjoint[cm[[i]]]]}]];

hyperchargesSquare=hypercharges^2;
hyperchargesSquare=Flatten[Table[hyperchargesSquare[[i]],{i,nReps},{j,Times@@DimR[cm,listReps[[i]]]}],1];
dRU1=0 hyperchargesSquare+1; (*U (1) representations are all 1-D *)

Do[
dR[[i]]=Join[dRU1[[i]],dR[[i]]];
cR[[i]]=Join[hyperchargesSquare[[i]],cR[[i]]];
sR[[i]]=Join[hyperchargesSquare[[i]],sR[[i]]];
,{i,Length[cR]}];


nnonU1=Length[cm];


ImportData[{matrixY,matrixMu,matrixL,matrixH,matrixB,matrixS,matrixM2,numberFlavours,dR,cR,sR,cG,nnonU1,representationMatrices}];

Return[{matrixY,matrixMu,matrixL,matrixH,matrixB,matrixS,matrixM2}];
];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)


FindParameter[matrix_,parameter_]:=Module[{aux},
aux=Cases[ matrix//ArrayRules,(x__->Head[parameter][Level[parameter,-1] /.List->Sequence,y__]):>x,-1]~Join~Cases[ matrix//ArrayRules,(x__->z_ Head[parameter][Level[parameter,-1] /.List->Sequence,y__]):>x,-1];
If[Length[aux]!=0,aux=aux[[1]]];
Return[aux];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

SearchAndCalcBeta1Loop[cm_,listReps_,hypercharges_,matrices_,functions_,numberOfFlavours_,printForm_Symbol:True]:=Module[{mY,mMu,mL,mH,mB,mM2,mS,position,entry,betaFuctionResult,coefficient,parameters,result},

Clear[y,y2,mu,mu2,l,l2,h,h2,b,b2,s,s2,m2, m22];
mY=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[1]]],y[x__,x1_,x2_,x3_]:>y[x],-1]]];
mMu=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[2]]],mu[x__,x1_,x2_]:>mu[x],-1]]];
mL=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[3]]],l[x__,x1_]:>l[x],-1]]];
mH=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[4]]],h[x__,x1_,x2_,x3_]:>h[x],-1]]];
mB=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[5]]],b[x__,x1_,x2_]:>b[x],-1]]];
mS=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[6]]],s[x__,x1_]:>s[x],-1]]];
mM2=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[7]]],m2[x__,x1_,x2_]:>m2[x],-1]]];
parameters={mY,mMu,mL,mH,mB,mS,mM2};
result={};

Do[
betaFuctionResult=\[Beta]g1[group];
{betaFuctionResult}=ApplySymmetries[{betaFuctionResult},1,cm,listReps,matrices,numberOfFlavours];

If[printForm,
Print[
\!\(\*SuperscriptBox["\[Beta]", "\"\<(1)\>\""]\), " of ",g[group]];Print[betaFuctionResult];Print["* * * * *"];
,
result=Append[result,{g[group],betaFuctionResult}];
];

,{group,Length[cm]+Length[hypercharges[[1]]]}];

Do[
betaFuctionResult=\[Beta]M1[group];
{betaFuctionResult}=ApplySymmetries[{betaFuctionResult},1,cm,listReps,matrices,numberOfFlavours];

If[printForm,
Print[
\!\(\*SuperscriptBox["\[Beta]", "\"\<(1)\>\""]\), " of ",M[group]];Print[betaFuctionResult];Print["* * * * *"];
,
result=Append[result,{M[group],betaFuctionResult}];
];

,{group,Length[cm]+Length[hypercharges[[1]]]}];

Do[

position=FindParameter[matrices[[i1]],parameters[[i1,i2]]];
entry=Part@@({matrices[[i1]]}~Join~position);

betaFuctionResult=Expand [ functions[[i1]]@@position] ;

{entry,betaFuctionResult}=ApplySymmetries[{entry,betaFuctionResult},2,cm,listReps,matrices,numberOfFlavours];


If[printForm,
Print[
\!\(\*SuperscriptBox["\[Beta]", "\"\<(1)\>\""]\), " of ",entry];Print[betaFuctionResult];Print["* * * * *"];
,
result=Append[result,{entry,betaFuctionResult}];
];

,{i1,7},{i2,Length[parameters[[i1]]]}];

If[printForm,result=Null;];
Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

SearchAndCalcBeta2Loop[cm_,listReps_,hypercharges_,matrices_,functions_,numberOfFlavours_,printForm_Symbol:True]:=Module[{mY,mMu,mL,mH,mB,mM2,mS,position,entry,betaFuctionResult1,betaFuctionResult2,coefficient,parameters,result},

Clear[y,y2,mu,mu2,l,l2,h,h2,b,b2,s,s2,m2, m22];
mY=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[1]]],y[x__,x1_,x2_,x3_]:>y[x],-1]]];
mMu=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[2]]],mu[x__,x1_,x2_]:>mu[x],-1]]];
mL=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[3]]],l[x__,x1_]:>l[x],-1]]];
mH=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[4]]],h[x__,x1_,x2_,x3_]:>h[x],-1]]];
mB=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[5]]],b[x__,x1_,x2_]:>b[x],-1]]];
mS=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[6]]],s[x__,x1_]:>s[x],-1]]];
mM2=Sort[DeleteDuplicates[Cases[ArrayRules[matrices[[7]]],m2[x__,x1_,x2_]:>m2[x],-1]]];
parameters={mY,mMu,mL,mH,mB,mS,mM2};
result={};

Do[
betaFuctionResult1=\[Beta]g1[group];
betaFuctionResult2=\[Beta]g2[group];
{betaFuctionResult1,betaFuctionResult2}=ApplySymmetries[{betaFuctionResult1,betaFuctionResult2},1,cm,listReps,matrices,numberOfFlavours];

If[printForm,
Print[
\!\(\*SuperscriptBox["\[Beta]", "\"\<(1)\>\""]\), " of ",g[group]];Print[betaFuctionResult1];Print["* * * * *"];
Print[
\!\(\*SuperscriptBox["\[Beta]", "\"\<(2)\>\""]\), " of ",g[group]];Print[betaFuctionResult2];Print["* * * * *"];
,
result=Append[result,{g[group],betaFuctionResult1,betaFuctionResult2}];
];

,{group,Length[cm]+Length[hypercharges[[1]]]}];

Do[
betaFuctionResult1=\[Beta]M1[group];
betaFuctionResult2=\[Beta]M2[group];
{betaFuctionResult1,betaFuctionResult2}=ApplySymmetries[{betaFuctionResult1,betaFuctionResult2},1,cm,listReps,matrices,numberOfFlavours];

If[printForm,
Print[
\!\(\*SuperscriptBox["\[Beta]", "\"\<(1)\>\""]\), " of ",M[group]];Print[betaFuctionResult1];Print["* * * * *"];
Print[
\!\(\*SuperscriptBox["\[Beta]", "\"\<(2)\>\""]\), " of ",M[group]];Print[betaFuctionResult2];Print["* * * * *"]; 
,
result=Append[result,{M[group],betaFuctionResult1,betaFuctionResult2}];
];

,{group,Length[cm]+Length[hypercharges[[1]]]}];

Do[

position=FindParameter[matrices[[i1]],parameters[[i1,i2]]];
entry=Part@@({matrices[[i1]]}~Join~position);

betaFuctionResult1=Expand [ functions[[i1,1]]@@position] ;
betaFuctionResult2=Expand [ functions[[i1,2]]@@position ] ;

{entry,betaFuctionResult1,betaFuctionResult2}=ApplySymmetries[{entry,betaFuctionResult1,betaFuctionResult2},2,cm,listReps,matrices,numberOfFlavours];

If[printForm,
Print[
\!\(\*SuperscriptBox["\[Beta]", "\"\<(1)\>\""]\), " of ",entry];Print[betaFuctionResult1];Print["* * * * *"];
Print[
\!\(\*SuperscriptBox["\[Beta]", "\"\<(2)\>\""]\), " of ",entry];Print[betaFuctionResult2];Print["* * * * *"];
,
result=Append[result,{entry,betaFuctionResult1,betaFuctionResult2}];
];

,{i1,7},{i2,Length[parameters[[i1]]]}];

If[printForm,result=Null;];
Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

BetaFunctions1L[cm_,listRepsWithY_,numberOfFlavours_,discreteCharges_,printForm_Symbol:True]:=Module[{auxCounter,listReps,hypercharges,matrices,numberOfFlavoursMod,discreteChargesMod,result},

Clear[y,y2,h,h2,mu,mu2,h,h2,b,b2,s,s2,m2,m22];

(*Separate listReps from hypercharges *)
auxCounter=1;
While[auxCounter<=Length[listRepsWithY[[1]]]&&ToString[Head[listRepsWithY[[1,auxCounter]]]]!="List",auxCounter++];

hypercharges=#[[1;;auxCounter-1]]&/@listRepsWithY;
listReps=#[[auxCounter;;Length[listRepsWithY[[1]]]]]&/@listRepsWithY;
(*/Separate listReps from hypercharges *)

(* If the number of flavours was not set, give the generic name nf[i] *)
numberOfFlavoursMod=numberOfFlavours;
If[Length[numberOfFlavoursMod]!=Length[listReps],numberOfFlavoursMod=Table[nf[i],{i,Length[listReps]}]];

(* If no discreteCharges were set, make them all equal to 1, allowing all terms *)
discreteChargesMod=discreteCharges;
If[Length[discreteChargesMod]!=Length[listReps],discreteChargesMod=Table[1,{i,Length[listReps]}]];

matrices=StandardInitialization[cm,listReps,hypercharges,numberOfFlavoursMod,discreteChargesMod];

result=SearchAndCalcBeta1Loop[cm,listReps,hypercharges,matrices,{\[Beta]Y1,\[Beta]\[Mu]1,\[Beta]L1,\[Beta]H1,\[Beta]B1,\[Beta]S1,\[Beta]2M1},numberOfFlavoursMod,printForm];
Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

BetaFunctions2L[cm_,listRepsWithY_,numberOfFlavours_,discreteCharges_,printForm_Symbol:True]:=Module[{auxCounter,listReps,hypercharges,matrices,numberOfFlavoursMod,discreteChargesMod,result},
Clear[y,y2,h,h2,mu,mu2,h,h2,b,b2,s,s2,m2,m22];

(*Separate listReps from hypercharges *)
auxCounter=1;
While[auxCounter<=Length[listRepsWithY[[1]]]&&ToString[Head[listRepsWithY[[1,auxCounter]]]]!="List",auxCounter++];

hypercharges=#[[1;;auxCounter-1]]&/@listRepsWithY;
listReps=#[[auxCounter;;Length[listRepsWithY[[1]]]]]&/@listRepsWithY;
(*/Separate listReps from hypercharges *)

(* If the number of flavours was not set, give the generic name nf[i] *)
numberOfFlavoursMod=numberOfFlavours;
If[Length[numberOfFlavoursMod]!=Length[listReps],numberOfFlavoursMod=Table[nf[i],{i,Length[listReps]}]];

(* If no discreteCharges were set, make them all equal to 1, allowing all terms *)
discreteChargesMod=discreteCharges;
If[Length[discreteChargesMod]!=Length[listReps],discreteChargesMod=Table[1,{i,Length[listReps]}]];

matrices=StandardInitialization[cm,listReps,hypercharges,numberOfFlavoursMod,discreteChargesMod];

result=SearchAndCalcBeta2Loop[cm,listReps,hypercharges,matrices,{{\[Beta]Y1,\[Beta]Y2},{\[Beta]\[Mu]1,\[Beta]\[Mu]2},{\[Beta]L1,\[Beta]L2},{\[Beta]H1,\[Beta]H2},{\[Beta]B1,\[Beta]B2},{\[Beta]S1,\[Beta]S2},{\[Beta]2M1,\[Beta]2M2}},numberOfFlavoursMod,printForm];
Return[result];
]

ShowLagrangian[cm_,listRepsWithY_,numberOfFlavours_,discreteCharges_,printForm_Symbol:True]:=Module[{auxCounter,listReps,hypercharges,matrices,numberOfFlavoursMod,discreteChargesMod,auxDim,vectorNoFlav,result},
Clear[y,y2,h,h2,mu,mu2,h,h2,b,b2,s,s2,m2,m22];

(*Separate listReps from hypercharges *)
auxCounter=1;
While[auxCounter<=Length[listRepsWithY[[1]]]&&ToString[Head[listRepsWithY[[1,auxCounter]]]]!="List",auxCounter++];

hypercharges=#[[1;;auxCounter-1]]&/@listRepsWithY;
listReps=#[[auxCounter;;Length[listRepsWithY[[1]]]]]&/@listRepsWithY;
(*/Separate listReps from hypercharges *)

(* If the number of flavours was not set, give the generic name nf[i] *)
numberOfFlavoursMod=numberOfFlavours;
If[Length[numberOfFlavoursMod]!=Length[listReps],numberOfFlavoursMod=Table[nf[i],{i,Length[listReps]}]];

(* If no discreteCharges were set, make them all equal to 1, allowing all terms *)
discreteChargesMod=discreteCharges;
If[Length[discreteChargesMod]!=Length[listReps],discreteChargesMod=Table[1,{i,Length[listReps]}]];

matrices=StandardInitialization[cm,listReps,hypercharges,numberOfFlavoursMod,discreteChargesMod];

If[!printForm,  (* IF printForm=False, just return the tensors {y,\[Mu],L,h,b,s,m2} ... *)

(*SetSymmetryAtributes finds all the parameters of the model and sees if they have flavour symmetries/antisymetries*)
SetSymmetryAtributes[cm,listReps,matrices,numberOfFlavoursMod];
matrices=Table[SparseArray[(ArrayRules[matrices[[i1]]] /.{y2->y3,mu2->mu3,l2->l3,h2->h3,b2->b3,s2->s3,m22->m23})/.{f1->i,f2->j,f3->k},Dimensions[matrices[[i1]]]],{i1,Length[matrices]}];
Clear[y,y2,mu,mu2,l,l2,h,h2,b,b2,s,s2,m2, m22];
matrices=Table[SparseArray[ArrayRules[matrices[[i1]]] /.{y3->y,mu3->mu,l3->l,h3->h,b3->b,s3->s,m23->m2},Dimensions[matrices[[i1]]]],{i1,Length[matrices]}];

Return[matrices];
,        (* ... or ELSE print the Lagrangian in expanded form *)

auxDim=DimR[cm,#]&/@ listReps;
vectorNoFlav=Table[Array[Fld[i],auxDim[[i]]],{i,Length[listReps]}];
(* Remove from the tensors the unnecessary flavour indices *)
vectorFlav[flav_]:=Flatten[Table[If[NumberQ[numberOfFlavoursMod[[i1]]]==True&&numberOfFlavoursMod[[i1]]==1,vectorNoFlav[[i1]],vectorNoFlav[[i1]]/.Fld[x_][y__]:>Fld[x][y,flav]],{i1,Length[listReps]}]];

SetSymmetryAtributes[cm,listReps,matrices,numberOfFlavoursMod]; (* Make Mathematica aware of the symmetries of the parameters of the model *)

result={
1/6matrices[[1]].vectorFlav[f3].vectorFlav[f2].vectorFlav[f1],
1/2 matrices[[2]].vectorFlav[f2].vectorFlav[f1],
matrices[[3]].vectorFlav[f1],
1/6 matrices[[4]].vectorFlav[f3].vectorFlav[f2].vectorFlav[f1],
1/2matrices[[5]].vectorFlav[f2].vectorFlav[f1],
matrices[[6]].vectorFlav[f1],
matrices[[7]].Conjugate[vectorFlav[f2]].vectorFlav[f1]
};

result=Expand[result  /.{f1->i,f2->j,f3->k,y2->y3,mu2->mu3,l2->l3,h2->h3,b2->b3,s2->s3,m22->m23}] ;

(* Make Mathematica forget the symmetries of the parameters of the model *)
Clear[y,y2,mu,mu2,l,l2,h,h2,b,b2,s,s2,m2,m22];

result=CanonicalForm[#,{i,j,k}]&/@Expand[(result /.{y3->y,mu3->mu,l3->l,h3->h,b3->b,s3->s,m23->m2}) ];





Print[">>>>>> Each rep/field is named Fld[<rep index>][<gauge indexes>,<flav if any>] <<<<<<"];
Print[""];Print["Y part:"];Print[result[[1]]];
Print[""];Print["\[Mu] part:"];Print[result[[2]]];
Print[""];Print["L part:"];Print[result[[3]]];
Print[""];Print["H part:"];Print[result[[4]]];
Print[""];Print["B part:"];Print[result[[5]]];
Print[""];Print["S part:"];Print[result[[6]]];
Print[""];Print["M2 part:"];Print[result[[7]]];
Print[""];Print[">>>>>>  End <<<<<<"];
];
];


(* Variables that have the complete input for the MSSM and NMSSM *)

MSSM=Sequence[{{{2}},{{2,-1},{-1,2}}},{{1/(2 Sqrt[15]),{1},{1,0}},{-(2/Sqrt[15]),{0},{0,1}},{1/Sqrt[15],{0},{0,1}},{-(Sqrt[(3/5)]/2),{1},{0,0}},{Sqrt[3/5],{0},{0,0}},{Sqrt[3/5]/2,{1},{0,0}},{-(Sqrt[(3/5)]/2),{1},{0,0}}},{3,3,3,3,3,1,1},{-1,-1,-1,-1,-1,1,1}];
NMSSM=Sequence[{{{2}},{{2,-1},{-1,2}}},{{1/6,{1},{1,0}},{-(2/3),{0},{0,1}},{1/3,{0},{0,1}},{-(1/2),{1},{0,0}},{1,{0},{0,0}},{1/2,{1},{0,0}},{-(1/2),{1},{0,0}},{0,{0},{0,0}}},{3,3,3,3,3,1,1,1},{-1,-1,-1,-1,-1,1,1,1}];
