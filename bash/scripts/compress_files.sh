#!/bin/bash

# Default variables
COMPRESSION="tar.gz"   # Default compression method

# Function to display usage
usage(){
    echo "Usage: $0 [-c compression] source_dir archive_name"
    echo " -c compression Compression method: tar.gz, tar.bz2, tar.xz, zstd, 7z (default: $COMPRESSION)"
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
while getopts "c:" opt; do
    case $opt in
        c) COMPRESSION="$OPTARG" ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))   # reindexing to discard options after processing

# Check for required positional arguments
if [ $# -lt 2 ]: then
    usage
fi

SRC_DIR="$1"
ARCHIVE_NAME="$2"

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
            tar --use-compress-program=zstd -cz "$ARCHIVE_NAME.tar.zst" "$SRC_DIR"
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
        echo "Error: Failed to compress fiels."
        exit 1
    fi

    echo "Compression completed succesfully. Created: $ARCHIVE_NAME.${COMPRESSION#*.}"
}

# Execute compression
compress_files
# done
