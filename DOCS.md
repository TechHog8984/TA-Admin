# Documentation

### The loadstring returns a library. I will be referring to this library as TALib.
## TALib:
### `CreateCommand`:
```lua
TALib:CreateCommand{<string>Name, <function>Callback, <string>(optional)Description}
```
#### This function has multiple different use cases. One way to use it is described as above and below in this example:
```lua
local Command = TALib:CreateCommand{'Command', function(...)print('Command was run with args: ', ...) end, 'Just an example :)'}
```
#### Another way to use this function is like so:
```lua
local Command = TALib:CreateCommand{Name = 'Command', Callback = function(...)print('Command was run with args: ', ...) end, Description = 'Just an example :)'}
```
#### If you want, you can combine both of these:
```lua
local Command = TALib:CreateCommand{Name = 'Command', function(...)print('Command was run with args: ', ...) end, 'Just and example :)'}
```
### It doesn't matter which one of these you use or how you use them, as long as the function gets a name and a callback.
