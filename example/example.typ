#import "../src/anshere.typ": *
#set text(font: ("Noto Serif CJK JP"))

#anshere((
  q(), // q()で質問を追加
  q(),
  q-blank, // q-blankで空白
  q-break, // q-breakで改行

  ..(q(),) * 3, // 繰り返しを使うと便利
  q-break,
  
  q(content: [#h(1fr)m / s]), // contentで解答欄に書き込み
  q(content: [#h(1fr)T#h(10pt)/#h(10pt)F#h(1fr)]),
  q(label: [$2x + 1$]), // labelで質問番号を自由に変更
  q-break,
  
  q(counter-reset: 1), // counter-resetで質問番号をリセット
  q(),
  q-blank,
  q-break,

  q(numbering-width: 50pt), // numbering-widthで質問番号の幅を変更
  q(hide-numbering: true) // hide-numberingで質問番号を非表示
))

#anshere((
  ..(q(numbering: "a"),) * 4, // numberingで質問番号の形式を変更
  ..(q-blank,) * 2,
  q-break,

  q(counter-reset: 1),
  q(),
  q(counter-skip: 1), // counter-skipで質問番号をスキップ
  q(),
  q(counter-skip: 1),
  q(),
  q-break,
  
  q(counter-reset: 1),
  q(),
  q(counter-skip: -1),
  q(),
  q(counter-skip: -1),
  q(),
  q-break,
))

#anshere((
  q(children: ( // childrenでネストされた質問を追加
    q(),
    q(),
    q(children: (
        q(),
        q(),
    )),
  )),
))

#anshere((
  q(children: (
    q(),
    q(children: (
      q(),
      q(children: (
        q(),
        q(),
      )),
    )),
  )),
), numberings: ("1", "1", "(1)", "あ", "a")) // 質問番号の形式を一括指定
