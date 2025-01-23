#!/bin/bash

# Default variables
COMPRESSION="tar.gz"   # Default compression method
HASH_ALGO="sha1sum" # Default hash algorithm, can be set to sha256sum
HASH_FILE="hashes.txt"
LOG_FILE="missing_files.txt"
TEMP_COMPRESSED_FILES="temp_compressed_files.txt"
TEMP_SRC_FILES="temp_src_files.txt"

# Function to display usage
usage(){
    echo "Usage: $0 [-c compression][-a hash_algo] source_dir archive_name"
    echo " -c compression Compression method: tar.gz, tar.bz2, tar.xz, zstd, 7z (default: $COMPRESSION)"
    echo " -a hash_algo  Hash algorithm (sha1sum or sha256sum, default: $HASH_ALGO)"
    echo
    echo "Supported Compression Methods:"
    echo "  -  tar.gz   : Medium compression, fast, widely supported"
    echo "  -  tar.bz2  : High compression, slower, widely supported"
    echo "  -  tar.xz   : Very high compression, slowest, widely supported"
    echo "  -  zstd     : High compression, very fast, modern tool"
    echo "  -  7z       : Very high compression, slow, supports encryption"
    echo
    exit 1
}


# Parse command-line options
while getopts "c:a:" opt; do
    case $opt in
        c) COMPRESSION="$OPTARG" ;;
        a) HASH_ALGO="$OPTARG" ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))   # reindexing to discard options after processing

# Check for required positional arguments
if [ $# -lt 2 ]; then
    usage
fi

SRC_DIR="$1"
ARCHIVE_NAME="$2"

# Function to generate file hashes
generate_hashes() {
  rm -f "$HASH_FILE" "$LOG_FILE"
  echo "Generating file hashes using $HASH_ALGO..."
  find "$SRC_DIR" -type f | while read -r file; do
      $HASH_ALGO "$file" >> "$HASH_FILE"
  done
}

# Function to compress files
compress_files(){
    case "$COMPRESSION" in
        tar.gz)
            tar -czf "$ARCHIVE_NAME.tar.gz" "$SRC_DIR"
            ;;
        tar.bz2)
            tar -cjf "$ARCHIVE_NAME.tar.bz2" "$SRC_DIR"
            ;;
        tar.xz)
            tar -cJf "$ARCHIVE_NAME.tar.xz" "$SRC_DIR"
            ;;
        zstd)
            tar --use-compress-program=zstd -cf "$ARCHIVE_NAME.tar.zst" "$SRC_DIR"
            ;;
        7z)
            7z a "$ARCHIVE_NAME.7z" "$SRC_DIR"
            ;;
        *)
            echo "Error: Unsupported compression method '$COMPRESSION',"
            exit 1
            ;;
    esac

    if [ $? -ne 0 ]; then
        echo "Error: Failed to compress files."
        exit 1
    fi

    echo "Compression completed succesfully. Created: $ARCHIVE_NAME.${COMPRESSION#*.}"
}

# Function to verify if all files were included
verify_compression_integrity(){
    echo "Verifying compression integrity..."
    case "$COMPRESSION" in
        tar.gz)
            tar -tzf "$ARCHIVE_NAME.tar.gz" > "$TEMP_COMPRESSED_FILES"
            ;;
        tar.bz2)
            tar -tjf "$ARCHIVE_NAME.tar.bz2" > "$TEMP_COMPRESSED_FILES"
            ;;
        tar.xz)
            tar -tJf "$ARCHIVE_NAME.tar.xz" > "$TEMP_COMPRESSED_FILES"
            ;;
        zstd)
            tar --use-compress-program=unzstd -tf "$ARCHIVE_NAME.tar.zst" > "$TEMP_COMPRESSED_FILES"
            ;;
        7z)
            7z l "$ARCHIVE_NAME.7z" | awk '/^-/{print $NF}' > "$TEMP_COMPRESSED_FILES"
            ;;
        *)
            echo "Error: Unsupported compression format."
            exit 1
            ;;
    esac

    find "$SRC_DIR" -type f > "$TEMP_SRC_FILES"
    comm -23 <(sort "$TEMP_SRC_FILES") <(sort "$TEMP_COMPRESSED_FILES") > "$LOG_FILE"
    if [ -s "$LOG_FILE" ]; then
        echo "Warning: Some files were not included in the zip file.  Check $LOG_FILE for details."
    else
        echo "All files are included in the zip file."
    fi
}

# Main scipt execution
echo "Starting compression task..."
generate_hashes
compress_files
verify_compression_integrity
# done
