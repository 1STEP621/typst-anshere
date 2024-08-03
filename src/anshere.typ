#let (q, q-break, q-blank, anshere) = {
  let q-break = "q-break"

  let q(
    content: h(1fr),
    label: auto,
    numbering: auto,
    numbering-width: auto,
    hide-numbering: false,
    counter-reset: none,
    counter-skip: none,
    children: none,
  ) = (
    content: content,
    label: label,
    numbering: numbering,
    numbering-width: numbering-width,
    hide-numbering: hide-numbering,
    counter-reset: counter-reset,
    counter-skip: counter-skip,
    children: children,
  )
  let q-blank = "q-blank"

  let counter = counter("anshere-counter")

  let questions-to-grid(questions, numberings, depth: 2) = {
    questions.map(question => if question == q-blank {
      grid.cell([#h(1fr)])
    } else {
      grid(
        columns: (
          if question.label == auto {
            if question.numbering-width == auto {
              27pt
            } else {
              question.numbering-width
            }
          } else {
            if question.numbering-width == auto {
              auto
            } else {
              question.numbering-width
            }
          },
          1fr,
        ),
        grid.cell(
          inset: 10pt,
          stroke: if question.hide-numbering {
            (top: 1pt, bottom: 1pt, left: 1pt, right: none)
          } else {
            1pt
          },
          align: horizon + center,
          [
            #counter.step(level: depth)
            #context {
              if question.counter-reset != none {
                let value = {
                  let x = counter.get()
                  x.at(depth - 1) = question.counter-reset
                  x
                }
                counter.update(value)
              }
            }
            #context {
              if question.counter-skip != none {
                let value = {
                  let x = counter.get()
                  x.at(depth - 1) = x.at(depth - 1) + question.counter-skip
                  x
                }
                counter.update(value)
              }
            }
            #let fmt = if question.numbering == auto {
              numberings.at(depth - 1)
            } else {
              question.numbering
            }
            #context if question.hide-numbering {
              [#sym.zws]
            } else {
              if question.label == auto {
                numbering(fmt, counter.get().last())
              } else {
                [#question.label#sym.zws] // 行の高さがずれるのを防ぐ
              }
            }
          ],
        ),
        if question.children == none {
          grid.cell(
            stroke: if question.hide-numbering {
              (top: 1pt, bottom: 1pt, left: none, right: 1pt)
            } else {
              1pt
            },
            inset: 10pt,
            align: horizon,
            question.content,
          )
        } else {
          grid(..questions-to-grid(question.children, numberings, depth: depth + 1))
        },
      )
    })
  }

  let anshere(questions, numberings: ("1", "1", "(1)", "1")) = {
    grid(
      columns: 2,
      gutter: 10pt,
      grid.cell(
        rect(
          stroke: 1pt,
          inset: 10pt,
          [
            #counter.step(level: 1)
            #context numbering(numberings.at(0), counter.get().last())
          ],
        ),
      ),
      grid(
        ..questions.split(q-break).filter(e => e.len() > 0).map(questions => grid(
          columns: questions.len(),
          ..questions-to-grid(questions, numberings)
        ))
      ),
    )
  }

  (q, q-break, q-blank, anshere)
}
