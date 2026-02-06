---
description: Import data into MongoDB from JSON or CSV files
argument-hint: [file-path] [collection-name]
allowed-tools: Bash, Read
---

# Import Data to MongoDB

Import data from a JSON or CSV file into a MongoDB collection.

**Arguments**: $ARGUMENTS

## Process

1. Parse file path and target collection from arguments
2. Detect file format from extension (.json or .csv)
3. Validate the file exists and is readable
4. Execute the import using `mongoimport`
5. Report number of documents imported

## Execution

For JSON:
```bash
mongoimport --uri="$MONGODB_URI" --collection=<collection> --file=<filepath> --jsonArray
```

For CSV:
```bash
mongoimport --uri="$MONGODB_URI" --collection=<collection> --type=csv --headerline --file=<filepath>
```

If `mongoimport` is not available, fall back to `mongosh` with a bulk insert script.

Always confirm with the user before importing into a collection that already has data, as this will add documents (not replace).
