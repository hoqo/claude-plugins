---
description: Quick overview of a MongoDB database - list collections, document counts, and sample schemas. For deep exploration with relationship mapping and recommendations, use the db-explorer agent instead
argument-hint: [database-name]
allowed-tools: Bash, Read, Write
---

# Explore MongoDB Database

Explore the MongoDB database and provide a comprehensive overview.

**Arguments**: $ARGUMENTS

## Process

1. Connect to the database (use argument as db name, or default from `MONGODB_URI`)
2. List all collections with document counts
3. For each collection (up to 10):
   - Show document count
   - Sample one document to reveal the schema
   - List indexes
4. Identify relationships between collections (shared field names like `*_id`)
5. Present a summary table

## Execution

Use `mongosh` with `MONGODB_URI` to run discovery queries:

```bash
mongosh "$MONGODB_URI" --quiet --eval "
  const colls = db.getCollectionNames();
  colls.slice(0, 10).forEach(c => {
    print('=== ' + c + ' ===');
    print('Count: ' + db[c].countDocuments({}));
    print('Sample:');
    printjson(db[c].findOne());
    print('Indexes:');
    printjson(db[c].getIndexes());
    print('');
  });
"
```

Format the output as a readable summary with a table of collections and their document counts.
