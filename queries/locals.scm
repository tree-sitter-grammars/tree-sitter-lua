;; Scopes

[(chunk)
 (block)
 (function_scope)] @local.scope

;; Definitions

(function_declaration name: (identifier) @local.definition)
(parameters name: _ @local.definition)
(variable_declaration (variable_list name: _ @local.definition))
(variable_declaration (assignment_statement (variable_list name: _ @local.definition)))
(for_generic_clause (variable_list name: _ @local.definition))
(for_numeric_clause name: _ @local.definition)

;; References

(identifier) @local.reference
