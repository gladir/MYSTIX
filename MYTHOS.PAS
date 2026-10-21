{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2026
  @website(https://www.gladir.com/mystix)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
  @description(Petit catalogue mythologique autonome. Les traditions ont des variantes; les 
  rapprochements greco-romains ne sont pas des identites absolues. Les champs internes sont 
  separes par |. Texte ASCII pour les consoles DOS.) 
}

Program MYTHOS;

Const MaxEntries = 40;

Type
 EntryRec = Record
  Name: String[30];
  Culture: String[12];
  Kind: String[10];
  Description: String[100];
  Parents, Spouses, Equivalents: String[60];
  Source: String[80];
 End;

Var
 Entries: Array[1..MaxEntries] of EntryRec;
 Count, I, J, Found: Integer;
 Command, Query, Culture, FormatName, Arg: String;
 HasCulture, HasFormat, HasQuery, Match: Boolean;

Function Lower(S: String): String;
Var K: Integer;
Begin
 For K := 1 to Length(S) do
  If (S[K] >= 'A') and (S[K] <= 'Z') then
   S[K] := Chr(Ord(S[K]) + 32);
 Lower := S;
End;

Function Field(S: String; N: Integer): String;
Var K, Start, Current: Integer;
Begin
 Start := 1; Current := 1;
 For K := 1 to Length(S) do
  If S[K] = '|' then Begin
   If Current = N then Begin
    Field := Copy(S, Start, K - Start); Exit;
   End;
   Inc(Current); Start := K + 1;
  End;
 If Current = N then Field := Copy(S, Start, 255)
 else Field := '';
End;

Procedure Add(S: String);
Begin
 Inc(Count);
 With Entries[Count] do Begin
  Name := Field(S, 1); Culture := Field(S, 2); Kind := Field(S, 3);
  Description := Field(S, 4); Parents := Field(S, 5);
  Spouses := Field(S, 6); Equivalents := Field(S, 7);
  Source := Field(S, 8);
 End;
End;

Procedure Init;
Begin
 Count := 0;
 Add('Zeus|greek|god|Dieu du ciel et de la foudre.|Cronus, Rhea|Hera|Jupiter|Hesiode, Theogonie');
 Add('Hera|greek|god|Deesse du mariage.|Cronus, Rhea|Zeus|Juno|Hesiode, Theogonie');
 Add('Athena|greek|god|Deesse de la sagesse et des arts de la guerre.|Zeus, Metis||Minerva|Hesiode, Theogonie');
 Add('Poseidon|greek|god|Dieu de la mer.|Cronus, Rhea|Amphitrite|Neptune|Hesiode, Theogonie');
 Add('Hades|greek|god|Souverain du monde des morts.|Cronus, Rhea|Persephone|Pluto|Hesiode, Theogonie');
 Add('Ares|greek|god|Dieu de la guerre.|Zeus, Hera||Mars|Hesiode, Theogonie');
 Add('Aphrodite|greek|god|Deesse de l''amour; naissance marine selon Hesiode.||Hephaestus|Venus|Hesiode, Theogonie');
 Add('Hermes|greek|god|Messager des dieux.|Zeus, Maia||Mercury|Hymne homerique a Hermes');
 Add('Apollo|greek|god|Dieu de la musique et de la divination.|Zeus, Leto|||Hymne homerique a Apollon');
 Add('Artemis|greek|god|Deesse de la chasse.|Zeus, Leto||Diana|Hymne homerique a Artemis');
 Add('Heracles|greek|hero|Heros des douze travaux.|Zeus, Alcmene|Hebe|Hercules|Pseudo-Apollodore, Bibliotheque');
 Add('Odysseus|greek|hero|Roi d''Ithaque, aussi appele Ulysses ou Ulysse.|Laertes, Anticlea|Penelope||Homere, Odyssee');
 Add('Achilles|greek|hero|Heros grec de la guerre de Troie.|Peleus, Thetis|||Homere, Iliade');
 Add('Perseus|greek|hero|Heros vainqueur de Medusa.|Zeus, Danae|Andromeda||Pseudo-Apollodore, Bibliotheque');
 Add('Medusa|greek|creature|Gorgone dont le regard petrifie.|Phorcys, Ceto|||Hesiode, Theogonie');
 Add('Minotaur|greek|creature|Creature du labyrinthe de Crete.|Pasiphae, taureau cretois|||Pseudo-Apollodore, Bibliotheque');
 Add('Jupiter|roman|god|Dieu du ciel et de la foudre.|Saturn, Ops|Juno|Zeus|Ovide, Metamorphoses');
 Add('Juno|roman|god|Deesse du mariage.|Saturn, Ops|Jupiter|Hera|Virgile, Eneide');
 Add('Minerva|roman|god|Deesse des arts et de la sagesse.|Jupiter||Athena|Ovide, Metamorphoses');
 Add('Mars|roman|god|Dieu de la guerre.|||Ares|Ovide, Fastes');
 Add('Venus|roman|god|Deesse de l''amour, mere d''Aeneas.|||Aphrodite|Virgile, Eneide');
 Add('Aeneas|roman|hero|Heros troyen du recit fondateur romain.|Anchises, Venus|Lavinia||Virgile, Eneide');
 Add('Odin|nordic|god|Dieu de la sagesse, de la poesie et des morts.|Borr, Bestla|Frigg||Snorri Sturluson, Edda en prose');
 Add('Thor|nordic|god|Dieu du tonnerre, porteur du marteau Mjollnir.|Odin, Jord|Sif||Snorri Sturluson, Edda en prose');
 Add('Loki|nordic|god|Figure ambivalente, rusee et perturbatrice.|Farbauti, Laufey|Sigyn||Snorri Sturluson, Edda en prose');
 Add('Freyja|nordic|god|Deesse de l''amour et du seidr.|Njord|Odr||Snorri Sturluson, Edda en prose');
 Add('Sigurd|nordic|hero|Heros vainqueur du dragon Fafnir.|Sigmund, Hjordis|Gudrun||Saga des Volsungar');
 Add('Fenrir|nordic|creature|Loup destine a affronter Odin au Ragnarok.|Loki, Angrboda|||Snorri Sturluson, Edda en prose');
 Add('Jormungandr|nordic|creature|Serpent qui entoure le monde.|Loki, Angrboda|||Snorri Sturluson, Edda en prose');
 Add('Fafnir|nordic|creature|Dragon gardien d''un tresor maudit.|Hreidmar|||Saga des Volsungar');
 Add('Odyssey|greek|story|Odyssee : retour d''Odysseus (Ulysse) a Ithaque.||||Homere, Odyssee, chants I-XXIV');
 Add('Iliad|greek|story|Iliade : colere d''Achilles pendant la guerre de Troie.||||Homere, Iliade, chants I-XXIV');
 Add('Aeneid|roman|story|Eneide : voyage d''Aeneas (Enee) vers l''Italie.||||Virgile, Eneide, livres I-XII');
 Add('Ragnarok|nordic|story|Conflit final des dieux et renouvellement du monde.||||Edda poetique, Voluspa; Edda en prose, Gylfaginning');
End;

Procedure Help;
Begin
 WriteLn('MYTHOS - Cette commande permet de lancer le catalogue mythologique int'+#130+'gr'+#130+'.');
 WriteLn;
 WriteLn('Syntaxe :');
 WriteLn;
 WriteLn('MYTHOS SEARCH "texte" [--culture greek|roman|nordic]');
 WriteLn('MYTHOS GODS|HEROES|CREATURES [--culture culture]');
 WriteLn('MYTHOS FAMILY "nom" [--culture culture]');
 WriteLn('MYTHOS EQUIVALENT "nom" [--culture culture d''origine]');
 WriteLn('MYTHOS STORY "texte" [--culture culture]');
 WriteLn('MYTHOS CULTURES');
 WriteLn('MYTHOS EXPORT "texte" [--format json|csv|text] [--culture culture]');
 WriteLn;
 WriteLn('Export vers la sortie standard; redirection possible avec > fichier.');
 WriteLn('Noms du catalogue en anglais; recherche sans distinction de casse.');
 WriteLn('Sources indicatives; genealogies et rapprochements selon les traditions.');
End;

Procedure Error(S: String);
Begin
 WriteLn({$IFDEF FPC}StdErr,{$ENDIF} 'MYTHOS: ', S);
 Halt(1);
End;

{ Ecriture par caractere pour eviter la limite des String[255]. }
Procedure Json(S: String);
Const Hex: String[16] = '0123456789abcdef';
Var K, N: Integer;
Begin
 Write('"');
 For K := 1 to Length(S) do Begin
  N := Ord(S[K]);
  Case S[K] of
   '"': Write('\"');
   '\': Write('\\');
   Else If N < 32 then Write('\u00', Hex[N div 16 + 1], Hex[N mod 16 + 1])
        else Write(S[K]);
  End;
 End;
 Write('"');
End;

Procedure Csv(S: String);
Var K: Integer;
Begin
 Write('"');
 For K := 1 to Length(S) do Begin
  If S[K] = '"' then Write('"');
  Write(S[K]);
 End;
 Write('"');
End;

Procedure Show(N: Integer);
Begin
 With Entries[N] do Begin
  WriteLn(Name, ' [', Culture, '/', Kind, '] : ', Description);
  If Parents <> '' then WriteLn('  Parents : ', Parents);
  If Spouses <> '' then WriteLn('  Conjoint(s) : ', Spouses);
  If Equivalents <> '' then WriteLn('  Rapprochement : ', Equivalents);
  WriteLn('  Source : ', Source);
 End;
End;

Procedure ExportEntry(N: Integer);
Begin
 With Entries[N] do
 If FormatName = 'json' then Begin
  If Found > 1 then WriteLn(',');
  Write('  {"name":'); Json(Name);
  Write(',"culture":'); Json(Culture);
  Write(',"type":'); Json(Kind);
  Write(',"description":'); Json(Description);
  Write(',"parents":'); Json(Parents);
  Write(',"spouses":'); Json(Spouses);
  Write(',"equivalents":'); Json(Equivalents);
  Write(',"source":'); Json(Source); Write('}');
 End else If FormatName = 'csv' then Begin
  Csv(Name); Write(','); Csv(Culture); Write(','); Csv(Kind); Write(',');
  Csv(Description); Write(','); Csv(Parents); Write(',');
  Csv(Spouses); Write(','); Csv(Equivalents); Write(','); Csv(Source); WriteLn;
 End else Show(N);
End;

Function ContainsName(List, Name: String): Boolean;
Var K, P: Integer; S: String;
Begin
 ContainsName := False; K := 1;
 Repeat
  { Reutilise Field avec un separateur transforme. }
  S := List;
  For P := 1 to Length(S) do If S[P] = ',' then S[P] := '|';
  S := Field(S, K);
  While (Length(S) > 0) and (S[1] = ' ') do Delete(S, 1, 1);
  If Lower(S) = Lower(Name) then ContainsName := True;
  Inc(K);
 Until S = '';
End;

Begin
 If ParamCount = 0 then Begin Help; Halt(0); End;
 Command := Lower(ParamStr(1));
 If (Command = '--help') or (Command = '-h') or (Command = '/?') then
 Begin Help; Halt(0); End;
 If (Command <> 'search') and (Command <> 'gods') and
    (Command <> 'heroes') and (Command <> 'creatures') and
    (Command <> 'family') and (Command <> 'equivalent') and
    (Command <> 'story') and (Command <> 'cultures') and
    (Command <> 'export') then Error('Commande inconnue. Utilisez --help.');
 Query := ''; Culture := ''; FormatName := 'text';
 HasQuery := False; HasCulture := False; HasFormat := False;
 I := 2;
 While I <= ParamCount do Begin
  Arg := ParamStr(I);
  If (Lower(Arg) = '--culture') or (Lower(Arg) = '--format') then Begin
   Inc(I);
   If I > ParamCount then Error('Valeur manquante pour ' + Arg);
   If Lower(Arg) = '--culture' then Begin
    If HasCulture then Error('Option --culture repetee.');
    HasCulture := True; Culture := Lower(ParamStr(I));
    If (Culture <> 'greek') and (Culture <> 'roman') and (Culture <> 'nordic') then
     Error('Culture inconnue : ' + Culture);
   End else Begin
    If HasFormat then Error('Option --format repetee.');
    HasFormat := True; FormatName := Lower(ParamStr(I));
    If (FormatName <> 'json') and (FormatName <> 'csv') and
       (FormatName <> 'text') then Error('Format inconnu : ' + FormatName);
   End;
  End else Begin
   If (Copy(Arg, 1, 1) = '-') then Error('Option inconnue : ' + Arg);
   If HasQuery then Error('Argument superflu : ' + Arg);
   HasQuery := True; Query := Lower(Arg);
   If Query = '' then Error('La recherche ne peut pas etre vide.');
  End;
  Inc(I);
 End;
 If HasFormat and (Command <> 'export') then Error('--format exige EXPORT.');
 If (Command = 'cultures') and HasCulture then Error('CULTURES ne prend pas --culture.');
 If (Command = 'gods') or (Command = 'heroes') or
    (Command = 'creatures') or (Command = 'cultures') then Begin
  If HasQuery then Error('Cette commande ne prend pas de texte.');
 End else If not HasQuery then Error('Texte ou nom requis. Utilisez --help.');
 Init;
 If Command = 'cultures' then Begin
  WriteLn('greek  - Mythologie grecque');
  WriteLn('roman  - Mythologie romaine');
  WriteLn('nordic - Mythologie nordique'); Halt(0);
 End;
 If Command = 'export' then Begin
  If FormatName = 'json' then WriteLn('[');
  If FormatName = 'csv' then
   WriteLn('name,culture,type,description,parents,spouses,equivalents,source');
 End;
 Found := 0;
 For I := 1 to Count do Begin
  Match := (Culture = '') or (Entries[I].Culture = Culture);
  If Command = 'gods' then Match := Match and (Entries[I].Kind = 'god')
  else If Command = 'heroes' then Match := Match and (Entries[I].Kind = 'hero')
  else If Command = 'creatures' then Match := Match and (Entries[I].Kind = 'creature')
  else If (Command = 'family') or (Command = 'equivalent') then
   Match := Match and (Lower(Entries[I].Name) = Query) and (Entries[I].Kind <> 'story')
  else Begin
   Match := Match and ((Pos(Query, Lower(Entries[I].Name)) > 0) or
    (Pos(Query, Lower(Entries[I].Description)) > 0) or
    (Pos(Query, Lower(Entries[I].Source)) > 0) or
    (Pos(Query, Lower(Entries[I].Parents)) > 0) or
    (Pos(Query, Lower(Entries[I].Equivalents)) > 0));
   If Command = 'story' then Match := Match and (Entries[I].Kind = 'story');
  End;
  If Match then Begin
   Inc(Found);
   If Command = 'export' then ExportEntry(I)
   else Begin
    Show(I);
    If Command = 'family' then Begin
     WriteLn('  Enfants presents dans le catalogue :');
     For J := 1 to Count do
      If ContainsName(Entries[J].Parents, Entries[I].Name) then
       WriteLn('    ', Entries[J].Name);
    End;
    If Command = 'equivalent' then Begin
     If Entries[I].Equivalents = '' then WriteLn('  Aucun rapprochement documente.');
     WriteLn('  Rapprochements traditionnels; les figures restent distinctes.');
    End;
   End;
  End;
 End;
 If (Command = 'export') and (FormatName = 'json') then Begin
  If Found > 0 then WriteLn;
  WriteLn(']');
 End;
 If Found = 0 then Begin
  WriteLn({$IFDEF FPC}StdErr,{$ENDIF} 'MYTHOS: Aucun resultat.'); Halt(2);
 End;
End.
