<p align="center">
  <img src="assets/banner.png" alt="visa-application banner" />
</p>

<p align="center">
  <a href="#english">English</a> ·
  <a href="#中文">中文</a> ·
  <a href="#español">Español</a> ·
  <a href="#हिन्दी">हिन्दी</a>
</p>

---

<a id="english"></a>
## English

A Claude Code skill that takes you from *"I need a visa"* to a printed, officer-ready document pack — in one session.

### Why

Visa rules drift every quarter. Half the third-party guides recycle 2019 information. The consulate site is two clicks deep and three years stale. Miss one document and you wait another month for a new appointment.

This skill keeps the rules current and the paperwork tidy. You handle what only you can — flights, photos, signing things. It handles the rest.

### What it produces

Every application gets its own folder with browser-viewable HTML documents, matching PDFs for print, and a numbered Print Pack in the order an officer flips through them.

<details>
<summary><b>Application Status Tracker</b> — the single source of truth across sessions</summary>
<br>
<p align="center"><img src="assets/demo-status.png" alt="Application status page showing trip details, appointment info, costs, and progress checklist" width="800" /></p>

Tracks every phase of your application: research, appointment booking, document assembly, submission, and outcome. When you come back days or weeks later, the skill reads this file and picks up exactly where you left off. Status badges update automatically — from **IN PROGRESS** through **SUBMITTED** to **GRANTED** or **REFUSED**.

<p align="center"><img src="assets/demo-status-granted.png" alt="Application status page showing granted visa with outcome details" width="800" /></p>

Once granted, the visa details (sticker number, validity, entries) are captured and saved to your reusable profile — so the next Schengen application auto-fills the "previous visas in last 3 years" question.
</details>

<details>
<summary><b>Appointment-Day Checklist</b> — your one-page cheat sheet</summary>
<br>
<p align="center"><img src="assets/demo-checklist.png" alt="Checklist showing before-leaving-home items, stack order, officer questions, and cross-checks" width="800" /></p>

Prints as the **cover sheet** of your Print Pack (file `00`). Includes:

- **Before leaving home** — what to sign, what to bring, what card to carry
- **Stack order** — every document numbered in the order the officer expects them
- **Likely officer questions** — with suggested answers drawn from your actual documents
- **Cross-checks verified** — passport validity, insurance coverage, fund minimums
- **Verify yourself** — things the skill can't confirm (UK visa expiry, guest counts)
- **Warning banners** — critical flags like residence permit expiry timing
</details>

<details>
<summary><b>Cover Letter</b> — one page, formal, ready to sign</summary>
<br>
<p align="center"><img src="assets/demo-cover-letter.png" alt="Cover letter addressed to consulate with applicant details and trip purpose" width="700" /></p>

Addressed to the correct consulate, with your real employment details, trip dates, prior visa history, and a reference to the enclosed evidence. Generated from your profile — you review it, sign it, done.
</details>

<details>
<summary><b>Print Pack</b> — numbered, ordered, print-and-go</summary>

```
Print Pack/
├── 00 - CHECKLIST.pdf
├── 01 - VFS Appointment Confirmation.pdf
├── 02 - Visa Application Form - SIGN.pdf
├── 03 - Cover Letter - SIGN.pdf
├── 04 - Passport - Bio Page (photocopy).pdf
├── 05 - UK Immigration Status (eVisa).pdf
├── 06 - UK Share Code.pdf
├── 07 - Travel Insurance Certificate.pdf
├── 08 - Flight - Outbound.pdf
├── 09 - Flight - Return.pdf
├── 10 - Hotel Reservation.pdf
├── 11 - Employment Letter (signed).pdf
├── 12 - Payslip - Month 1.pdf
├── 13 - Payslip - Month 2.pdf
├── 14 - Payslip - Month 3.pdf
└── 15 - Bank Statement (3 months).pdf
```

Print all files, single-sided, A4, keep in numbered order. The officer flips through them in sequence.
</details>

### How it works

The skill runs a **9-phase workflow** — strict order, no skipping, same every time:

| Phase | What happens |
|-------|-------------|
| **0. Search** | Finds your existing profile and any prior application folders on disk |
| **1. Ask** | Interactive questions via structured UI — cold start (4 questions) or warm start (resume / new / update) |
| **2. Profile** | Reads your passport, payslips, bank statements via document intake — you drop files, it extracts data |
| **3. Folder** | Locates or creates the application folder (iCloud Drive, Documents, Desktop, or custom) |
| **4. Research** | Hits the consulate page, visa-centre operator, and a third-party guide. Cross-validates every material claim. Flags disagreements. |
| **5. Appointment** | Books or captures the VFS/TLScontact appointment. Runs timing cross-checks against processing time and document freshness. |
| **6. Documents** | Generates cover letter, employment letter draft, fills the application form (portal → interactive PDF → vision overlay → manual fallback), assembles the Print Pack |
| **7. Cross-check** | Final report: document manifest, compliance checks, next steps. Written to `application_status.html` for multi-session continuity. |
| **8. Post-submission** | Tracks status, captures granted visa details into reusable profile, handles refusals and appeals |

### Demo

```
You:    I need a Schengen visa to the Netherlands from the UK, late July.

Skill:  [structured questions for dates and details]

You:    24th to 27th.

Skill:  Got it — Netherlands Schengen tourist, 4 days, applying from London.
        Profile on file from your last application.
        Researching against netherlandsworldwide.nl, VFS Global UK,
        and Wise 2026 guide…

        Cross-validated: EUR 90 fee + GBP 18 VFS, EUR 30k insurance,
        35×45mm photo, online form mandatory from 1 Jun 2026, 15–21 day
        processing, 59-month biometric reuse from your France 2025 capture.

        [books appointment via VFS Global]

        Generating cover letter, checklist, application status tracker…
        Assembling Print Pack (15 documents).

        ⚠ Flag: your UK Graduate Visa must be valid until at least
        27 Aug 2026 (1 month past trip end) — verify via UKVI account.

You:    [prints, signs, walks in]

        (… 2 weeks later …)

You:    Visa granted — here's the sticker.

Skill:  Captured: NLD 7829104, valid 20 Jul → 20 Jan 2027, multiple
        entries, 90 days. Saved to visa_history — the next Schengen
        application auto-fills "previous visas in last 3 years".
```

**First visa: ~45 minutes. Every visa after: ~10 minutes.**

### Key features

- **Reusable profile** at `~/.claude/visa-profile.json` — passport, address, employer, banking, visa history. Built once from document intake (drop your passport scan, payslips, bank statement — the skill reads them). Replayed forever.
- **Cross-validated research** — consulate page first, visa-centre operator second, third-party guide third. Two sources minimum for every material claim. Source URLs and dates cited.
- **Smart form filling** — 4-tier strategy: online portal (with 2D barcode), interactive PDF fields, vision-driven coordinate overlay, manual data sheet as last resort. The skill fills the form itself; asking you to do it by hand is the fallback, not the default.
- **Multi-session continuity** — `application_status.html` tracks progress. Come back days later and the skill resumes at the first incomplete phase.
- **Document intake** — drop a file, get structured data back. Passport scan → name, number, expiry. Payslip → salary, employer, NI number. Hotel PDF → dates, address, guest count. Cross-checked against the profile automatically.
- **Timing intelligence** — warns about stale documents, processing time vs trip date, peak-season backlogs, passport expiry traps, insurance date gaps.
- **Questionnaire forms** — when the skill needs 4+ answers (DS-160 fields, family details, travel history), it generates an interactive HTML form you fill in your browser — not a chat wall of questions.
- **Dual output** — every generated document is both HTML (browser-viewable) and PDF (print-ready). User-provided uploads stay in their original format.

### Install

**macOS / Linux / WSL / Git Bash:**

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

**Windows PowerShell:**

```powershell
New-Item -ItemType Directory -Force -Path "$HOME\.claude\skills" | Out-Null
git clone https://github.com/Shadowhusky/visa-application.git "$HOME\.claude\skills\visa-application"
```

No git, or hitting any issue? See [INSTALL.md](INSTALL.md) for ZIP download, verification, troubleshooting (corporate proxies, paths with spaces, `/skills` not showing the skill, etc).

Then in any Claude Code session, mention a visa. The skill takes over.

### Coverage

Schengen (all 27), US B1/B2, UK Visitor, Japan, Canada, China, Australia — any country with a documented visa process. Country-specific quirks are handled: VFS vs TLScontact routing, online portal detection, biometric reuse rules, EES border procedures.

### What it won't do

- Asylum, family reunification, or anything that needs a real immigration lawyer
- Enter payment card details — the skill always stops at the payment step
- Make promises about visa outcomes — it assembles the strongest possible file, not guarantees
- Store your data remotely — everything is local files on your machine

### Privacy

Profile data is **local only**, never transmitted. Application folders default to `~/Documents/Visa Applications/{Country}-{Year}/` or iCloud Drive. The skill reads your documents to extract data but never sends them anywhere.

### File structure

```
visa-application/
├── SKILL.md                    ← the 9-phase workflow (what Claude reads)
├── README.md                   ← this file
├── INSTALL.md                  ← installation & troubleshooting
├── LICENSE                     ← MIT
├── references/
│   ├── research-protocol.md    ← how to research and cross-validate sources
│   ├── document-checklist.md   ← standard document lists by visa type
│   ├── known-portals.md        ← online application portals, booking URLs, country quirks
│   ├── profile-schema.md       ← visa-profile.json schema
│   ├── form-filling-strategy.md ← 4-tier strategy for filling application forms
│   └── visa-scenarios.md       ← renewal, family, business, transit, student, refusal/appeal
├── templates/
│   ├── cover-letter.html       ← cover letter, A4 single page
│   ├── employment-letter.html  ← employment letter, A4 single page
│   ├── checklist.html          ← Print Pack cover-sheet checklist
│   ├── application-status.html ← application status tracker
│   ├── form-data.html          ← Tier 4 manual-transcription data sheet
│   └── questionnaire.html      ← interactive HTML form for bulk data collection
├── scripts/
│   ├── render-pdf.sh           ← HTML → PDF via Chrome headless
│   ├── find-existing.sh        ← search for existing profile / application folders
│   └── build-print-pack.sh     ← assemble the numbered Print Pack
├── assets/                     ← banner, icons, demo screenshots
└── tests/
    ├── smoke-test.sh           ← structural sanity check
    └── scenarios.md            ← 11 end-to-end behavioural scenarios
```

### License

MIT.

---

<a id="中文"></a>
## 中文

一个 Claude Code 技能，帮你从「我要办签证」一路走到打印就能交、官员认可的完整材料包。

### 为什么

签证规则每个季度都在变。网上一半的第三方指南还在沿用 2019 年的旧信息。领事馆官网藏得深、几年不更新。漏一份文件就要再等一个月重新预约。

这个技能让规则保持最新，让材料井井有条。你只管做只有你能做的事 —— 订机票、拍照片、签字。其余的它来搞定。

### 产出物

每次申请都有自己的文件夹，包含浏览器可查看的 HTML 文档、配套的打印用 PDF，以及按官员翻阅顺序编号的 Print Pack。

<details>
<summary><b>申请状态跟踪页</b> —— 跨会话的唯一真相源</summary>
<br>
<p align="center"><img src="assets/demo-status.png" alt="申请状态页" width="800" /></p>

跟踪申请的每个阶段。几天或几周后回来，技能读取此文件并从中断处继续。状态从 <b>IN PROGRESS</b> 自动更新到 <b>GRANTED</b> 或 <b>REFUSED</b>。

<p align="center"><img src="assets/demo-status-granted.png" alt="已批准的状态页" width="800" /></p>
</details>

<details>
<summary><b>预约日清单</b> —— 一页速查表</summary>
<br>
<p align="center"><img src="assets/demo-checklist.png" alt="清单页" width="800" /></p>

包含：出门前检查项、文件堆叠顺序、官员可能的提问及建议回答、已验证的交叉检查、需要自行确认的事项。
</details>

<details>
<summary><b>签证说明信</b> —— 一页正式信函</summary>
<br>
<p align="center"><img src="assets/demo-cover-letter.png" alt="求职信" width="700" /></p>
</details>

### 工作流程

技能运行 **9 个阶段**的严格流程：搜索 → 提问 → 建档 → 文件夹 → 调研 → 预约 → 生成文档 → 交叉检查 → 提交后跟踪。

**首次申请：约 45 分钟。之后每次：约 10 分钟。**

### 核心功能

- **可复用个人资料** `~/.claude/visa-profile.json` —— 护照、地址、公司、银行、签证历史。拖入文件自动提取，一次建档以后每次自动填入。
- **交叉验证调研** —— 领事馆官网 + 签证中心 + 第三方指南，每项关键信息至少两个来源。
- **智能表格填写** —— 四级策略：在线门户 → 可填PDF → 视觉定位叠加 → 手动填写数据表。技能自己填表，手动填写是最后手段。
- **跨会话连续性** —— `application_status.html` 跟踪进度，随时可中断再继续。
- **文件摄入** —— 拖入护照扫描件、工资单、银行流水，自动提取结构化数据并交叉检查。
- **时间智能** —— 警告过期文件、处理时间风险、旺季积压、护照有效期陷阱。

### 安装

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

详见 [INSTALL.md](INSTALL.md)。之后在任何 Claude Code 会话里提到签证，技能就会接管。

### 覆盖范围

申根（全部 27 国）、美国 B1/B2、英国旅游签、日本、加拿大、中国、澳大利亚 —— 任何有公开签证流程的国家。

### 隐私

个人资料仅保存在本地，绝不外传。

### 许可

MIT。

---

<a id="español"></a>
## Español

Un skill de Claude Code que te lleva de *"necesito un visado"* a un paquete de documentos impreso y listo para el funcionario — en una sola sesion.

### Por que

Las normas de visado cambian cada trimestre. La mitad de las guias online siguen reciclando informacion de 2019. La web del consulado esta enterrada a dos clics y lleva tres anos sin actualizarse. Olvida un documento y esperaras otro mes para una nueva cita.

Este skill mantiene las normas actualizadas y los papeles ordenados. Tu haces lo que solo tu puedes — vuelos, fotos, firmar cosas. Del resto se encarga el skill.

### Que produce

Cada solicitud tiene su propia carpeta con documentos HTML visibles en el navegador, PDFs correspondientes para imprimir, y un Print Pack numerado en el orden que el funcionario espera.

<details>
<summary><b>Rastreador de estado</b></summary>
<br>
<p align="center"><img src="assets/demo-status.png" alt="Pagina de estado" width="800" /></p>
<p align="center"><img src="assets/demo-status-granted.png" alt="Estado aprobado" width="800" /></p>
</details>

<details>
<summary><b>Checklist del dia de la cita</b></summary>
<br>
<p align="center"><img src="assets/demo-checklist.png" alt="Checklist" width="800" /></p>
</details>

<details>
<summary><b>Carta de presentacion</b></summary>
<br>
<p align="center"><img src="assets/demo-cover-letter.png" alt="Carta de presentacion" width="700" /></p>
</details>

**Primer visado: ~45 minutos. Cada visado siguiente: ~10 minutos.**

### Instalacion

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

Consulta [INSTALL.md](INSTALL.md) para mas opciones. Despues, en cualquier sesion de Claude Code, menciona un visado.

### Cobertura

Schengen (los 27 paises), EE. UU. B1/B2, UK Visitor, Japon, Canada, China, Australia — cualquier pais con un proceso de visado documentado.

### Privacidad

El perfil es local, nunca se transmite. Las carpetas de solicitud van por defecto a `~/Documents/Visa Applications/{Pais}-{Ano}/`.

### Licencia

MIT.

---

<a id="हिन्दी"></a>
## हिन्दी

एक Claude Code skill जो आपको *"मुझे वीज़ा चाहिए"* से लेकर प्रिंट करके अधिकारी को सौंपने लायक पूरे दस्तावेज़ पैक तक पहुँचाती है — एक ही सत्र में।

### क्यों

वीज़ा नियम हर तिमाही बदलते हैं। ऑनलाइन उपलब्ध आधे गाइड्स में अभी भी 2019 की पुरानी जानकारी है। कॉन्सुलेट की वेबसाइट दो क्लिक भीतर छिपी है और तीन साल पुरानी जानकारी देती है। एक दस्तावेज़ छूट जाए तो नई अपॉइंटमेंट के लिए एक महीना और इंतज़ार।

यह skill नियमों को अपडेट रखती है और कागज़ात व्यवस्थित। आप वही करते हैं जो केवल आप कर सकते हैं — फ़्लाइट बुक करना, फ़ोटो खिंचवाना, साइन करना। बाकी सब यह करती है।

### यह क्या बनाती है

हर आवेदन का अपना फ़ोल्डर, ब्राउज़र में देखने योग्य HTML दस्तावेज़, प्रिंट के लिए PDF, और अधिकारी के पलटने के क्रम में नंबर वाला Print Pack।

<details>
<summary><b>आवेदन स्थिति ट्रैकर</b></summary>
<br>
<p align="center"><img src="assets/demo-status.png" alt="स्थिति पेज" width="800" /></p>
<p align="center"><img src="assets/demo-status-granted.png" alt="स्वीकृत स्थिति" width="800" /></p>
</details>

<details>
<summary><b>अपॉइंटमेंट-डे चेकलिस्ट</b></summary>
<br>
<p align="center"><img src="assets/demo-checklist.png" alt="चेकलिस्ट" width="800" /></p>
</details>

<details>
<summary><b>कवर लेटर</b></summary>
<br>
<p align="center"><img src="assets/demo-cover-letter.png" alt="कवर लेटर" width="700" /></p>
</details>

**पहला वीज़ा: ~45 मिनट। उसके बाद हर वीज़ा: ~10 मिनट।**

### इंस्टॉल

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

देखें [INSTALL.md](INSTALL.md)। फिर किसी भी Claude Code सेशन में वीज़ा का ज़िक्र करें।

### कवरेज

Schengen (सभी 27 देश), US B1/B2, UK Visitor, जापान, कनाडा, चीन, ऑस्ट्रेलिया — कोई भी देश जिसकी वीज़ा प्रक्रिया दस्तावेज़ित हो।

### गोपनीयता

प्रोफ़ाइल सिर्फ़ लोकल रहती है, कभी बाहर नहीं जाती। Application फ़ोल्डर डिफ़ॉल्ट रूप से `~/Documents/Visa Applications/{Country}-{Year}/` में बनते हैं।

### लाइसेंस

MIT।
