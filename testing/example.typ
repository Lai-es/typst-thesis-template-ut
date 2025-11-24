// This example imports from template/lib.typ (package entrypoint)
#import "template/lib.typ": *

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
