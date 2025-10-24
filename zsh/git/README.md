# Source in ~/.zshrc
```
echo "source <Path to dotfiles>/zsh/git/functions.zsh" >> ~/.zprofile (or .zsh etc)
```

# Create new worktree
```
create_git_worktree <branch name>
```

# Remove worktree
## Scenario 1: Remove current worktree (most common)

```
# Just run without args - removes current and returns to main
remove_git_worktree
```

Output:
```
✅ Removed worktree and returned to main repo
```
You're now in: /Users/vinayakmenon/mpo-api-authn-server

## Scenario 2: Remove specific worktree from main repo
```
  # You're in main repo. Remove by path
  delete_git_worktree ../<path to worktree>
```
  
## Scenario 3: List then remove
```
  list_git_worktrees
```

  Output shows all worktrees with paths
```
  delete_git_worktree ../<path to worktree>
```

## Scenario 4: Clean up manually deleted worktrees
```
  # Someone did: rm -rf ../<path to worktree>. Git still tracks it, so prune:
   prune_git_worktrees
```

