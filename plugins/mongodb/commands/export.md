---
description: Export MongoDB collection data to JSON or CSV
argument-hint: [collection] [format:json|csv]
allowed-tools: Bash, Read, Write
---

# Export MongoDB Data

Export data from a MongoDB collection to a file.

**Arguments**: $ARGUMENTS

## Process

1. Parse collection name and desired format (default: JSON) from arguments
2. Determine output file path (default: `./data/<collection>-export.<format>`)
3. Ensure the output directory exists (`mkdir -p ./data`)
4. Execute the export using `mongoexport`
5. Report file size and document count

## Execution

Create the output directory first:
```bash
mkdir -p ./data
```

For JSON export:
```bash
mongoexport --uri="$MONGODB_URI" --collection=<collection> --out=<filepath> --jsonArray --pretty
```

For CSV export:
```bash
mongoexport --uri="$MONGODB_URI" --collection=<collection> --type=csv --fields=<auto-detected-fields> --out=<filepath>
```

If `mongoexport` is not available, fall back to `mongosh` with a script that writes documents to a file.

Auto-detect fields for CSV by sampling a document first.
