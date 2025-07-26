(function_declaration
  name: [
    (identifier) @name
    (dot_index_expression
      field: (member_identifier) @name)
  ]) @definition.function

(function_declaration
  name: (method_index_expression
    method: (member_identifier) @name)) @definition.method

(assignment_statement
  (variable_list .
    name: [
      (identifier) @name
      (dot_index_expression
        field: (member_identifier) @name)
    ])
  (expression_list .
    value: (function_definition))) @definition.function

(table_constructor
  (field
    name: (member_identifier) @name
    value: (function_definition))) @definition.function

(function_call
  name: [
    (identifier) @name
    (dot_index_expression
      field: (member_identifier) @name)
    (method_index_expression
      method: (member_identifier) @name)
  ]) @reference.call
