---
type: slide
slideOptions:
  transition: slide
  width: 1400
  height: 900
  margin: 0.1
---

<style>
  .reveal strong {
    font-weight: bold;
    color: orange;
  }
  .reveal p {
    text-align: left;
  }
  .reveal section h1 {
    color: orange;
  }
  .reveal section h2 {
    color: orange;
  }
  .reveal code {
    font-family: 'Ubuntu Mono';
    color: orange;
  }
  .reveal section img {
    background:none;
    border:none;
    box-shadow:none;
  }
</style>

# Learning Goals

- Name and explain common workflows to automate in RSE.
- Explain the differences between the various continuous methodologies.
- Explain why automation is crucial in RSE.
- Write and understand basic automation scripts for GitHub Actions.
  - s.t. we are able to understand what `PkgTemplates` generates for us.


Material is taken and modified from the [SSE lecture](https://github.com/Simulation-Software-Engineering/Lecture-Material).

---

# 1. Workflow Automation

---

## Why Automation?

- Automatize tasks
    - Run tests frequently, give feedback early etc.
    - Ensure reproducible test environments
    - Cannot forget automatized tasks
    - Less burden to developer (and their workstation)
    - Avoid manual errors
- Process often integrated in development workflow
    - Example: Support by Git hooks or Git forges

---

## Typical Automation Tasks in RSE

- Check code formatting and quality
- Compile and test code for different platforms
- Generate coverage reports and visualization
- Build documentation and deploy it
- Build, package, and upload releases

---

## Continuous Methodologies (1/2)

- **Continuous Integration** (CI)
    - Continuously integrate changes into "main" branch
    - Avoids "merge hell"
    - Relies on testing and checking code continuously
        - Should be automatized

---

## Continuous Methodologies (2/2)

- **Continuous Delivery** (CD)
    - Software is in a state that allows new release at any time
    - Software package is built
    - Actual release triggered manually
- **Continuous Deployment** (CD)
    - Software is in a state that allows new release at any time
    - Software package is built
    - Actual release triggered automatically (continuously)

---

## Automation Services/Software

- [GitHub Actions](https://github.com/features/actions)
- [GitLab CI/CD](https://docs.gitlab.com/ee/ci/)
- [Circle CI](https://circleci.com/)
- [Travis CI](https://www.travis-ci.com/)
- [Jenkins](https://www.jenkins.io/)
- ...

---

# 2. GitHub Actions

---

## What is "GitHub Actions"?

> Automate, customize, and execute your software development workflows right in your repository with GitHub Actions.

From: [https://docs.github.com/en/actions](https://docs.github.com/en/actions)

---

## General Information

- Usage of GitHub's runners is [limited](https://docs.github.com/en/actions/learn-github-actions/usage-limits-billing-and-administration#usage-limits)
- Available for public repositories or accounts with subscription
- By default Actions run on GitHub's runners
    - Linux, Windows, or MacOS
- Quickly evolving and significant improvements in recent years

---

## Components (1/2)

- [Workflow](https://docs.github.com/en/actions/using-workflows): Runs one or more jobs
- [Event](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows): Triggers a workflow
- [Jobs](https://docs.github.com/en/actions/using-jobs): Set of steps (running on same runner)
    - Steps executed consecutively and share data
    - Jobs by default executed in parallel
- [Action](https://docs.github.com/en/actions/creating-actions): Application performing common, complex task (step) often used in workflows
- [Runner](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions#runners): Server that runs jobs
- [Artifacts](https://docs.github.com/en/actions/learn-github-actions/essential-features-of-github-actions#sharing-data-between-jobs): Files to be shared between jobs or to be kept after workflow finishes

---

## Components (2/2)

<img src="https://docs.github.com/assets/cb-25628/images/help/images/overview-actions-simple.png" width=95%; style="margin-left:auto; margin-right:auto; padding-top: 25px; padding-bottom: 25px; background: #eeeeee">


From [GitHub Actions tutorial](https://docs.github.com/en/actions)

---

## Setting up a Workflow

- Workflow file files stored `${REPO_ROOT}/.github/workflows`
- Configured via YAML file

```yaml
name: learn-github-actions
on: [push]
jobs:
  check-bats-version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '14'
      - run: npm install -g bats
      - run: bats -v
```

---

## Actions

```yaml
- uses: actions/checkout@v3
- uses: actions/setup-node@v2
  with:
    node-version: '14'
```

- Integrated via `uses` directive
- Additional configuration via `with` (options depend on Action)
- Find actions in [marketplace](https://github.com/marketplace?type=actions)
- Write [own actions](https://docs.github.com/en/actions/creating-actions)

---

## Some Useful Julia Actions

- Find on [gitHub.com/julia-actions](https://github.com/julia-actions/)

   ```
   - uses: julia-actions/setup-julia@v1
        with:
          version: '1.9'
   ```

- More:
  - `cache`: caches `~/.julia/artifacts/*` and `~/.julia/packages/*` to reduce runtime of CI
  - `julia-buildpkg`: build package
  - `julia-runtest`: run tests
  - `julia-format`: format code

---

## User-specified Commands

```yaml
- name: "Single line command"
  run: echo "Single line command"
- name: "Multi line command"
  run: |
    echo "First line"
    echo "Second line. Directory ${PWD}"
  workdir: tmp/
  shell: bash
```

---

## Events

- Single or multiple events

  ```yaml
  on: [push, fork]
  ```

- Activities

  ```yaml
  on:
    issue:
      types:
        - opened
        - labeled
  ```

- Filters

  ```yaml
  on:
    push:
      branches:
        - main
        - 'releases/**'
  ```

---

## Artifacts

- Data sharing between jobs and data upload
- Uploading artifact

  ```yaml
  - name: "Upload artifact"
    uses: actions/upload-artifact@v2
    with:
      name: my-artifact
      path: my_file.txt
      retention-days: 5
  ```

- Downloading artifact

  ```yaml
  - name: "Download a single artifact"
    uses: actions/download-artifact@v2
    with:
      name: my-artifact
  ```

  **Note**: Drop name to download all artifacts

---

## Test Actions Locally

- [act](https://github.com/nektos/act)
- Relies extensively on Docker
    - User should be in `docker` group
- Run `act` from root of the repository

  ```text
  act (runs all workflows)
  act --job WORKFLOWNAME
  ```

- Environment is not 100% identical to GitHub's
    - Workflows may fail locally, but work on GitHub

---

## Advanced Topics

- [Self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners)
- [Secrets and tokens](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Continuous deployment](https://docs.github.com/en/actions/deployment/about-deployments/about-continuous-deployment)
- [Custom actions](https://docs.github.com/en/actions/creating-actions/about-custom-actions)
- [Build matrices](https://docs.github.com/en/actions/using-workflows/advanced-workflow-features#using-a-build-matrix)
- Using own Docker containers

---

## Further Reading

- [What is Continuous Integration?](https://www.atlassian.com/continuous-delivery/continuous-integration)
- [GitHub Actions documentation](https://docs.github.com/en/actions)
- [GitHub Actions quickstart](https://docs.github.com/en/actions/quickstart)

---

# 3. Demo: Automation with GitHub Actions

---

## Setting up a Test Job

- Import [Julia test package repository](https://github.com/uekerman/JuliaTestPackage) (the same code we used for testing)
- Set up workflow file

  ```bash
  mkdir -p .github/workflows
  cd .github/workflows
  vi format-check.yml
  ```

- Let's check whether our code is formatted correctly. Edit `format-check.yml` to have following content

  ```yaml
  name: format-check

  on: [push, pull_request]

  jobs:
    format:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v3
        - uses: julia-actions/setup-julia@v1
          with:
            version: '1.9'
        - name: Install JuliaFormatter and format
          run: |
            julia  -e 'using Pkg; Pkg.add(PackageSpec(name="JuliaFormatter"))'
            julia  -e 'using JuliaFormatter; format(".", verbose=true)'
        - name: Format check
          run: |
            julia -e '
            out = Cmd(`git diff --name-only`) |> read |> String
            if out == ""
                exit(0)
            else
                @error "Some files have not been formatted"
                write(stdout, out)
                exit(1)
            end'     
  ```

- `runs-on` does **not** refer to a Docker container, but to a runner tag.
- Add, commit, push
- After the push, inspect "Action" panel on GitHub repository
    - GitHub will schedule a run (yellow dot)
    - Hooray. We have set up our first action.
- Failing test example:
    - Edit settings on GitHub that one can only merge if all tests pass:
        - Settings -> Branches -> Branch protection rule
        - Choose `main` branch
        - Enable "Require status checks to pass before merging". Optionally enable "Require branches to be up to date before merging"
        - Choose status checks that need to pass: `test`
        - Click on "Create" at bottom of page.
    - Create a new branch `break-code`.
    - Edit some file, violate the formatting, commit it and push it to the branch. Afterwards open a new PR and inspect the failing test. We are also not able to merge the changes as the "Merge" button should be inactive.

---

## act Demo

- `act` is for quick checks while developing workflows, not for developing the code
- Check available jobs (at root of repository) 

  ```bash
  act -l
  ```

- Run jobs for `push` event (default event)

  ```bash
  act
  ```

- Run a specific job

  ```bash
  act -j test
  ```

---

# 4. Exercise

Set up GitHub Actions for your statistics package. They should format your code and run the tests. To structure and parallelize things, you could use two separate jobs.
