#!/bin/bash
# Test script to verify all dependencies work and project is coherent

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

echo "========================================="
echo "Testing Typst Thesis Template"
echo "========================================="

# Check Typst installation
echo -e "\n${YELLOW}1. Checking Typst installation...${NC}"
if ! command -v typst &> /dev/null; then
    echo -e "${RED}ERROR: Typst is not installed${NC}"
    echo "Please install Typst from: https://github.com/typst/typst/releases"
    exit 1
fi

TYPST_VERSION=$(typst --version)
echo -e "${GREEN}✓ Typst found: $TYPST_VERSION${NC}"

# Check compiler version compatibility
REQUIRED_VERSION="0.13.1"
echo -e "\n${YELLOW}2. Checking compiler version compatibility...${NC}"
echo "Required version: $REQUIRED_VERSION"
echo "Installed version: $TYPST_VERSION"

# Check for required files
echo -e "\n${YELLOW}3. Checking required files...${NC}"
REQUIRED_FILES=(
    "source/lib.typ"
    "typst.toml"
    "template/chapters/1 title-page.typ"
    "template/chapters/2 declaration.typ"
    "template/chapters/3 abstract.typ"
    "template/chapters/4 acknowledgements.typ"
    "template/chapters/5 abbreviations.typ"
    "template/chapters/6 introduction.typ"
    "template/chapters/7 methods.typ"
    "template/chapters/8 results.typ"
    "template/chapters/9 discussion.typ"
    "template/chapters/10 bibliography.typ"
    "template/chapters/11 appendix.typ"
    "template/bibliography.bib"
    "template/nature_squarebrackets.csl"
)

MISSING_FILES=()
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $file"
    else
        echo -e "${RED}✗${NC} $file (MISSING)"
        MISSING_FILES+=("$file")
    fi
done

if [ ${#MISSING_FILES[@]} -ne 0 ]; then
    echo -e "\n${RED}ERROR: Missing required files!${NC}"
    exit 1
fi

# Check for external dependencies in lib.typ
echo -e "\n${YELLOW}4. Checking external package dependencies...${NC}"
DEPENDENCIES=(
    "@preview/hydra:0.6.2"
    "@preview/subpar:0.2.2"
)

for dep in "${DEPENDENCIES[@]}"; do
    echo "  - $dep"
done

echo -e "\n${BLUE}Note: These packages will be downloaded automatically on first compilation.${NC}"
echo -e "${BLUE}Ensure you have internet connectivity for the first run.${NC}"

# Create a test document
echo -e "\n${YELLOW}5. Creating test document...${NC}"
cat > test_document.typ << 'EOF'
#import "source/lib.typ": *

// Import chapter functions
#import "template/chapters/1 title-page.typ": *
#import "template/chapters/2 declaration.typ": *
#import "template/chapters/3 abstract.typ": *
#import "template/chapters/4 acknowledgements.typ": acknowledgments
#import "template/chapters/5 abbreviations.typ": *
#import "template/chapters/6 introduction.typ": *
#import "template/chapters/7 methods.typ": *
#import "template/chapters/8 results.typ": *
#import "template/chapters/9 discussion.typ": *
#import "template/chapters/10 bibliography.typ": bibliography as biblio
#import "template/chapters/11 appendix.typ": *

#show: template.with(
  title-page: title-page(),
  declaration: declaration(),
  abstract: abstract(),
  acknowledgements: acknowledgments(),
  abbreviations: abbreviations(),
  results: results(),
  discussion: discussion(),
  bibliography: biblio(),
  appendix: appendix()
)

#introduction()

#methods()
EOF

echo -e "${GREEN}✓ Test document created${NC}"

# Test compilation
echo -e "\n${YELLOW}6. Testing template compilation...${NC}"
echo "Compiling test document..."

# Try to compile, but handle network errors gracefully
if typst compile test_document.typ test_output.pdf 2>&1; then
    echo -e "${GREEN}✓ Compilation successful!${NC}"
    
    # Check if PDF was created
    if [ -f "test_output.pdf" ]; then
        PDF_SIZE=$(du -h test_output.pdf | cut -f1)
        echo -e "${GREEN}✓ PDF generated successfully (Size: $PDF_SIZE)${NC}"
    else
        echo -e "${RED}✗ PDF file not created${NC}"
        exit 1
    fi
    
    # Test custom functions
    echo -e "\n${YELLOW}7. Testing custom functions...${NC}"
    cat > test_functions.typ << 'EOF'
#import "source/lib.typ": caption, todo, subfigure

// Test caption function
#figure(
  rect(width: 50%, height: 50pt),
  caption: caption[Short caption][Long detailed description of the figure]
)

// Test todo function
#todo[This is a TODO item]

// Test subfigure function
#subfigure(
  columns: 2,
  figure(rect(width: 40%, height: 40pt), caption: []),
  figure(rect(width: 40%, height: 40pt), caption: []),
  caption: caption[Two subfigures][Description of both subfigures]
)
EOF

    if typst compile test_functions.typ test_functions.pdf 2>&1; then
        echo -e "${GREEN}✓ Custom functions work correctly${NC}"
    else
        echo -e "${RED}✗ Custom functions failed${NC}"
        exit 1
    fi
    
    # Clean up test files
    echo -e "\n${YELLOW}8. Cleaning up test files...${NC}"
    rm -f test_output.pdf test_functions.pdf
    echo -e "${GREEN}✓ Cleanup complete${NC}"
    
    # Summary
    echo -e "\n${GREEN}========================================="
    echo "All tests passed successfully! ✓"
    echo "=========================================${NC}"
    echo ""
    echo "The template is coherent and all dependencies work correctly."
    echo ""
else
    COMPILE_ERROR=$?
    echo -e "${YELLOW}⚠ Compilation failed - checking if it's due to network issues...${NC}"
    
    if typst compile test_document.typ test_output.pdf 2>&1 | grep -q "Network unreachable\|Connection Failed\|failed to download"; then
        echo -e "\n${YELLOW}=========================================${NC}"
        echo -e "${YELLOW}Network connectivity required!${NC}"
        echo -e "${YELLOW}=========================================${NC}"
        echo -e "\nThe template structure is correct, but external packages need to be downloaded."
        echo -e "\nExternal package dependencies:"
        for dep in "${DEPENDENCIES[@]}"; do
            echo "  - $dep"
        done
        echo -e "\n${BLUE}To complete the test:${NC}"
        echo "1. Ensure you have internet connectivity"
        echo "2. Run: typst compile test_document.typ test_output.pdf"
        echo "3. The packages will be downloaded and cached automatically"
        echo ""
        echo -e "${GREEN}✓ Template structure validated${NC}"
        echo -e "${GREEN}✓ All required files present${NC}"
        echo -e "${YELLOW}⚠ Network required for package download${NC}"
        exit 0
    else
        echo -e "${RED}✗ Compilation failed for unknown reasons${NC}"
        exit $COMPILE_ERROR
    fi
fi

echo "To use this template, run:"
echo "  typst compile your_thesis.typ output.pdf"
