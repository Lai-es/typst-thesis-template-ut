#import "../lib.typ": caption, subfigure

#let results()=[

#lorem(100)

#subfigure(columns:2,
figure(box(rect(width: 40%, height: 40pt)), caption: []),
figure(box(rect(width: 40%, height: 40pt)), caption: []),
caption: caption[Two boxes][There are two of them, can you believe it!]
          )

#lorem(50)

]
