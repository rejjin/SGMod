unit mmap;

interface

uses register, defines, sysutils, windows, utils, configuration;

procedure MMapCreate(mr : integer);
procedure MMapCreateSmall(mr : integer);
procedure MMapDraw;
procedure MMapDrawPlayers;
procedure MMapShow;
procedure MMapIn;
procedure MMapOut;
procedure MMapDrawAlways;
procedure MMapDrawSmallPlayers;

implementation

  procedure MMapIn;
  begin
    if (MMAP_OUT_BIND_KEY <> 0) and KeyPressed(MMAP_OUT_BIND_KEY) then
    begin
      if GetTickCount > (mmap_out_bind_key_last_time + 500) then begin
        if (MMapStruct.r >= 4) then MMapCreate(trunc(MMapStruct.r / 2));
        mmap_out_bind_key_last_time := GetTickCount;
      end;
    end;
  end;

  procedure MMapOut;
  begin
    if (MMAP_IN_BIND_KEY <> 0) and KeyPressed(MMAP_IN_BIND_KEY) then
    begin
      if GetTickCount > (mmap_in_bind_key_last_time + 500) then begin
        if (MMapStruct.r < 16) then MMapCreate(trunc(MMapStruct.r * 2));
        mmap_in_bind_key_last_time := GetTickCount;
      end;
    end;
  end;

  procedure MMapShow;
  begin
    if players[idx] = nil then exit;
    if players[idx].balloon then exit;
    
    if (MMAP_BIND_KEY <> 0) and KeyPressed(MMAP_BIND_KEY) then
      MMapDraw;

    if mmap_always_show then
      MMapDrawAlways;
  end;

  procedure MMapCreate(mr : integer);
  var
    i, r, x, y: integer;
    Tb : TBrick;
  begin
    i := 0;

    for r := 0 to 62500 do begin
      brks[r].x := MMAP_EMPTY;
      brks[r].y := MMAP_EMPTY;
    end;

    MMapStruct.map_w := strtoint(GetSystemVariable('bricks_x'));
    MMapStruct.map_h := strtoint(GetSystemVariable('bricks_y'));

    if (mr = 0) then MMapStruct.r := 2 else MMapStruct.r := mr;

    MMapStruct.offsetx := round(640 / 2 - round(MMapStruct.map_w * 32 / MMapStruct.r) / 2);
    MMapStruct.offsety := round(480 / 2 - round(MMapStruct.map_h * 16 / MMapStruct.r) / 2);

    for x := 0 to MMapStruct.map_w do
      for y := 0 to MMapStruct.map_h do
    begin
      Tb := GetBrickStruct(x, y);

      if (Tb.image >= 54) and (Tb.image <= 254) then
      begin
        brks[i].x := round(x * 32 / MMapStruct.r);
        brks[i].y := round(y * 16 / MMapStruct.r);
        i := i + 1;
      end;
    end;

    brks[i].x := MMAP_END;
    brks[i].y := MMAP_END;
  end;

  procedure MMapCreateSmall(mr : integer);
  var
    x, y, i : Integer;
    Tb : TBrick;
  begin

    MMapStructSmall.map_w := strtoint(GetSystemVariable('bricks_x'));
    MMapStructSmall.map_h := strtoint(GetSystemVariable('bricks_y'));

    if (mr = 0) then MMapStructSmall.r := 8 else MMapStructSmall.r := mr;

    MMapStructSmall.offsetx := round(640 - (MMapStructSmall.map_w * 32 / MMapStructSmall.r) - 10);
    MMapStructSmall.offsety := 10;

    i := 0;
    for x := 0 to MMapStructSmall.map_w do
      for y := 0 to MMapStructSmall.map_h do
    begin
      Tb := GetBrickStruct(x, y);

      if (Tb.image >= 54) and (Tb.image <= 254) then
      begin
        brksSmall[i].x := round(x * 32 / MMapStructSmall.r);
        brksSmall[i].y := round(y * 16 / MMapStructSmall.r);
        i := i + 1;
      end;
    end;

    brksSmall[i].x := MMAP_END;
    brksSmall[i].y := MMAP_END;
  end;

  procedure MMapDrawAlways;
  var
    i : integer;
  begin
     i := 0;

    FX_Rectangle(
      MMapStructSmall.offsetx,
      MMapStructSmall.offsety,
      round(MMapStructSmall.map_w * 32 / MMapStructSmall.r) + 2,
      round(MMapStructSmall.map_h * 16 / MMapStructSmall.r) + 2,
      $88ffffff,
      $99000000,
      $102,
      false);

    while (brksSmall[i].x <> MMAP_END) and (brksSmall[i].y <> MMAP_END) do
    begin
      if (brksSmall[i].x = MMAP_EMPTY) or (brksSmall[i].y = MMAP_EMPTY) then begin
        i := i + 1;
        continue;
      end;

      if (brksSmall[i].x + round(32/MMapStructSmall.r/2) > round(MMapStructSmall.map_w*32/MMapStructSmall.r)) or
        (brksSmall[i].y + round(16/MMapStructSmall.r/2) > round(MMapStructSmall.map_h*16/MMapStructSmall.r)) then
      begin
        i := i + 1;
        continue;
      end;

      FX_FillRect(
        MMapStructSmall.offsetx + brksSmall[i].x + 1,
        MMapStructSmall.offsety + brksSmall[i].y + 1,
        round(32/MMapStructSmall.r),
        round(16/MMapStructSmall.r),
        $88405050,
        $102,
        false);

      i := i + 1;
    end;

    MMapDrawSmallPlayers;
  end;

  procedure MMapDraw;
  var
    i : integer;
  begin
    i := 0;

    if (MMapStruct.offsetx < 0) or (MMapStruct.offsety < 0) then
    begin
      if (MMapStruct.r > 16) then begin
        debug_textout(2, 40, '^1Too large map!');
        exit;
      end;
      MMapStruct.r := MMapStruct.r * 2;
      MMapCreate(MMapStruct.r);
    end;

    FX_Rectangle(
      MMapStruct.offsetx,
      MMapStruct.offsety,
      round(MMapStruct.map_w * 32 / MMapStruct.r) + 2,
      round(MMapStruct.map_h * 16 / MMapStruct.r) + 2,
      $99304040,
      $99000000,
      $102,
      false);

    while (brks[i].x <> MMAP_END) and (brks[i].y <> MMAP_END) do
    begin
      if (brks[i].x = MMAP_EMPTY) or (brks[i].y = MMAP_EMPTY) then begin
        i := i + 1;
        continue;
      end;

      if (brks[i].x + round(32/MMapStruct.r/2) > round(MMapStruct.map_w*32/MMapStruct.r)) or
        (brks[i].y + round(16/MMapStruct.r/2) > round(MMapStruct.map_h*16/MMapStruct.r)) then
      begin
        i := i + 1;
        continue;
      end;

      FX_FillRect(
        MMapStruct.offsetx + brks[i].x + 1,
        MMapStruct.offsety + brks[i].y + 1,
        round(32/MMapStruct.r),
        round(16/MMapStruct.r),
        $FF304040,
        $102,
        false);

      i := i + 1;
    end;

    MMapDrawPlayers;

  end;

  procedure MMapDrawPlayers;
  var
    i, s, d : Integer;
    gametype : shortstring;
    color : Cardinal;
  begin


    if (players[idx] = nil) then exit;

    gametype := GetSystemVariable('gametype');

    if (gametype='CTF')or(gametype='DOM')or(gametype='TDM') then
    begin
      for i := 0 to 7 do if players[i] <> nil then
      begin
        if (players[i].team <> players[idx].team) then continue;
        if (players[i].dead) then continue;
          s := 3;
          if (players[i].crouch) then s := 2;
          color := $FFFFFFFF;
          if (players[i].team = C_TEAMBLUE) then color := $FFFF0000;
          if (players[i].team = C_TEAMRED) then color := $FF0000FF;
          d := 0;
          if (s = 2) then d := 16;
          FX_FillRect(
            MMapStruct.offsetx + trunc(players[i].x / MMapStruct.r) - 2,
            MMapStruct.offsety + trunc((players[i].y - 24 + d) / MMapStruct.r) + 1,
            round(32 / MMapStruct.r / 2),
            round(16 / MMapStruct.r * s),
            color,
            $102,
            false);
      end;
    end else begin
      s := 3;
      if (players[idx].crouch) then s := 2;
      d := 0;
      if (s = 2) then d := 16;
      FX_FillRect(
          MMapStruct.offsetx + trunc(players[idx].x / MMapStruct.r) - 2,
          MMapStruct.offsety + trunc((players[idx].y - 24 + d) / MMapStruct.r) + 1,
          round(32 / MMapStruct.r / 2),
          round(16 / MMapStruct.r * s),
          $FFFFFFFF,
          $102,
          false);
    end;
  end;

  procedure MMapDrawSmallPlayers;
    var
    i, s, d : Integer;
    gametype : shortstring;
    color : Cardinal;
  begin
    if (players[idx] = nil) then exit;

    gametype := GetSystemVariable('gametype');

    i := 0;
    if (gametype='CTF')or(gametype='DOM')or(gametype='TDM') then
    begin
      for i := 0 to 7 do if players[i] <> nil then
      begin
        if (players[i].team <> players[idx].team) then continue;
        if (players[i].dead) then continue;
          s := 3;
          if (players[i].crouch) then s := 2;
          color := $FFFFFFFF;
          if (players[i].team = C_TEAMBLUE) then color := $FFFF0000;
          if (players[i].team = C_TEAMRED) then color := $FF0000FF;
          d := 0;
          if (s = 2) then d := 16;
          FX_FillRect(
            MMapStructSmall.offsetx + trunc(players[i].x / MMapStructSmall.r + 2),
            MMapStructSmall.offsety + trunc((players[i].y - 24 + d) / MMapStructSmall.r) + 1,
            round(32 / MMapStructSmall.r / 2),
            round(16 / MMapStructSmall.r * s),
            color,
            $102,
            false);
      end;
    end else begin
      s := 3;
      if (players[idx].crouch) then s := 2;
      d := 0;
      if (s = 2) then d := 16;
      FX_FillRect(
          MMapStructSmall.offsetx + trunc(players[i].x / MMapStructSmall.r + 2),
          MMapStructSmall.offsety + trunc((players[idx].y - 24 + d) / MMapStructSmall.r) + 1,
          round(32 / MMapStructSmall.r / 2),
          round(16 / MMapStructSmall.r * s),
          $FFFFFFFF,
          $102,
          false);
    end;
  end;
end.
