library sgmod;

uses
  sysutils,
	defines in 'defines.pas',
	register in 'register.pas',
	commands in 'commands.pas',
  console in 'console.pas',
  auto_message in 'auto_message.pas',
  mmap in 'mmap.pas',
  low_ammo_warning in 'low_ammo_warning.pas',
  vote_menu in 'vote_menu.pas',
  show_hp in 'show_hp.pas',
  deg_of_messages in 'deg_of_messages.pas',
  logo in 'logo.pas',
  utils in 'utils.pas';
  
procedure DLL_RegisterProc1(AProc: TCallProcWordWordFunc);
begin
  SetAngle:=AProc;
end;

procedure DLL_RegisterProc2(AProc: TCallTextProc; ProcID: byte);
begin
  case ProcID of
    1: AddMessage:=AProc;
    2: RegisterConsoleCommand:=AProc;
    3: SendConsoleCommand:=AProc;
    4: SendConsoleHCommand:=AProc;
  end;
end;

procedure DLL_RegisterProc3(AProc: TCallProcSTR; ProcID: byte);
begin
  case ProcID of
    1: GetSystemVariable:=AProc;
  end;
end;


procedure DLL_RegisterProc4(AProc: TCallProcCreatePlayer; ProcID: byte);
begin
  sys_CreatePlayer:=AProc;
end;

procedure DLL_RegisterProc5(AProc: TCallProcWordByteFunc; ProcID: byte);
begin
  case ProcID of
    1: SetKeys:=AProc;
    3: SetWeapon:=AProc;
    4: SetBalloon:=AProc;
  end;
end;

procedure DLL_RegisterProc6(AProc: TCallProcWordWord_Bool; ProcID: byte);
begin
  case ProcID of
    1: Test_Blocked:=AProc;
  end;
end;

procedure DLL_RegisterProc7(AProc: TCallProcWordWordString; ProcID: byte);
begin
  case ProcID of
    1: debug_textout:=AProc;
    2: debug_textoutc:=AProc;
  end;
end;

procedure DLL_RegisterProc8(AProc: TCallProcBrickStruct);
begin
  GetBrickStruct:=AProc;
end;

procedure DLL_RegisterProc9(AProc: TCallProcObjectsStruct);
begin
  GetObjStruct:=AProc;
end;

procedure DLL_RegisterProc10(AProc: TCallProcSpecailObjectsStruct);
begin
  GetSpecObjStruct:=AProc;
end;

procedure DLL_RegisterProc11(AProc: TCallProcWord);
begin
  RemoveBot:=AProc;
end;

procedure DLL_RegisterProc12(AProc: TCallProcChat);
begin
  SendBotChat:=AProc;
end;

procedure DLL_RegisterProc13(AProc: TCallProcExtendedTextout);
begin
  ExtendedTextout:=AProc;
end;

procedure DLL_MainLoop();
begin
  MAIN_Loop;
end;

procedure DLL_EVENT_BeginGame;
begin
  CMD_Register;
  EVENT_BeginGame;
end;

procedure DLL_EVENT_MapChanged;
begin
  EVENT_MapChanged;
end;

procedure DLL_EVENT_ResetGame;
begin
  EVENT_ResetGame;
end;

function DLL_QUERY_VERSION: shortstring;
begin
  AddMessage('^1SGMOD:^7 Shadow Gamers mod loaded.');
  result := '';
end;

procedure DLL_SYSTEM_AddPlayer(Player: TPlayerEx);
var
  i: byte;
begin
  for i:=0 to 7 do if players[i]=nil then
    begin
      players[i] := Tplayer.Create;
      players[i].DXID := Player.DXID;
      players[i].netname := player.netname;
      players[i].bot := player.bot;
      exit;
    end;
end;

procedure DLL_EVENT_ItemTaken ( brickx, bricky, image : byte; dxid : word );
begin
  EVENT_ItemTaken(brickx, bricky, image, dxid);
end;

procedure DLL_SYSTEM_RemoveAllPlayers();
var
  i: byte;
begin
  for i:=0 to high(Players) do if players[i]<>nil then players[i]:=nil;
end;

procedure DLL_SYSTEM_RemovePlayer(DXID: word);
begin
  RemovePlayer(DXID);
end;

procedure DLL_DMGReceived(TargetDXID,AttackerDXID: Word; dmg: word);
begin
  EVENT_DMGReceived(TargetDXID,AttackerDXID,dmg);
end;

procedure DLL_ChatReceived(DXID: Word; Text: shortstring);
begin
  EVENT_ChatReceived(DXID,Text);
end;

procedure DLL_AddModel(s: shortstring);
begin

end;

procedure DLL_SYSTEM_UpdatePlayer(Player: TPlayerEx);
var
  i: byte;
begin
  for i:=0 to 7 do if players[i]<>nil then if players[i].DXID=Player.DXID then with players[i] do
    begin
      dead:=player.dead;
      bot:=player.bot;
      refire:=player.refire;
      weapchg:=player.weapchg;
      weapon:=player.weapon;
      threadweapon:=player.threadweapon;
      dir:=player.dir;
      gantl_state:=player.gantl_state;
      air:=player.air;
      team:=player.team;
      health:=player.health;
      armor:=player.armor;
      frags:=player.frags;
      netname:=player.netname;
      nfkmodel:=player.nfkmodel;
      crouch:=player.crouch;
      balloon:=player.balloon;
      flagcarrier:=player.flagcarrier;
      Location:=player.Location;
      item_quad:=player.item_quad;
      item_regen:=player.item_regen;
      item_battle:=player.item_battle;
      item_flight:=player.item_flight;
      item_haste:=player.item_haste;
      item_invis:=player.item_invis;
      have_rl:=player.have_rl;
      have_gl:=player.have_gl;
      have_rg:=player.have_rg;
      have_bfg:=player.have_bfg;
      have_sg:=player.have_sg;
      have_sh:=player.have_sh;
      have_mg:=player.have_mg;
      have_pl:=player.have_pl;
      ammo_mg:=player.ammo_mg;
      ammo_sg:=player.ammo_sg;
      ammo_gl:=player.ammo_gl;
      ammo_rl:=player.ammo_rl;
      ammo_sh:=player.ammo_sh;
      ammo_rg:=player.ammo_rg;
      ammo_pl:=player.ammo_pl;
      ammo_bfg:=player.ammo_bfg;
      x:=player.x;
      y:=player.y;
      cx:=player.cx;
      cy:=player.cy;
      InertiaX:=player.InertiaX;
      InertiaY:=player.InertiaY;
      if not bot then fangle:=player.fangle;
      exit;
    end;
end;

procedure DLL_RegisterProcFX_FillRect(AProc: TCallProcFX_FillRect);
begin
  FX_FillRect:=AProc;
end;

procedure DLL_RegisterProcFX_FillRectMap(AProc: TCallProcFX_FillRectMap);
begin
  FX_FillRectMap:=AProc;
end;

procedure DLL_RegisterProcFX_FillRectMapEx(AProc: TCallProcFX_FillRectMapEx);
begin
  FX_FillRectMapEx:=AProc;
end;

procedure DLL_RegisterProcFX_Rectangle(AProc: TCallProcFX_Rectangle);
begin
  FX_Rectangle:=AProc;
end;

procedure DLL_RegisterProcFX_Line(AProc: TCallProcFX_Line);
begin
  FX_Line:=AProc;
end;

procedure DLL_RegisterKeyPressed(AProc: TCallProcKeyPressed);
begin
  KeyPressed:=AProc;
end;

procedure DLL_RegisterMouseDelta(AProc: TCallProcMouseDelta);
begin
  MouseDelta:=AProc;
end;

procedure DLL_RegisterProcPatch(AProc: TCallProcPatch);
begin
  PatchBot:=AProc;
end;

exports
  DLL_RegisterProc1,DLL_RegisterProc2,DLL_RegisterProc3,DLL_RegisterProc4,DLL_RegisterProc5,
  DLL_RegisterProc6,DLL_RegisterProc7,DLL_RegisterProc8,DLL_RegisterProc9,DLL_RegisterProc10,
  DLL_RegisterProc11,DLL_RegisterProc12,DLL_RegisterProc13,
  DLL_EVENT_BeginGame,DLL_EVENT_ResetGame,DLL_EVENT_MapChanged,
  DLL_MainLoop,DLL_SYSTEM_UpdatePlayer,DLL_SYSTEM_AddPlayer,
  DLL_SYSTEM_RemoveAllPlayers,DLL_SYSTEM_RemovePlayer,DLL_AddModel,
  DLL_DMGReceived,DLL_ChatReceived,DLL_CMD,DLL_QUERY_VERSION,
  DLL_RegisterProcFX_FillRect,DLL_RegisterProcFX_FillRectMap,
  DLL_RegisterProcFX_FillRectMapEx,DLL_RegisterProcFX_Rectangle,DLL_RegisterProcFX_Line,
  DLL_RegisterKeyPressed,DLL_RegisterMouseDelta,DLL_RegisterProcPatch, DLL_EVENT_ItemTaken;

begin

end.