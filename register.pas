unit register;

interface
uses windows, classes;

type TPlayer = class
       dead: boolean;
       bot: boolean;
       refire,
       weapchg,
       weapon,
       threadweapon: byte;
       dir: byte;
       gantl_state: byte;
       air,
       team: byte;
       target: byte;               
       currentKeys: byte;          
       ThinkTime: byte;             
       health,armor,frags: integer;
       netname,                    
       nfkmodel: string[30];
       crouch,
       balloon,
       flagcarrier: boolean;
       Location: string[64]; 
       item_quad,item_regen,item_battle,item_flight,item_haste,item_invis: byte;
       have_rl,have_gl,have_rg,have_bfg,have_sg,have_mg,have_sh,have_pl: boolean;
       ammo_mg,ammo_sg,ammo_gl,ammo_rl,ammo_sh,ammo_rg,ammo_pl,ammo_bfg: byte;
       DXID: word;
       x,y,cx,cy,fangle: real;
       InertiaX,InertiaY: real;  
     end;

type TBrick = record
       image: byte;
       block: boolean;
       respawntime: integer;
       y: shortint;
       dir: byte;
       oy: real;
       respawnable: boolean;
       scale: byte;
     end;
pbrick = ^TBrick;

type TObj = record
       dead: byte;
       speed,fallt,weapon,doublejump,refire: byte;
       imageindex,dir,idd: byte;
       clippixel: smallint;
       spawnerDXID: word;
       frame: byte;
       health: smallint;
       x,y,cx,cy,fangle,fspeed: real;
       objname: string[30];
       DXID: word;
       mass,InertiaX,InertiaY: real;
     end;
      Pobj = ^TObj;

type TSpecObj = record
       active: boolean;
       x,y,lenght,dir,wait: word;
       targetname,target,orient,nowanim,special: word;
       objtype: byte;
     end;

type TPlayerEx = record
       dead,bot,crouch,balloon,flagcarrier,have_rl,have_gl,have_rg,have_bfg,have_sg,have_mg,have_sh,have_pl: boolean;
       refire,weapchg,weapon,threadweapon,dir,gantl_state,air,team,item_quad,item_regen,item_battle,item_flight,item_haste,item_invis,ammo_mg,ammo_sg,ammo_gl,ammo_rl,ammo_sh,ammo_rg,ammo_pl,ammo_bfg: byte;
       x,y,cx,cy,fangle,InertiaX,InertiaY: real;
       health,armor,frags: integer;
       netname,nfkmodel: string[30];
       Location: string[64];
       DXID: word;
     end;

type
  TCallProc_DLL_EVENT_ItemTaken = procedure ( brickx, bricky, image : byte; dxid : word );
  TCallProcSTR=function(text: shortstring): shortstring;
  TCallTextProc=procedure(text: shortstring);
  TCallProcCreatePlayer=function(name,model: shortstring;team: byte): word;
  TCallProcWordByteFunc=procedure(DXID: word;value: byte);
  TCallProcWordWordFunc=procedure(DXID: word;value: word);
  TCallProcWordWord_Bool=function(x,y: word): boolean;
  TCallProcWordWordString=procedure(x,y: word;text: shortstring);
  TCallProcBrickStruct=function(x,y: word): TBrick;
  TCallProcObjectsStruct=function(ID: word): TObj;
  TCallProcSpecailObjectsStruct=function(ID: byte): TSpecObj;
  TCallProcChat=procedure(DXID: word;text: shortstring;teamchat: boolean);
  TCallProcWord=procedure(par: WORD);
  TCallProcExtendedTextout=procedure(x,y: word;text: shortstring;font: byte;camera: boolean);
  TCallProcFX_FillRect=procedure(X,Y,Width,Height: Integer;Color: Cardinal;Effect: Integer;Camera: boolean);
  TCallProcFX_FillRectMap=procedure(X1,Y1,X2,Y2,X3,Y3,X4,Y4: Integer;Color: Cardinal;Effect: Integer;Camera: boolean);
  TCallProcFX_FillRectMapEx=procedure(X1,Y1,X2,Y2,X3,Y3,X4,Y4: Integer;C1,C2,C3,C4: Cardinal;Effect: Integer;Camera: boolean);
  TCallProcFX_Rectangle=procedure(X,Y,Width,Height: Integer;ColorLine,ColorFill: Cardinal;Effect: Integer;Camera: boolean);
  TCallProcFX_Line=procedure(X1,Y1,X2,Y2: Integer;Color: Cardinal;Effect: Integer;Camera: boolean);
  TCallProcKeyPressed=function(key: byte): boolean;
  TCallProcMouseDelta=function: TPoint;
  TCallProcPatch=procedure(DXID: word;hiparam: single;loparam: single);
VAR
  players: array[0..7] of TPlayer;
  sys_CreatePlayer: TCallProcCreatePlayer;
  SetKeys: TCallProcWordByteFunc;
  SetWeapon: TCallProcWordByteFunc;
  SetBalloon: TCallProcWordByteFunc;
  SendBotChat: TCallProcChat;
  SetAngle: TCallProcWordWordFunc;
	AddMessage: TCallTextProc;
	RegisterConsoleCommand: TCallTextProc;
	SendConsoleCommand: TCallTextProc;
	SendConsoleHCommand: TCallTextProc;
	GetSystemVariable: TCallProcSTR;
	Test_Blocked: TCallProcWordWord_Bool;
	debug_textout: TCallProcWordWordString;
	debug_textoutc: TCallProcWordWordString;
	GetBrickStruct: TCallProcBrickStruct;
	GetObjStruct: TCallProcObjectsStruct;
	GetSpecObjStruct: TCallProcSpecailObjectsStruct;
	ExtendedTextout: TCallProcExtendedTextout;
	RemoveBot: TCallProcWord;
	ModelList: TStringList;
	FX_FillRect: TCallProcFX_FillRect;
	FX_FillRectMap: TCallProcFX_FillRectMap;
	FX_FillRectMapEx: TCallProcFX_FillRectMapEx;
	FX_Rectangle: TCallProcFX_Rectangle;
	FX_Line: TCallProcFX_Line;
	KeyPressed: TCallProcKeyPressed;
	PatchBot: TCallProcPatch;
  MouseDelta: TCallProcMouseDelta;

procedure RemovePlayer(DXID: Word);

implementation

procedure RemovePlayer(DXID: Word);
var
  i: byte;
begin
  for i:=0 to 7 do if players[i]<>nil then if players[i].dxid=dxid then players[i]:=nil;
end;

end.
