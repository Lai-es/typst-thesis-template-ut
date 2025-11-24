# Typst thesis templates for bachelor and master thesis

This template is designed to write final theses in the field of life sciences with a clean look, offering 1) the automatic generation of a two-column bibliography 2) automatic subfigure-numbering and 3) allows for the display of short captions for figures in the outline.

## Disclaimer

- This is a template and does not have to meet the exact requirements of your university
- It is currently only supported in English

## Getting started

When the template is published to the package repository, the following typst-code will be able to kickstart the template:

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

To verify that all dependencies work and the project is coherent, see [TESTING.md](TESTING.md) for detailed testing instructions.

Quick test:
```bash
./test.sh
```
