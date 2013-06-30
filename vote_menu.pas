unit vote_menu;

interface

uses register, defines, sysutils, windows, utils;

procedure CreateVoteMenu;
procedure ShowVoteMenuKey;
procedure CreateDefaultVoteMenuItems;
procedure ReadVoteMenuItems;
procedure VoteMenuKeys;

implementation
  procedure ShowVoteMenuKey;
  begin
    if players[idx] = nil then exit;
    if players[idx].balloon then exit;
    if (VOTE_MENU_BIND_KEY <> 0) and KeyPressed(VOTE_MENU_BIND_KEY) then
      begin
        if GetTickCount > (vote_menu_key_last_ticks + 200) then begin
          if vote_menu_showed then
          begin
            vote_menu_showed := false;
            if (current_menu_item = 0) then begin
              vote_menu_key_last_ticks := GetTickCount;
              exit;
            end else SendConsoleHCommand(VoteItems[current_menu_item]);
          end else begin
            vote_menu_showed := true;
            current_menu_item := 0;
          end;
          vote_menu_key_last_ticks := GetTickCount;
        end;
      end;
  end;

  procedure VoteMenuKeys;
  var
    i : Integer;
  begin
    i := 0;
    
    if (vote_menu_key_up <> 0) and KeyPressed(vote_menu_key_up) then
        if GetTickCount > (vote_menu_key_up_last_ticks + 100) then begin
        if current_menu_item = 0 then current_menu_item := max_menu_item else begin
          i := current_menu_item-1;
          while (i >= 0) do begin
            if (VoteItems[i] <> '-') then begin
              current_menu_item := i;
              break;
            end;
            i := i-1;
          end;
        end;
        vote_menu_key_up_last_ticks := GetTickCount;
    end;

    if (vote_menu_key_down <> 0) and KeyPressed(vote_menu_key_down) then
        if GetTickCount > (vote_menu_key_down_last_ticks + 100) then begin
        if current_menu_item = max_menu_item then current_menu_item := 0 else
          i := current_menu_item+1;
          while (i <= max_menu_item) do begin
            if (VoteItems[i] <> '-') then begin
              current_menu_item := i;
              break;
            end;
            i := i+1;
          end;
        vote_menu_key_down_last_ticks := GetTickCount;
    end;
  end;

  procedure CreateVoteMenu;
  var
    i, mlen, x, y, w, h: integer;
  begin
    if not vote_menu_showed then exit;

    mlen := 0;
    for i := 0 to 20 do if length(VoteItems[i]) > mlen then
      mlen := length(VoteItems[i]);

    if mlen = 0 then exit;

    for i := 0 to 21 do begin
      if length(VoteItems[i]) = 0 then break;
      max_menu_item := i;
    end;

    w := 0;
    for i := 0 to max_menu_item do begin
      if w < FontMetrics('[ ' + VoteItems[i] + ' ]') then
        w := FontMetrics('[ ' + VoteItems[i] + ' ]');
    end;

    x := round(640/2-w/2);
    h := 40 + max_menu_item * 15;
    y := round(480 / 2 - h / 2);

    FX_Rectangle(x-10, y, w+10, h, $ffffffff,$99000000, $102, false);

    VoteItems[0] := '<-- Back';
    VoteItems[1] := '-';

    for i := 0 to max_menu_item do begin
      if (VoteItems[i] <> '-') then
      begin
        if current_menu_item = i then
          debug_textout(x+10, 10+y+i*15, '^1[ ^4' + VoteItems[i] + ' ^1]') else
            debug_textout(x+10, 10+y+i*15, '^3' + VoteItems[i]);
      end;

    end;

  end;

  procedure CreateDefaultVoteMenuItems;
  var
    F : TextFile;
  begin
    AssignFile(F,GetSystemVariable('gamedir')+ '\' + 'menu-commands.txt');
    rewrite(f);

    writeln(f,'callvote map pro-dm0 dm');
    writeln(f,'callvote map dm2 dm');
    writeln(f,'callvote map tourney4 dm');
    writeln(f,'callvote map ctf2 ctf');
    writeln(f,'callvote map zef1 ctf');
    writeln(f,'callvote map nfk-dm6-9 tdm');
    writeln(f,'callvote map tdm1 tdm');
    writeln(f,'callvote map zuu4a tdm');
    writeln(f,'-');
    writeln(f,'callvote sv_maxplayers 2');
    writeln(f,'callvote sv_maxplayers 4');
    writeln(f,'callvote sv_maxplayers 8');
    writeln(f,'-');
    writeln(f,'callvote restart');
    writeln(f,'callvote ready');
    writeln(f,'-');
    writeln(f,'reconnect');

    CloseFile(F);
    AddMessage('^1SGMOD:^7 Create default vote menu items file.');
  end;

  procedure ReadVoteMenuItems;
  var
    F: TextFile;
    i: integer;
  begin
    if not FileExists(GetSystemVariable('gamedir') + '\' + 'menu-commands.txt') then
      CreateDefaultVoteMenuItems;

    AssignFile(F,GetSystemVariable('gamedir')+ '\' + 'menu-commands.txt');
    Reset(F);

    for i := 2 to 21 do Readln(F, VoteItems[i]);

    CloseFile(F);
  end;

end.