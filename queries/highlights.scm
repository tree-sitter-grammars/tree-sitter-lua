;; Comments

[(comment) (hash_bang_line)] @comment

;; Punctuation

["(" ")" "," ";"] @punctuation

;; Literals

[(true) (false)] @boolean_literal
(nil) @null_literal
(number) @number_literal
(string [start: _ end: _] @string_literal_delimiter) @string_literal
(escape_sequence) @string_literal_escape_sequence

;; Operators

(expression operator: _ @operator)
"=" @operator
(arguments ["(" ")"] @matchfix_operator)
["[" "]" "{" "}"] @matchfix_operator
["." ":"] @member_access_operator

;; Keywords

["function" "do" "end"] @keyword

["if" "then" "elseif" "else" "and" "or"] @evaluation_branch
(if_statement "end" @evaluation_branch)

["while" "repeat" "until" "for" "in"] @evaluation_loop
(while_statement ["do" "end"] @evaluation_loop)
(for_statement ["do" "end"] @evaluation_loop)

[(break_statement) "goto" "return"] @evaluation_end

["local" "::"] @declaration
(function_declaration ["function" "end"] @declaration)

(function_declaration "local" @declaration_modifier)
(attribute ["<" ">"] @declaration_modifier_delimiter)

;; Identifiers

; Includes all built-in and special identifiers in Lua 5.1, 5.2, 5.3 and 5.4.

(identifier) @variable
(member_identifier) @member_variable

([(identifier) @_name @type
  (member_identifier) @_name @member_type]
 (#match? @_name "^[A-Z]"))

([(identifier) @_name @constant
  (member_identifier) @_name @member_constant]
 (#match? @_name "^[A-Z_0-9]*$"))

(function_call
 name: [(identifier) @function
        (_ (member_identifier) @member_function)])

((dot_index_expression
  table: (identifier) @builtin_variable
  "." @builtin_variable
  field: _ @builtin_variable) @_name
 (#any-of? @_name "package.config" "package.cpath"
  "package.loaders" "package.path" "package.searchers"))

((identifier) @builtin_constant
 (#any-of? @builtin_constant "_G" "_VERSION"))

((dot_index_expression
  table: (identifier) @builtin_constant
  "." @builtin_constant
  field: _ @builtin_constant) @_name
 (#any-of? @_name "io.stderr" "io.stdin" "io.stdout" "math.huge"
  "math.maxinteger" "math.mininteger" "math.pi" "package.loaded"
  "package.preload"))

((identifier) @builtin_function
 (#any-of? @builtin_function "assert" "collectgarbage" "dofile" "error"
  "getfenv" "getmetatable" "ipairs" "load" "loadfile" "loadstring" "module"
  "next" "pairs" "pcall" "print" "rawequal" "rawget" "rawlen" "rawset" "require"
  "select" "setfenv" "setmetatable" "tonumber" "tostring" "type" "unpack" "warn"
  "xpcall"))

((dot_index_expression
  table: (identifier) @builtin_function
  "." @builtin_function
  field: _ @builtin_function) @_name
 (#any-of? @_name "bit32.arshift" "bit32.band" "bit32.bnot" "bit32.bor"
  "bit32.btest" "bit32.bxor" "bit32.extract" "bit32.lrotate" "bit32.lshift"
  "bit32.replace" "bit32.rrotate" "bit32.rshift" "coroutine.close"
  "coroutine.create" "coroutine.isyieldable" "coroutine.resume"
  "coroutine.running" "coroutine.status" "coroutine.wrap" "coroutine.yield"
  "debug.debug" "debug.getfenv" "debug.gethook" "debug.getinfo"
  "debug.getlocal" "debug.getmetatable" "debug.getregistry" "debug.getupvalue"
  "debug.getuservalue" "debug.setfenv" "debug.sethook" "debug.setlocal"
  "debug.setmetatable" "debug.setupvalue" "debug.setuservalue" "debug.traceback"
  "debug.upvalueid" "debug.upvaluejoin" "io.close" "io.flush" "io.input"
  "io.lines" "io.open" "io.output" "io.popen" "io.read" "io.tmpfile" "io.type"
  "io.write" "math.abs" "math.acos" "math.asin" "math.atan" "math.atan2"
  "math.ceil" "math.cos" "math.cosh" "math.deg" "math.exp" "math.floor"
  "math.fmod" "math.frexp" "math.ldexp" "math.log" "math.log10" "math.max"
  "math.min" "math.modf" "math.pow" "math.rad" "math.random" "math.randomseed"
  "math.sin" "math.sinh" "math.sqrt" "math.tan" "math.tanh" "math.tointeger"
  "math.type" "math.ult" "os.clock" "os.date" "os.difftime" "os.execute"
  "os.exit" "os.getenv" "os.remove" "os.rename" "os.setlocale" "os.time"
  "os.tmpname" "package.loadlib" "package.searchpath" "package.seeall"
  "string.byte" "string.char" "string.dump" "string.find" "string.format"
  "string.gmatch" "string.gsub" "string.len" "string.lower" "string.match"
  "string.pack" "string.packsize" "string.rep" "string.reverse" "string.sub"
  "string.unpack" "string.upper" "table.concat" "table.insert" "table.maxn"
  "table.move" "table.pack" "table.remove" "table.sort" "table.unpack"
  "utf8.char" "utf8.charpattern" "utf8.codepoint" "utf8.codes" "utf8.len"
  "utf8.offset"))

(assignment_statement (variable_list (identifier) @variable))

(assignment_statement (variable_list (identifier) @type)
 (#match? @type "^[A-Z]"))

(assignment_statement (variable_list (identifier) @constant)
 (#match? @constant "^[A-Z_0-9]*$"))

(function_declaration
 name: [(identifier) @function
        (_ (member_identifier) @member_function)])
(field
 name: (member_identifier) @member_function
 value: (function_definition))
(assignment_statement
 (variable_list . name: [(identifier) @function
                         (_ (member_identifier) @member_function)])
 (expression_list . value: (function_definition)))

(parameters (identifier) @function_parameter)
(vararg_expression) @special_function_parameter

((identifier) @builtin_function_parameter
 (#eq? @builtin_function_parameter "self"))

(label_statement (identifier) @goto_label)
(goto_statement (identifier) @goto_label)

((member_identifier) @special_member_variable
 (#any-of? @special_member_variable "__metatable" "__mode" "__name"))

((member_identifier) @special_member_function
 (#any-of? @special_member_function "__add" "__band" "__bnot" "__bor" "__bxor"
  "__call" "__close" "__concat" "__div" "__eq" "__gc" "__idiv" "__index"
  "__ipairs" "__le" "__len" "__lt" "__mod" "__mul" "__newindex" "__pairs"
  "__pow" "__shl" "__shr" "__sub" "__tostring" "__unm"))

;; Query precedence fixes

(field ["[" "]" "="] @punctuation)
(attribute (identifier) @declaration_modifier)
