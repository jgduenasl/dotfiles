#!/bin/bash

# default variables (can be overridden by command-line arguments)
REMOTE_USER="jgduenasl"  # Replace with your default remote user
REMOTE_HOST="default_host"  # Replace with your default remote host
REMOTE_DIR="/home/jgduenasl"  # Replace with your default remote directory
HASH_ALGO="sha1sum"  # Default hash algorithm, can be set to sha256sum

# Function to display usage
usage() {
  echo "Usage: $0 [-u user] [-h host] [-d dir] [-a hash_algo] source_dir zip_file"
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
if [ $# -lt 2 ]; then
    usage
fi

SRC_DIR="$1"
ZIP_FILE="$2"
HASH_FILE="hashes.txt"
LOG_FILE="missing_files.txt"

# Function to generate file hashes
generate_hashes() {
  rm -f "$HASH_FILE" "$LOG_FILE"
  echo "Generating file hashes using $HASH_ALGO..."
  find "$SRC_DIR" -type f | while read -r file; do
      $HASH_ALGO "$file" >> "$HASH_FILE"
  done
}

# Function to create a zip file
create_zip() {
    zip -r "$ZIP_FILE" "$SRC_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create zip file."
        exit 1
    fi
}

# Function to verify files included in the zip
verify_zip_contents() {
    unzip -l "$ZIP_FILE" | awk '{print $4}' | tail -n +4 | head -n -2 > temp_zip_files.txt
    find "$SRC_DIR" -type f > temp_src_files.txt
    comm -23 <(sort temp_src_files.txt) <(sort temp_zip_files.txt) > "$LOG_FILE"
    if [ -s "$LOG_FILE" ]; then
        echo "Warning: Some files were not included in the zip file.  Check $LOG_FILE for details."
    else
        echo "All files are included in the zip file."
    fi
}

# Function to transfer the zip file using rsync
transfer_file() {
    rsync -avz --no-perms "$ZIP_FILE" "$REMOTE_USER"@"$REMOTE_HOST":"$REMOTE_DIR"
      if [ $?  -ne 0 ]; then
        echo "Error: Failed to transfer zip file to the remote server."
        exit 1
    fi
}

# Function to verify integrity on the remote server
verify_remote_integrity() {
  ssh "$REMOTE_USER"@"$REMOTE_HOST" "unzip -l \"$REMOTE_DIR/$ZIP_FILE\" > /tmp/remote_files.txt"
  ssh "$REMOTE_USER"@"$REMOTE_HOST" "$HASH_ALGO \"$REMOTE_DIR/$ZIP_FILE\" > /tmp/remote_hash.txt"

  LOCAL_HASH=$($HASH_ALGO "$ZIP_FILE" | awk '{print $1}')
  REMOTE_HASH=$(ssh "$REMOTE_USER"@"$REMOTE_HOST" "cat /tmp/remote_hash.txt" | awk '{print $1}')

  if [ "$LOCAL_HASH" == "$REMOTE_HASH" ]; then
      echo "File integrity verified: Hashes match."
  else
      echo "Warning: File integrity check failed.  Hashes do not match."
  fi

  rm -f temp_zip_files.txt temp_src_files.txt
}

# Main script execution
generate_hashes
create_zip
verify_zip_contents
transfer_file
verify_remote_integrity
# done
