-- stylua: ignore start

foo
--^ variable

FOO
--^ constant

print
--^ function.builtin

foo()
--^ function.call

FOO()
--^ function.call

print()
--^ function.builtin

foo.print
--^ variable
--  ^ field

foo.PRINT
--^ variable
--  ^ field

foo.print()
--^ variable
--  ^ function.call

foo:print()
--^ variable
--  ^ method.call

{ foo = 1, FOO = 2, print = 3 }
--^ field  ^ field  ^ field

{ [foo] = 1, [FOO] = 2, [print] = 3 }
-- ^ variable ^ constant ^ function.builtin

function foo(bar) end
--       ^ function
--           ^ parameter

function foo.print() end
--       ^ variable
--           ^ function

function foo:print() end
--       ^ variable
--           ^ method

foo.print = function() end
--^ variable
--  ^ function

foo = function() end
--^ function

self
--^ variable.builtin

local foo <close>
--         ^ attribute

pcall(require, 'core')
--^ function.builtin
--    ^ function.builtin
