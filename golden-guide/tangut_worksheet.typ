#import "@preview/cetz:0.3.1": canvas, draw

#set page(paper: "a4", margin: 22mm)

// ── Font ─────────────────────────────────────────────────────────────
// Switch to "Noto Serif Tangut" for Tangut worksheets
#let char-font = "Noto Serif"

// ── Parameters ───────────────────────────────────────────────────────
#let cs     = 1.8   // square cell size (cm = cetz units)
#let li     = 2.0   // left info column width (cm)
#let n-cols = 8

#let ps = cs / 3     // pronunciation strip height
#let ru = cs + ps    // row unit height
#let hs = cs / 2     // half-cell (quarter lines)

// ── Data ─────────────────────────────────────────────────────────────
#let rows-data = (
  ([作], [zuò]),
  ([呼], [hū]),
  ([月], [yuè]),
  ([識], [shí]),
  ([不], [bù]),
  ([時], [shí]),
  ([小], [xiǎo]),
  ([字], [zì]),
  ([山], [shān]),
  ([水], [shuǐ]),
)

// ── Canvas ───────────────────────────────────────────────────────────
#canvas({
  import draw: *

  let n-rows = rows-data.len()
  let W = li + cs * n-cols
  let H = ru * n-rows

  for r in range(n-rows) {
    let (ch, pron) = rows-data.at(r)

    // r=0 → top row; y flipped
    let yb     = float(n-rows - 1 - r) * ru
    let pron-y = yb + cs + ps / 2

    // left info cell
    rect((0, yb), (li, yb + ru), stroke: 0.7pt)

    for c in range(n-cols) {
      let xb   = li + float(c) * cs
      let xcen = xb + hs
      let ycen = yb + hs

      // pronunciation strip
      rect((xb, yb + cs), (xb + cs, yb + ru), stroke: 0.7pt)

      // gray quarter lines
      line((xcen, yb), (xcen, yb + cs),
        stroke: (paint: luma(180), thickness: 0.3pt))
      line((xb, ycen), (xb + cs, ycen),
        stroke: (paint: luma(180), thickness: 0.3pt))

      // square cell border
      rect((xb, yb), (xb + cs, yb + cs), stroke: 0.7pt)

      // 描紅 — first 3 cells
      if c < 3 {
        content((xcen, ycen),
          text(size: 38pt, fill: red.lighten(70%), font: char-font)[#ch])
        content((xcen, pron-y),
          text(size: 7pt, fill: red.lighten(70%))[#pron])
      }
    }
  }

  // outer border
  rect((0, 0), (W, H), stroke: 1.4pt)
})
