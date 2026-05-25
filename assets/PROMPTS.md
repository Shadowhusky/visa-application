# Image generation prompts

The current `icon.png` and `banner.png` use a warmer editorial raster style rather than bare SVG-style line art. Use these prompts with any image-gen tool (DALL·E, Midjourney, Stable Diffusion, ChatGPT's image tool, Gemini, etc.) to regenerate.

> **One caveat about text in images:** most image-gen models still produce wonky letterforms when asked for readable text. The banner prompt below asks for *no text* — render the typography as a separate layer (HTML → PNG, Figma, Sketch, etc.) on top of the generated visual.

---

## Icon — `assets/icon.png` (512 × 512, square)

```
Create an attractive, premium icon for a visa-application software project.
Subject is a closed passport viewed from above, centered, vertical
orientation, with a circular visa stamp and three short abstract document
lines on the cover. Do not include readable letters or words.

Style direction: refined editorial product illustration, Japanese-inspired
restraint but NOT bare SVG. Make it feel like a polished raster icon with
subtle material depth: warm off-white paper background, deep charcoal or
near-black passport outline/cover, delicate paper grain, very soft ambient
shadow, crisp edges, slight ink texture, balanced negative space.

Composition: passport proportion about 2:3, centered with generous margin.
Add a single subtle circular stamp on the lower-right cover area and three
short abstract horizontal marks above it. Optional tiny corner rounding and
slight page-edge detail are allowed, but no extra travel objects.

Palette: warm white, charcoal black, very muted cool gray; restrained
monochrome with depth, no bright colors.
```

**Negative prompt suggestions** (Stable Diffusion / Midjourney): *readable text, letters, numbers, typography, watermark, globe emblem, coat of arms, airplane, flags, busy background, photorealistic passport photo, harsh shadow, neon color, clutter*

**Aspect ratio**: 1:1, output 512×512

---

## Banner — `assets/banner.png` (1600 × 500, wide)

For the banner I recommend a **two-step** approach because image-gen handles type poorly:

### Step 1 — Visual elements only (image-gen)

```
Create a premium, attractive banner visual for a software project that builds
officer-ready visa application document packs.

Canvas and layout: wide 1600×500 composition. Leave the left 58% to 62% as
calm, clean negative space for typography overlay. Put all main visual
interest on the right 38% to 42%. No readable text anywhere in the generated
image.

Right-side visual concept: a refined editorial flat-lay of a visa application
pack: a closed passport, a neat stack of A4 application documents, a checklist
sheet with abstract check marks and short non-readable lines, a cover-letter
sheet, a subtle circular visa stamp, a small calendar/card, and a few orderly
paper edges. The arrangement should clearly communicate: passport +
application form + evidence pack + checklist ready for an appointment.

Style: premium modern editorial illustration with subtle material depth, warm
paper texture, crisp object edges, soft ambient shadows, tasteful composition,
not SVG-flat and not a broken layout placeholder. It should feel polished
enough for a GitHub README hero.

Palette: warm ivory paper background, deep charcoal passport, muted graphite,
soft gray, one restrained accent such as muted burgundy or ink-blue for
stamp/check marks. No bright colors.

Hard avoid: readable words, letters, numbers, typography, watermarks, logos,
flags, airplane, globe emblem, coat of arms, faces, hands, clutter, chaotic
travel collage, harsh shadows, neon gradients, red X or crossed diagonal
lines.
```

**Aspect ratio**: 16:5 (1600×500). If your tool insists on 16:9, generate 1920×540 and crop.

### Step 2 — Overlay typography

Drop the typography on top of the generated visual using HTML, Figma, or any vector editor. The text layout:

- **Top-left, small caps, monospace, grey**: `CLAUDE / SKILL`
- **Centered-left, large sans-serif, dark, weight 500**: `visa-application`
- **Below title, light grey, sans-serif weight 300**: `any visa · any country · officer-ready pack in one session`

Suggested fonts: Inter, Helvetica Neue, or system-ui. Keep the type quiet and editorial so it does not fight the generated texture.

---

## Style consistency

Both images should:

- Use the **same warm paper base** and charcoal/graphite palette.
- Keep the passport shape and stamp language consistent across both.
- Use subtle material depth and grain, but avoid heavy realism.
- Avoid busy travel-collage motifs; the assets should still feel quiet and professional.

If you generate them in separate sessions, generate the icon first and ask the image-gen tool to reference it as the style anchor when generating the banner.

---

## After regenerating

Replace the generated assets:

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
