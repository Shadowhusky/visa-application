# Image generation prompts

The current `icon.png` and `banner.png` are placeholders rendered from hand-drawn SVG. Use these prompts with any image-gen tool (DALL·E, Midjourney, Stable Diffusion, ChatGPT's image tool, Gemini, etc.) to regenerate.

> **One caveat about text in images:** most image-gen models still produce wonky letterforms when asked for readable text. The banner prompt below asks for *no text* — render the typography as a separate layer (HTML → PNG, Figma, Sketch, etc.) on top of the generated visual.

---

## Icon — `assets/icon.png` (512 × 512, square)

```
A minimalist line-art icon of a passport viewed from above, in extreme
Japanese-style 极简 (minimalist) flat illustration. Pure black outlines on a
pure white background. No shading, no gradient, no color, no shadows, no
texture. The passport is shown closed, vertical orientation, centered, with
clean geometric proportions roughly 2:3. On the cover of the passport,
slightly off-center toward the lower right, is a single circular outline
representing a visa stamp. Above the stamp, three short horizontal lines of
varying lengths suggesting lines of text or a name. All strokes are uniform
weight, slightly chunky (about 4% of icon width). The composition has
generous breathing room around the edges. Crisp vector aesthetic, the kind of
icon that would sit comfortably in a 16×16 tab favicon as well as a 512×512
app icon. No words or letters anywhere in the image.
```

**Negative prompt suggestions** (Stable Diffusion / Midjourney): *text, words, letters, typography, color, gradient, shadow, 3D, photorealistic, busy, ornate, detailed background*

**Aspect ratio**: 1:1, output 512×512

---

## Banner — `assets/banner.png` (1600 × 500, wide)

For the banner I recommend a **two-step** approach because image-gen handles type poorly:

### Step 1 — Visual elements only (image-gen)

```
A wide, ultra-minimalist horizontal composition in 极简 (Japanese minimalist
flat illustration) style for a software project banner. 1600×500 aspect ratio.
Pure white background, no color, no gradient, no shadow, no texture. The left
85% of the canvas is empty white space intended for typography to be added in
a later step — leave it completely blank. The right 15% contains a single
small line-art illustration: a passport viewed from the front, vertical
orientation, with a circular visa stamp outline on its lower right corner and
three short horizontal lines suggesting text above the stamp. All strokes are
uniform weight, pure black, line-art only, no fills. The illustration is
small relative to the canvas, occupying maybe one-fifth of the height. Two
thin horizontal black hairlines run across the entire width of the canvas —
one near the top edge (about 20% from the top), one near the bottom (about
85% from the top), framing the central white space. The aesthetic is
restrained, library-card-like, the kind of thing you'd see at the top of a
Notion doc or a GitHub README in 2026.
```

**Aspect ratio**: 16:5 (1600×500). If your tool insists on 16:9, generate 1920×540 and crop.

### Step 2 — Overlay typography

Drop the typography on top of the generated visual using HTML, Figma, or any vector editor. The text layout:

- **Top-left, small caps, monospace, grey**: `CLAUDE / SKILL`
- **Centered-left, large sans-serif, dark, weight 500**: `visa-application`
- **Below title, light grey, sans-serif weight 300**: `any visa · any country · officer-ready pack in one session`

Suggested fonts: Inter, Helvetica Neue, or system-ui. Avoid serifs — they fight the minimalist line-art.

If you don't want to compose layers, you can use the current `banner.svg` as a base — the typography is already laid out correctly there; you just need to swap the passport silhouette on the right for a generated, higher-quality version.

---

## Style consistency

Both images should:

- Use the **same black** (`#111111` or pure `#000000`, consistent across both)
- Use the **same stroke weight** so they look like a family
- Reserve **all interior space for white** — no fills, no swatches
- Avoid **any photographic or 3D rendering** — keep flat, vector, geometric

If you generate them in separate sessions, generate the icon first and ask the image-gen tool to reference it as the style anchor when generating the banner.

---

## After regenerating

Replace the placeholders:

```bash
# from your image-gen output directory
mv ~/Downloads/visa-icon.png    ~/Desktop/visa-application/assets/icon.png
mv ~/Downloads/visa-banner.png  ~/Desktop/visa-application/assets/banner.png
```

Then commit:

```bash
cd ~/Desktop/visa-application
git add assets/icon.png assets/banner.png
git commit -m "Replace placeholder icon and banner with generated art"
git push
```
