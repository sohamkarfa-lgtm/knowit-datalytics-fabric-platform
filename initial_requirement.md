1. Create the run folder
Copy fabric_platform_development_kit/runs/_template/ → fabric_platform_development_kit/runs/<YYYY-MM-DD>-<change-slug>/

For a first platform setup, a sensible slug is something like 2026-09-10-knowit-initial-platform-setup.

2. Fill in manifest.yaml immediately
Set run_id, title (one line, e.g. "Initial Fabric platform setup for Knowit Datalytics"), created, requested_by, and run_status: in_progress. Leave every stage's status as pending — do not pre-approve anything.

3. Gather what Stage 1 needs before running it
Per stages/01-requirement-analysis/prompt.md, you need:

The actual business requirement/change request in your own words (client, environment scope, sizing inputs if known)


example-- 
Stand up a minimal development environment for Knowit Datalytics's Fabric platform: an F2 capacity and a dev workspace, with supporting resource group(s).

Functional requirements
Provision a Microsoft Fabric capacity (SKU: F2) for the dev environment
Provision one Fabric workspace in dev, assigned to that capacity
Provision a dev resource group (or set of resource groups) to host the capacity and any other dev resources
Assign at least one capacity administrator and appropriate workspace RBAC so someone can actually access it


Azure region: swedencentral
dev subscription ID / tenant ID: a2b9014e-5ea3-4e5f-805f-a89a6c32b560 / 3d1db40c-c430-4721-a837-7ae369ef246d
capacity administrator UPN or SP object ID: soham.karfa_knowit.se#EXT#@knowitsandbox.onmicrosoft.com
dev workspace RBAC assignments: primary access to capacity administrator


Resource	Proposed name
Dev resource group	rg-kd-fabric-dev-swc-001
F2 capacity	fckddevswc001
Fabric workspace	Knowit Datalytics - Dev

kd means Knowit Datalytics; swc means Sweden Central.


Apply these tags to the Azure resource group and capacity:
Tag	Proposed value
environment	dev
workload	fabric-platform
owner	soham-karfa
cost_center	knowit-datalytics-dev — proposed allocation label, not a verified finance code
data_classification	internal
managed_by	terraform
