unit defines;

interface

uses windows;

type tVector = record
  x, y : integer;
end;

type tMMapStruct = record
  offsetx, offsety : integer;
  map_w, map_h : integer;
  r : integer;
end;

const
  C_TEAMBLUE=0;
  C_TEAMRED=1;
  C_TEAMNON=2;
  
  C_WPN_GAUNTLET=0;
  C_WPN_MACHINE=1;
  C_WPN_SHOTGUN=2;
  C_WPN_GRENADE=3;
  C_WPN_ROCKET=4;
  C_WPN_SHAFT=5;
  C_WPN_RAIL=6;
  C_WPN_PLASMA=7;
  C_WPN_BFG=8;

  IT_NONE=0;
  IT_SHOTGUN=1;
  IT_GRENADE=2;
  IT_ROCKET=3;
  IT_SHAFT=4;
  IT_RAIL=5;
  IT_PLASMA=6;
  IT_BFG=7;
  IT_AMMO_MACHINEGUN=8;
  IT_AMMO_SHOTGUN=9;
  IT_AMMO_GRENADE=10;
  IT_AMMO_ROCKET=11;
  IT_AMMO_SHAFT=12;
  IT_AMMO_RAIL=13;
  IT_AMMO_PLASMA=14;
  IT_AMMO_BFG=15;
  IT_SHARD=16;
  IT_YELLOW_ARMOR=17;
  IT_RED_ARMOR=18;
  IT_HEALTH_5=19;
  IT_HEALTH_25=20;
  IT_HEALTH_50=21;
  IT_HEALTH_100=22;
  IT_POWERUP_REGENERATION=23;
  IT_POWERUP_BATTLESUIT=24;
  IT_POWERUP_HASTE=25;
  IT_POWERUP_QUAD=26;
  IT_POWERUP_FLIGHT=27;
  IT_POWERUP_INVISIBILITY=28;
  IT_TRIX_GRENADE=29;
  IT_TRIX_ROCKET=30;
  IT_LAVA=31;
  IT_WATER=32;
  IT_DEATH=33;
  IT_RESPAWN=34;
  IT_RED_RESPAWN=35;
  IT_BLUE_RESPAWN=36;
  IT_EMPTY=37;
  IT_JUMPPAD=38;
  IT_JUMPPAD2=39;
  IT_BLUE_FLAG=40;
  IT_RED_FLAG=41;
  IT_DOMINATION_FLAG=42;

  DIR_LW=0; // walkin left
  DIR_RW=1; // walkin right
  DIR_LS=2; // standin left
  DIR_RS=3; // standin right

  // Messages
  MESSAGE_RA=0;
  MESSAGE_YA=1;
  MESSAGE_H100=2;
  MESSAGE_QUAD=3;
  MESSAGE_REGENERATION=4;
  MESSAGE_HASTE=5;
  MESSAGE_FLIGHT=6;
  MESSAGE_BATTLESUIT=7;
  MESSAGE_RAIL=8;

  // Mini map
  MMAP_END=-1;
  MMAP_EMPTY=-2;
  
  // key bindings
  mButton1  : byte = 250;
  mButton2  : byte = 251;
  mButton3  : byte = 252;
  mScrollUp : byte = 253;
  mScrollDn : byte = 254;

  bmax=255;
  wmax=65535;
  
VAR
  idx : Integer;
  gametype : String;
  time_alarm_start : cardinal;

  warning_ammo_mg : byte;
  warning_ammo_sg : byte;
  warning_ammo_gl : byte;
  warning_ammo_rl : byte;
  warning_ammo_sh : byte;
  warning_ammo_rg : byte;
  warning_ammo_pl : byte;
  warning_ammo_bfg : byte;

  ampl_offsety : integer;
  ampl_offsety_vel : integer;
  draw_time : boolean;
  time_size : byte;
  time_color : byte;
  time_pos_x : integer;
  time_pos_y : integer;
  start_logo : byte;
  logo_x : integer;
  logo_center_wait : integer;
  logo_inertia_x : integer;
  logo_frame : integer;
  auto_messages : boolean;
  low_ammo_table : boolean;
  messages : array[0..8] of String;
  brks : array[0..62500] of tVector;
  brksSmall : array[0..62500] of tVector;
  VoteItems : array[0..21] of String;
  MMapStruct : tMMapStruct;
  MMapStructSmall : tMMapStruct;
  MMAP_BIND_KEY : integer;
  MMAP_OUT_BIND_KEY : integer;
  MMAP_IN_BIND_KEY : integer;
  mmap_in_bind_key_last_time : cardinal;
  mmap_out_bind_key_last_time : cardinal;
  VOTE_MENU_BIND_KEY : integer;
  vote_menu_showed : boolean;
  mmap_always_show : boolean;
  vote_menu_key_last_ticks : cardinal;
  current_menu_item : integer;
  vote_menu_key_up : integer;
  vote_menu_key_down : integer;
  vote_menu_key_up_last_ticks : cardinal;
  vote_menu_key_down_last_ticks : cardinal;
  max_menu_item : integer;
  is_show_hp : boolean;
  // Deg of messages:
  is_mouse_choise_started : boolean;
  mouse_choise_new_point : TPoint;
  mouse_choise_close_time : cardinal;
  mouse_choise_messages : array[0..7] of String;
  mouse_choise_vector_array : array[0..7] of tVector;
  mouse_choise_key : Integer;
  use_deg_of_messages : Boolean;
implementation

end.
