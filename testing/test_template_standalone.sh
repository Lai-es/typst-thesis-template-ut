#!/bin/bash
# Test script to verify the template works standalone (as users would get it)

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "========================================="
echo "Testing Template Standalone Usage"
echo "========================================="

# Create a temp directory to simulate "Start from template"
echo -e "\n${YELLOW}1. Creating isolated test environment...${NC}"
TEST_DIR=$(mktemp -d -t typst-template-test-XXXXXXXXXX)

# Copy only template directory contents (what users get)
echo -e "${YELLOW}2. Copying template files (simulating 'Start from template')...${NC}"
cp -r template/* "$TEST_DIR/"
cd "$TEST_DIR"

echo -e "${GREEN}✓ Template files copied to $TEST_DIR${NC}"

# List copied files
echo -e "\n${YELLOW}3. Verifying copied files...${NC}"
find . -type f | sort

# Check for lib.typ
if [ -f "lib.typ" ]; then
    echo -e "\n${GREEN}✓ lib.typ present in template${NC}"
else
    echo -e "\n${RED}✗ lib.typ missing from template!${NC}"
    echo "Template cannot work standalone!"
    cd /
    rm -rf "$TEST_DIR"
    exit 1
fi

# Check main.typ imports
echo -e "\n${YELLOW}4. Checking import paths in main.typ...${NC}"
if grep -q '#import "lib.typ"' main.typ; then
    echo -e "${GREEN}✓ main.typ uses correct local import${NC}"
else
    echo -e "${RED}✗ main.typ import path incorrect${NC}"
    cd /
    rm -rf "$TEST_DIR"
    exit 1
fi

# Check bibliography paths
echo -e "\n${YELLOW}5. Checking bibliography paths...${NC}"
if grep -q '"bibliography.bib"' chapters/10\ bibliography.typ && \
   grep -q '"nature_squarebrackets.csl"' chapters/10\ bibliography.typ; then
    echo -e "${GREEN}✓ Bibliography uses correct relative paths${NC}"
else
    echo -e "${RED}✗ Bibliography path incorrect${NC}"
    cd /
    rm -rf "$TEST_DIR"
    exit 1
fi

# Check results.typ imports
echo -e "\n${YELLOW}6. Checking custom function imports...${NC}"
if grep -q '#import "../lib.typ"' chapters/8\ results.typ; then
    echo -e "${GREEN}✓ results.typ uses correct import path${NC}"
else
    echo -e "${RED}✗ results.typ import path incorrect${NC}"
    cd /
    rm -rf "$TEST_DIR"
    exit 1
fi

# Verify all required files exist
echo -e "\n${YELLOW}7. Checking for required files...${NC}"
REQUIRED_FILES=(
    "main.typ"
    "lib.typ"
    "bibliography.bib"
    "nature_squarebrackets.csl"
)

ALL_PRESENT=true
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}  ✓${NC} $file"
    else
        echo -e "${RED}  ✗${NC} $file (MISSING)"
        ALL_PRESENT=false
    fi
done

if [ "$ALL_PRESENT" = false ]; then
    echo -e "\n${RED}Some required files are missing!${NC}"
    cd /
    rm -rf "$TEST_DIR"
    exit 1
fi

# Cleanup
cd /
rm -rf "$TEST_DIR"

echo -e "\n${GREEN}========================================="
echo "Template Standalone Test Passed! ✓"
echo "=========================================${NC}"
echo ""
echo "The template structure is correct and will"
echo "work when users 'Start from template'."
echo ""
echo "Note: Actual compilation requires network"
echo "connectivity to download external packages:"
echo "  - @preview/hydra:0.6.2"
echo "  - @preview/subpar:0.2.2"
echo ""
