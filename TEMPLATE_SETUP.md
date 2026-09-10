# Template Setup — Starting a New Engagement

This repo is the reusable **Microsoft Fabric** platform kit. It contains no
live client data. Before using it on a real engagement, resolve every
placeholder below.

## Placeholder reference

| Placeholder | Meaning | Typical source |
|---|---|---|
| `{{CLIENT}}` | Client / engagement display name | Kickoff |
| `{{DOMAIN_LIST}}` | Client's business/data domains (e.g. "Finance, Sales, Campaign, Customer Ops") | Parent repo engagement entity |
| `{{PARENT_REPO_URL}}` | URL of this engagement's parent knowledge-model repo | Repo setup |
| `{{VALIDATED_ASSUMPTIONS}}` | Sizing/budget block for this engagement | Stage 1 + platform questionnaire |
| `{{GROUP_PREFIX}}` | Entra ID / management-group naming prefix (e.g. "DA" for a "Data-Analytics" convention) | Client's naming convention |
| `{{CLIENT_DOMAIN}}` | Email domain for example contacts in `terraform.tfvars.example` (e.g. "acme.com") | Kickoff |

Do a global find-and-replace for `{{CLIENT}}` and `{{DOMAIN_LIST}}` first —
they appear most often. Then resolve any remaining `{{...}}` token
individually; do not delete a token without replacing it, and do not guess a
plausible-looking value — leave `[NEEDS HUMAN INPUT: ...]` if it isn't known
yet, consistent with the rest of this kit's approval-gate conventions.

## Setup checklist

- [ ] Replace `{{CLIENT}}` everywhere (`git grep -l '{{CLIENT}}'`)
- [ ] Replace `{{DOMAIN_LIST}}` everywhere (`git grep -l '{{DOMAIN_LIST}}'`)
- [ ] Set `{{PARENT_REPO_URL}}` in `README.md`
- [ ] Populate `{{VALIDATED_ASSUMPTIONS}}` in `README.md` once Stage 1 is approved
- [ ] Confirm `fabric_platform_development_kit/runs/` contains only `_template/`
      — delete any prior engagement's run folders before reuse (already true
      in this template repo as of folder 5's pass)
- [ ] Confirm `platform-spec/` and `knowledge-model-platform-engineering/domains/*`,
      `adr/*` contain only `_template.md` files and no validated client entities
- [ ] Confirm `open-questions/` and `open-questions/oq_ans/` are empty of
      prior-client content
- [ ] Update `iac/environments/*/terraform.tfvars.example` placeholder emails/
      subscription IDs if you want engagement-specific example values (optional —
      these are already non-secret examples)
- [ ] Run `git grep -n '{{'` at the end — it should return nothing

## What this kit intentionally keeps fixed (for now)

Per the current scope, this kit is **Microsoft Fabric-specific**: the six
platform design domains (landing-zone, compute, storage, network,
identity-security, operations), the `PLAT-*`/`PLAT-ADR-*` ID convention, and
the `iac/modules/fabric-*` Terraform modules are not parameterized. A
generic (non-Fabric) version is a future exercise, not part of this pass.

## Progress log

This file is updated as each folder of the repo is templatized. See
`TEMPLATE_PROGRESS.md` for the current status.
