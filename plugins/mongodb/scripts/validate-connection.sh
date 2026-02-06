#!/bin/bash
# Validate MongoDB connection before executing queries
# Used by hooks to ensure connectivity

URI="${MONGODB_URI:-mongodb://localhost:27017}"

# Check for npx (optional — needed for MCP server)
if ! command -v npx &> /dev/null; then
	echo "Node.js is not installed. The MongoDB MCP server provides additional database tools but requires Node.js."
	echo "Install Node.js to enable it: brew install node (macOS) or https://nodejs.org/en/download"
fi

if ! command -v mongosh &> /dev/null; then
	echo "mongosh is not installed. Install with: brew install mongosh" >&2
	exit 1
fi

mongosh "$URI" --quiet --eval "db.adminCommand('ping')" &> /dev/null
if [ $? -ne 0 ]; then
	echo "Cannot connect to MongoDB at $URI" >&2
	exit 1
fi

exit 0
