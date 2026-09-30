---
name: git-workflow
description: Manage Git branches, commits, rebases, pulls, pushes, and pull requests while preserving a reviewable history and guarding publication to main or active PR branches.
---

# Git Workflow

Use this skill for work that inspects or changes Git state, including commits, rebases, branch changes, pushes, and pull requests.

## Local project rules take precedence

Before acting on Git state in a repository, look for applicable repository- or project-level Git instructions: `AGENTS.md` files in scope and Git-related `SKILL.md` files under project-local skill directories such as `.agents/skills`, `.codex/skills`, and `.claude/skills`. Do not recursively load unrelated skills.

When a local rule conflicts with this skill, briefly tell the user which policy conflicts and apply the local project rule for that repository. Otherwise, follow both sets of rules. Do not treat a generic repository README as a Git policy unless it explicitly states one.

## Determine the publication context

Before every push, actively check hosting metadata to determine whether the current branch has an open PR. Do not rely only on branch names or prior user context. Also determine whether it is:

- the `main` branch (or the repository's designated default/integration branch);
- a branch with an open PR; or
- an ordinary work-in-progress branch.

Use explicit user context and available repository/hosting metadata to make that determination. If open-PR status cannot be determined reliably, do not push; ask the user to publish instead. Apply the same classification before a history rewrite that could later be published.

## Publication guardrail

Never run `git push` (or an equivalent operation that publishes history) to `main` or to a branch with an open PR. This includes force-pushes after a rebase.

Instead, prepare and verify the intended history, then ask the user to publish it. Give a copyable, branch-specific command, normally:

```powershell
git push origin <branch>
```

If a rewritten remote branch genuinely must be updated, explain why and give only the safer command:

```powershell
git push --force-with-lease origin <branch>
```

Never recommend plain `--force`.

Once the open-PR check confirms that a branch is an ordinary WIP branch, the agent may push it without requesting additional confirmation, unless an applicable local policy prohibits it.

## Commit history by lifecycle

### Ordinary WIP branches

Small, frequent, exploratory commits are allowed. They may include intermediate approaches, reversions, and a feature followed by its fix. Keep messages brief, one line, and follow the repository's convention. If none exists, use a familiar Conventional Commit-style prefix such as `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, or `chore:`.

Do not add a commit-message body by default: detailed rationale belongs in the PR.

### Before an active PR is updated or main is integrated

Shape the history into meaningful, coherent change units before publication:

- Squash a feature and subsequent fixes to that feature unless the separation has lasting value.
- Fold transient WIP, reversions, and mechanical corrections into the change they correct.
- Keep distinct changes separate only when that improves comprehension, testing, rollback, or review.
- During PR review, isolate broad mechanical changes, such as mass import-path rewrites, from behavioral changes when that improves reviewability.
- Before merging to `main`, fold review-only separations and temporary commits back into the smallest sensible long-term history, unless a local project rule says otherwise.

Before a PR is finalized, rebase the branch onto its current target branch and consolidate fixup commits, normally with an interactive autosquash rebase such as `git rebase -i --autosquash <target-branch>`. Resolve conflicts and inspect the resulting log and diff. Integrate the cleaned branch with a fast-forward-only merge where the repository workflow permits it; a local project rule may specify a different merge strategy.

Before opening a PR, update from its target/base branch so the PR starts from current code and avoids avoidable conflicts. Do not do this merely as an automatic background operation: perform it when preparing the PR or when the user requests synchronization.

### PR review follow-ups

For a change made specifically in response to an existing PR review comment, create a fixup commit targeted at the commit it corrects:

```powershell
git commit --fixup=<target-commit>
```

This makes the review trail easier to follow. Before the PR is merged, autosquash these fixups into their targets as part of the final history cleanup. Do not publish the fixup commit yourself because the branch has an active PR; provide the appropriate `git push` command to the user.

## Quality and safety checks

Before committing or handing off a history, inspect the staged diff and status. Do not commit secrets, credentials, generated local configuration, or unrelated user changes.

On WIP branches, commits may be amended, rebased, reset, or otherwise rewritten freely. For a rewritten remote history, prefer `--force-with-lease` whenever a push is appropriate under the publication guardrail.
