---
description: Check MongoDB connection status and database info
allowed-tools: Bash, Read
---

# MongoDB Status

Check the MongoDB connection status using `mongosh`. Report:

1. **Connection**: Whether the database is reachable
2. **Server version**: MongoDB server version
3. **Databases**: List all databases with their sizes
4. **Current database**: The default database from the connection string

Use the connection string from the `MONGODB_URI` environment variable. If not set, try `mongodb://localhost:27017`.

Run:
```bash
mongosh --eval "
  db.adminCommand('ping');
  print('--- Server Info ---');
  printjson(db.adminCommand('serverStatus').version);
  print('--- Databases ---');
  printjson(db.adminCommand('listDatabases'));
" "${MONGODB_URI:-mongodb://localhost:27017}" --quiet
```

If `mongosh` is not installed, suggest installing it with `brew install mongosh` (macOS) or provide the appropriate installation command for the detected platform.
