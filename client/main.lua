local lastAction = GetGameTimer();

Citizen.CreateThread(function()
  local set = false;

  ---@param bool boolean
  local function toggleFocus(bool)
    if set == bool then
      return;
    end

    set = bool;

    SetNuiFocus(bool, false);
    SetNuiFocusKeepInput(bool);
  end

  while true do
    if not set and not IsNuiFocused() and not IsNuiFocusKeepingInput() then
      toggleFocus(true);
    elseif set and GetGameTimer() - lastAction > 500 and IsNuiFocused() and IsNuiFocusKeepingInput() then
      toggleFocus(false);
    end

    Citizen.Wait(200);
  end
end);

---@param event string
---@param req CallbackResponse | { key: string }
local function handleAction(event, req)
  local data = {
    ctrlKey = req.ctrlKey,
    shiftKey = req.shiftKey,
    altKey = req.altKey,
  };

  TriggerEvent(event, req.key, data);
  TriggerServerEvent(event, req.key, data);
end

RegisterNUICallback('KeyUp', function(req, resp)
  handleAction('key::Up', req);

  lastAction = GetGameTimer();

  resp('OK');
end);

RegisterNUICallback('KeyDown', function(req, resp)
  handleAction('key::Down', req);

  lastAction = GetGameTimer();

  resp('OK');
end);
