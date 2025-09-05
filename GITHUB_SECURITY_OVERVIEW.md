# GitHub Advanced Security (GHAS) Overview - 2025

## Repository Security Scanning with Trivy

This repository demonstrates container vulnerability scanning using Trivy integrated with GitHub's Security tab. The implementation uploads SARIF reports to GitHub's Code Scanning feature for centralized security visibility.

## How Security Tab Integration Works

The workflow (`.github/workflows/trivy-scan.yml`) enables Security tab integration through:

1. **SARIF Report Generation** - Trivy creates standardized vulnerability reports
2. **Code Scanning Upload** - Reports uploaded via `github/codeql-action/upload-sarif`
3. **Security Permissions** - Workflow has `security-events: write` permission
4. **Always Upload** - Uses `if: always()` to ensure results upload even on scan failures

Results appear under: **Repository → Security → Code scanning alerts**

## GitHub Advanced Security Pricing (2025)

### Major Changes - April 1, 2025

GitHub is unbundling GHAS into two standalone products:

#### 1. GitHub Secret Protection - $19/month per active committer
- Push protection to prevent secret leaks
- Secret scanning with AI-powered detection
- Custom patterns for organization-specific secrets
- Delegated bypass for push protection
- Security insights

#### 2. GitHub Code Security - $30/month per active committer
- **Code scanning** (required for Trivy SARIF uploads to Security tab)
- CodeQL analysis
- Copilot Autofix for automated vulnerability fixes
- Security campaigns
- Dependency Review Action

### Pricing Model
- **Billing**: Based on unique active committers (pushed commits in last 90 days)
- **Access**: Available to GitHub Team plans (previously Enterprise-only)
- **Options**: Pay-as-you-go consumption model available

### Public vs Private Repositories

| Repository Type | Security Features | Cost |
|----------------|-------------------|------|
| **Public** | Code scanning, secret scanning, CodeQL CLI, Copilot Autofix | **Free** |
| **Private** | Requires GitHub Code Security license for Security tab features | **$30/month per active committer** |

## Checking GHAS Status in Your Organization

### Method 1: Organization Settings (Admin/Owner)
Navigate to: `GitHub.com → Your org → Settings → Code security and analysis`
- Look for "GitHub Advanced Security" section
- Shows enabled status and repository count

### Method 2: Security Tab Test
1. Open any private repository in your organization
2. Click the **Security** tab
3. If you see "Code scanning alerts" - GHAS is enabled
4. If you see upgrade prompts - GHAS is not enabled

### Method 3: GitHub CLI
```bash
# Check organization plan
gh api /orgs/YOUR_ORG_NAME | jq '.plan'

# Check GHAS billing status
gh api /orgs/YOUR_ORG_NAME/settings/billing/advanced-security
```

### Method 4: Billing Page (Owner only)
Navigate to: `GitHub.com → Your org → Settings → Billing and plans → GitHub Advanced Security`

## Trivy Scanner Implementation Options

### With Security Tab (GHAS Required for Private Repos)
- Full integration with GitHub Security dashboard
- SARIF reports visible in Code scanning alerts
- Centralized vulnerability management
- Historical tracking and trends

### Without Security Tab (No GHAS)
Alternative approaches for private repos without GHAS:
- View scan results in GitHub Actions logs
- Create GitHub Issues for vulnerabilities
- Add scan results as PR comments
- Store reports as workflow artifacts
- Use Trivy's native GitHub PR commenting feature

## Key Takeaways

1. **This repository's workflow** will populate the Security tab with vulnerability findings:
   - ✅ Immediately for public repositories (free)
   - 💰 For private repos, requires GitHub Code Security ($30/month per active committer after April 2025)

2. **Cost-effective testing**: Start with public repositories for free security scanning

3. **Private repo alternatives**: If GHAS is not available, the workflow still runs and provides value through:
   - Build failures on HIGH/CRITICAL vulnerabilities
   - Detailed logs in Actions tab
   - Optional artifact storage of scan reports

## Resources
- [GitHub Advanced Security Documentation](https://docs.github.com/en/get-started/learning-about-github/about-github-advanced-security)
- [GitHub Pricing](https://github.com/pricing)
- [Trivy Documentation](https://aquasecurity.github.io/trivy/)