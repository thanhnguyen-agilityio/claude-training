# Study Hub update

1. `Artifact` read the hub URL. If it differs from `index.html`, save the live version over the file first.
2. Add the card to the matching `<h2>` section (`Working with AI`, `Using Claude`), or a new `<section>` with the same markup (e.g. `Building with Claude`). Use the next `--p1..--p4` unused in that section. Course already on the hub → replace its card.

```html
<a class="course" style="--c:var(--pN)" href="<guide URL>#overview" target="_blank" rel="noopener">
  <div class="top"><h3><Course title></h3><span class="go">Open ↗</span></div>
  <p class="q"><one-line thesis, ≤ 90 chars></p>
  <div class="bar" aria-hidden="true"><!-- one <i></i> per module --></div>
  <div class="chips"><span class="chip"><b>L</b> lessons</span><span class="chip"><b>M</b> modules</span><span class="chip"><b>Q</b> quiz questions</span><span class="chip"><b>F</b> flashcards</span></div>
  <p class="mods"><module short names joined by " · ", & as &amp;></p>
  <span class="path">resources/claude-academy/<slug>/</span>
</a>
```

3. Update the eyebrow (`Claude Academy · <n> courses · <total> lessons`) and the course count in the intro.
4. Publish `index.html` with `url` = the hub URL and no `icon`. Never publish it without `url`: that creates a second hub.
