# Testing

This document explains how to test the Typst thesis template to verify that all dependencies work and the project is coherent.

## Quick Start

To verify that all dependencies work and the project is coherent, run the included test scripts:

```bash
# Test complete repository structure (from root directory)
bash testing/test.sh

# Test standalone template (simulates "Start from template")
bash testing/test_template_standalone.sh
```

## What the Test Scripts Do

### Main Test Script (`test.sh`)

The main test script performs the following checks:

1. **Typst Installation Check** - Verifies that Typst is installed and accessible
2. **Version Compatibility** - Checks the installed Typst version against the required version
3. **File Integrity** - Verifies all required template files are present
4. **Dependency Detection** - Lists all external package dependencies
5. **Template Compilation** - Compiles a test document using the template
6. **Custom Functions** - Tests all custom functions (caption, todo, subfigure)

### Standalone Template Test (`test_template_standalone.sh`)

This test simulates what users get when they "Start from template":

1. **Isolation** - Creates a temporary directory with only template files
2. **File Verification** - Ensures all necessary files are copied
3. **Path Validation** - Checks that all import paths are relative and correct
4. **Standalone Check** - Verifies the template works without the full repository structure

Both tests are important:
- `test.sh` validates the complete repository
- `test_template_standalone.sh` validates the user experience

## Requirements

- **Typst 0.13.1 or later** - The Typst compiler must be installed on your system
- **Internet connectivity** - Required for first-time package downloads

### Installing Typst

If you don't have Typst installed, download it from the [official releases page](https://github.com/typst/typst/releases).

On Linux:
```bash
curl -fsSL https://github.com/typst/typst/releases/download/v0.13.0/typst-x86_64-unknown-linux-musl.tar.xz -o typst.tar.xz
tar -xf typst.tar.xz
sudo mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/
```

Note: While version 0.13.0 is shown in the example above, version 0.13.1 or later is recommended for full compatibility.

## External Dependencies

This template uses the following external packages from the Typst package repository:

- **@preview/hydra:0.6.2** - For document headers with smart heading display
- **@preview/subpar:0.2.2** - For subfigure functionality with automatic numbering

These packages are automatically downloaded by Typst on first use and cached locally.

## Manual Testing

If you prefer to test manually, you can compile the example file:

```bash
typst compile example.typ output.pdf
```

This will:
1. Download required packages (if not already cached)
2. Compile the template with all chapters
3. Generate a PDF output

## Continuous Integration

The template includes a GitHub Actions workflow (`.github/workflows/test.yml`) that automatically runs tests on every push and pull request.

### Workflow Details

The CI workflow:
- Runs on Ubuntu Latest
- Installs Typst automatically
- Executes the test script
- Uploads test artifacts for inspection

### Viewing CI Results

1. Navigate to the "Actions" tab in the GitHub repository
2. Select the latest workflow run
3. Check the test results and download artifacts if needed

## Troubleshooting

### Network Issues

If you see an error like:
```
failed to download package (Connection Failed: Network unreachable)
```

This means:
- ✅ The template structure is correct
- ✅ All required files are present
- ⚠️ Internet connectivity is needed to download external packages

**Solution**: Ensure you have internet access and run the test again. Packages will be cached after the first successful download.

### Missing Typst

If you see:
```
ERROR: Typst is not installed
```

**Solution**: Install Typst following the instructions in the Requirements section above.

### Compilation Errors

If the template fails to compile with other errors:

1. Check that all template files are present (the test script will list them)
2. Verify your Typst version is compatible (`typst --version`)
3. Try removing the Typst package cache: `rm -rf ~/.cache/typst/packages`
4. Check the error message for specific issues

## Test Output

A successful test run will show:

```
=========================================
Testing Typst Thesis Template
=========================================

✓ Typst found: typst 0.13.0
✓ All required files present
✓ Test document created
✓ Compilation successful!
✓ PDF generated successfully
✓ Custom functions work correctly
✓ Cleanup complete

=========================================
All tests passed successfully! ✓
=========================================
```

## Manual Function Testing

You can also test individual custom functions:

### Caption Function

```typ
#import "template/lib.typ": caption

#figure(
  rect(width: 50%, height: 50pt),
  caption: caption[Short caption][Long detailed description of the figure]
)
```

### TODO Function

```typ
#import "template/lib.typ": todo

#todo[This is a TODO item]
```

### Subfigure Function

```typ
#import "template/lib.typ": subfigure, caption

#subfigure(
  columns: 2,
  figure(rect(width: 40%, height: 40pt), caption: []),
  figure(rect(width: 40%, height: 40pt), caption: []),
  caption: caption[Two subfigures][Description of both subfigures]
)
```

## Contributing

If you make changes to the template:

1. Run `./test.sh` to verify everything still works
2. Ensure the CI workflow passes
3. Update this document if you add new tests or requirements
