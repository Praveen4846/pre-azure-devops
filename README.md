# Azure DevOps Pre-Course Setup

Prepare your workstation and skills before diving into the Azure DevOps course. This guide covers the mandatory software, shell scripts, baseline commands, reference links, and a study plan so you can start the course confidently.

## Quick Start Checklist
- Confirm you have admin rights on your machine and a stable internet connection.
- Install required software (Git, VS Code, Azure CLI, optional Docker/Node.js).
- Run the helper scripts in the `scripts/` folder when available for your OS.
- Validate tooling with the smoke tests listed at the end of this document.
- Review the study guide topics and bookmark the reference links.

## Prerequisites
- **Accounts**: Microsoft account for Azure Active Directory, Azure subscription with DevOps access (free tier works), GitHub account for source control practice.
- **Hardware**: 8 GB RAM minimum (16 GB recommended), 10 GB free disk space, virtualization enabled if you plan to use Docker or WSL.
- **Operating System**: macOS 12+, Windows 10/11, or Ubuntu 20.04+. Other distros work but may require manual package adjustments.
- **Baseline Skills**: Comfortable using a terminal (navigate, create folders, edit files) and Git fundamentals (clone, branch, commit). The "Basic Commands" section below gives a refresher.
- **Cloud Foundations**: Familiar with shared responsibility, cloud cost models, and how to read architectural diagrams.

## Cloud Prerequisites
- **Service Models**: Understand IaaS vs. PaaS vs. SaaS and where Azure services align.
- **Deployment Models**: Know the difference between public, private, hybrid, and multicloud strategies.
- **Pricing Models**: Recognize pay-as-you-go, reserved instances, savings plans, spot pricing, consumption-based services, and Azure Hybrid Benefit.
- **Networking Basics**: IP ranges, CIDR blocks, subnets, firewalls, and load balancer concepts.
- **Identity & Security**: Principles of least privilege, role assignments, and multi-factor authentication.
- **Resiliency & Scalability**: High availability, auto-scaling, backup/restore, and disaster recovery patterns.
- **Monitoring & Cost Management**: Cloud spend visibility, tagging strategies, alerts, and observability fundamentals.
- **Linux Familiarity**: Comfortable navigating Linux file systems, managing services, and connecting securely with SSH.

## Cloud Types & Pricing Models
- **Public Cloud**: Shared Azure infrastructure managed by Microsoft and accessed over the internet.
- **Private Cloud**: Dedicated resources hosted on-premises or via Azure Stack for regulatory isolation.
- **Hybrid Cloud**: Integrates on-premises and Azure environments using VPN or ExpressRoute with unified management.
- **Multicloud**: Operates across Azure, AWS, and GCP; requires consistent governance and identity strategy.
- **Pay-as-you-go (PAYG)**: Metered billing with no commitment—ideal for experimentation and variable workloads.
- **Reserved Capacity/Savings Plans**: One- or three-year commitments on compute for up to ~72% savings.
- **Spot Instances**: Discounted surplus capacity with eviction risk; suited for stateless or batch jobs.
- **Consumption-Based**: Serverless services such as Azure Functions or Logic Apps bill per execution and scale to zero.
- **Azure Hybrid Benefit**: Apply existing Windows Server or SQL Server licenses to reduce VM costs.

## Azure Account Setup
1. **Check eligibility**: Ensure you have a personal Microsoft account (MSA) or work/school account that can be associated with Azure. Corporate tenants may require admin approval.
2. **Gather requirements**:
   - Valid credit card or debit card (for identity verification; not charged during free trial unless you upgrade).
   - Phone capable of receiving SMS or voice calls for multi-factor verification.
   - Government-issued ID may be requested in some regions for additional identity checks.
3. **Create an Azure free account**:
   - Navigate to https://azure.microsoft.com/free/ and sign in with your MSA.
   - Complete identity verification and review the subscription agreement.
   - Receive $200 USD (or local equivalent) credits valid for 30 days plus access to select services free for 12 months.
4. **Enable spending controls**:
   - Stay on the Free tier by keeping the "Do not upgrade" option enabled during the trial.
   - Monitor usage from the Cost Management + Billing blade; set budgets and alerts.
5. **Explore alternate offers**:
   - **Azure for Students**: Available with an academic email; no credit card required and includes $100 in credits.
   - **Visual Studio Subscription Benefits**: MSDN/Visual Studio subscribers receive monthly Azure credits (typically $50-$150).
   - **Azure Pass / Sponsorship**: Sometimes provided by training programs or Microsoft events for temporary access.
6. **Verify DevOps access**:
   - Ensure the subscription owner or administrator can add the `Microsoft.VisualStudio` resource provider if you plan to connect Azure DevOps pipelines.
   - Confirm the Azure AD tenant allows third-party applications so the Azure DevOps service principal can be created.


## Key Definitions
- **Organization**: Top-level Azure DevOps container that houses projects and users.
- **Project**: Scoped workspace inside an organization that groups repos, pipelines, boards, and artifacts for a product or team.
- **Repository**: Git repo hosted in Azure DevOps or GitHub where source code lives.
- **Pipeline**: Automated build/test/release workflow defined in YAML or the classic editor.
- **Service Connection**: Secure credential store used by Azure DevOps pipelines to access external services like Azure subscriptions or Docker registries.
- **Artifact Feed**: Package storage (NuGet, npm, Maven, Python) managed by Azure Artifacts for dependency sharing.
- **PAT (Personal Access Token)**: Scopes-based token alternative to passwords for authenticating automation and CLI tools.
- **Infrastructure as Code (IaC)**: Declarative definition of infrastructure (ARM, Bicep, Terraform) applied consistently through pipelines.

## Azure & DevOps Job Roles
- **Azure Administrator**: Manages subscriptions, governance, networking, and operational health.
- **DevOps Engineer**: Builds CI/CD pipelines, automates infrastructure, and champions continuous delivery.
- **Cloud Solutions Architect**: Designs secure, scalable reference architectures across Azure services.
- **Site Reliability Engineer (SRE)**: Improves reliability through automation, observability, and incident response.
- **Security Engineer**: Applies security controls, monitors threats, and manages identities and policies.
- **Data/AI Engineer**: Operates data platforms and ML workloads with Azure Synapse, Data Factory, and Machine Learning.
- **Platform Engineer**: Provides internal developer platforms, reusable infrastructure modules, and tooling.

## Required Software
| Tool | Purpose | macOS | Windows | Linux |
| --- | --- | --- | --- | --- |
| Git | Source control | `brew install git` or Xcode Command Line Tools | Install from [git-scm.com](https://git-scm.com/download/win) | `sudo apt install git` |
| Visual Studio Code | Editor & Dev Containers | Download [VS Code](https://code.visualstudio.com/) | Same link | Same link |
| VS Code Command Line | Launch VS Code from terminal | Run `scripts/install_vscode_terminal.sh` | Use the VS Code Command Palette → "Shell Command: Install 'code' command" | `/usr/bin/code` after installing VS Code |
| Azure CLI | Azure & DevOps automation | `scripts/install_azure_cli.sh` | Use [MSI installer](https://aka.ms/installazurecliwindows) | `scripts/install_azure_cli.sh` |
| Azure DevOps CLI extension | Manage org/projects/pipelines | `scripts/install_azure_devops_extension.sh` | `az extension add --name azure-devops` (run in PowerShell) | `scripts/install_azure_devops_extension.sh` |
| Node.js (LTS) | Pipeline scripting (optional) | `brew install node` or use [nvm](https://github.com/nvm-sh/nvm) | [Node.js installer](https://nodejs.org/en/download) | `sudo apt install nodejs npm` or nvm |
| Docker Desktop (optional) | Containerized builds & testing | [Docker Desktop](https://www.docker.com/products/docker-desktop/) | Same link | [Docker Engine](https://docs.docker.com/engine/install/) |

> Tip: Windows users aiming for a Linux-like experience should enable WSL2 and install Ubuntu. See the [WSL setup guide](https://learn.microsoft.com/windows/wsl/install) for details.

## Installation Steps
1. **Clone this repository** (or download it):
   ```bash
   git clone https://github.com/<your-org>/pre-azure-devops.git
   cd pre-azure-devops
   ```
2. **Run the helper scripts** relevant to your platform:
   ```bash
   # macOS / Linux
   bash scripts/install_vscode_terminal.sh
   bash scripts/install_azure_cli.sh
   bash scripts/install_azure_devops_extension.sh
   ```
3. **Install remaining software manually** if a script is not provided for your OS (see table above).
4. **Configure Git** (set your name/email, enable credential helper):
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "you@example.com"
   git config --global pull.rebase false
   ```
5. **Authenticate Azure CLI** once installed:
   ```bash
   az login
   az account set --subscription "<subscription-name-or-id>"
   ```
6. **Verify DevOps extension**:
   ```bash
   az extension list --query "[?name=='azure-devops']"
   az devops configure --defaults organization=https://dev.azure.com/<org> project=<project>
   ```

## Commands to Learn
- **Terminal Basics**: `pwd`, `ls -al`, `cd <path>`, `mkdir <name>`, `rm -rf <path>`, `code .`
- **File Inspection**: `cat`, `less`, `tail -f`, `grep`, `rg`, `vim`, `nano`
- **Git Workflow**: `git status`, `git clone <repo>`, `git checkout -b <branch>`, `git add`, `git commit -m`, `git push`, `git pull`, `git fetch`, `git log`, `git diff`
- **Azure CLI Essentials**: `az version`, `az login`, `az account show`, `az group list`, `az storage account list`, `az deployment group create`
- **Azure DevOps CLI**: `az devops project list`, `az repos list`, `az pipelines list`, `az pipelines run`, `az boards work-item create`, `az artifacts universal publish`
- **Container & Build Tools (optional)**: `docker ps`, `docker build`, `docker run`, `npm install`, `npm test`
- **Linux Server Ops**: `whoami`, `uname -a`, `df -h`, `free -h`, `systemctl status <service>`, `journalctl -xe`, `chmod`, `chown`, `ssh user@host`, `scp <file> user@host:/path`
- **Networking & Connectivity**: `ifconfig`/`ip addr show`, `ip route`, `ping`, `traceroute`, `nslookup`, `dig`, `az network vnet list`, `az network nsg list`, `az network public-ip list`, `az network nic show`, `az network watcher test-ip-flow`

> Challenge yourself by using these commands daily—repetition cements muscle memory before the course accelerates.

## Linux & Server Foundations
- **Why it matters**: Most Azure build agents, container hosts, and Kubernetes nodes run Linux; pipelines often target Linux-based services.
- **Shell mastery**: Bash scripting automates provisioning, configuration, and CI tasks—practice conditionals, loops, functions, and environment variables.
- **Process & service management**: Use `systemctl`/`service`, understand logs with `journalctl`, and monitor workloads using `top`, `htop`, or `ps`.
- **Package ecosystems**: Know how to install software with `apt`, `yum`, or `dnf`, and verify binaries with `which`/`whereis`.
- **Permissions & security**: Manage file ownership (`chmod`, `chown`, `umask`), sudoers configuration, and SSH key-based authentication.
- **Remote administration**: Confidently connect via `ssh`, copy files with `scp`/`rsync`, and tunnel ports when diagnosing cloud resources.

## Practice Code & Automation Exercises
- **Bash automation**: Write a script that provisions a resource group and storage account using `az` CLI, wraps error handling, and logs output to a file.
- **PowerShell Core**: Use Azure PowerShell (`Az` module) to create and tag a virtual network, then export the configuration to JSON.
- **YAML pipelines**: Draft a minimal `azure-pipelines.yml` with stages for build, test, and deploy, including variable groups and conditional steps.
- **IaC template**: Author a simple Bicep or ARM template that deploys an App Service plan and web app; parameterize environment names.
- **Git workflow**: Practice branching, making pull requests, and resolving merge conflicts in a dummy repository.
- **Python/Node scripts**: Create a small script that calls the Azure REST API or SDK to list resource groups and handle pagination.
- **Container build**: Build a Dockerfile that packages a sample web app, pushes it to Azure Container Registry via `az acr build`, and runs it locally.

## Basic Commands & Syntax Refresher
- **Terminal navigation**
  ```bash
  pwd            # current directory
  ls -al         # list files (including hidden)
  cd <folder>    # change directory
  mkdir <name>   # create folder
  code .         # open VS Code in current directory
  ```
- **Git essentials**
  ```bash
  git clone <repo-url>
  git status
  git checkout -b feature/setup
  git add .
  git commit -m "Describe your change"
  git push origin feature/setup
  ```
- **Azure CLI + DevOps basics**
  ```bash
  az version
  az account show
  az devops project list
  az pipelines create --name SamplePipeline --repository <repo> --branch main --yml-path azure-pipelines.yml
  az boards work-item create --title "Course prerequisite task" --type Task
  ```

> Keep experimenting with `--help` on each command: `az devops --help` prints subcommand lists and examples.

## Important Azure DevOps Services
- **Boards**: Agile planning hub for epics, features, user stories, tasks, and bugs with Kanban and Scrum tooling baked in.
- **Repos**: Git hosting with branch policies, pull-request reviews, and integration with Azure Pipelines for gated builds.
- **Pipelines**: Cloud-hosted CI/CD service supporting YAML, classic editor, container jobs, and multi-stage releases.
- **Test Plans**: Manual and exploratory testing workflows, capturing rich diagnostics and linking to Boards work items.
- **Artifacts**: Managed package feeds for Maven, npm, NuGet, Python, and Universal Packages with upstream sources.
- **Environments & Deployment Groups**: Model stages and target resources, track deployments, and enforce approvals.
- **Service Connections**: Centralized credentials for connecting pipelines to Azure, GitHub, Docker, Jenkins, and more.
- **Secure Files & Variable Groups**: Store secrets, certificates, and shared configuration injected into pipeline runs.
- **Extensions Marketplace**: Expand capabilities with ready-made integrations (Slack, SonarCloud, Dependabot, etc.).

## Important Azure Concepts
- **Resource Hierarchy**: Subscriptions contain resource groups; resource groups host resources managed via Azure Resource Manager (ARM).
- **Landing Zones**: Standardized Azure environment design with network, identity, governance, and security baselines.
- **Regions & Availability Zones**: Choose regions close to users; deploy across zones for resilience and understand paired-region disaster recovery.
- **Virtual Networks (VNets)**: Isolated network fabric subdivided into subnets, integrated with Network Security Groups and Azure Firewall for traffic control.
- **Identity & Access**: Azure Active Directory tenants manage users, groups, and service principals; apply Role-Based Access Control (RBAC) for least-privileged access.
- **Security & Secret Management**: Azure Key Vault stores keys, secrets, and certificates; Managed Identities allow resources to authenticate without stored credentials.
- **Storage Services**: Storage accounts provide blobs, files, queues, and tables; understand redundancy options (LRS, GRS) and lifecycle management.
- **Compute & Containers**: Azure App Service, Azure Functions, Azure Kubernetes Service (AKS), and Azure Container Apps enable hosting web apps and APIs.
- **Networking Connectivity**: Site-to-site VPN, ExpressRoute, and VNet peering connect on-premises and cross-region workloads.
- **Monitoring & Logging**: Azure Monitor, Log Analytics, and Application Insights capture metrics, traces, and alerts; integrate dashboards with DevOps pipelines.
- **Governance**: Azure Policy enforces compliance; Blueprints and Management Groups orchestrate large-scale governance and cost management.
- **Automation**: Azure Automation, Event Grid, Logic Apps, and Functions support automation scenarios triggered by infrastructure events or schedules.

## Azure Networking Concepts
- **VNet & Subnet Design**: Plan address spaces (CIDR), segregate workloads by tier, and avoid overlapping IP ranges across subscriptions.
- **Network Security Groups (NSGs)**: Apply inbound/outbound rules at subnet or NIC level; leverage service tags and application security groups to simplify rule management.
- **Load Balancing Options**: Pick Azure Load Balancer for L4 traffic, Application Gateway with WAF for L7, and Azure Front Door or Traffic Manager for global routing.
- **Private Connectivity**: Use private endpoints, service endpoints, and VNet peering to keep traffic on the Microsoft backbone and secure PaaS access.
- **Perimeter Protection**: Combine Azure Firewall, DDoS Protection, WAF policies, and Azure Bastion for secure edge access without exposing management ports.
- **Hybrid Connectivity**: Compare VPN Gateway (site-to-site, point-to-site) with ExpressRoute and Virtual WAN for reliable, high-throughput hybrid networks.
- **DNS Strategy**: Manage public zones with Azure DNS, internal name resolution with Private DNS zones, and conditional forwarding for on-prem integration.
- **Observability & Troubleshooting**: Enable Network Watcher (Connection Monitor, IP Flow Verify, Packet Capture), NSG flow logs, and Azure Monitor alerts to diagnose issues quickly.

## Tools & Services to Focus On
- **Azure DevOps Platform**: Boards (work tracking), Repos (Git hosting), Pipelines (CI/CD), Artifacts (package feeds), Test Plans (manual/automated test management).
- **Core Azure Services for DevOps**: App Service, Azure Functions, Storage Accounts, Key Vault, Azure Container Registry, Azure Kubernetes Service.
- **Supporting Tooling**: VS Code (extensions for YAML, Azure, GitLens), GitHub (remote repo practice), Docker Desktop (local container builds), Azure Monitor / Application Insights (observability).
- **Security & Governance**: Azure Active Directory, RBAC roles, Azure Policy basics, Secure DevOps Kit references.

## Repository Scripts
| Script | Description |
| --- | --- |
| `scripts/install_vscode_terminal.sh` | Adds the `code` command to your PATH on macOS/Linux so you can launch VS Code from the terminal. |
| `scripts/install_azure_cli.sh` | Installs or upgrades the Azure CLI using the appropriate package manager for macOS (Homebrew) or Debian-based Linux. |
| `scripts/install_azure_devops_extension.sh` | Ensures the Azure DevOps CLI extension is available and sets sensible defaults when desired. |

> All scripts are idempotent: you can run them multiple times safely. They log each operation and exit on failure.

## Study Guide (Week 0)
1. **Command Line Primer**
   - Navigating files and folders
   - Editing with VS Code & VS Code integrated terminal
2. **Git & GitHub Fundamentals**
   - Branching strategies, pull requests, resolving merge conflicts
   - Using personal access tokens (PATs)
3. **Azure Fundamentals**
   - Core Azure services (App Service, Storage, Functions)
   - Role-Based Access Control (RBAC) basics
4. **Azure DevOps Overview**
   - Boards, Repos, Pipelines, Artifacts, Test Plans
   - Service connections and secure variable management
5. **Pipelines & YAML Syntax**
   - Multistage pipelines, templates, variables & parameters
   - Running builds locally with `az pipelines runs` commands
6. **Continuous Delivery Concepts**
   - Release strategies (Blue/Green, Canary)
   - Infrastructure as Code intros (ARM/Bicep/Terraform)

Allocate 60–90 minutes daily; mix reading official docs, watching short tutorials, and experimenting in a sandbox project.

## Reference Links
- [Azure DevOps Documentation](https://learn.microsoft.com/azure/devops/)
- [Azure CLI Docs](https://learn.microsoft.com/cli/azure/)
- [Azure DevOps CLI Reference](https://learn.microsoft.com/cli/azure/devops)
- [Git Book](https://git-scm.com/book/en/v2)
- [VS Code Documentation](https://code.visualstudio.com/docs)
- [YAML Pipeline Schema](https://learn.microsoft.com/azure/devops/pipelines/yaml-schema)
- [Microsoft Learn Paths](https://learn.microsoft.com/training/azure/)
- [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)
- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)
- [Azure Status](https://status.azure.com/en-us/status)
- [Azure DevOps Labs](https://azuredevopslabs.com/)
- [DevOps Dojo Exercises](https://aka.ms/devopsdojo)
- [Azure Friday Videos](https://azure.microsoft.com/resources/videos/azure-friday/)
- [Cloud Adoption Framework](https://learn.microsoft.com/azure/cloud-adoption-framework/)
- [Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
- [GitHub Learning Lab](https://lab.github.com/)
- [Docker Documentation](https://docs.docker.com/)

## Smoke Tests
- `code --version` prints the current VS Code CLI version.
- `git --version` returns 2.x or later.
- `az --version` shows the Azure CLI version and installed extensions.
- `az devops project list` succeeds after authenticating and setting defaults.

## Troubleshooting
- If VS Code’s `code` command is missing on macOS, rerun `scripts/install_vscode_terminal.sh` and restart your terminal.
- Azure CLI login issues: clear cached tokens with `az account clear` and retry `az login`.
- Use `az feedback` to open issues with the Azure CLI team or check the CLI GitHub repository for known bugs.

Happy learning!
