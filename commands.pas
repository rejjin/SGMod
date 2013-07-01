unit commands;

interface

uses register, defines, utils, sysutils, configuration, console, auto_message,
  low_ammo_warning, mmap, vote_menu, show_hp, windows, deg_of_messages, time, logo;

procedure EVENT_BeginGame;
procedure EVENT_ResetGame;
procedure EVENT_MapChanged;
procedure EVENT_DMGReceived(TargetDXID,AttackerDXID: Word; dmg: word);
procedure EVENT_ChatReceived(DXID: Word; Text: shortstring);
procedure EVENT_ItemTaken(brickx, bricky, image : byte; dxid : word);
procedure MAIN_Loop;
procedure EVENT_GameEnd;
procedure DLL_CMD(s: string);
procedure CMD_Register;

implementation

procedure EVENT_BeginGame;
begin
  ReadVoteMenuItems;

  LoadMessages;
  LoadConfiguration;

  MMapCreate(0);
  MMapCreateSmall(0);

  LogoInit;
end;

procedure EVENT_ResetGame;
begin

end;

procedure EVENT_MapChanged;
begin
  MMapCreate(0);
  MMapCreateSmall(0);
end;

procedure EVENT_DMGReceived(TargetDXID,AttackerDXID: Word; dmg: word);
begin

end;

procedure EVENT_ChatReceived(DXID: Word; Text: shortstring);
begin

end;

procedure EVENT_ItemTaken(brickx, bricky, image : byte; dxid : word);
begin
  AutoMessageHandle(image, dxid);
  SetAmpl(image, dxid);
end;

procedure CMD_Register;
begin
  RegisterConsoleCommand('sg_auto_messages');
  RegisterConsoleCommand('sg_draw_time');
  RegisterConsoleCommand('sg_low_ammo_table');
  RegisterConsoleCommand('sg_show_hp');
  RegisterConsoleCommand('sg_mouse_messages');
  RegisterConsoleCommand('sg_bind_mmap');
  RegisterConsoleCommand('sg_bind_mmap_in');
  RegisterConsoleCommand('sg_bind_mmap_out');
  RegisterConsoleCommand('sg_bind_vote_menu');
  RegisterConsoleCommand('sg_bind_vote_menu_key_down');
  RegisterConsoleCommand('sg_bind_vote_menu_key_up');
  RegisterConsoleCommand('sg_bind_deg_of_messages');
  RegisterConsoleCommand('sg_mmap_always_show');
  RegisterConsoleCommand('sg_low_ammo_mg');
  RegisterConsoleCommand('sg_low_ammo_sg');
  RegisterConsoleCommand('sg_low_ammo_gl');
  RegisterConsoleCommand('sg_low_ammo_rl');
  RegisterConsoleCommand('sg_low_ammo_sh');
  RegisterConsoleCommand('sg_low_ammo_rg');
  RegisterConsoleCommand('sg_low_ammo_pl');
  RegisterConsoleCommand('sg_low_ammo_bfg');
  RegisterConsoleCommand('sg_time_size');
  RegisterConsoleCommand('sg_time_color');
  RegisterConsoleCommand('sg_time_pos_x');
  RegisterConsoleCommand('sg_time_pos_y');


end;

procedure DLL_CMD(s: string);
begin
  try
    ParseCommands(s);
  except
    AddMessage('^1SGMOD:^7 Invalid value.');
  end;
end;

procedure MAIN_Loop;
var
  i : Integer;
begin

  idx := -1;
  for i := 0 to 7 do if players[i]<>nil then
    if (players[i].dxid = strtoint(GetSystemVariable('localdxid'))) then
  begin
    idx := i;
    break;
  end;

  gametype := GetSystemVariable('gametype');

  LogoStart;
  ShowHP;
  DrawTime;
  LowAmmoWarning;

  MMapShow;
  MMapIn;
  MMapOut;

  ShowVoteMenuKey;
  CreateVoteMenu;
  VoteMenuKeys;

  if use_deg_of_messages then StartMouseChoise;
end;

procedure EVENT_GameEnd;
begin

end;

end.
