local my_cool_module = require("my_awesome_plugin.my_cool_module")

local my_awesome_plugin = {}

local function with_defaults(options)
   return {
      name = options.name or "John Doe"
   }
end

-- This function is supposed to be called explicitly by users to configure this
-- plugin
function my_awesome_plugin.setup(options)
   -- avoid setting global values outside of this function. Global state
   -- mutations are hard to debug and test, so having them in a single
   -- function/module makes it easier to reason about all possible changes
   my_awesome_plugin.options = with_defaults(options)

   -- do here any startup your plugin needs, like creating commands and
   -- mappings that depend on values passed in options
   vim.api.nvim_create_user_command("MyAwesomePluginGreet", my_awesome_plugin.greet, {})
end

function my_awesome_plugin.is_configured()
   return my_awesome_plugin.options ~= nil
end

-- lets see what happens
function my_awesome_plugin.generic_greet()
   local bnr = vim.fn.bufnr('%')
   local ns_id = vim.api.nvim_create_namespace('demo')

   local line_num = 0
   local col_num = 0

   local opts = {
      virt_lines={{{"test", 'Comment'}}},
      virt_lines_above = true
   }

   local mark_id = vim.api.nvim_buf_set_extmark(bnr, ns_id, line_num, col_num, opts)
   --
   -- vim.api.nvim_buf_set_extmark(0, 0, 0, 0, {virt_lines={{"test", "Comment"}}, v
      print("Hello, unnamed friend!")


   -- i don't know what this does yet...
   -- virt_text_win_col = 20,
  if not parsers.has_parser() then return end
  local options = opts or {}
  if type(opts) == 'number' then
    options = {indicator_size = opts}
  end
  local indicator_size = options.indicator_size or 100
  local type_patterns = options.type_patterns or {'class', 'function', 'method'}
  local transform_fn = options.transform_fn or transform_line
  local separator = options.separator or ' -> '

  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return "" end

  local lines = {}
  local expr = current_node

  while expr do
    local line = get_line_for_node(expr, type_patterns, transform_fn)
    if line ~= '' and not vim.tbl_contains(lines, line) then
      table.insert(lines, 1, line)
    end
    expr = expr:parent()
  end

  local text = table.concat(lines, separator)
  local text_len = #text
  if text_len > indicator_size then
    return '...'..text:sub(text_len - indicator_size, text_len)
  end

end

my_awesome_plugin.options = nil
return my_awesome_plugin