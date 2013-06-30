unit utils;

interface

uses register, defines, math, sysutils, windows;

function Patch(addr: Cardinal; data: string): boolean;
function strpar(s: string; pos: byte): string;
function key_parse(s: string): integer;
function getKeyNameFromNumber(n: integer): string;
function GetDist(x1,y1,x2,y2: real): word;
function FontMetrics(str: String): Integer;
function strpar_next(s:string; pos : word):string;

implementation

function Patch(addr: Cardinal; data: string): boolean;
var
  oldProtect: Cardinal;
begin
  Result := false;
  if not VirtualProtect(Pointer(addr), Length(data), PAGE_EXECUTE_READWRITE, oldProtect) then
  begin
    AddMessage('Error patching NFK executable');
    exit;
  end;
  Move(PChar(data)^, PChar(addr)^, Length(data));
  if not VirtualProtect(Pointer(addr), Length(data), oldProtect, oldProtect) then
  begin
    AddMessage('Error patching NFK executable');
    exit;
  end;

  Result := true;
end;

function key_parse(s: string): integer;
var
  key : integer;
begin
  key := 0;

  if length(s) = 1 then begin
    if (ord(s[1]) >= 97) and (ord(s[1]) <= 122) then
      key := ord(s[1])-32;
    if (ord(s[1]) >= 46) and (ord(s[1]) <= 59) then
      key := ord(s[1]);
  end;

  if s = 'shift' then key := 16 else if s = 'ctrl' then key := 17 else
  if s = 'alt' then key := 18 else if s = 'tab' then key := 9 else
  if s = 'space' then key := 32 else if s = 'capslock' then key := 20 else
  if s = 'num0' then key := 96 else if s = 'num1' then key := 97 else
  if s = 'num2' then key := 98 else if s = 'num3' then key := 99 else
  if s = 'num4' then key := 100 else if s = 'num5' then key := 101 else
  if s = 'num6' then key := 102 else if s = 'num7' then key := 103 else
  if s = 'num8' then key := 104 else if s = 'num9' then key := 105 else
  if s = 'num/' then key := 111 else if s = 'num*' then key := 106 else
  if s = 'num-' then key := 109 else if s = 'num+' then key := 107 else
  if s = 'num.' then key := 110 else if s = 'enter' then key := 13 else
  if s = 'insert' then key := 45 else if s = 'home' then key := 36 else
  if s = 'pgup' then key := 33 else if s = 'pgdown' then key := 34 else
  if s = 'delete' then key := 46 else if s = 'end' then key := 35 else
  if s = 'backspace' then key := 8 else if s = 'leftarrow' then key := 37 else
  if s = 'rightarrow' then key := 39 else if s = 'uparrow' then key := 38 else
  if s = 'downarrow' then key := 40 else if s = 'mbutton1' then key := ord(mbutton1) else
  if s = 'mbutton2' then key := ord(mbutton2) else if s = 'mbutton3' then key := ord(mbutton3) else
  if s = 'mwheelup' then key := ord(mscrollup) else if s = 'mwheeldown' then key := ord(mscrolldn);

  result := key;
end;

function getKeyNameFromNumber(n: integer): string;
begin
  result := '';

  if n = 16 then result := 'shift' else if n = 17 then result := 'ctrl' else
  if n = 18 then result := 'alt' else if n = 9 then result := 'tab' else
  if n = 32 then result := 'space' else if n = 20 then result := 'capslock' else
  if n = 96 then result := 'num0' else if n = 97 then result := 'num1' else
  if n = 98 then result := 'num2' else if n = 99 then result := 'num3' else
  if n = 100 then result := 'num4' else if n = 101 then result := 'num5' else
  if n = 102 then result := 'num6' else if n = 103 then result := 'num7' else
  if n = 104 then result := 'num8' else if n = 105 then result := 'num9' else
  if n = 111 then result := 'num/' else if n = 106 then result := 'num*' else
  if n = 109 then result := 'num-' else if n = 107 then result := 'num+' else
  if n = 110 then result := 'num.' else if n = 13 then result := 'enter' else
  if n = 45 then result := 'insert' else if n = 36 then result := 'home' else
  if n = 33 then result := 'pgup' else if n = 34 then result := 'pgdown' else
  if n = 46 then result := 'delete' else if n = 35 then result := 'end' else
  if n = 8 then result := 'backspace' else if n = 37 then result := 'leftarrow' else
  if n = 39 then result := 'rightarrow' else if n = 38 then result := 'uparrow' else
  if n = 40 then result := 'downarrow' else if n = ord(mbutton1) then result := 'mbutton1' else
  if n = ord(mbutton2) then result := 'mbutton2' else if n = ord(mbutton3) then result := 'mbutton3' else
  if n = ord(mscrollup) then result := 'mwheelup' else if n = ord(mscrolldn) then result := 'mwheeldown';

  if length(result) = 0 then result := chr(n);

  if length(result) = 0 then result := 'none';
end;

function strpar(s: string; pos: byte): string;
var
  del1,counter: byte;
  i,len: word;
const
  delimeter: char=' ';
begin
  result:='';
  len:=length(s);
  if len=0 then exit;
  del1:=1;
  counter:=0;
  for i:=1 to len do if (s[i]=delimeter)or(i=len) then
    begin
      if counter=pos then
        begin
          if (pos=0)and(s[i]<>delimeter) then
            result:=copy(s,del1,i-del1+1)
          else
            if (pos=0) then
              result:=copy(s,del1,i-del1)
            else
              if (i=len)and(s[i]<>delimeter) then
                result:=copy(s,del1+1,i-del1+2)
              else result:=copy(s,del1+1,i-del1);
          exit;
        end;
      del1:=i;
      inc(counter);
    end;
end;

function GetDist(x1,y1,x2,y2: real): word;
begin
  result:=round(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)));
end;

function FontMetrics(str: String): Integer;
var
  i : Integer;
begin
  result := 0;
  i := 0;
  while (i <= length(str)) do begin
  if str[i] = '^' then begin
    i := i + 2;
    continue;
  end;
  // Verdana 7
  if str[i] = '' then result := result else
  if str[i] = '`' then result := result + 6 else
	if str[i] = '1' then result := result + 7 else
	if str[i] = '2' then result := result + 7 else
	if str[i] = '3' then result := result + 7 else
	if str[i] = '4' then result := result + 7 else
	if str[i] = '5' then result := result + 7 else
	if str[i] = '6' then result := result + 7 else
	if str[i] = '7' then result := result + 7 else
	if str[i] = '8' then result := result + 7 else
	if str[i] = '9' then result := result + 7 else
	if str[i] = '0' then result := result + 7 else
	if str[i] = '!' then result := result + 5 else
	if str[i] = '@' then result := result + 10 else
	if str[i] = '#' then result := result + 7 else
	if str[i] = '$' then result := result + 7 else
	if str[i] = '%' then result := result + 11 else
	if str[i] = '^' then result := result + 7 else
	if str[i] = '&' then result := result + 7 else
	if str[i] = '*' then result := result + 7 else
	if str[i] = '(' then result := result + 4 else
	if str[i] = ')' then result := result + 4 else
	if str[i] = '-' then result := result + 5 else
	if str[i] = '_' then result := result + 6 else
	if str[i] = '=' then result := result + 7 else
	if str[i] = '+' then result := result + 7 else
	if str[i] = 'q' then result := result + 6 else
	if str[i] = 'Q' then result := result + 9 else
	if str[i] = 'w' then result := result + 7 else
	if str[i] = 'W' then result := result + 9 else
	if str[i] = 'e' then result := result + 6 else
	if str[i] = 'E' then result := result + 7 else
	if str[i] = 'r' then result := result + 4 else
	if str[i] = 'R' then result := result + 7 else
	if str[i] = 't' then result := result + 4 else
	if str[i] = 'T' then result := result + 7 else
	if str[i] = 'y' then result := result + 6 else
	if str[i] = 'Y' then result := result + 7 else
	if str[i] = 'u' then result := result + 6 else
	if str[i] = 'U' then result := result + 8 else
	if str[i] = 'i' then result := result + 3 else
	if str[i] = 'I' then result := result + 5 else
	if str[i] = 'o' then result := result + 6 else
	if str[i] = 'O' then result := result + 9 else
	if str[i] = 'p' then result := result + 6 else
	if str[i] = 'P' then result := result + 7 else
	if str[i] = '[' then result := result + 4 else
	if str[i] = '{' then result := result + 6 else
	if str[i] = ']' then result := result + 4 else
	if str[i] = '}' then result := result + 6 else
	if str[i] = '\' then result := result + 4 else
	if str[i] = '|' then result := result + 5 else
	if str[i] = 'a' then result := result + 6 else
	if str[i] = 'A' then result := result + 8 else
	if str[i] = 's' then result := result + 6 else
	if str[i] = 'S' then result := result + 7 else
	if str[i] = 'd' then result := result + 6 else
	if str[i] = 'D' then result := result + 8 else
	if str[i] = 'f' then result := result + 3 else
	if str[i] = 'F' then result := result + 6 else
	if str[i] = 'g' then result := result + 6 else
	if str[i] = 'G' then result := result + 8 else
	if str[i] = 'h' then result := result + 6 else
	if str[i] = 'H' then result := result + 8 else
	if str[i] = 'j' then result := result + 3 else
	if str[i] = 'J' then result := result + 5 else
	if str[i] = 'k' then result := result + 6 else
	if str[i] = 'K' then result := result + 7 else
	if str[i] = 'l' then result := result + 3 else
	if str[i] = 'L' then result := result + 6 else
	if str[i] = ';' then result := result + 4 else
	if str[i] = ':' then result := result + 4 else
	if str[i] = '"' then result := result + 5 else
	if str[i] = 'z' then result := result + 5 else
	if str[i] = 'Z' then result := result + 7 else
	if str[i] = 'x' then result := result + 6 else
	if str[i] = 'X' then result := result + 7 else
	if str[i] = 'c' then result := result + 6 else
	if str[i] = 'C' then result := result + 8 else
	if str[i] = 'v' then result := result + 6 else
	if str[i] = 'V' then result := result + 8 else
	if str[i] = 'b' then result := result + 6 else
	if str[i] = 'B' then result := result + 7 else
	if str[i] = 'n' then result := result + 6 else
	if str[i] = 'N' then result := result + 8 else
	if str[i] = 'm' then result := result + 9 else
	if str[i] = 'M' then result := result + 9 else
	if str[i] = ',' then result := result + 3 else
	if str[i] = '<' then result := result + 7 else
	if str[i] = '.' then result := result + 3 else
	if str[i] = '>' then result := result + 7 else
	if str[i] = '/' then result := result + 4 else
	if str[i] = '?' then result := result + 6 else
  if str[i] = ' ' then result := result + 6;
	//result := result + 6;
  i := i + 1;
  end;
end;

function strpar_next(s:string; pos : word):string;
var     counter : byte;
        len, i : word;
const   delimeter : char = ' ';
begin
        result := ''; len := length(s);
        if len = 0 then exit; counter := 0;
        s := delimeter + s + delimeter;
        for i := 1 to len do
        if (s[i]=delimeter) then begin
                if counter = pos then begin
                        result := copy(s, i+1, len-i+1);
                        exit;
                        end;
                inc(counter);
        end;
end;

end.
