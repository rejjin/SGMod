unit auto_message;

interface

uses register, defines, sysutils;

procedure AutoMessageHandle(image : byte; dxid : word);

implementation
  procedure AutoMessageHandle(image : byte; dxid : word);
  var
    out_message : String;
  begin
    if not auto_messages then exit;

    if (players[idx] = nil) or (players[idx].DXID <> dxid) or
      ((gametype <> 'TDM') and (gametype <> 'CTF') and (gametype <> 'DOM')) then
      exit;

    out_message := '';
    
    case image of
      IT_YELLOW_ARMOR : out_message := messages[MESSAGE_YA];
      IT_RED_ARMOR : out_message := messages[MESSAGE_RA];
      IT_HEALTH_100 : out_message := messages[MESSAGE_H100];
      IT_POWERUP_REGENERATION : out_message := messages[MESSAGE_REGENERATION];
      IT_POWERUP_HASTE : out_message := messages[MESSAGE_HASTE];
      IT_POWERUP_FLIGHT : out_message := messages[MESSAGE_FLIGHT];
      IT_POWERUP_BATTLESUIT : out_message := messages[MESSAGE_BATTLESUIT];
      IT_POWERUP_QUAD : out_message := messages[MESSAGE_QUAD];
      IT_RAIL : out_message := messages[MESSAGE_RAIL];
    end;

    if length(out_message) <> 0 then
      SendConsoleHCommand('say_team ' + out_message);
  end;
end.