# Typst thesis templates for bachelor and master thesis

This template is designed to write final theses in the field of life sciences with a clean look, offering 1) the automatic generation of a two-column bibliography 2) automatic subfigure-numbering and 3) allows for the display of short captions for figures in the outline.

## Disclaimer

- This is a template and does not have to meet the exact requirements of your university
- It is currently only supported in English

## Getting started

The following typst-code will be able to kickstart the template in the future

```typ
#import "@preview/ut-thesis-clean:0.1.0": *

#show: template.with(

)
```

## Custom functions

The caption-function is a slight modification of the original caption of figures:

```typ
#figure(.., caption: caption[short description][more details])
```
This will display the short description in the outline of figures and will show the original figure caption as: 

**Figure X: short description.** more details

Furthermore, the TODO-function is a small QoL-improvement, allowing for highlighting text for later editing:

```typ
#todo[text]
```

Finally, the custom subfigure-function automatically numbers the subfigures with A,B,C... above the top-left corner of the figure:

```typ
#subfigure(columns: 2,
figure(.., caption: []),
figure(.., caption: []),
..,
caption: [caption describing the whole figure, including subfigures]
```

Note that this does **not** allow for captioning of the subfigures directly, but instead requires a description in the total figure caption

## Testing

To verify that all dependencies work and the project is coherent, run the included test script:

```bash
./test.sh
```

This test script will:
1. Check that Typst is installed
2. Verify all required files are present
3. List external package dependencies
4. Compile a test document using the template
5. Test all custom functions (caption, todo, subfigure)

### Requirements

- Typst 0.13.0 or later
- Internet connectivity (for first-time package downloads)

### External Dependencies

This template uses the following external packages:
- `@preview/hydra:0.6.2` - For document headers
- `@preview/subpar:0.2.2` - For subfigure functionality

These packages are automatically downloaded by Typst on first use.

### Continuous Integration

The template includes a GitHub Actions workflow that automatically runs tests on every push and pull request to ensure the template remains functional.
