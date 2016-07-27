Program Zoo(Input,Output);
Const
   Maxn	= 100000;
   Maxm	= 50000;
Var
   A,B,P,Num,Sum	       : Array[0..Maxn]Of Longint;
   {A记录狮子的觅食能力，P记录狮子的编号}
   St,En,K,Q,Ans	       : Array[0..Maxm]Of Longint;
   {st为投喂区间起点，en为终点，k为第i个询问所求的第k小值，q记录问题的编号，ans[i]记录第i条询问的答案}
   N,M,I,Now,Rear,Tail,L,R,Mid : Longint;
Procedure Qsort1(L,R : Longint);
Var
   I,J,Mid,Temp	: Longint;
Begin
   I:=L;
   J:=R;
   Mid:=A[(L+R)Shr 1];
   While I<J Do
   Begin
      While (A[I]<Mid)Do
	 Inc(I);
      While (A[J]>Mid)Do
	 Dec(J);
      If I<=J Then
      Begin
	 Temp:=A[I];A[I]:=A[J];A[J]:=Temp;
	 Temp:=P[I];P[I]:=P[J];P[J]:=Temp;
	 Inc(I);
	 Dec(J);
      End;
   End;
   If I<R Then Qsort1(I,R);
   If L<J Then Qsort1(L,J);
End;
Procedure Qsort2(L,R:Longint);
Var
   I,J,Temp,Mid	: Longint;
Begin
   I:=L;
   J:=R;
   Mid:=St[(L+R)Shr 1];
   While I<J Do
   Begin
      While St[I]<Mid Do
	 Inc(I);
      While St[J]>Mid Do
	 Dec(J);
      If I<=J Then
      Begin
	 Temp:=St[I];St[I]:=St[J];St[J]:=Temp;
	 Temp:=En[I];En[I]:=En[J];En[J]:=Temp;
	 Temp:=K[I];K[I]:=K[J];K[J]:=Temp;
	 Temp:=Q[I];Q[I]:=Q[J];Q[J]:=Temp;
	 Inc(I);
	 Dec(J);
      End;
   End;
   If I<R Then Qsort2(I,R);
   If L<J Then Qsort2(L,J);
End;
Procedure Init;
Begin
   Readln(N,M);
   For I:=1 To N Do
   Begin
      Read(A[I]);
      P[I]:=I;
   End;
   Qsort1(1,N);
   A[0]:=A[1]-1;
   Now:=0;
   For I:=1 To N Do
   Begin
      If A[I]<>A[I-1] Then
      Begin
	 Inc(Now);
	 Num[Now]:=A[I];
      End;
      B[P[I]]:=Now;
   End;
   For I:=1 To M Do
   Begin
      Readln(St[I],En[I],K[I]);
      Q[I]:=I;
   End;
   Qsort2(1,M);
End;
Procedure Insert(X,Number:Longint);
Begin
   While X<=Now Do
   Begin
      Inc(Sum[X],Number);
      X:=X+X And(-X);
   End;
End;
Function Find(X:Longint):Longint;
Begin
   Find:=0;
   While X>0 Do
   Begin
      Inc(Find,Sum[X]);
      X:=X-X And (-X);
   End;
End;
Procedure Main;
Begin
   Rear:=1;Tail:=0;
   For I:=1 To M Do
   Begin
      While (Rear<=Tail)And(Rear<St[I])Do
      Begin
	 Insert(B[Rear],-1);
	 Inc(Rear);
      End;
      If Rear>Tail Then
      Begin
	 Rear:=St[I];
	 Tail:=Rear-1;
      End;
      While (Tail<En[I])Do
      Begin
	 Inc(Tail);
	 Insert(B[Tail],1);
      End;
      L:=0;
      R:=Now;
      While L<R-1 Do
      Begin
	 Mid:=(L+R)Shr 1;
	 If Find(Mid)<K[I] Then
	    L:=Mid
	 Else
	    R:=Mid;
      End;
      Ans[Q[I]]:=Num[R];
   End;
   For I:=1 To M Do
      Writeln(Ans[I]);
End;
Begin
   Init;
   Main;
End.