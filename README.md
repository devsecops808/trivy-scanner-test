# Trivy Scanner Test

A minimal repo to test GitHub Actions that builds a Docker image and scans it with Trivy. The workflow fails on HIGH/CRITICAL vulnerabilities and uploads a SARIF report to GitHub code scanning.

## What’s included
- `Dockerfile`: Alpine-based sample image
- `app.sh`: Tiny script as the container entrypoint
- `.github/workflows/trivy-scan.yml`: Build image, scan with Trivy, upload SARIF

## Quick start
1. Create a new GitHub repository and push this repo:
   ```bash
   git remote add origin git@github.com:<your-org-or-user>/<your-repo>.git
   git push -u origin main
   ```
2. Open GitHub → Actions → “Build and Trivy Scan” to see the run.
3. Open GitHub → Security → Code scanning alerts to view findings from the SARIF upload.

Notes:
- For public repos, code scanning is free. For private repos, Code Scanning may require GitHub Advanced Security.
- The workflow triggers on both pushes and pull requests.

## Workflow overview
The workflow at `.github/workflows/trivy-scan.yml`:
- Builds the image: `docker build -t local/trivy-scanner-test:${{ github.sha }} .`
- Runs Trivy against the built image and fails on `CRITICAL,HIGH` severities.
- Generates a SARIF report and uploads it to the Code scanning UI.

Key settings you can tweak:
- `severity: 'CRITICAL,HIGH'` — change gating threshold.
- `exit-code: '1'` — set to `'0'` if you don’t want failures to block.
- `ignore-unfixed: true` — include or exclude vulnerabilities without available fixes.
- `vuln-type: 'os,library'` — scan OS packages and application libraries.

## Local testing (optional)
If you want to test locally with Docker (and optionally Trivy CLI):

- Build the image:
  ```bash
  docker build -t trivy-scanner-test:local .
  ```
- Run it:
  ```bash
  docker run --rm trivy-scanner-test:local
  ```
- Scan locally with Trivy CLI (if installed):
  ```bash
  trivy image --ignore-unfixed --severity CRITICAL,HIGH trivy-scanner-test:local
  ```

## Common scenarios
- Allow lower severities: change `severity` to include `MEDIUM,LOW`.
- Don’t fail the build: set `exit-code: '0'` in the “Trivy scan (fail on HIGH/CRITICAL)” step.
- Pin Trivy action version: update `aquasecurity/trivy-action@<version>` to the latest known good.
- Push and scan GHCR images: replace the local tag with `ghcr.io/<owner>/<name>:${{ github.sha }}` and add an `docker/login-action` step.

## Troubleshooting
- No alerts in Security tab: verify the SARIF upload step ran and that your repo/org has Code Scanning enabled (private repos may require GHAS).
- Rate limits or network hiccups: re-run the job; Trivy downloads a vulnerability DB which requires network access.
- Failing on known-but-unfixed CVEs: set `ignore-unfixed: true` (already set) or add an ignore policy file.

## Status badge (optional)
Add this to your README after replacing placeholders with your repo details:

```md
![Build and Trivy Scan](https://github.com/<org-or-user>/<repo>/actions/workflows/trivy-scan.yml/badge.svg)
```

Happy scanning!
