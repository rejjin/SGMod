unit time;

interface

uses register, defines, sysutils, windows;

procedure DrawTime;
procedure SetAmpl(image : byte; dxid : word);
procedure UpdateAmplitude;

implementation

  procedure UpdateAmplitude;
  begin
    if time_alarm_start=0 then exit;
    if (gettickcount-time_alarm_start) mod 50 > 0 then begin
      if ampl_offsety > 12 then ampl_offsety_vel := -1;
      if ampl_offsety <= 0 then begin
        ampl_offsety := 0;
        ampl_offsety_vel := 1;
      end;
      ampl_offsety := ampl_offsety + ampl_offsety_vel;
      if (gettickcount-time_alarm_start) > 1150 then
        time_alarm_start := 0;
    end;
  end;

  procedure SetAmpl(image : byte; dxid : word);
  begin
    if dxid <> strtoint(GetSystemVariable('localdxid')) then
      exit;

    if (image = IT_YELLOW_ARMOR) or (image = IT_RED_ARMOR) or (image = IT_RAIL) or
      (image = IT_HEALTH_100) or (image = IT_POWERUP_REGENERATION) or (image = IT_POWERUP_BATTLESUIT) or
      (image = IT_POWERUP_HASTE) or (image = IT_POWERUP_QUAD) or (image = IT_POWERUP_FLIGHT) or
      (image = IT_POWERUP_INVISIBILITY) then begin
        time_alarm_start := gettickcount;
        ampl_offsety_vel := 1;
      end;
  end;

  procedure DrawTime;
  var
    size : byte;
    time : shortstring;
  begin
    size := 4;
    if time_size = 1 then size := 2;
    if time_size = 2 then size := 4;
    if time_size = 3 then size := 6;

    if time_alarm_start <> 0 then UpdateAmplitude;

    time:=Format('%.2d', [strtoint(GetSystemVariable('time_min'))])+
      ':'+
      Format('%.2d', [strtoint(GetSystemVariable('time_sec'))]);

    if (not draw_time) or (players[idx] = nil) then
      exit;

    if strtoint(GetSystemVariable('warmupleft')) <> 0 then
      exit;

    ExtendedTextout(time_pos_x,time_pos_y+ampl_offsety,'^'+inttostr(time_color)+time,size, false);

  end;
end.
