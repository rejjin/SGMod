unit show_hp;

interface

uses register, defines, sysutils;

procedure ShowHP;

implementation

  procedure ShowHP;
  var
    i, x, y : integer;
    outs, c : shortstring;
  begin
    if (not is_show_hp) or (players[idx] = nil) then
      exit;

    // if (gametype <> 'TDM') and (gametype <> 'CTF') and (gametype <> 'DOM') then exit;

    for i := 0 to 7 do if players[i]<>nil then
    begin

    if (players[i].team <> players[idx].team) then
        continue;

      x := round(players[i].x - 24);
      y := round(players[i].y + 30);

      if (players[i].health > 80) then c:='^2' else
        if (players[i].health > 30) then c:='^3' else
          c:='^1';
      outs := c;

      if players[i].health < 0 then outs := outs + '0' else
        outs := outs + inttostr(players[i].health);

      outs := outs + ' ^7/ ';

      if (players[i].armor > 80) then c:='^2' else
        if (players[i].armor > 30) then c:='^3' else
          c:='^1';
      outs := outs + c;
      outs := outs + inttostr(players[i].armor);

      debug_textoutc(x, y, outs);
    end;

  end;

end.