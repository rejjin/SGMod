unit console;

interface

uses register, configuration, utils, defines, sysutils, mmap;

procedure ParseCommands(s: string);

implementation

  procedure ParseCommands(s: string);
  var
    option: shortstring;
    value: shortstring;
    tmp : shortstring;
    key : integer;
  begin
    option := lowercase(strpar(s, 0));
    value := lowercase(strpar(s, 1));

    if (option='sg_mmap_always_show') then begin
      if (value = 'yes') or (value = '1') then
      begin
        mmap_always_show := true;
        AddMessage('^1SGMOD:^7 sg_mmap_always_show set to "yes"');
        SaveConfiguration;
      end else if (value = 'no') or (value = '0') then
      begin
        mmap_always_show := false;
        AddMessage('^1SGMOD:^7 sg_mmap_always_show set to "no"');
        SaveConfiguration;
      end else if (value = '') then
      begin
        if mmap_always_show then tmp := 'yes' else tmp := 'no';
        AddMessage('^1SGMOD:^7 sg_mmap_always_show is ' + tmp);
        AddMessage('^1SGMOD:^7 ^4USAGE: ^7sg_mmap_always_show yes|no(1|0)');
      end;
    end;

    if (option='sg_auto_messages') then begin
      if (value = 'yes') or (value = '1') then
      begin
        auto_messages := true;
        AddMessage('^1SGMOD:^7 sg_auto_messages set to "yes"');
        SaveConfiguration;
      end else if (value = 'no') or (value = '0') then
      begin
        auto_messages := false;
        AddMessage('^1SGMOD:^7 sg_auto_messages set to "no"');
        SaveConfiguration;
      end else if (value = '') then
      begin
        if auto_messages then tmp := 'yes' else tmp := 'no';
        AddMessage('^1SGMOD:^7 sg_auto_messages is ' + tmp);
        AddMessage('^1SGMOD:^7 ^4USAGE: ^7sg_auto_messages yes|no(1|0)');
      end;
    end;

    if (option='sg_draw_time') then begin
      if (value = 'yes') or (value = '1') then
      begin
        draw_time := true;
        AddMessage('^1SGMOD:^7 sg_draw_time set to "yes"');
        SaveConfiguration;
      end else if (value = 'no') or (value = '0') then
      begin
        draw_time := false;
        AddMessage('^1SGMOD:^7 sg_draw_time set to "no"');
        SaveConfiguration;
      end else if (value = '') then
      begin
        if draw_time then tmp := 'yes' else tmp := 'no';
        AddMessage('^1SGMOD:^7 sg_draw_time is ' + tmp);
        AddMessage('^1SGMOD:^7 ^4USAGE: ^7sg_draw_time yes|no(1|0)');
      end;
    end;

    if (option='sg_low_ammo_table') then begin
      if (value = 'yes') or (value = '1') then
      begin
        low_ammo_table := true;
        AddMessage('^1SGMOD:^7 sg_low_ammo_table set to "yes"');
        SaveConfiguration;
      end else if (value = 'no') or (value = '0') then
      begin
        low_ammo_table := false;
        AddMessage('^1SGMOD:^7 sg_low_ammo_table set to "no"');
        SaveConfiguration;
      end else if (value = '') then
      begin
        if low_ammo_table then tmp := 'yes' else tmp := 'no';
        AddMessage('^1SGMOD:^7 sg_low_ammo_table is ' + tmp);
        AddMessage('^1SGMOD:^7 ^4USAGE: ^7sg_low_ammo_table yes|no(1|0)');
      end;
    end;

    if (option='sg_show_hp') then begin
      if (value = 'yes') or (value = '1') then
      begin
        is_show_hp := true;
        AddMessage('^1SGMOD:^7 sg_show_hp set to "yes"');
        SaveConfiguration;
      end else if (value = 'no') or (value = '0') then
      begin
        is_show_hp := false;
        AddMessage('^1SGMOD:^7 sg_show_hp set to "no"');
        SaveConfiguration;
      end else if (value = '') then
      begin
        if is_show_hp then tmp := 'yes' else tmp := 'no';
        AddMessage('^1SGMOD:^7 sg_show_hp is ' + tmp);
        AddMessage('^1SGMOD:^7 ^4USAGE: ^7sg_show_hp yes|no(1|0)');
      end;
    end;

    if (option='sg_mouse_messages') then begin
      if (value = 'yes') or (value = '1') then
      begin
        use_deg_of_messages := true;
        AddMessage('^1SGMOD:^7 sg_mouse_messages set to "yes"');
        SaveConfiguration;
      end else if (value = 'no') or (value = '0') then
      begin
        use_deg_of_messages := false;
        AddMessage('^1SGMOD:^7 sg_mouse_messages set to "no"');
        SaveConfiguration;
      end else if (value = '') then
      begin
        if use_deg_of_messages then tmp := 'yes' else tmp := 'no';
        AddMessage('^1SGMOD:^7 sg_mouse_messages is ' + tmp);
        AddMessage('^1SGMOD:^7 ^4USAGE: ^7sg_mouse_messages yes|no(1|0)');
      end;
    end;

    if (option='sg_bind_mmap') then begin
      key := key_parse(value);
      if (key <> 0) then begin
        MMAP_BIND_KEY := key;
        SaveConfiguration;
      end;
        AddMessage('^1SGMOD:^7 '
          + 'mini-map is now binded to '
          + getKeyNameFromNumber(MMAP_BIND_KEY));
    end;

    if (option='sg_bind_mmap_in') then begin
      key := key_parse(value);
      if (key <> 0) then begin
        MMAP_IN_BIND_KEY := key;
        SaveConfiguration;
      end;
      AddMessage('^1SGMOD:^7 '
        + 'mini-map-in is now binded to '
        + getKeyNameFromNumber(MMAP_IN_BIND_KEY));
    end;

    if (option='sg_bind_mmap_out') then begin
      key := key_parse(value);
      if (key <> 0) then begin
        MMAP_OUT_BIND_KEY := key;
        SaveConfiguration;
      end;
      AddMessage('^1SGMOD:^7 '
              + 'mini-map-out is now binded to '
              + getKeyNameFromNumber(MMAP_OUT_BIND_KEY));
    end;

    if (option='sg_bind_vote_menu') then begin
      key := key_parse(value);
      if (key <> 0) then begin
        VOTE_MENU_BIND_KEY := key;
        SaveConfiguration;
      end;
      AddMessage('^1SGMOD:^7 '
              + 'vote menu is now binded to '
              + getKeyNameFromNumber(VOTE_MENU_BIND_KEY));
    end;

    if (option='sg_bind_vote_menu_key_up') then begin
      key := key_parse(value);
      if (key <> 0) then begin
        vote_menu_key_up := key;
        SaveConfiguration;
      end;
      AddMessage('^1SGMOD:^7 '
              + 'vote menu up key is now binded to '
              + getKeyNameFromNumber(vote_menu_key_up));
    end;

    if (option='sg_bind_vote_menu_key_down') then begin
      key := key_parse(value);
      if (key <> 0) then begin
        vote_menu_key_down := key;
        SaveConfiguration;
      end;
      AddMessage('^1SGMOD:^7 '
              + 'vote menu down key is now binded to '
              + getKeyNameFromNumber(vote_menu_key_down));
    end;

    if (option='sg_bind_deg_of_messages') then begin
      key := key_parse(value);
      if (key <> 0) then begin
        mouse_choise_key := key;
        SaveConfiguration;
      end;
      AddMessage('^1SGMOD:^7 '
              + 'sg_bind_deg_of_messages is now binded to '
              + getKeyNameFromNumber(mouse_choise_key));
    end;


    if (option='sg_low_ammo_mg') then begin
      if value <> '' then begin
        warning_ammo_mg := strtoint(value);
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_mg set to '
            + inttostr(warning_ammo_mg));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_mg is '
            + inttostr(warning_ammo_mg));
      end;
    end;

    if (option='sg_time_size') then begin
      if value <> '' then begin
          if strtoint(value) < 1 then value := inttostr(1);
          if strtoint(value) > 3 then value := inttostr(3);
          time_size := strtoint(value);
          AddMessage('^1SGMOD:^7 '
              + 'sg_time_size set to '
              + inttostr(time_size));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_time_size is '
            + inttostr(time_size)
            + '. Possible value 1-3');
      end;
    end;

    if (option='sg_time_color') then begin
      if value <> '' then begin
          if strtoint(value) < 1 then value := inttostr(1);
          if strtoint(value) > 7 then value := inttostr(7);
          time_color := strtoint(value);
          AddMessage('^1SGMOD:^7 '
              + 'sg_time_color set to '
              + inttostr(time_color));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_time_color is '
            + inttostr(time_color)
            + '. Possible value 1-7');
      end;
    end;

    if (option='sg_time_pos_x') then begin
      if value <> '' then begin
          if strtoint(value) < 1 then value := inttostr(1);
          time_pos_x := strtoint(value);
          AddMessage('^1SGMOD:^7 '
              + 'sg_time_pos_x set to '
              + inttostr(time_pos_x));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_time_pos_x is '
            + inttostr(time_pos_x));
      end;
    end;

    if (option='sg_time_pos_y') then begin
      if value <> '' then begin
          if strtoint(value) < 1 then value := inttostr(1);
          time_pos_y := strtoint(value);
          AddMessage('^1SGMOD:^7 '
              + 'sg_time_pos_y set to '
              + inttostr(time_pos_y));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_time_pos_y is '
            + inttostr(time_pos_y));
      end;
    end;

    if (option='sg_low_ammo_sg') then begin
      if value <> '' then begin
        warning_ammo_sg := strtoint(value);
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_sg set to '
            + inttostr(warning_ammo_sg));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_sg is '
            + inttostr(warning_ammo_sg));
      end;
    end;

    if (option='sg_low_ammo_gl') then begin
      if value <> '' then begin
        warning_ammo_gl := strtoint(value);
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_gl set to '
            + inttostr(warning_ammo_gl));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_gl is '
            + inttostr(warning_ammo_gl));
      end;
    end;

    if (option='sg_low_ammo_rl') then begin
      if value <> '' then begin
        warning_ammo_rl := strtoint(value);
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_rl set to '
            + inttostr(warning_ammo_rl));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_rl is '
            + inttostr(warning_ammo_rl));
      end;
    end;

    if (option='sg_low_ammo_sh') then begin
      if value <> '' then begin
        warning_ammo_sh := strtoint(value);
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_sh set to '
            + inttostr(warning_ammo_sh));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_sh is '
            + inttostr(warning_ammo_sh));
      end;
    end;

    if (option='sg_low_ammo_rg') then begin
      if value <> '' then begin
        warning_ammo_rg := strtoint(value);
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_rg set to '
            + inttostr(warning_ammo_rg));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_rg is '
            + inttostr(warning_ammo_rg));
      end;
    end;

    if (option='sg_low_ammo_pl') then begin
      if value <> '' then begin
        warning_ammo_pl := strtoint(value);
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_pl set to '
            + inttostr(warning_ammo_pl));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_pl is '
            + inttostr(warning_ammo_pl));
      end;
    end;

    if (option='sg_low_ammo_bfg') then begin
      if value <> '' then begin
        warning_ammo_bfg := strtoint(value);
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_bfg set to '
            + inttostr(warning_ammo_bfg));
      end else begin
        AddMessage('^1SGMOD:^7 '
            + 'sg_low_ammo_bfg is '
            + inttostr(warning_ammo_bfg));
      end;
    end;
  end;
end.