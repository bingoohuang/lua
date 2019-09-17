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

1.  [Strings in Lua](http://lua-users.org/wiki/StringsTutorial) for more information.

    ```lua
    -- No difference between these
    myStr = "Hi!!"
    myStr = 'Hi!!'
    myStr = [[Hi!!]] -- The 'weird' way to make a string literal IMO...

    -- Double quotes enclosed in single quotes    
    myStr = 'My friend said: "Hi!!"'

    -- Single quotes enclosed in double quotes
    myStr = "My friend said: 'Hi!!'"

    -- Single and double quotes enclosed in double brackets
    myStr = [[My friend said: "What's up?"]]
    
    -- Nesting quotes
    -- Double square brackets allow nesting, but they require one or more = inserted 
    -- in the outer-most brackets to distinguish them. 
    -- It doesn't matter how many = are inserted, as long as the number is the same in the beginning and ending brackets.
    myStr = [=[one [[two]] one]=]      -- ok: one [[two]] one
    myStr = [===[one [[two]] one]===]  -- ok: too one [[two]] one
    myStr = [=[one [ [==[ one]=]       -- ok. nothing special about the inner content: one [ [==[ one

    ```
    
1. `...` [Variable Number of Arguments](https://www.lua.org/pil/5.2.html), [examples](https://repl.it/@bingoohuang/VariableNumberOfArguments-1)

    ```lua
    local function anyOf(element, ...)
        for _, v in ipairs({...}) do
            if v == element then
                return true
            end
        end

        return false
    end
    ```
    
    [Forwarding ... to next function  like](https://github.com/thibaultcha/lua-resty-mlcache/blob/master/lib/resty/mlcache.lua)
    
    ```lua
    function _M:get(key, opts, cb, ...)
        return run_callback(self, key, namespaced_key, data, ttl, neg_ttl,
                        went_stale, l1_serializer, resurrect_ttl,
                        shm_set_tries, cb, ...)
    end
    ```

1. [table initializing](https://github.com/thibaultcha/lua-resty-mlcache/blob/master/lib/resty/mlcache.lua)

    ```lua
    local marshallers = {
        shm_value = function(str_value, value_type, at, ttl)
            return fmt("%d:%f:%f:%s", value_type, at, ttl, str_value)
        end,

        shm_nil = function(at, ttl)
            return fmt("0:%f:%f:", at, ttl)
        end,

        [1] = function(number) -- number
            return tostring(number)
        end,

        [2] = function(bool)   -- boolean
            return bool and "true" or "false"
        end,

        [3] = function(str)    -- string
            return str
        end,

        [4] = function(t)      -- table
            local json, err = cjson.encode(t)
            if not json then
                return nil, "could not encode table value: " .. err
            end

            return json
        end,
    }
    ```
    
1. [What does # mean in Lua?](https://stackoverflow.com/questions/17974622/what-does-mean-in-lua)
    
    [hash/hash key/hash mark #](https://zh.wikipedia.org/wiki/%E4%BA%95%E8%99%9F#cite_ref-2)
    
    > That is the [length operator](http://www.lua.org/manual/5.1/manual.html#2.5.5):

    > The length operator is denoted by the unary operator #. The length of a string is its number of bytes (that is, the usual meaning of string length when each character is one byte).

    > The length of a table t is defined to be any integer index n such that t[n] is not nil and t[n+1] is nil; moreover, if t[1] is nil, n can be zero. For a regular array, with non-nil values from 1 to a given n, its length is exactly that n, the index of its last value. If the array has "holes" (that is, nil values between other non-nil values), then #t can be any of the indices that directly precedes a nil value (that is, it may consider any such nil value as the end of the array).

1. [Lua里的真值与假值](https://repl.it/@bingoohuang/truefalse)

    ```lua
    -- OpenResty 中的真值与假值与坑 https://segmentfault.com/a/1190000007937895
    -- Lua 里的真值与假值：除了 nil 和 false 为假，其他值都是真。“其他值”这个概念包括0、空字符串、空表，等等。
    -- 在 Lua 里，通常使用 and 和 or 作为逻辑操作符。比如 true and false 返回 false，而 false or true 返回 true。
    print("nil:", nil and true or false)
    print("false:", false and true or false)
    print("(空字符串):", "" and true or false)
    print("0:", 0 and true or false)
    print("{}:", {} and true or false)
    ```
   
    结果
    ```
    Lua 5.1.5
    nil:    false
    false:  false
    (空字符串): true
    0:  true
    {}: true
    ```

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
1. [OpenResty Reference](https://openresty-reference.readthedocs.io)
1. [lua 中如何 continue](https://wiki.jikexueyuan.com/project/openresty/something/2016_10_3.html)
1. [用 do-end 整理你的代码](https://wiki.jikexueyuan.com/project/openresty/something/2016_10_2.html)
1. [使用idea调试lua代码-Openresty](https://segmentfault.com/a/1190000018430640)
