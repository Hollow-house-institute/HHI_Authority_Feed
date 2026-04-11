#!/data/data/com.termux/files/usr/bin/bash

DATE=$(date +%Y-%m-%d)

BASE=~/hhi_authority
POSTS=$BASE/posts
LINKEDIN=$BASE/linkedin
DEV=$BASE/dev
MANIFESTS=$BASE/manifests

mkdir -p "$POSTS" "$LINKEDIN" "$DEV" "$MANIFESTS"

POST_FILE="$POSTS/$DATE.md"
LI_FILE="$LINKEDIN/$DATE.txt"
DEV_FILE="$DEV/$DATE.md"
MANIFEST_FILE="$MANIFESTS/$DATE.json"

DOI="https://doi.org/10.5281/zenodo.18615600"
STANDARDS="https://github.com/Hollow-house-institute/Hollow_House_Standards_Library"
GOV="https://github.com/Hollow-house-institute/HHI_GOV_01"

# --- POSTS ---
cat > "$POST_FILE" <<EOT
# HHI Authority Output — $DATE

## Statement
AI systems do not fail at design. They fail at execution.

## Breakdown
AI reflects organizational structure through permissions, workflows, and incentives.
Over time, these patterns become automated and scaled.

## Framework
Behavior → Metrics → Severity → Decision Boundary → Enforcement

## Contrast
Monitoring observes.
Governance decides.

## Canonical References
DOI: $DOI
Standards: $STANDARDS
Governance: $GOV
EOT

# --- LINKEDIN ---
cat > "$LI_FILE" <<EOT
AI systems do not fail at design.
They fail at execution.

Most organizations focus on building AI correctly.
Few control how it behaves under real conditions.

Without enforcement:
- drift accumulates
- escalation is delayed
- risk compounds

Governance must operate at execution time.

DOI: $DOI
EOT

# --- DEV ---
cat > "$DEV_FILE" <<EOT
# Execution-Time Governance — $DATE

AI systems reflect the structure of the organizations that deploy them.

## Mechanism
Permissions, workflows, and incentives encode behavior.

## Failure Mode
Without enforcement:
- drift scales
- escalation delays
- accountability diffuses

## Required Shift
Governance must operate at execution time.

## Framework
Behavior → Metrics → Severity → Decision Boundary → Enforcement

## References
- DOI: $DOI
- Standards: $STANDARDS
- Governance: $GOV
EOT

# --- MANIFEST ---
SHA=$(sha256sum "$POST_FILE" | awk '{print $1}')

cat > "$MANIFEST_FILE" <<EOT
{
  "date": "$DATE",
  "post_file": "$POST_FILE",
  "linkedin_file": "$LI_FILE",
  "dev_file": "$DEV_FILE",
  "sha256": "$SHA",
  "canonical": {
    "doi": "$DOI",
    "standards": "$STANDARDS",
    "governance": "$GOV"
  }
}
EOT

echo "Generated:"
echo "$POST_FILE"
echo "$LI_FILE"
echo "$DEV_FILE"
echo "$MANIFEST_FILE"
