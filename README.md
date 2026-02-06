# Claude Code plugins & skills

## What is this?

This is a collection of **Claude Code plugins** :
- **MongoDB**: build queries in natural language, explore schemas, optimize performance, run migrations, and import/export data.

## MongoDB Plugin

### Quick Start

#### Prerequisites

| Requirement | Details |
|-------------|---------|
| **Claude Code** | [Install Claude Code](https://docs.anthropic.com/en/docs/claude-code) |
| **mongosh** | MongoDB Shell — `brew install mongosh` (macOS) or [install guide](https://www.mongodb.com/docs/mongodb-shell/install/) |
| **MONGODB_URI** | Connection string as an environment variable |
| **Node.js** | Required for the MCP server (`npx mongodb-mcp-server`) |


#### Installation

1. **Set your MongoDB connection string**

   ```bash
   export MONGODB_URI="mongodb+srv://user:pass@cluster.mongodb.net/mydb"
   ```

2. **Install the plugin**

   ```
   > /plugin marketplace add hoqo/claude-plugins
   > /plugin install mongodb@hoqo-claude-plugins
   ```

3. **Start using**

   ```
   > /status
   > /explore
   > /query users find all active users created this month
   ```
   
### Commands

**`/status`**

- Check connection status and database info. 
- Reports connection health, server version, database list with sizes, and current database.

**`/explore [database-name]`**

- Quick overview of database.
- Lists all collections with document counts, samples a document from each to reveal the schema, and shows indexes. 
- For deep exploration with relationship mapping, use the `db-explorer` agent instead.

**`/query [collection] [query-description]`**

- Run a query or aggregation pipeline described in natural language. 
- Defaults to `find()` for simple lookups, uses aggregation for joins and grouping. 
- Results are automatically limited to 20 documents.

**`/import [file-path] [collection-name]`**

- Import data from JSON or CSV files into a collection using `mongoimport`. 
- Confirms before importing into collections that already have data.

**`/export [collection] [format:json|csv]`**

- Export collection data to JSON or CSV files using `mongoexport`. 
- Auto-detects fields for CSV exports.

### Agents

**`db-explorer`**

- An autonomous agent that thoroughly documents a database. 
- It discovers collections, infers schemas by sampling documents, maps cross-collection relationships via foreign-key-like fields, and generates a structured report with recommendations for missing indexes and schema improvements.

**`query-advisor`**

- An interactive query optimizer.
- Give it a slow query and it will: run explain plans, diagnose the root cause (missing index, inefficient pipeline), recommend a fix (compound index, query rewrite), and verify the improvement with before/after metrics.

**`migration-helper`**

- Plans and executes MongoDB data migrations safely.
- Supports field renames, type conversions, restructuring (embed to reference), and adding default values. 
- All migrations are idempotent, tested on samples first, and use `bulkWrite` for performance.

### Skills

**`query-builder`**

Comprehensive reference for queries: 
- aggregation pipeline stages
- common operators
- `$lookup` joins
- cursor-based pagination
- full-text search
- transactions

**`performance-advisor`**

Index strategy guide covering the ESR rule (Equality, Sort, Range), compound indexes, partial indexes, TTL indexes, explain plan interpretation, and a performance checklist.

**`schema-analyzer`**

Schema analysis toolkit: infer field types from sampled documents, detect type inconsistencies, evaluate embedding vs. referencing decisions, recommend JSON Schema validation rules, and flag anti-patterns.

### Safety Hooks

The plugin includes three hooks that run automatically to keep DB safe:

- **Connection validation** (`SessionStart`): Checks that `mongosh` is installed and `MONGODB_URI` is reachable before you start working.
- **Destructive operation guard** (`PreToolUse`): Intercepts commands containing `dropDatabase`, `dropCollection`, `deleteMany({})`, or `drop()` and asks for explicit confirmation before proceeding.
- **Error diagnostics** (`PostToolUse`): When a MongoDB command fails, automatically analyzes the error and suggests a fix.