# Study guide data block

Keep the CSS and render code. Replace:

| Item | Value |
| --- | --- |
| `<title>` | `<Course title> Study Guide` |
| `STORE` | unique localStorage key, e.g. `"mcp101"` (check the other guides' keys) |
| `BASE` | `https://academy.claude.com/courses/<slug>/` |
| `LESSONS` | `{n:["Lesson title","lesson-url-slug"]}` for every lesson |
| `NOTES` | sources for "From your notes" items, e.g. `{readme:"<slug>/README.md · course in one page"}` |
| `M` | modules, schema below |
| `D` | one inline SVG per module (`box()`, `arr()`, `${AR}`), keyed by `m.diagram` |
| `viewOverview()` | title, lesson count, thesis, intro, "About the sources" note |
| `viewCheat()` | one summary table and 4–6 panels |
| comment under `<style>` | one-line layout note naming the sections |

Leave `PRACTICE` unchanged.

```js
{id:"start", c:"--p1",                  // --p1..--p4, one per course section, cycle after 4
 short:"Getting started", sub:"<Section> · L1–2",
 eyebrow:"Lessons 1–2 · <Section>", title:"<module title>", file:"01-<section>.md",
 question:"<question the module answers>",
 take:[["Headline","2–3 sentences", lessonNo /* or NOTES.key */]],     // 4–7
 concepts:[["Term","one-line definition", lessonNo]],                 // become flashcards
 snips:[["Label","copyable prompt, path or command", lessonNo, "when to use"]],
 pit:["pitfall"],
 gaps:["not covered in the notes"],
 diagram:"start",
 quiz:[["Question?",["A","B","C","D"], correctIndex, "why", lessonNo]] // 4–6
}
```

Target: 6–9 modules, 35–45 flashcards. Every item cites a lesson number or `NOTES` key. Write your own quiz questions, never the course quiz. Put anything missing from the notes in `gaps`.

Hub counts: lessons = `Object.keys(LESSONS).length`, modules = `M.length`, quiz = sum of `quiz.length`, flashcards = sum of `concepts.length`. Read them with `javascript_tool` on the open page.
