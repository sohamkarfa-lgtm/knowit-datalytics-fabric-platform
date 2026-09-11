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
capacity administrator UPN or SP object ID: soham.karfa_knowit.se#EXT#@knowitsandbox.onmicrosoft.com / 7e6f2e1a-5598-4021-9f20-a1daa6e2291c
(Go to Azure Portal.Open Microsoft Entra ID.Select Users.Click your user account.)
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



az login

terraform installation-

winget install Hashicorp.Terraform
winget list Hashicorp.Terraform

Get-ChildItem "C:\Users\sohkar\AppData\Local\Microsoft\WinGet\Packages" -Filter "*Terraform*" -Directory
Get-ChildItem "C:\Users\sohkar\AppData\Local\Microsoft\WinGet\Packages\<folder-name-from-above>" -Recurse -Filter "terraform.exe"

[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path","User") + ";C:\Users\sohkar\AppData\Local\Microsoft\WinGet\Packages\Hashicorp.Terraform_Microsoft.Winget.Source_8wekyb3d8bbwe", "User")

Close this terminal completely and open a brand new one
terraform version


cd iac\environments\dev


Provision the actual state backend first. This is a real Azure resource that needs to exist before Terraform can use it as a backend — Terraform can't create its own state storage as part of the same init that needs that storage to exist. Someone needs to create, outside this Terraform config (Azure CLI/Portal), a resource group + storage account + blob container to hold state, e.g.:

az group create --name rg-terraform-state-dev --location swedencentral
az storage account create --name stkdfabricdev001 --resource-group rg-terraform-state-dev --sku Standard_LRS --location swedencentral
az storage container create --name tfstate --account-name stkdfabricdev001

terraform init

terraform plan -var-file terraform.tfvars 


terraform apply 


--Your identity is a guest (#EXT#) in this sandbox tenant, home tenant knowit.se. This strongly suggests Microsoft.Fabric/capacities administration members genuinely cannot be guest/external accounts at all — this isn't a formatting issue, it's a hard platform constraint. Both the UPN attempt and the object-ID attempt failed for the same underlying reason, just with different error text depending on which validation step caught it first.


Use a service principal-
az ad sp create-for-rbac --name "sp-kd-fabric-dev" --skip-assignment

Get the service principal's Object ID (not the App ID)
az ad sp show --id "61652ef7-bc82-4dcc-a2e8-10d09a16e761" --query "{objectId:id, appId:appId, displayName:displayName}" -o table

The Fabric control-plane API (microsoft/fabric provider's data "fabric_capacity") is trying to look up the capacity by display name immediately after the Azure ARM resource finished creating, but Fabric's own indexing/discovery hasn't caught up yet — this is a known timing gap between "ARM resource exists" and "Fabric control plane can see it."

az resource show --ids "/subscriptions/a2b9014e-5ea3-4e5f-805f-a89a6c32b560/resourceGroups/rg-kd-fabric-dev-swc-001/providers/Microsoft.Fabric/capacities/fckddevswc001" --query "properties" -o json

This should return the list of capacities--
az rest --method get --url "https://api.fabric.microsoft.com/v1/capacities" --resource "https://api.fabric.microsoft.com" -o json


Once you have that GUID, set it in terraform.tfvars:
fabric_capacity_id_override = "<the-guid>"