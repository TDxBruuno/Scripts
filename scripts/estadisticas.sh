#!/bin/bash

OUTPUT_DIR="/Estadisticas"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
OUTPUT_FILE="$OUTPUT_DIR/estadisticas_$TIMESTAMP.txt"

mkdir -p "$OUTPUT_DIR"
top -b -n1 > "$OUTPUT_FILE"
