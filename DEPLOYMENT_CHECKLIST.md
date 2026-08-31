# Deployment Submission Checklist

- [ ] **Link to GitHub repository:**
  - Paste your repo link here

- [ ] **GitHub Actions Success Screenshots:**
  - [ ] Dev deployment (develop branch)
  - [ ] UAT deployment (uat branch)
  - [ ] Production deployment (main branch, manual trigger)

- [ ] **AWS Resources Screenshot:**
  - [ ] Paste screenshot here

- [ ] **GitHub Secrets Setup Screenshot:**
  - [ ] Paste screenshot here (blur out sensitive info)

---

**Instructions:**
- For production, after pushing to main, go to GitHub Actions, click 'Run workflow', set `environment: production` and `destroy: false` (or `true` to destroy).
- Attach all screenshots as required above.
