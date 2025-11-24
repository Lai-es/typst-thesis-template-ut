// Import the template library
// Note: This imports from the local lib.typ in the template directory,
// which allows the template to work standalone.
#import "lib.typ": *

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
