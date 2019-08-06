# trial-lua
lua learning

## fucks

1. ~= is not equals.

    ```lua
    if s ~= 'walternate' then  -- ~= is not equals.
      -- Equality check is == like Python; ok for strs.
      -- Calls with one string param don't need parens:
      print 'not equals walternate'  -- Works fine.
    end
    ```

1. todo

##

```bash
➜  ~ export http_proxy=http://127.0.0.1:9999; export https_proxy=http://127.0.0.1:9999;
➜  ~ brew install luarocks
Updating Homebrew...
==> Installing dependencies for luarocks: lua@5.1
==> Installing luarocks dependency: lua@5.1
==> Downloading https://homebrew.bintray.com/bottles/lua@5.1-5.1.5_8.mojave.bottle.tar.gz
######################################################################## 100.0%
==> Pouring lua@5.1-5.1.5_8.mojave.bottle.tar.gz
==> Caveats
You may also want luarocks:
  brew install luarocks
==> Summary
🍺  /usr/local/Cellar/lua@5.1/5.1.5_8: 22 files, 245.6KB
==> Installing luarocks
==> Downloading https://homebrew.bintray.com/bottles/luarocks-3.1.3.mojave.bottle.tar.gz
######################################################################## 100.0%
==> Pouring luarocks-3.1.3.mojave.bottle.tar.gz
==> Caveats
LuaRocks supports multiple versions of Lua. By default it is configured
to use Lua5.3, but you can require it to use another version at runtime
with the `--lua-dir` flag, like this:

  luarocks --lua-dir=/usr/local/opt/lua@5.1 install say
==> Summary
🍺  /usr/local/Cellar/luarocks/3.1.3: 101 files, 615.3KB

➜  ~ luarocks  install luasocket
Installing https://luarocks.org/luasocket-3.0rc1-2.src.rock

luasocket 3.0rc1-2 is now installed in /usr/local (license: MIT)

```

## Hacks

1. [block](https://www.lua.org/pil/4.2.html)
    * implicit blocks:  the body of a control structure, the body of a function, or a chunk (the file or string with the code where the variable is declared).
    * explicit blocks:  do-end  blocks
    
1. [pass by value or reference?](https://stackoverflow.com/questions/6128152/function-variable-scope-pass-by-value-or-reference)

    > There are eight basic types in Lua: nil, boolean, number, string, function, userdata, thread, and table. ...

    > Lua's function, table, userdata and thread (coroutine) types are passed by reference. 

    > The other types (nil, booleans, numbers and strings) are passed by value. 

    > Or as some people like to put it; all types are passed by value, but function, table, userdata and thread are reference types.

1. [self.__index = self](http://lua-users.org/lists/lua-l/2013-04/msg00617.html)
   ```lua
   function Account:new (o)
       o = o or {}   -- create object if user does not provide one
       self.__index = self
       return setmetatable(o, self)
    end
   ```
   
   > This is a common hack to save some memory.
   > non-hack (three table) version：
   ```lua
   function Account:new (o)
          o = o or {}   -- create object if user does not provide one
          setmetatable(o, {__index = self})
          return o
   end
   ```

## Thanks

1. [Lua Style Guide](https://github.com/Olivine-Labs/lua-style-guide)
1. [Learn X in Y minutes Where X=Lua](https://learnxinyminutes.com/docs/lua/)
1. [Online Learn X in Y minutes Where X=Lua](https://repl.it/@bingoohuang/learn-lua-in-y-minutes)
1. [OpenResty 最佳实践](https://moonbingbing.gitbooks.io/openresty-best-practices/)
