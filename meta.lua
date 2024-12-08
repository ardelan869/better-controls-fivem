---@meta

---@class CallbackResponse
---@field ctrlKey boolean
---@field shiftKey boolean
---@field altKey boolean

---@class Options
---@field ctrlKey? boolean
---@field shiftKey? boolean
---@field altKey? boolean

---@alias CallbackFunction fun(resp: CallbackResponse);

---@class CacheEntry
---@field id number
---@field func CallbackFunction
---@field isHold? boolean
---@field options? Options

---@class Controls
---@field __cache { release: table<string, CacheEntry[]>, press: table<string, CacheEntry[]> }
---@field __pressed table<string, boolean>
Controls = {};

---@private
---@param _type 'press' | 'release'
---@param key string
---@param func CallbackFunction
---@param options? Options
---@param isHold? boolean
---@return number id, fun() unregister
function Controls:on(_type, key, func, options, isHold)
end

---@private
---@param _type 'press' | 'release'
---@param key string
---@param value number | CallbackFunction
function Controls:off(_type, key, value)
end

---@private
---@param _type 'press' | 'release'
---@param key string
---@param response CallbackResponse
function Controls:trigger(_type, key, response)
end

---@param key string
---@param func CallbackFunction
---@param options? Options
---@return number id, fun() unregister
function Controls:OnPress(key, func, options)
end

---@param key string
---@param value number | CallbackFunction
function Controls:OffPress(key, value)
end

---@param key string
---@param func CallbackFunction
---@param options? Options
---@return number id, fun() unregister
function Controls:OnHold(key, func, options)
end

---@param key string
---@param value number | CallbackFunction
function Controls:OffHold(key, value)
end

---@param key string
---@param func CallbackFunction
---@param options? Options
---@return number id, fun() unregister
function Controls:OnRelease(key, func, options)
end

---@param key string
---@param value number | CallbackFunction
function Controls:OffRelease(key, value)
end
