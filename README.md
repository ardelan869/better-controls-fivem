
# better-controls-fivem

## Additional Requirements

- [Sumneko Lua Language Server (LLS) for VSCode](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)

## Features

- **Simple**: Just add the `import.lua` file to your resources, and you're ready to start scripting!

- **Easy**: No need to tinker with `RegisterCommand`, `RegisterKeyMapping`, or manual loops like `IsControlJustPressed`.

- **Fast**: Performance is optimized and handled seamlessly by the game engine.

- **Customizable**: Tailor the controls to suit your preferences.

## Installation

1. Download the [latest release](https://github.com/ardelan869/better-controls-fivem) from GitHub.

2. Extract the contents of the zip file into your `resources` folder.

3. Update your [Sumneko LLS](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) settings by adding the `meta.lua` file path to the `workspace.library` configuration.

4. Include `ensure better-controls-fivem` in your `server.cfg` file.

5. Add `@better-controls-fivem/import.lua` to the `fxmanifest.lua` file of any resource you want to use it in, and start scripting!

## Example

```lua
-- Triggered when the key is pressed
Controls:OnPress('F1', function(resp)
  print('Press', json.encode(resp))
end)

-- Triggered when the key is pressed with additional modifiers
Controls:OnPress('F1', function(resp)
  print('Press', json.encode(resp))
end, {
  -- Available options:
  -- ctrlKey = true, -- Trigger only if the Ctrl key is pressed
  -- altKey = true,  -- Trigger only if the Alt key is pressed
  shiftKey = true     -- Trigger only if the Shift key is pressed
})

-- Triggered while the key is held down
Controls:OnHold('F1', function(resp)
  print('Hold', json.encode(resp))
end)

-- Triggered when the key is released
Controls:OnRelease('F1', function(resp)
  print('Release', json.encode(resp))
end)
```
