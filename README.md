# hoqo's Claude Code plugins

A collection of plugins for [Claude Code](https://claude.com/claude-code).

## Plugins

### MongoDB

Interactive MongoDB plugin providing query building, schema analysis, performance optimization, and data import/export through Claude Code.

**Setup:** Requires `MONGODB_URI` environment variable.

## Structure

```
plugins/
└── mongodb/
    ├── .mcp.json     # MCP server configuration
    ├── agents/       # Specialized subagents
    ├── commands/     # Slash commands
    ├── hooks/        # Event hooks
    ├── scripts/      # Helper scripts
    └── skills/       # Skills & knowledge
```