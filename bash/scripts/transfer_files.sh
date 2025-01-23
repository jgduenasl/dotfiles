#!/bin/bash

# default variables (can be overridden by command-line arguments)
REMOTE_USER="jgduenasl"  # Replace with your default remote user
REMOTE_HOST="default_host"  # Replace with your default remote host
REMOTE_DIR="/home/jgduenasl/downloads"  # Replace with your default remote directory
HASH_ALGO="sha1sum"  # Default hash algorithm, can be set to sha256sum
LOG_FILE="transfer_log.txt"

# Function to display usage
usage() {
  echo "Usage: $0 [-u user] [-h host] [-d dir] [-a hash_algo] compressed_file"
  echo "  -u user       Remote server user (default: $REMOTE_USER)"
  echo "  -h host       Remote server host (default: $REMOTE_HOST)"
  echo "  -d dir        Remote server directory (default: $REMOTE_DIR)"
  echo "  -a hash_algo  Hash algorithm (sha1sum or sha256sum, default: $HASH_ALGO)"
  exit 1
}

# Parse command-line options
while getopts "u:h:d:a:" opt; do
    case $opt in
      u) REMOTE_USER="$OPTARG" ;;
      h) REMOTE_HOST="$OPTARG" ;;
      d) REMOTE_DIR="$OPTARG" ;;
      a) HASH_ALGO="$OPTARG" ;;
      *) usage ;;
    esac
done
shift $((OPTIND - 1))

# Check for required positional arguments
if [ $# -lt 1 ]; then
    usage
fi

COMPRESSED_FILE="$1"

# Function to transfer file
transfer_file() {
    echo "Starting file transfer..."
    rsync -avz --no-perms "$COMPRESSED_FILE" "$REMOTE_USER"@"$REMOTE_HOST":"$REMOTE_DIR" &> "$LOG_FILE"
    if [ $?  -ne 0 ]; then
        echo "Error: Failed to transfer zip file to the remote server."
        exit 1
    fi
}

# Function to verify integrity on the remote server
verify_remote_integrity() {
    echo "Verifying file integrity on remote server..."
    LOCAL_HASH=$($HASH_ALGO "$COMPRESSED_FILE" | awk '{print $1}')
    REMOTE_HASH=$(ssh "$REMOTE_USER"@"$REMOTE_HOST" "$HASH_ALGO \"$REMOTE_DIR/$(basename "$COMPRESSED_FILE")\" | awk '{print $1}')

    if [ "$LOCAL_HASH" != "$REMOTE_HASH" ]; then
        echo "Error: File integrity checkk failed. Hash mismatch."
        echo "Local hash: $LOCAL_HASH"
        echo "Remote hash: $REMOTE_HASH"
        exit 1
    fi
}

# Main script execution
transfer_file
verify_remote_integrity
# done
