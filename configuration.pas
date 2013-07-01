unit configuration;

interface

uses register, defines, utils, sysutils, inifiles;

procedure LoadConfiguration;
procedure CreateConfigFile;
procedure SaveConfiguration;

implementation

  procedure LoadConfiguration;
  var
  IniFile : TIniFile;
  Str : ShortString;
  begin
    if not FileExists(GetSystemVariable('gamedir') + '\' + 'sgmod.txt') then
      CreateConfigFile;

    IniFile := TIniFile.Create(GetSystemVariable('gamedir') + '\' + 'sgmod.txt');
    with IniFile do
    begin
      // Default configuration
      Str := IniFile.ReadString('SGMOD','sg_draw_time','yes');
      if (Str = 'yes') then draw_time := true else
        if (Str = 'no') then draw_time := false;

      Str := IniFile.ReadString('SGMOD','sg_auto_messages','yes');
      if (Str = 'yes') then auto_messages := true else
        if (Str = 'no') then auto_messages := false;

      Str := IniFile.ReadString('SGMOD','sg_low_ammo_table','yes');
      if (Str = 'yes') then low_ammo_table := true else
        if (Str = 'no') then low_ammo_table := false;

      Str := IniFile.ReadString('SGMOD','sg_show_hp','yes');
      if (Str = 'yes') then is_show_hp := true else
        if (Str = 'no') then is_show_hp := false;

      Str := IniFile.ReadString('SGMOD','sg_mouse_messages','yes');
      if (Str = 'yes') then use_deg_of_messages := true else
        if (Str = 'no') then use_deg_of_messages := false;

      Str := IniFile.ReadString('SGMOD','sg_mmap_always_show','no');
      if (Str = 'yes') then mmap_always_show := true else
        if (Str = 'no') then mmap_always_show := false;

      // Binds
      MMAP_BIND_KEY := strtoint(IniFile.ReadString('BINDS','mmap_bind','0'));
      MMAP_IN_BIND_KEY := strtoint(IniFile.ReadString('BINDS','mmap_in_bind','0'));
      MMAP_OUT_BIND_KEY := strtoint(IniFile.ReadString('BINDS','mmap_out_bind','0'));
      VOTE_MENU_BIND_KEY := strtoint(IniFile.ReadString('BINDS','vote_menu_bind','0'));
      vote_menu_key_up := strtoint(IniFile.ReadString('BINDS','vote_menu_key_up_bind','0'));
      vote_menu_key_down := strtoint(IniFile.ReadString('BINDS','vote_menu_key_down_bind','0'));
      mouse_choise_key := strtoint(IniFile.ReadString('BINDS','mouse_choise_key','0'));

      // Ammo warning
      warning_ammo_mg := strtoint(IniFile.ReadString('AMMO_WARNING','mg', '20'));
      warning_ammo_sg := strtoint(IniFile.ReadString('AMMO_WARNING','sg','2'));
      warning_ammo_gl := strtoint(IniFile.ReadString('AMMO_WARNING','gl','2'));
      warning_ammo_rl := strtoint(IniFile.ReadString('AMMO_WARNING','rl','2'));
      warning_ammo_sh := strtoint(IniFile.ReadString('AMMO_WARNING','sh','30'));
      warning_ammo_rg := strtoint(IniFile.ReadString('AMMO_WARNING','rg','2'));
      warning_ammo_pl := strtoint(IniFile.ReadString('AMMO_WARNING','pl','15'));
      warning_ammo_bfg := strtoint(IniFile.ReadString('AMMO_WARNING','bfg','2'));

      // Time
      time_size := strtoint(IniFile.ReadString('TIME','SIZE', '3'));
      time_color := strtoint(IniFile.ReadString('TIME','COLOR','3'));
      time_pos_x := strtoint(IniFile.ReadString('TIME','POS_X','10'));
      time_pos_y := strtoint(IniFile.ReadString('TIME','POS_Y','450'));

      // Messages:
      Str := IniFile.ReadString('MESSAGES','YA','TESTYA');
      messages[MESSAGE_YA] := Str;

      Str := IniFile.ReadString('MESSAGES','RA','');
      messages[MESSAGE_RA] := Str;

      Str := IniFile.ReadString('MESSAGES','H100','');
      messages[MESSAGE_H100] := Str;

      Str := IniFile.ReadString('MESSAGES','QUAD','');
      messages[MESSAGE_QUAD] := Str;

      Str := IniFile.ReadString('MESSAGES','REGENERATION','');
      messages[MESSAGE_REGENERATION] := Str;

      Str := IniFile.ReadString('MESSAGES','HASTE','');
      messages[MESSAGE_HASTE] := Str;

      Str := IniFile.ReadString('MESSAGES','FLIGHT','');
      messages[MESSAGE_FLIGHT] := Str;

      Str := IniFile.ReadString('MESSAGES','BATTLESUIT','');
      messages[MESSAGE_BATTLESUIT] := Str;

      Str := IniFile.ReadString('MESSAGES','RAIL','');
      messages[MESSAGE_RAIL] := Str;
    end;                

    IniFile.Free;
  end;

  procedure SaveConfiguration;
  var
    IniFile: TIniFile;
  begin
    IniFile:=TIniFile.Create(GetSystemVariable('gamedir') + '\' + 'sgmod.txt');

    with IniFile do
    begin
      if auto_messages then IniFile.WriteString('SGMOD','sg_auto_messages', 'yes') else
        IniFile.WriteString('SGMOD','sg_auto_messages', 'no');

      if draw_time then IniFile.WriteString('SGMOD','sg_draw_time', 'yes') else
        IniFile.WriteString('SGMOD','sg_draw_time', 'no');

      if low_ammo_table then IniFile.WriteString('SGMOD','sg_low_ammo_table', 'yes') else
        IniFile.WriteString('SGMOD','sg_low_ammo_table', 'no');

      if is_show_hp then IniFile.WriteString('SGMOD','sg_show_hp', 'yes') else
        IniFile.WriteString('SGMOD','sg_show_hp', 'no');

      if use_deg_of_messages then IniFile.WriteString('SGMOD','sg_mouse_messages', 'yes') else
        IniFile.WriteString('SGMOD','sg_mouse_messages', 'no');

      if mmap_always_show then IniFile.WriteString('SGMOD','sg_mmap_always_show', 'yes') else
        IniFile.WriteString('SGMOD','sg_mmap_always_show', 'no');

      // Binds
      IniFile.WriteString('BINDS','mmap_bind', inttostr(MMAP_BIND_KEY));
      IniFile.WriteString('BINDS','mmap_in_bind', inttostr(MMAP_IN_BIND_KEY));
      IniFile.WriteString('BINDS','mmap_out_bind', inttostr(MMAP_OUT_BIND_KEY));
      IniFile.WriteString('BINDS','vote_menu_bind', inttostr(VOTE_MENU_BIND_KEY));
      IniFile.WriteString('BINDS','vote_menu_key_up_bind', inttostr(vote_menu_key_up));
      IniFile.WriteString('BINDS','vote_menu_key_down_bind', inttostr(vote_menu_key_down));
      IniFile.WriteString('BINDS','mouse_choise_key', inttostr(mouse_choise_key));

      // Ammo warning
      IniFile.WriteString('AMMO_WARNING','mg', inttostr(warning_ammo_mg));
      IniFile.WriteString('AMMO_WARNING','sg', inttostr(warning_ammo_sg));
      IniFile.WriteString('AMMO_WARNING','gl', inttostr(warning_ammo_gl));
      IniFile.WriteString('AMMO_WARNING','rl', inttostr(warning_ammo_rl));
      IniFile.WriteString('AMMO_WARNING','sh', inttostr(warning_ammo_sh));
      IniFile.WriteString('AMMO_WARNING','rg', inttostr(warning_ammo_rg));
      IniFile.WriteString('AMMO_WARNING','pl', inttostr(warning_ammo_pl));
      IniFile.WriteString('AMMO_WARNING','bfg', inttostr(warning_ammo_bfg));

      // Time
      IniFile.WriteString('TIME','SIZE', inttostr(time_size));
      IniFile.WriteString('TIME','COLOR', inttostr(time_color));
      IniFile.WriteString('TIME','POS_X', inttostr(time_pos_x));
      IniFile.WriteString('TIME','POS_Y', inttostr(time_pos_y));

      // Messages
      IniFile.WriteString('MESSAGES','YA', messages[MESSAGE_YA]);
      IniFile.WriteString('MESSAGES','RA', messages[MESSAGE_RA]);
      IniFile.WriteString('MESSAGES','H100', messages[MESSAGE_H100]);
      IniFile.WriteString('MESSAGES','QUAD', messages[MESSAGE_QUAD]);
      IniFile.WriteString('MESSAGES','REGENERATION', messages[MESSAGE_REGENERATION]);
      IniFile.WriteString('MESSAGES','HASTE', messages[MESSAGE_HASTE]);
      IniFile.WriteString('MESSAGES','FLIGHT', messages[MESSAGE_FLIGHT]);
      IniFile.WriteString('MESSAGES','BATTLESUIT', messages[MESSAGE_BATTLESUIT]);
      IniFile.WriteString('MESSAGES','RAIL', messages[MESSAGE_RAIL]);
    end;

    IniFile.Free;
  end;

  procedure CreateConfigFile;
  var
    F : TextFile;
  begin
    AssignFile(F,GetSystemVariable('gamedir')+ '\' + 'sgmod.txt');
    rewrite(f);

    writeln(f,'[SGMOD]');
    writeln(f,'sg_auto_messages=yes');
    writeln(f,'sg_draw_time=yes');
    writeln(f,'sg_low_ammo_table=yes');
    writeln(f,'sg_show_hp=yes');
    writeln(f,'sg_mouse_messages=yes');
    writeln(f,'sg_mmap_always_show=no');

    // Binds
    writeln(f,'');
    writeln(f,'[BINDS]');
    writeln(f,'mmap_bind=9');
    writeln(f,'mmap_in_bind=107');
    writeln(f,'mmap_out_bind=109');
    writeln(f,'vote_menu_bind=39');
    writeln(f,'vote_menu_key_down_bind=40');
    writeln(f,'vote_menu_key_up_bind=38');
    writeln(f,'mouse_choise_key=16');

    // Time
    writeln(f,'');
    writeln(f,'[TIME]');
    writeln(f,'SIZE=3');
    writeln(f,'COLOR=3');
    writeln(f,'POS_X=10');
    writeln(f,'POS_Y=450');

    // Ammo warning
    writeln(f,'');
    writeln(f,'[AMMO_WARNING]');
    writeln(f,'mg=20');
    writeln(f,'sg=2');
    writeln(f,'gl=2');
    writeln(f,'rl=2');
    writeln(f,'sh=30');
    writeln(f,'rg=2');
    writeln(f,'pl=15');
    writeln(f,'bfg=2');

    // Messages
    writeln(f,'');
    writeln(f,'[MESSAGES]');
    writeln(f,'YA=^3YA^2 TAKEN.');
    writeln(f,'RA=^1RA^2 TAKEN.');
    writeln(f,'H100=^4MEGA HEALTH^2 TAKEN.');
    writeln(f,'QUAD=^4QUAD^2 TAKEN.');
    writeln(f,'REGENERATION=^4REGENERATION^2 TAKEN.');
    writeln(f,'HASTE=^4HASTE^2 TAKEN.');
    writeln(f,'FLIGHT=^4FLIGHT^2 TAKEN.');
    writeln(f,'BATTLESUIT=^4BATTLESUIT^2 TAKEN.');
    writeln(f,'RAIL=^5RAIL^2 TAKEN.');
    CloseFile(F);
    AddMessage('^1SGMOD:^7 Create default configuration file.');
  end;

end.
