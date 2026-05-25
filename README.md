<p align="center">
  <img src="assets/banner.png" alt="visa-application banner" />
</p>

<p align="center">
  <a href="#english">🇬🇧 English</a> ·
  <a href="#中文">🇨🇳 中文</a> ·
  <a href="#español">🇪🇸 Español</a> ·
  <a href="#हिन्दी">🇮🇳 हिन्दी</a>
</p>

---

<a id="english"></a>
## English

A Claude Code skill that takes you from *"I need a visa"* to a printed, officer-ready document pack.

### Why

Visa rules drift every quarter. Half the third-party guides recycle 2019 information. The consulate site is two clicks deep and three years stale. Miss one document and you wait another month for a new appointment.

This skill keeps the rules current and the paperwork tidy. You handle what only you can — flights, photos, signing things. It handles the rest.

### Demo

```
You:    I need a Schengen visa to Italy from the UK. Trip 22-26 June.

Skill:  Four quick questions… [you answer]
        No profile yet — drop in your passport, payslip, and a bank
        statement.

You:    [drops 3 files]

Skill:  Read them. Profile saved.
        Researching against the Italian consulate page, VFS Italy
        London, and the MFA portal… cross-validated: €90 fee, €30k
        insurance, 35×45mm photo, EES live at the border since
        Oct 2025.

        Have you already booked your visa appointment?  [you answer]
        OK — booking with VFS Italy London via Chrome MCP.
        Pausing at the payment step — you enter the card.

You:    [pays, confirms slot]

Skill:  Appointment captured: Wed 4 June, 10:00, Pocock St.
        Generating cover letter, employment letter draft, application
        form via e-applicationvisa.esteri.it (with 2D barcode), and
        a one-page checklist.

        One issue caught: hotel checkout dated a day after return flight.

You:    [signs, prints, walks in]

       (… weeks later, after the trip …)

You:    Update on the Italy visa — got approved, here's the sticker.

Skill:  Captured: visa 1234567, valid 22 May → 22 Nov, multiple
        entries, 90 days. Saved to your visa_history — the next
        Schengen application will reuse it for the "previous visas"
        question.
```

**First visa: ~45 minutes. Every visa after: ~10 minutes.**

### What you get

- A reusable profile at `~/.claude/visa-profile.json` — passport, address, employer, banking. Built once, replayed forever.
- A document pack — cover letter, employment letter draft, filled application form, checklist PDF. The skill fills the form itself: portal, interactive PDF, vision overlay — manual transcription only as a last resort.
- A numbered Print Pack folder in officer flip-order. Print A4, sign, walk in.

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

Schengen (all 27), US B1/B2, UK Visitor, Japan, Canada, China, Australia — any country with a documented visa process.

### Not for

Asylum, family reunification, or anything that wants a real visa lawyer. Payments are always on you — the skill never enters card details.

### Privacy

Profile is local only, never transmitted. Application folders default to `~/Documents/Visa Applications/{Country}-{Year}/`.

### License

MIT.

---

<a id="中文"></a>
## 中文

一个 Claude Code 技能，帮你从「我要办签证」一路走到打印就能交、官员认可的完整材料包。

### 为什么

签证规则每个季度都在变。网上一半的第三方指南还在沿用 2019 年的旧信息。领事馆官网藏得深、几年不更新。漏一份文件就要再等一个月重新预约。

这个技能让规则保持最新，让材料井井有条。你只负责只有你能做的事 —— 订机票、拍照片、签字。其他的它来做。

### 演示

```
你：    我要从英国办意大利申根签证。行程 6 月 22 到 26 日。

技能：  先问四个问题…… [你回答]
        没有个人档案 —— 把护照、工资单、银行账单拖进来。

你：    [拖入 3 份文件]

技能：  已读取，档案已保存。
        正在查询意大利领事馆官网、VFS Italy 伦敦中心、外交部门户……
        交叉验证完成：签证费 90 欧元、保险至少 3 万欧元、
        照片 35×45mm、EES 自 2025 年 10 月起在边境生效。

        你已经预约 VFS 了吗？ [你回答]
        好的 —— 通过 Chrome MCP 在 VFS Italy 伦敦中心预约。
        付款这一步停下，由你输入卡片信息。

你：    [付款、确认时段]

技能：  预约已记录：6 月 4 日（周三）10:00，Pocock St。
        正在生成求职信、雇主信草稿、通过 e-applicationvisa.esteri.it
        填写的申请表（含 2D 条码）、以及一页清单。

        发现一处问题：酒店退房日期晚于回程航班一天。

你：    [签字、打印、去 VFS]

       (……几周后，旅行结束之后……)

你：    意大利签证有更新 —— 已批，签证贴纸在这里。

技能：  已记录：签证 1234567，有效期 5 月 22 → 11 月 22，
        多次往返，90 天。已保存到 visa_history —— 下次申根申请
        会自动用于「过去三年内的签证」这一项。
```

**首次申请：约 45 分钟。之后每次：约 10 分钟。**

### 你将获得

- 一份可复用的个人档案，存于 `~/.claude/visa-profile.json` —— 护照、地址、雇主、银行信息。建一次，永久复用。
- 完整材料包 —— 求职信、雇主信草稿、填好的申请表、清单 PDF。技能会自己填表：优先通过官方在线门户，其次直接编辑可填 PDF，再次用视觉对齐叠加文字 —— 让你手抄是最后才用的方案。
- 一个按官员翻阅顺序编号的 Print Pack 文件夹。A4 打印、签字、去递交即可。

### 安装

**macOS / Linux / WSL / Git Bash：**

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

**Windows PowerShell：**

```powershell
New-Item -ItemType Directory -Force -Path "$HOME\.claude\skills" | Out-Null
git clone https://github.com/Shadowhusky/visa-application.git "$HOME\.claude\skills\visa-application"
```

没有 git，或遇到问题？请看 [INSTALL.md](INSTALL.md) —— 包含 ZIP 下载、安装验证、以及常见故障排查（公司代理、路径中带空格、`/skills` 命令找不到技能等）。

之后在任何 Claude Code 会话里提到签证，技能就会接管。

### 覆盖范围

申根（全部 27 国）、美国 B1/B2、英国旅游签、日本、加拿大、中国、澳大利亚 —— 任何有公开签证流程的国家。

### 不适用于

庇护、家庭团聚、或任何需要真正签证律师的复杂情况。付款始终由你完成 —— 技能绝不会输入信用卡信息。

### 隐私

个人档案仅保存在本地，绝不传输。每次申请的文件夹默认在 `~/Documents/Visa Applications/{国家}-{年份}/`。

### 许可

MIT。

---

<a id="español"></a>
## Español

Una skill de Claude Code que te lleva de *"necesito un visado"* a un paquete de documentos impreso y listo para el funcionario.

### Por qué

Las normas de visado cambian cada trimestre. La mitad de las guías online siguen reciclando información de 2019. La web del consulado está dos clics más adentro y desactualizada hace tres años. Olvida un documento y esperarás otro mes para una nueva cita.

Esta skill mantiene las normas actualizadas y los papeles ordenados. Tú haces lo que solo tú puedes — vuelos, fotos, firmar cosas. Ella se encarga del resto.

### Demo

```
Tú:      Necesito un visado Schengen para Italia desde el Reino Unido.
         Viaje del 22 al 26 de junio.

Skill:   Cuatro preguntas rápidas… [respondes]
         No hay perfil — arrastra aquí tu pasaporte, una nómina y un
         extracto bancario.

Tú:      [suelta 3 archivos]

Skill:   Leídos. Perfil guardado.
         Investigando con el consulado italiano, VFS Italy Londres y
         el portal del MAE… validado: tasa €90, seguro €30k, foto
         35×45mm, EES activo en frontera desde octubre 2025.

         ¿Ya tienes la cita reservada?  [respondes]
         OK — reservando en VFS Italy London vía Chrome MCP.
         Pauso en el paso de pago — tú metes la tarjeta.

Tú:      [pagas, confirmas la cita]

Skill:   Cita capturada: miércoles 4 de junio, 10:00, Pocock St.
         Generando carta de presentación, borrador de carta laboral,
         formulario vía e-applicationvisa.esteri.it (con código 2D),
         y una checklist de una página.

         Detectada una incidencia: la salida del hotel es un día
         posterior al vuelo de regreso.

Tú:      [firma, imprime, va al VFS]

       (… semanas después, ya hecho el viaje …)

Tú:      Actualización del visado: aprobado, aquí está la pegatina.

Skill:   Capturado: visado 1234567, vigente 22 may → 22 nov,
         entradas múltiples, 90 días. Guardado en visa_history —
         la próxima solicitud Schengen lo usará automáticamente
         para "visados anteriores en los últimos 3 años".
```

**Primer visado: ~45 minutos. Cada visado siguiente: ~10 minutos.**

### Lo que obtienes

- Un perfil reutilizable en `~/.claude/visa-profile.json` — pasaporte, dirección, empresa, banco. Se construye una vez, se reutiliza siempre.
- Un paquete documental — carta de presentación, borrador de carta laboral, formulario relleno, checklist en PDF. La skill rellena el formulario sola: portal oficial, PDF interactivo, o superposición con visión — solo como último recurso te pide transcribir a mano.
- Una carpeta Print Pack numerada en el orden en que el funcionario pasa las páginas. Imprime A4, firma, entra.

### Instalación

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

¿Sin git, o algún problema? Consulta [INSTALL.md](INSTALL.md) — incluye descarga ZIP, verificación, y solución de problemas (proxy corporativo, rutas con espacios, `/skills` no muestra la skill, etc).

Después, en cualquier sesión de Claude Code, menciona un visado. La skill toma el relevo.

### Cobertura

Schengen (los 27 estados), EE. UU. B1/B2, UK Visitor, Japón, Canadá, China, Australia — cualquier país con un proceso de visado documentado.

### No sirve para

Asilo, reagrupación familiar, o cualquier caso que requiera un abogado de inmigración. Los pagos siempre los haces tú — la skill nunca introduce datos de tarjeta.

### Privacidad

El perfil es local, nunca se transmite. Las carpetas por aplicación van por defecto a `~/Documents/Visa Applications/{País}-{Año}/`.

### Licencia

MIT.

---

<a id="हिन्दी"></a>
## हिन्दी

एक Claude Code skill जो आपको *"मुझे वीज़ा चाहिए"* से लेकर प्रिंट करके अधिकारी को सौंपने लायक पूरे दस्तावेज़ पैक तक पहुँचाती है।

### क्यों

वीज़ा नियम हर तिमाही बदलते हैं। ऑनलाइन उपलब्ध आधे गाइड्स में अभी भी 2019 की पुरानी जानकारी है। कॉन्सुलेट की वेबसाइट दो क्लिक भीतर छिपी है और तीन साल पुरानी जानकारी देती है। एक दस्तावेज़ छूट जाए तो नई अपॉइंटमेंट के लिए एक महीना और इंतज़ार।

यह skill नियमों को अपडेट रखती है और कागज़ात व्यवस्थित। आप वही करते हैं जो केवल आप कर सकते हैं — फ़्लाइट बुक करना, फ़ोटो खिंचवाना, साइन करना। बाकी सब यह करती है।

### डेमो

```
आप:     मुझे यूके से इटली के लिए Schengen वीज़ा चाहिए। यात्रा 22-26 जून।

Skill:  चार जल्दी सवाल… [आप जवाब देते हैं]
        अभी कोई प्रोफ़ाइल नहीं — पासपोर्ट, payslip, और bank
        statement यहाँ ड्रॉप करें।

आप:     [3 फ़ाइलें ड्रॉप करते हैं]

Skill:  पढ़ लिए। प्रोफ़ाइल सेव हो गई।
        इटालियन कॉन्सुलेट पेज, VFS Italy लंदन, और MFA पोर्टल पर
        शोध कर रही हूँ… क्रॉस-वैलिडेटेड: €90 शुल्क, €30k बीमा,
        35×45mm फ़ोटो, EES अक्टूबर 2025 से बॉर्डर पर चालू।

        क्या आपने अपॉइंटमेंट बुक कर ली है?  [आप जवाब देते हैं]
        ठीक है — Chrome MCP के ज़रिए VFS Italy London बुक कर रही हूँ।
        Payment step पर रुक रही हूँ — card details आप डालें।

आप:     [पेमेंट, स्लॉट कन्फ़र्म]

Skill:  अपॉइंटमेंट सेव: बुध 4 जून, 10:00, Pocock St।
        कवर लेटर, employment letter draft, e-applicationvisa.esteri.it
        के ज़रिए भरा गया फ़ॉर्म (2D बारकोड के साथ), और एक-पेज
        चेकलिस्ट तैयार कर रही हूँ।

        एक समस्या मिली: होटल चेकआउट रिटर्न फ़्लाइट के एक दिन बाद है।

आप:     [साइन करते हैं, प्रिंट करते हैं, VFS जाते हैं]

       (… कुछ हफ़्ते बाद, यात्रा के बाद …)

आप:     इटली वीज़ा का अपडेट — मंज़ूर हो गया, स्टिकर यहाँ है।

Skill:  सेव कर लिया: वीज़ा 1234567, मान्य 22 मई → 22 नवंबर,
        multiple entries, 90 दिन। visa_history में सेव — अगली
        Schengen एप्लीकेशन में "पिछले 3 साल के वीज़े" वाले सवाल
        में अपने आप काम आएगा।
```

**पहला वीज़ा: ~45 मिनट। उसके बाद हर वीज़ा: ~10 मिनट।**

### आपको क्या मिलता है

- एक पुनः-उपयोगी प्रोफ़ाइल `~/.claude/visa-profile.json` पर — पासपोर्ट, पता, नियोक्ता, बैंक। एक बार बनाई, हमेशा के लिए।
- एक दस्तावेज़ पैक — कवर लेटर, employment letter ड्राफ़्ट, भरा हुआ application फ़ॉर्म, चेकलिस्ट PDF। Skill फ़ॉर्म खुद भरती है: ऑनलाइन पोर्टल, interactive PDF, या vision overlay — हाथ से लिखना केवल अंतिम विकल्प।
- एक numbered Print Pack फ़ोल्डर, अधिकारी के पेज पलटने के क्रम में। A4 प्रिंट करें, साइन करें, सबमिट करें।

### इंस्टॉल

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

Git नहीं है, या कोई समस्या? देखें [INSTALL.md](INSTALL.md) — इसमें ZIP डाउनलोड, सत्यापन, और सामान्य समस्याओं का समाधान है (corporate proxy, स्पेस वाले paths, `/skills` skill न दिखाए, इत्यादि)।

फिर किसी भी Claude Code सेशन में वीज़ा का ज़िक्र करें। Skill संभाल लेगी।

### कवरेज

Schengen (सभी 27 देश), US B1/B2, UK Visitor, जापान, कनाडा, चीन, ऑस्ट्रेलिया — कोई भी देश जिसकी वीज़ा प्रक्रिया दस्तावेज़ित हो।

### इसके लिए नहीं

शरण, परिवार पुनर्मिलन, या कोई भी मामला जिसमें असली वीज़ा वकील चाहिए। भुगतान हमेशा आप करते हैं — skill कभी कार्ड विवरण दर्ज नहीं करती।

### गोपनीयता

प्रोफ़ाइल केवल लोकल है, कभी ट्रांसमिट नहीं होती। आवेदन फ़ोल्डर डिफ़ॉल्ट रूप से `~/Documents/Visa Applications/{Country}-{Year}/` पर जाते हैं।

### लाइसेंस

MIT।
