---
description: Run a MongoDB query or aggregation pipeline
argument-hint: [collection] [query-description]
allowed-tools: Bash, Read, Write
---

# Run MongoDB Query

Execute a MongoDB query against the connected database.

**Arguments**: $ARGUMENTS

## Process

1. Parse the collection name and query description from the arguments
2. Build the appropriate MongoDB query (find, aggregate, or other operation)
3. Execute it using `mongosh` with the `MONGODB_URI` environment variable
4. Format and display the results clearly

## Guidelines

- Default to `find()` for simple lookups
- Use aggregation pipelines for joins, grouping, or complex transformations
- Always add `.limit(20)` to find queries unless the user specifies otherwise
- Pretty-print results with `printjson()` or `.pretty()`
- If the query description is vague, first list the collection's sample document to understand the schema

## Execution

```bash
mongosh "$MONGODB_URI" --quiet --eval "<generated-query>"
```

If no collection is specified, list all collections first and ask which one to query.
