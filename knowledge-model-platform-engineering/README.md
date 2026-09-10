# Platform Engineering Knowledge Model

This child knowledge model records the validated Microsoft Fabric platform design decisions for {{CLIENT}}'s data & analytics engagement.

## Parent model

The parent knowledge model is at {{PARENT_REPO_URL}}. Its validated target-state, ADR, governance, delivery, and requirement entities remain the source constraints for this repository. Cross-repository links use the PARENT-* IDs defined by the parent entities index.

## Domains

- landing-zone — subscriptions, resource groups, environment separation, naming, and tags
- compute — analytics capacity, scaling, and workspace model
- storage — lake zones, lifecycle, retention, and redundancy
- network — private access, segmentation, DNS, and connectivity
- identity-security — Entra ID, RBAC, secrets, and encryption
- operations — cost management, observability, and infrastructure delivery

## Template state

This repo ships with **no validated design entities** — `entities.index.yaml`
is empty and only the `_template.md` file exists in each domain and in `adr/`.
Use `prompt-library/platform-design-decision-maker.md` (Prompt 00) to draft
the first `PLAT-*` entities per domain for {{CLIENT}}, typically covering:

- Landing zone: management group / subscription boundaries for dev, test, and prod
- Compute: Fabric capacity sizing, scaling posture, and cost guardrails
- Storage: ADLS Gen2 bronze/silver/gold structure with retention and lifecycle rules
- Network: private-by-default access, hub-spoke topology, and any on-prem coexistence
- Identity & security: Entra ID group-based least-privilege access, Key Vault, managed identities
- Operations: cost monitoring visible to {{DOMAIN_LIST}} stakeholders, alerts, and CI/CD governance

Only mark an entity `status: validated` once a human has explicitly approved
it in conversation — see `AGENTS.md`.

## Workflow

1. Read the parent index, schema, and relevant parent entities.
2. Produce or update a design proposal with traceable relates_to links.
3. Obtain explicit human approval.
4. Apply only approved changes and mark the design as validated.
5. Update the registry and validate IDs, paths, frontmatter, and links.

As entities are drafted and validated, keep the ADRs and domain entities aligned with the accepted decisions, and keep `entities.index.yaml` in sync.
