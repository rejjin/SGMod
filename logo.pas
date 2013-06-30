unit logo;

interface

uses register, defines;

procedure LogoInit;
procedure LogoStart;

implementation

  procedure LogoInit;
  begin
    start_logo := 1;
    logo_x := -20;
    logo_inertia_x := 0;
    logo_center_wait := 0;
  end;

  procedure LogoStart;
  begin
    if start_logo = 1 then begin
      logo_inertia_x := round(1/(640-logo_x)*3200);

      if logo_x >= 640 then begin
        start_logo := 0;
        exit;
      end;

      if (logo_x >= 270) and (logo_center_wait < 70) then
        logo_center_wait := logo_center_wait + 1
      else logo_x := logo_x + logo_inertia_x;

      FX_FillRect(logo_x,260,90,3,$77000000,$102,false);
      FX_FillRect(logo_x+90,225,3,38,$77000000,$102,false);
      FX_Rectangle(logo_x-5,220,95,40,$99ffffff,$77000000,$102,false);
      ExtendedTextout(logo_x, 233, '^0SG Mod', 6, false);
      ExtendedTextout(logo_x+3, 231, 'SG Mod', 6, false);
    end;
  end;

end.