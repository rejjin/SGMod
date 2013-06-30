unit low_ammo_warning;

interface

uses register, defines, sysutils, windows;

procedure LowAmmoWarning;

implementation

  procedure LowAmmoWarning;
  var
    draw_table : boolean;
    c_ammo, x, y, w, h : integer;
  begin

    if not low_ammo_table then exit;

    if (players[idx] = nil) or (players[idx].dead) then
      exit;

    draw_table := false;
    c_ammo := 0;

    case players[idx].weapon of
      C_WPN_MACHINE : begin
        if players[idx].ammo_mg <= warning_ammo_mg then begin
          draw_table := true;
          c_ammo := players[idx].ammo_mg;
        end;
      end;
      C_WPN_SHOTGUN : begin
        if players[idx].ammo_sg <= warning_ammo_sg then begin
          draw_table := true;
          c_ammo := players[idx].ammo_sg;
        end;
      end;
      C_WPN_GRENADE : begin
        if players[idx].ammo_gl <= warning_ammo_gl then begin
          draw_table := true;
          c_ammo := players[idx].ammo_gl;
        end;
      end;
      C_WPN_ROCKET : begin
        if players[idx].ammo_rl <= warning_ammo_rl then begin
          draw_table := true;
          c_ammo := players[idx].ammo_rl;
        end;
      end;
      C_WPN_SHAFT : begin
        if players[idx].ammo_sh <= warning_ammo_sh then begin
          draw_table := true;
          c_ammo := players[idx].ammo_sh;
        end;
      end;
      C_WPN_RAIL : begin
        if players[idx].ammo_rg <= warning_ammo_rg then begin
          draw_table := true;
          c_ammo := players[idx].ammo_rg;
        end;
      end;
      C_WPN_PLASMA : begin
        if players[idx].ammo_pl <= warning_ammo_pl then begin
          draw_table := true;
          c_ammo := players[idx].ammo_pl;
        end;
      end;
      C_WPN_BFG : begin
        if players[idx].ammo_bfg <= warning_ammo_bfg then begin
          draw_table := true;
          c_ammo := players[idx].ammo_bfg;
        end;
      end;
    end;

    if not draw_table then exit;

    x := 0;
    if (players[idx].dir = DIR_LW) or (players[idx].dir = DIR_LS) then
        x := round(players[idx].x + 15);

    if (players[idx].dir = DIR_RW) or (players[idx].dir = DIR_RS) then
        x := round(players[idx].x - 15 - 70);

    y := round(players[idx].y - 47);

    w := strtoint(GetSystemVariable('bricks_x'))*32;
    h := strtoint(GetSystemVariable('bricks_y'))*16;

    if (x < 0) then x := 5;
    if (y < 0) then y := 5;
    if ((x + 70) > w) then x := w-75;
    if ((y + 20) > h) then y := h-25;

    FX_Rectangle(x, y, 70, 20, $99ffffff,$75000000,$102,true);

    if c_ammo > 0 then debug_textoutc(x + 10, y + 5, '^3^bLow ammo') else
       debug_textoutc(x + 10, y + 5, '^1^bNo ammo');
  end;
end.