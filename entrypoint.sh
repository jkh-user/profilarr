#!/bin/bash
set -e

GID=$(id -g)
# Default umask to 022 if not provided
UMASK=${UMASK:-022}

echo "Starting with UID: $UID, GID: $GID, UMASK: $UMASK"

umask "$UMASK"

# Fix permissions on /config if it exists
if [ -d "/config" ]; then
    echo "Setting up /config directory permissions"
    # Change ownership of /config and all its contents to PUID:PGID
    # This ensures files created by different UIDs are accessible
    chown -R "$UID:$GID" /config
fi

# Execute the main command as the specified user
echo "Starting application as user $UID:$GID"
exec "$@"