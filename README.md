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

A Claude Code skill that turns *"I need a visa"* into a print-ready, officer-friendly document pack in a single session.

### Why

Visa requirements change all the time. Half the third-party guides still recycle 2019 advice, and the official consulate page is often buried, outdated, or both. Miss one document and you may be waiting another month for a new appointment.

This skill keeps the rules current and the paperwork organized. You handle the things only you can do — flights, photos, signatures — and it handles the rest.

### What it produces

Each application gets its own folder with browser-viewable HTML files, matching print-ready PDFs, and a numbered Print Pack arranged in the order an officer will review it.

<details>
<summary><b>Application Status Tracker</b> — the single source of truth across sessions</summary>
<br>
<p align="center"><img src="assets/demo-status.png" alt="Application status page showing trip details, appointment info, costs, and progress checklist" width="800" /></p>

Tracks every stage of your application: research, appointment booking, document assembly, submission, and outcome. When you come back days or weeks later, the skill reads this file and resumes exactly where you left off. Status badges update automatically — from **IN PROGRESS** through **SUBMITTED** to **GRANTED** or **REFUSED**.

<p align="center"><img src="assets/demo-status-granted.png" alt="Application status page showing granted visa with outcome details" width="800" /></p>

After approval, the visa details (sticker number, validity dates, entries) are captured and saved to your reusable profile, so the next Schengen application can auto-fill the "previous visas in the last 3 years" question.
</details>

<details>
<summary><b>Appointment-Day Checklist</b> — your one-page cheat sheet</summary>
<br>
<p align="center"><img src="assets/demo-checklist.png" alt="Checklist showing before-leaving-home items, stack order, officer questions, and cross-checks" width="800" /></p>

Prints as the **cover sheet** of your Print Pack (file `00`). It includes:

- **Before leaving home** — what to sign, what to bring, and which card to carry
- **Stack order** — every document numbered in the order the officer expects
- **Likely officer questions** — with suggested answers drawn from your actual documents
- **Cross-checks verified** — passport validity, insurance coverage, fund minimums
- **Verify yourself** — items the skill cannot confirm (UK visa expiry, hotel guest counts)
- **Warning banners** — critical flags like residence permit expiry timing
</details>

<details>
<summary><b>Cover Letter</b> — one page, formal, ready to sign</summary>
<br>
<p align="center"><img src="assets/demo-cover-letter.png" alt="Cover letter addressed to consulate with applicant details and trip purpose" width="700" /></p>

Addressed to the correct consulate, with your real employment details, trip dates, prior visa history, and a reference to the evidence enclosed. It is generated from your profile — you review it, sign it, and you are done.
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

Print every file single-sided on A4 and keep the numbered order. The officer can then review the pack in sequence.
</details>

### How it works

The skill follows a **9-phase workflow** — same order every time, with no skipped steps:

| Phase | What happens |
|-------|-------------|
| **0. Search** | Finds your existing profile and any prior application folders on disk |
| **1. Ask** | Interactive questions via structured UI — cold start (4 questions) or warm start (resume, new application, or profile update) |
| **2. Profile** | Reads your passport, payslips, and bank statements through document intake — you drop files, it extracts the data |
| **3. Folder** | Locates or creates the application folder (iCloud Drive, Documents, Desktop, or custom) |
| **4. Research** | Checks the consulate page, the visa-centre operator, and a third-party guide. Cross-validates every material claim and flags disagreements. |
| **5. Appointment** | Books or records the VFS/TLScontact appointment. Checks timing against processing windows and document freshness. |
| **6. Documents** | Generates the cover letter and employment-letter draft, fills the application form (portal → interactive PDF → vision overlay → manual fallback), and assembles the Print Pack |
| **7. Cross-check** | Produces the final report: document manifest, compliance checks, and next steps. Written to `application_status.html` for multi-session continuity. |
| **8. Post-submission** | Tracks status, captures approved visa details in the reusable profile, and handles refusals or appeals |

### Demo

```
You:    I need a Schengen visa to the Netherlands from the UK, late July.

Skill:  [structured questions for dates and details]

You:    24th to 27th.

Skill:  Got it — Netherlands Schengen tourist visa, 4 days, applying from London.
        I found the profile from your last application.
        Checking netherlandsworldwide.nl, VFS Global UK,
        and Wise 2026 guide…

        Cross-validated: EUR 90 fee + GBP 18 VFS service fee, EUR 30k insurance,
        35×45mm photo, online form mandatory from 1 Jun 2026, 15–21 day
        processing, 59-month biometric reuse from your France 2025 capture.

        [books the appointment through VFS Global]

        Generating cover letter, checklist, application status tracker…
        Assembling the Print Pack (15 documents).

        ⚠ Flag: your UK Graduate Visa must be valid until at least
        27 Aug 2026 (1 month past trip end) — verify via UKVI account.

You:    [prints, signs, walks in]

        (… 2 weeks later …)

You:    Visa granted — here's the sticker.

Skill:  Captured: NLD 7829104, valid 20 Jul → 20 Jan 2027, multiple
        entries, 90 days. Saved to `visa_history` — the next Schengen
        application auto-fills "previous visas in last 3 years".
```

**First visa: ~45 minutes. Every visa after: ~10 minutes.**

### Key features

- **Reusable profile** at `~/.claude/visa-profile.json` — passport, address, employer, banking, and visa history. Built once from document intake (drop your passport scan, payslips, and bank statement; the skill reads them) and reused forever.
- **Cross-validated research** — consulate page first, visa-centre operator second, third-party guide third. Every material claim needs at least two sources, with URLs and access dates cited.
- **Smart form filling** — 4-tier strategy: online portal (with 2D barcode), interactive PDF fields, vision-driven coordinate overlay, and manual data sheet as the last resort. The skill fills the form itself; asking you to do it by hand is the fallback, not the default.
- **Multi-session continuity** — `application_status.html` tracks progress. Come back days later and the skill resumes at the first incomplete phase.
- **Document intake** — drop a file and get structured data back. Passport scan → name, number, expiry. Payslip → salary, employer, NI number. Hotel PDF → dates, address, guest count. Everything is cross-checked against the profile automatically.
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

No git, or running into an issue? See [INSTALL.md](INSTALL.md) for ZIP download instructions, verification steps, and troubleshooting for corporate proxies, paths with spaces, `/skills` not showing the skill, and more.

Then mention a visa in any Claude Code session. The skill takes over from there.

### Coverage

Schengen (all 27 countries), US B1/B2, UK Visitor, Japan, Canada, China, Australia — any country with a documented visa process. Country-specific quirks are handled: VFS vs TLScontact routing, online portal detection, biometric reuse rules, and EES border procedures.

### What it won't do

- Asylum, family reunification, or anything that needs a qualified immigration lawyer
- Enter payment card details — the skill always stops at the payment step
- Make promises about visa outcomes — it helps assemble a strong file, not a guarantee
- Store your data remotely — everything is local files on your machine

### Privacy

Profile data is **local only** and is never transmitted. Application folders default to `~/Documents/Visa Applications/{Country}-{Year}/` or iCloud Drive. The skill reads your documents to extract data, but it does not send them anywhere.

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

一个 Claude Code 技能，帮你把「我要办签证」变成一套可直接打印、按受理人员审核顺序整理好的完整材料包。

### 为什么

签证要求经常变化。网上很多第三方指南还在重复 2019 年的旧信息，领事馆官网又常常藏得很深、更新不及时。少交一份材料，就可能要再等一个月重新预约。

这个技能会核对最新要求，并把材料整理清楚。你只需要处理那些必须由你本人完成的事 —— 订机票、拍证件照、签字；其余流程由它来完成。

### 产出物

每次申请都会生成一个独立文件夹，里面包含可在浏览器查看的 HTML 文档、对应的打印版 PDF，以及按受理人员审核顺序编号的 Print Pack。

<details>
<summary><b>申请状态跟踪页</b> —— 跨会话的进度总表</summary>
<br>
<p align="center"><img src="assets/demo-status.png" alt="申请状态页" width="800" /></p>

它会记录申请的每个阶段。几天或几周后再回来，技能会读取这个文件，并从上次中断的地方继续。状态会从 <b>IN PROGRESS</b> 自动推进到 <b>SUBMITTED</b>，最终更新为 <b>GRANTED</b> 或 <b>REFUSED</b>。

<p align="center"><img src="assets/demo-status-granted.png" alt="已批准的状态页" width="800" /></p>
</details>

<details>
<summary><b>预约当天清单</b> —— 一页速查表</summary>
<br>
<p align="center"><img src="assets/demo-checklist.png" alt="清单页" width="800" /></p>

包含出门前检查项、材料排列顺序、受理人员可能提出的问题及建议回答、已完成的交叉核验，以及仍需你本人确认的事项。
</details>

<details>
<summary><b>签证说明信</b> —— 一页正式信函</summary>
<br>
<p align="center"><img src="assets/demo-cover-letter.png" alt="签证说明信" width="700" /></p>
</details>

### 工作流程

技能会按固定顺序运行 **9 个阶段**：搜索 → 提问 → 资料建档 → 创建文件夹 → 核查签证要求 → 预约 → 生成文档 → 交叉检查 → 提交后跟踪。

**第一次申请：约 45 分钟。之后每次：约 10 分钟。**

### 核心功能

- **可复用个人资料** `~/.claude/visa-profile.json` —— 护照、地址、雇主、银行信息、签证历史。拖入文件即可自动提取；建档一次，以后反复使用。
- **交叉验证调研** —— 领事馆官网、签证中心、第三方指南三方核对；每项关键信息至少需要两个来源。
- **智能表格填写** —— 四级策略：在线门户 → 可填写 PDF → 视觉定位叠加 → 手动填写数据表。默认由技能填表，手动填写只是最后兜底。
- **跨会话连续性** —— `application_status.html` 持续记录进度，随时可以中断后继续。
- **文件读取** —— 拖入护照扫描件、工资单、银行流水，自动提取结构化数据并与个人资料交叉检查。
- **时间风险提醒** —— 提醒材料过期、处理时间不足、旺季积压、护照有效期等常见风险。

### 安装

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

更多安装方式见 [INSTALL.md](INSTALL.md)。安装后，在任何 Claude Code 会话里提到签证，技能就会接手流程。

### 覆盖范围

申根（全部 27 国）、美国 B1/B2、英国访客签证、日本、加拿大、中国、澳大利亚 —— 任何有公开签证流程的国家都可以处理。

### 隐私

个人资料只保存在本地，不会外传。

### 许可

MIT。

---

<a id="español"></a>
## Español

Una habilidad de Claude Code que convierte *"necesito un visado"* en un paquete de documentos listo para imprimir y presentar, todo en una sola sesión.

### Por qué

Los requisitos de visado cambian constantemente. Muchas guías de terceros siguen repitiendo información de 2019, y la página oficial del consulado a menudo está escondida, desactualizada o ambas cosas. Si falta un documento, puede que tengas que esperar otro mes para conseguir una nueva cita.

Esta herramienta mantiene los requisitos al día y deja los documentos bien ordenados. Tú te ocupas de lo que solo tú puedes hacer — vuelos, fotos y firmas — y ella se encarga del resto.

### Qué produce

Cada solicitud tiene su propia carpeta, con documentos HTML que puedes revisar en el navegador, sus PDF listos para imprimir y un Print Pack numerado en el orden en que lo revisará el funcionario.

<details>
<summary><b>Seguimiento del estado de la solicitud</b></summary>
<br>
<p align="center"><img src="assets/demo-status.png" alt="Página de estado" width="800" /></p>
<p align="center"><img src="assets/demo-status-granted.png" alt="Estado aprobado" width="800" /></p>
</details>

<details>
<summary><b>Checklist para el día de la cita</b></summary>
<br>
<p align="center"><img src="assets/demo-checklist.png" alt="Checklist" width="800" /></p>
</details>

<details>
<summary><b>Carta de presentación</b></summary>
<br>
<p align="center"><img src="assets/demo-cover-letter.png" alt="Carta de presentación" width="700" /></p>
</details>

**Primer visado: ~45 minutos. Siguientes visados: ~10 minutos cada uno.**

### Instalación

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

Consulta [INSTALL.md](INSTALL.md) para ver más opciones. Después, menciona un visado en cualquier sesión de Claude Code.

### Cobertura

Schengen (los 27 países), EE. UU. B1/B2, UK Visitor, Japón, Canadá, China, Australia — cualquier país con un proceso de visado documentado.

### Privacidad

El perfil se guarda solo en local y nunca se transmite. Por defecto, las carpetas de solicitud se crean en `~/Documents/Visa Applications/{País}-{Año}/`.

### Licencia

MIT.

---

<a id="हिन्दी"></a>
## हिन्दी

यह Claude Code skill *"मुझे वीज़ा चाहिए"* से लेकर प्रिंट करके अधिकारी को सौंपने लायक पूरा दस्तावेज़ पैक तैयार करने तक आपका काम एक ही सत्र में कर देती है।

### क्यों

वीज़ा की ज़रूरतें अक्सर बदलती रहती हैं। ऑनलाइन उपलब्ध कई गाइड अभी भी 2019 की पुरानी जानकारी दोहराते हैं, और कॉन्सुलेट की आधिकारिक वेबसाइट अक्सर छिपी हुई, पुरानी, या दोनों होती है। एक दस्तावेज़ छूट जाए, तो नई अपॉइंटमेंट के लिए एक महीना और इंतज़ार करना पड़ सकता है।

यह skill ताज़ा नियमों की जाँच करती है और कागज़ात को सही क्रम में रखती है। आप सिर्फ़ वही काम करते हैं जो आप ही कर सकते हैं — फ़्लाइट, फ़ोटो और हस्ताक्षर — बाकी प्रक्रिया यह संभाल लेती है।

### यह क्या बनाती है

हर आवेदन के लिए अलग फ़ोल्डर बनता है, जिसमें ब्राउज़र में देखे जा सकने वाले HTML दस्तावेज़, प्रिंट के लिए तैयार PDF, और अधिकारी की जाँच के क्रम में नंबर किया हुआ Print Pack होता है।

<details>
<summary><b>आवेदन की स्थिति ट्रैक करने वाला पेज</b></summary>
<br>
<p align="center"><img src="assets/demo-status.png" alt="स्थिति पेज" width="800" /></p>
<p align="center"><img src="assets/demo-status-granted.png" alt="स्वीकृत स्थिति" width="800" /></p>
</details>

<details>
<summary><b>अपॉइंटमेंट वाले दिन की चेकलिस्ट</b></summary>
<br>
<p align="center"><img src="assets/demo-checklist.png" alt="चेकलिस्ट" width="800" /></p>
</details>

<details>
<summary><b>कवर लेटर</b></summary>
<br>
<p align="center"><img src="assets/demo-cover-letter.png" alt="कवर लेटर" width="700" /></p>
</details>

**पहला वीज़ा: ~45 मिनट। उसके बाद हर वीज़ा: लगभग 10 मिनट।**

### इंस्टॉल करें

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

[INSTALL.md](INSTALL.md) में और विकल्प दिए गए हैं। उसके बाद किसी भी Claude Code सेशन में वीज़ा का ज़िक्र करें।

### किन देशों के लिए

Schengen (सभी 27 देश), US B1/B2, UK Visitor, जापान, कनाडा, चीन, ऑस्ट्रेलिया — यानी कोई भी देश जिसकी वीज़ा प्रक्रिया दस्तावेज़ित हो।

### गोपनीयता

प्रोफ़ाइल सिर्फ़ आपके कंप्यूटर पर रहती है; इसे कहीं भेजा नहीं जाता। आवेदन फ़ोल्डर डिफ़ॉल्ट रूप से `~/Documents/Visa Applications/{Country}-{Year}/` में बनते हैं।

### लाइसेंस

MIT।
