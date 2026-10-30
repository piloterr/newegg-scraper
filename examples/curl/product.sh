#!/usr/bin/env bash
# Newegg Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/newegg/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=N82E16819113844
