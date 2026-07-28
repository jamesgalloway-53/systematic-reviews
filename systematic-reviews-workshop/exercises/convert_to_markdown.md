# Converting documents to Markdown for efficient AI workflows

## Why bother?

Large language models charge (in money and in context space) by the **token**.
A PDF carries a lot of tokens that have nothing to do with the science: font
tables, layout coordinates, image data, repeated headers and footers, page
furniture. When you hand Claude a clean Markdown file instead, you strip all of
that away and keep only the words and structure that matter.

Rough rule of thumb: the *text* of a journal article is a few thousand tokens.
The *PDF* of the same article can be several times larger once encoded, and
scanned/image PDFs are larger still (and may need OCR before any text exists at
all). Markdown is typically the cheapest faithful representation of a paper.

**Practical consequence:** for a review of 40 papers, converting to Markdown
first can cut token usage — and therefore cost and the risk of hitting context
limits — dramatically, while often *improving* extraction accuracy because the
model sees clean headings and tables rather than jumbled layout.

## The file-format hierarchy (cheapest, cleanest first)

| Format | Token efficiency | Fidelity for text | When to use |
|--------|------------------|-------------------|-------------|
| Markdown (.md) | Best | Excellent for text + tables | Default for AI-assisted screening & extraction |
| Plain text (.txt) | Best | Good, but loses table/heading structure | Quick jobs where structure doesn't matter |
| HTML | Good | Excellent, but tag overhead | When the source is already a web page |
| Word (.docx) | Moderate | Good | Human editing; convert to .md for AI |
| Text-based PDF | Poor | Good text, heavy overhead | Convert before heavy AI use |
| Scanned/image PDF | Worst | None without OCR | OCR first, then convert |

## Practical conversion workflows

### 1. Text-based PDF -> Markdown
Command-line tools such as `pandoc`, `pdftotext` (Poppler), or Python libraries
(`pymupdf`, `markitdown`) will pull the text out. Always eyeball the result:
check that tables survived and that numbers weren't mangled.

```
pdftotext -layout paper.pdf paper.txt        # quick text dump
# or, for structure-aware Markdown:
markitdown paper.pdf > paper.md
```

### 2. Scanned / image PDF -> Markdown
These have no text layer, so run OCR first (e.g. `ocrmypdf`), then convert.
Treat OCR output with suspicion — verify every extracted number against the image.

### 3. Word / HTML -> Markdown
`pandoc paper.docx -o paper.md` handles most documents cleanly.

## The golden rule

Converting to Markdown makes AI cheaper and often more accurate — but it can
silently drop or corrupt data (especially in complex tables). **Always keep the
original PDF, and validate anything that will feed a result against that
original.** Efficiency never overrides accuracy.
