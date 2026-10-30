#!/usr/bin/env bash
# Rate My Professors Professor API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./professor.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/ratemyprofessors/professor" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=1064107
