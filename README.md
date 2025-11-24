# Typst thesis templates for bachelor and master thesis

This template is designed to write final theses in the field of life sciences with a clean look, offering 1) the automatic generation of a two-column bibliography 2) automatic subfigure-numbering and 3) allows for the display of short captions for figures in the outline.

## Disclaimer

- This is a template and does not have to meet the exact requirements of your university
- It is currently only supported in English

## Getting started

This template is used best with the "Start from template"-option in the Typst web-app, since all files are then automatically added.
When the template is published to the package repository, the following typst-code will be able to kickstart the template:

```typ
#import "@preview/ut-thesis-clean:0.1.0": *

#import "chapters/1 title-page.typ": title-page
#import "chapters/2 declaration.typ": declaration
#import "chapters/3 abstract.typ": abstract
#import "chapters/4 acknowledgements.typ": acknowledgments
#import "chapters/5 abbreviations.typ": abbreviations
#import "chapters/6 introduction.typ": introduction
#import "chapters/7 methods.typ": methods 
#import "chapters/8 results.typ": results
#import "chapters/9 discussion.typ": discussion
#import "chapters/10 bibliography.typ": bibliography
#import "chapters/11 appendix.typ": appendix


#show: template.with(
title-page: title-page(), 
declaration: declaration(),
abstract: abstract(),
acknowledgements: acknowledgements(),
abbreviations: abbreviations(),
introduction: introduction(),
methods: methods(),
results: results(),
discussion: discussion(),
bibliography: bibliography(),
appendix: appendix()
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
