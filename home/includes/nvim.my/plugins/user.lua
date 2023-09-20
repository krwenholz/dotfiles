return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
  "RRethy/nvim-base16",
    commit = "6247ca9aa9f34644dfa290a6df3f6feefb73eb97",
  },
  {
    {
      "L3MON4D3/LuaSnip",
      config = function(plugin, opts)
        -- include the default astronvim config that calls the setup call
        require "plugins.configs.luasnip"(plugin, opts)
        -- load snippets paths
        require("luasnip.loaders.from_vscode").lazy_load {
          -- this can be used if your configuration lives in ~/.config/nvim
          -- if your configuration lives in ~/.config/astronvim, the full path
          -- must be specified in the next line
          paths = { "./lua/user/snippets" }
        }

        ls = require("luasnip")
        ls.add_snippets("all", {
	        ls.snippet("todo", {
		        ls.function_node(function(_, snip)
			        return snip.env.LINE_COMMENT
		        end, {}),
		        ls.text_node("TODO("),
		        ls.function_node(function(_, _)
			        return bash("git config --get user.email")
		        end, {}),
		        ls.text_node(": "),
		        ls.insert_node(0),
		        ls.text_node(os.date("%Y-%m-%d-%H:%M:%S")),
	        }),
	        ls.snippet("date", {
		        ls.text_node(os.date("%Y-%m-%d")),
	        }),
        })
      end,
    },
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require("astronvim.utils.status")

        opts.statusline = { -- statusline
          hl = { fg = "fg", bg = "bg" },
          status.component.mode(),
          status.component.file_info { file_modified = false },
          status.component.git_diff(),
          status.component.diagnostics(),
          status.component.fill(),
          status.component.cmd_info(),
          status.component.fill(),
          status.component.lsp(),
          status.component.treesitter(),
          status.component.nav(),
          status.component.mode { surround = { separator = "right" } },
        }

        opts.winbar = { -- winbar
          init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
          fallthrough = false,
          { -- inactive winbar
            condition = function() return not status.condition.is_active() end,
            --status.component.separated_path(),
            status.component.file_info {
              file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
              -- file_modified = false,
              file_read_only = false,
              hl = status.hl.get_attributes("winbarnc", true),
              surround = false,
              update = "BufEnter",
            },
          },
          { -- active winbar
            status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
          },
        }

        opts.tabline = { -- tabline
          { -- file tree padding
            condition = function(self)
              self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
              return status.condition.buffer_matches(
                { filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" } },
                vim.api.nvim_win_get_buf(self.winid)
              )
            end,
            provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1) end,
            hl = { bg = "tabline_bg" },
          },
          status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
          status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
          { -- tab list
            condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
            status.heirline.make_tablist { -- component for each tab
              provider = status.provider.tabnr(),
              hl = function(self)
                return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true)
              end,
            },
            { -- close button for current tab
              provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
              hl = status.hl.get_attributes("tab_close", true),
              on_click = { callback = function() require("astronvim.utils.buffer").close_tab() end, name = "heirline_tabline_close_tab_callback" },
            },
          },
        }

        --opts.statuscolumn = { -- statuscolumn
        --  status.component.foldcolumn(),
        --  status.component.fill(),
        --  status.component.numbercolumn(),
        --  status.component.signcolumn(),
        --}

        -- return the final configuration table
        return opts
      end,
    },
  },
}
