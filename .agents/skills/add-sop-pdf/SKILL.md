---
name: add-sop-pdf
description: Use when adding a new SOP PDF to this repo, including static/sop file placement, PDF title metadata updates, static/index.html link updates, and docker verification.
---

# Add SOP PDF

Use this workflow when a user asks to publish a new SOP PDF version in `oncokb-sop`.

## Required Inputs

- New SOP version number (for example `6.3`)
- Display month/year (for example `July 2026`)
- Source PDF path

## Steps

1. Ask user to provide the new SOP PDF and version number.
   - The PDF should be in the repository somewhere.
2. Move the PDF into `static/sop/`.
3. Rename the file to this exact pattern:
   `OncoKB_Curation_Standard_Operating_Procedure_vX_X.pdf`
   - Replace `X_X` with the version.
   - Use `_` for decimal versions (example: `6.3` -> `v6_3`).
   - Use no suffix for whole-number versions (example: `6.0` -> `v6`).
4. Run `scripts/set-pdf-titles.sh static/sop/OncoKB_Curation_Standard_Operating_Procedure_vX_X.pdf` to set the new PDF title in file metadata.
5. Update `static/index.html` by adding a new `<li>` entry at the top of the list:

```html
<li>
  <a href="/static/sop/OncoKB_Curation_Standard_Operating_Procedure_vX_X.pdf"
    ><span>Version X.X</span>
    <span>MMMM YYYY</span>
  </a>
</li>
```

## Validation Checklist

- PDF exists at `static/sop/OncoKB_Curation_Standard_Operating_Procedure_vX_X.pdf`
- PDF metadata title matches filename without `.pdf`
- `static/index.html` contains the new version entry at the top
- Docker build succeeds
- Link works in a local docker run
