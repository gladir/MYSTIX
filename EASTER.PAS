{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/mystix)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program Easter;

Uses DOS;

Function GetCurrYear:Word;
Var
 Year,Month,Day,DOW:Word;
Begin
 GetDate(Year,Month,Day,DOW);
 GetCurrYear:=Year;
End;

Procedure DateOfEaster(Year:Integer;Var Month,Day:Byte);
Var
 G,C,X,Z,D,E,N:Integer;
Begin
 G:=(Year mod 19) + 1;
 C:=(Year div 100) + 1;
 X:=((3 * C) div 4) - 12;
 Z:=((8 * C + 5) div 25) - 5;
 D:=((5 * Year) div 4) - X - 10;
 E:=(11 * G + 20 + Z - X) MOD 30;
 If E < 0 Then E := E + 30;
 If((E = 25) and (G > 11)) or (E = 24) Then E := E + 1;
 N:=44-E;
 If N < 21 Then N := N + 30;
 N := N + 7 - ((D + N) MOD 7);
 If N > 31 Then Begin
  Month := 4;
  Day := N - 31;
 End
  Else
 Begin
  Month := 3;
  Day := N;
 End;
End;

Function MonthName(Month:Byte):String;BEGIN
 Case Month of
  1:MonthName:='Janvier';
  2:MonthName:='F‚vrier';
  3:MonthName:='Mars';
  4:MonthName:='Avril';
  5:MonthName:='Mai';
  6:MonthName:='Juin';
  7:MonthName:='Juillet';
  8:MonthName:='Ao–t';
  9:MonthName:='Septembre';
  10:MonthName:='Octobre';
  11:MonthName:='Novembre';
  12:MonthName:='D‚cembre';
 End;
End;

Var
 I,Year:Integer;
 Month,Day:Byte;
 Err:Word;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('EASTER : Cette commande permet d''afficher ',
                      'la date de la Paque l''annee specifie.');
  WriteLn;
  WriteLn('Syntaxe : EASTER [annee]');
  WriteLn;
  WriteLn('annee   Ce parametre permet d''indiquer l''annee a calculer.');
 End
  Else
 If ParamCount>0Then Begin
  For I:=1 to ParamCount do Begin
   Val(ParamStr(I),Year,Err);
   If Err>0Then Begin
    WriteLn('Parametre invalide');
    Halt;
   End;
   DateOfEaster(Year,Month,Day);
   WriteLn('Paque en l''annee ',Year,' est le jour ',Day,' du mois ',MonthName(Month));
  End;
 End
  Else
 Begin
  DateOfEaster(GetCurrYear,Month,Day);
  WriteLn('Pƒque de cette ann‚e est le jour ',Day,' du mois ',MonthName(Month));
 End;
END.