if IsDuplicityVersion() then
  error('better-controls-fivem is not supported on the server side.');
end

---@diagnostic disable: duplicate-set-field

---@class Controls
Controls = {
  __cache = {
    ---@type table<string, CacheEntry[]>
    release = {},
    ---@type table<string, CacheEntry[]>
    press = {}
  },
  ---@type table<string, boolean>
  __pressed = {}
};

---@private
---@param _type 'press' | 'release'
---@param key string
---@param func CallbackFunction
---@param options? Options
---@param isHold? boolean
---@return number id, fun() unregister
function Controls:on(_type, key, func, options, isHold)
  key = key:upper();

  if not self.__cache[_type][key] then
    self.__cache[_type][key] = {};
  end

  local index = #self.__cache[_type][key] + 1;

  self.__cache[_type][key][index] = {
    id = index,
    func = func,
    isHold = isHold,
    options = options or {}
  };

  return index, function()
    self:off(_type, key, index);
  end;
end

---@private
---@param _type 'press' | 'release'
---@param key string
---@param value number | CallbackFunction
function Controls:off(_type, key, value)
  key = key:upper();

  if not self.__cache[_type][key] then
    return;
  end

  for cacheIndex, cachedFunction in next, self.__cache[_type][key] do
    if cachedFunction.id == value or cachedFunction.func == value then
      table.remove(self.__cache[_type][key], cacheIndex);
    end
  end
end

---@private
---@param _type 'press' | 'release'
---@param key string
---@param response CallbackResponse
function Controls:trigger(_type, key, response)
  key = key:upper();

  if self.__cache[_type][key] then
    for _, cachedFunction in next, self.__cache[_type][key] do
      if _type == 'press' and not cachedFunction.isHold and self.__pressed[key] == true then
        goto continue;
      end

      if cachedFunction.options and next(cachedFunction.options) then
        for optionKey, optionValue in next, cachedFunction.options do
          if response[optionKey] ~= optionValue then
            goto continue;
          end
        end
      end

      Citizen.CreateThreadNow(function()
        cachedFunction.func(response);

        TerminateThisThread();
      end);

      ::continue::
    end
  end

  self.__pressed[key] = _type == 'press';
end

---@param key string
---@param func CallbackFunction
---@param options? Options
---@return number id, fun() unregister
function Controls:OnPress(key, func, options)
  return self:on('press', key, func, options);
end

---@param key string
---@param value number | CallbackFunction
function Controls:OffPress(key, value)
  return self:off('press', key, value);
end

---@param key string
---@param func CallbackFunction
---@param options? Options
---@return number id, fun() unregister
function Controls:OnHold(key, func, options)
  return self:on('press', key, func, options, true);
end

---@param key string
---@param value number | CallbackFunction
function Controls:OffHold(key, value)
  return self:off('press', key, value);
end

---@param key string
---@param func CallbackFunction
---@param options? Options
---@return number id, fun() unregister
function Controls:OnRelease(key, func, options)
  return self:on('release', key, func, options);
end

---@param key string
---@param value number | CallbackFunction
function Controls:OffRelease(key, value)
  return self:off('release', key, value);
end

AddEventHandler('key::Down', function(key, data)
  Controls:trigger('press', key:upper(), data);
end);

AddEventHandler('key::Up', function(key, data)
  Controls:trigger('release', key:upper(), data);
end);
