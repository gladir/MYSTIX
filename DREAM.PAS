{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/mystix)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program DREAM;

Uses Strings;

Type
 SymbolRec=Record
  Expression:PChar;
  Definition:PChar;
 End;

Const
 SymbolList:Array[0..23]of SymbolRec=(
  (Expression:'Araign‚e';
   Definition:'Prison int‚rieur du rˆveur. Situation stressante '+
              'angoissante'),
  (Expression:'Avion';
   Definition:'Envol‚es int‚rieures risqu‚s'),
  (Expression:'Bleu';
   Definition:'Esprit, intelligence, transparence et f‚minit‚'),
  (Expression:'Carr‚';
   Definition:'R‚alisme, ‚quilibre, projet r‚alisable, stabilit‚ dans les projets r‚alisables.'),
  (Expression:'Ciel';
   Definition:'Indique la tonalit‚ de son v‚cu et '+
              'pr‚cise parfois le fils des ‚v‚nements … venir.'),
  (Expression:'CimetiŠre';
   Definition:'Remise en question dans la maniŠre de penser. '+
              'Prise de conscience de ce qui est mort en soi.'),
  (Expression:'Cinq';
   Definition:'L''inspiration, la cr‚ativit‚, la vie ‚quilibr‚'),
  (Expression:'Deux';
   Definition:'La dualit‚, l''instabilit‚, le passif'),
  (Expression:'Dix';
   Definition:'Le destin dans une nouvelle bases des condition de vie.'),
  (Expression:'Glace';
   Definition:'S‚pare le conscient du subconscient. P‚riode de solitude.'),
  (Expression:'Huit';
   Definition:'La justice.'),
  (Expression:'Ile';
   Definition:'Refuge, centre sacr‚ de paix.'),
  (Expression:'Lune';
   Definition:'Inspiration dans les cycles de rennaissances.'),
  (Expression:'Maison';
   Definition:'Centre sacr‚ de la vie du rˆveur.'),
  (Expression:'Neuf';
   Definition:'Nombre de valeur rituelle, il oblige … la prodence, … la tran sposer un autre plan.'),
  (Expression:'Oc‚an';
   Definition:'Esprit universel o— l''on va plonger le principe '+
              'de vie. Indiff‚rence, ind‚termination, t‚n‚breux,'+
              'il est la forme incr‚‚e d''o— toute est n‚, mˆme '+
              'les dieux.'),
  (Expression:'Quatre';
   Definition:'La r‚alisation, la stabilit‚.'),
  (Expression:'Requin';
   Definition:'Instant d''arriviste existant dans chaque ˆtre.'),
  (Expression:'Sept';
   Definition:'Nombre sacr‚ du triomphe, du pouvoir magique.'),
  (Expression:'Six';
   Definition:'L''oposition … l''hormonie c‚leste.'),
  (Expression:'Soleil';
   Definition:'Source nourriciŠre de toute vie.'),
  (Expression:'Tˆte';
   Definition:'Envisager la vie sous une angle diff‚rent. Parfois, le courage.'),
  (Expression:'Trois';
   Definition:'La conception, l''id‚e'),
  (Expression:'Un';
   Definition:'Point de d‚part, l''actif, les valeurs de '+
              'l''intelligence.')
 );

 PositiveList:Array[0..17]of PChar=(
  'adore','beau','beaucoup','bien','bienvenue','bien merci','blanc',
  'bon','bonne','bonne journ‚e','excellente journ‚e',
  'heureux','mieux','moins pire',
  'tellement mieux','tres','trŠs','trop'
 );

 NegativeList:Array[0..14]of PChar=(
  'balles de frais',
  'honte',
  'infecte',
  'je comprends mˆme pas',
  'je suis r‚volt‚',
  'mal','mauvais',
  'maladroit','malpropre',
  'merde','moins','noir','pas',
  'sombre',
  'vrai honte'
 );

 NeutralList:Array[0..2]of PChar=(
  'je pr‚fŠre ne pas me prononcer','moyen','passable'
 );

Var
 SymbolPresent:Array[Low(SymbolList)..High(SymbolList)]of Boolean;
 PositiveWord,NegativeWord,NeutralWord:LongInt;
 BeginWord,I,J:Integer;
 FoundMultiWord:Boolean;
 SourceFile:Text;
 FileName,CurrLine,CurrWord:String;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I]in['‚','Š','ˆ',#232,#233,#234]Then S[I]:='E'Else
  If S[I]in['Œ',#238]Then S[I]:='I'Else
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function IsLetter(Chr:Char):Boolean;Begin
 IsLetter:=Chr in ['A'..'Z','a'..'z','‚','ˆ','Œ',
                   'Š','…','ƒ','“','‡',#232,#233,#234,#238];
End;

Procedure CompileWord;
Var
 I:Integer;
Begin
 For I:=Low(SymbolList) to High(SymbolList) do Begin
  If StrToUpper(StrPas(SymbolList[I].Expression))=StrToUpper(CurrWord)Then Begin
   If Not(SymbolPresent[I])Then Begin
    WriteLn(StrPas(SymbolList[I].Expression),' : ',StrPas(SymbolList[I].Definition));
    WriteLn;
    SymbolPresent[I]:=True;
   End;
  End;
 End;
 For I:=Low(PositiveList) to High(PositiveList) do Begin
  If StrToUpper(StrPas(PositiveList[I]))=StrToUpper(CurrWord)Then Begin
   Inc(PositiveWord);
   Exit;
  End;
 End;
 For I:=Low(NegativeList) to High(NegativeList) do Begin
  If StrToUpper(StrPas(NegativeList[I]))=StrToUpper(CurrWord)Then Begin
   Inc(NegativeWord);
   Exit;
  End;
 End;
 For I:=Low(NeutralList) to High(NeutralList) do Begin
  If StrToUpper(StrPas(NeutralList[I]))=StrToUpper(CurrWord)Then Begin
   Inc(NeutralWord);
   Exit;
  End;
 End;
End;

Procedure ParseLineDetectSymbol;
Var
 J:Integer;
Begin
 CurrWord:='';
 BeginWord:=1;
 For I:=1 to Length(CurrLine)do Begin
  If(IsLetter(CurrLine[I]))Then CurrWord:=CurrWord+CurrLine[I]
   Else
  Begin
   FoundMultiWord:=False;
   For J:=Low(PositiveList) to High(PositiveList) do Begin
    If(StrLen(PositiveList[J])>Length(CurrWord))and
      (StrToUpper(StrPas(PositiveList[J]))=
      StrToUpper(Copy(CurrLine,BeginWord,StrLen(PositiveList[J]))))Then Begin
     FoundMultiWord:=True;
     Break;
    End;
   End;
   If Not(FoundMultiWord)Then Begin
    For J:=Low(NegativeList) to High(NegativeList) do Begin
     If(StrLen(NegativeList[J])>Length(CurrWord))and
       (StrToUpper(StrPas(NegativeList[J]))=
       StrToUpper(Copy(CurrLine,BeginWord,StrLen(NegativeList[J]))))Then Begin
      FoundMultiWord:=True;
      Break;
     End;
    End;
   End;
   If Not(FoundMultiWord)Then Begin
    For J:=Low(NeutralList) to High(NeutralList) do Begin
     If(StrLen(NeutralList[J])>Length(CurrWord))and
       (StrToUpper(StrPas(NeutralList[J]))=
       StrToUpper(Copy(CurrLine,BeginWord,StrLen(NeutralList[J]))))Then Begin
      FoundMultiWord:=True;
      Break;
     End;
    End;
   End;
   If(FoundMultiWord)Then Begin
    CurrWord:=CurrWord+CurrLine[I]
   End
    Else
   Begin
    CompileWord;
    CurrWord:='';
    BeginWord:=I+1;
   End;
  End;
 End;
 CompileWord;
End;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('DREAM : Cette commande permet d''analyser le symbolisme ',
                   'et les sentiments dans un reve.');
  WriteLn;
  WriteLn('Syntaxe : DREAM "message"');
  WriteLn('          DREAM /FILE:fichier');
  WriteLn;
 End
  Else
 Begin
  FillChar(SymbolPresent,SizeOf(SymbolPresent),0);
  PositiveWord:=0;
  NegativeWord:=0;
  NeutralWord:=0;
  FileName:='';
  CurrLine:='';
  WriteLn('Symbolisme');
  WriteLn('----------');
  For I:=1 to ParamCount do Begin
   If StrToUpper(Copy(ParamStr(I),1,6))='/FILE:'Then Begin
    FileName:=Copy(ParamStr(I),7,255);
   End
    Else
   Begin
    If CurrLine=''Then CurrLine:=ParamStr(I)
                  Else CurrLine:=CurrLine+' '+ParamStr(I);
   End;
  End;
  If FileName<>''Then Begin
    Assign(SourceFile,FileName);
    Reset(SourceFile);
    While Not EOF(SourceFile)do Begin
     ReadLn(SourceFile,CurrLine);
     ParseLineDetectSymbol;
    End;
    Close(SourceFile);
   End
    Else
   ParseLineDetectSymbol;
   WriteLn;
   WriteLn('Sentiment');
   WriteLn('---------');
   If PositiveWord>NegativeWord Then WriteLn('Positif')Else
   If PositiveWord<NegativeWord Then WriteLn('N‚gatif')
                                Else WriteLn('Neutre');
 End;
END.
