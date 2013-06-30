unit deg_of_messages;

interface

uses register, defines, sysutils, windows, math, utils;

procedure StartMouseChoise;
procedure ProcessMouseChoise;
procedure DrawMessages;
procedure LoadMessages;
procedure ParseMousePosition;
procedure SendCommand(cmd : String);
procedure CreateDefaultDegOfMessagesItems;

implementation

procedure StartMouseChoise;
begin

  if players[idx] = nil then exit;
  if players[idx].balloon then exit;

  if (MMAP_BIND_KEY = 0) or (not KeyPressed(mouse_choise_key)) then begin
    is_mouse_choise_started := false;
    if (PByte($004E972B)^<>0) then begin
      //PByte($004E972B)^:=0;
      Patch($004E972B, '0');
      SetCursorPos(320, 240);
    end;
    exit;
  end;

	if is_mouse_choise_started then begin
    // PByte($004E972B)^:=1;
    Patch($004E972B, '1');
		ProcessMouseChoise;
		exit;
	end;

	is_mouse_choise_started := true;

  SetCursorPos(320, 240);
end;

procedure ProcessMouseChoise;
var
  offset : integer;
  alpha : Extended;
begin
	if (GetTickCount < (mouse_choise_close_time + 700)) then begin
		is_mouse_choise_started := false;
		exit;
	end;

	DrawMessages;

	GetCursorPos(mouse_choise_new_point);

  if (GetDist(320, 240, mouse_choise_new_point.X, mouse_choise_new_point.Y) > 55) then
  begin
    alpha := arctan((mouse_choise_new_point.Y - 240) / (mouse_choise_new_point.X - 320));
    if (mouse_choise_new_point.X < 320) then offset := -55 else offset := 55;
    mouse_choise_new_point.X := round( 320 + offset * cos(alpha) );
    mouse_choise_new_point.Y := round( 240 + offset * sin(alpha) );
  end;

  SetCursorPos(mouse_choise_new_point.X, mouse_choise_new_point.Y);

  FX_Rectangle(320-3,240-3,6,6,$99000000,$99000000,$102,false);

	FX_Line(320, 240, mouse_choise_new_point.X, mouse_choise_new_point.Y,
			$99000000, $102, false);

  FX_Rectangle(mouse_choise_new_point.X-4,mouse_choise_new_point.Y-4,
      8, 8,$ffd3d3d3,$99000000,$102,false);

 ParseMousePosition;

end;

procedure ParseMousePosition;
var
  iter, mx, my, ix, iy : Integer;
begin
  mx := mouse_choise_new_point.X;
  my := mouse_choise_new_point.Y;

  for iter := 0 to 7 do begin
    if length(mouse_choise_messages[iter]) = 0 then continue;

    ix := mouse_choise_vector_array[iter].x;
    iy := mouse_choise_vector_array[iter].y;
    if (mx-4>=ix-14)and(mx+4<ix+14) then
      if (my-4>=iy-14)and(my+4<iy+14) then
    begin
      is_mouse_choise_started := false;
		  mouse_choise_close_time := GetTickCount;
      SendCommand(mouse_choise_messages[iter]);
      exit;
    end;
  end;
end;

procedure SendCommand(cmd : String);
begin
  SendConsoleHCommand(cmd);
end;

procedure DrawMessages;
var 
	iter : Integer;
	x, y, ws : Integer;
  str : String;
begin

  FX_Rectangle(0,0,640,480,$66000000,$66000000,$102,false);

	for iter := 0 to 7 do begin
    x := round(320 - 50 * cos(DegToRad(360 / 8 * iter + 90)));
    y := round(240 - 50 * sin(DegToRad(360 / 8 * iter + 90)));
    str := mouse_choise_messages[iter];

    mouse_choise_vector_array[iter].x := x;
    mouse_choise_vector_array[iter].y := y;

    if length(str) = 0 then continue;
    
    FX_Rectangle(x-14,y-14,28,28,$99ffffff,$99000000,$102,false);
    ExtendedTextout(x-6, y-9, inttostr(iter+1), 4, false);

    x := round(320 - 100 * cos(DegToRad(360 / 8 * iter + 90)));
    y := round(240 - 100 * sin(DegToRad(360 / 8 * iter + 90)));

    if (strpar(mouse_choise_messages[iter], 0) = 'say') or
      (strpar(mouse_choise_messages[iter], 0) = 'say_team') then
        str := strpar_next(mouse_choise_messages[iter], 1);
        
    ws := FontMetrics(str);

    debug_textout(x-round(ws/2), y, str);

	end;
end;

procedure CreateDefaultDegOfMessagesItems;
var
  F : TextFile;
begin
  AssignFile(F,GetSystemVariable('gamedir')+ '\' + 'messages.txt');
  rewrite(f);

  writeln(f,'say_team ^4UP');
  writeln(f,'say_team ^1ATTACK!');
  writeln(f,'say_team ^4RIGHT');
  writeln(f,'say_team ^3DEFENCE!');
  writeln(f,'say_team ^4DOWN');
  writeln(f,'say_team ^1POWER!');
  writeln(f,'say_team ^4LEFT');
  writeln(f,'say_team ^1HELP');

  CloseFile(F);
  AddMessage('^1SGMOD:^7 Create default messages file.');
end;

procedure LoadMessages;
var
  F: TextFile;
  i: Integer;
begin
  if not FileExists(GetSystemVariable('gamedir') + '\' + 'messages.txt') then
    CreateDefaultDegOfMessagesItems;

  AssignFile(F,GetSystemVariable('gamedir')+ '\' + 'messages.txt');
  Reset(F);

  for i := 0 to 7 do begin
    mouse_choise_messages[i] := '';
    Readln(F, mouse_choise_messages[i]);
  end;

  CloseFile(F);
end;

end.
