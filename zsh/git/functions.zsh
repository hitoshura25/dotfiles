# Git worktree shortcuts
create_git_worktree() {
  local branch="${1:?Usage: create_git_worktree BRANCH_NAME}"
  local dir="../$(basename "$PWD")-${branch##*/}"
  git worktree add "$dir" -b "$branch" && cd "$dir"
}

delete_git_worktree() {
  # Check if we're in a worktree (not main repo)
  if git rev-parse --git-common-dir &>/dev/null; then
    local git_common=$(git rev-parse --git-common-dir)
    local git_dir=$(git rev-parse --git-dir)

    # If git-common-dir differs from git-dir, we're in a worktree
    if [ "$git_common" != "$git_dir" ]; then
      local worktree_path=$(pwd)
      local main_repo="$git_common/.."

      echo "📍 Current worktree: $worktree_path"
      echo "🏠 Main repo: $main_repo"

      # Check for uncommitted changes
      if ! git diff-index --quiet HEAD --; then
        echo "⚠️  Warning: You have uncommitted changes!"
        read -p "Continue with removal? (y/N) " -n 1 -r
        echo
        [[ ! $REPLY =~ ^[Yy]$ ]] && return 1
      fi

      # Go to main repo, remove worktree, stay in main repo
      cd "$main_repo"
      git worktree remove "$worktree_path"
      echo "✅ Removed worktree and returned to main repo"
      return 0
    fi
  fi

  # If not in a worktree, require path argument
  if [ -z "$1" ]; then
    echo "Usage: wt-rm [PATH]"
    echo "  Run without args from a worktree to remove current"
    echo "  Or provide path to remove specific worktree"
    git worktree list
    return 1
  fi

  # Remove specified worktree
  git worktree remove "$1"
  echo "✅ Removed worktree: $1"
}

# List all worktrees
list_git_worktrees() {
  git worktree list
}

# Clean up stale worktrees (deleted manually)
prune_git_worktrees() {
  git worktree prune -v
  echo "✅ Pruned stale worktrees"
}

delete_local_non_main_branches() {
  # Check if we're in a git repository
  if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
      echo "Error: Not in a git repository"
      return 1
  fi

  # Get current branch
  local current_branch=$(git branch --show-current)

  echo "This will delete all local branches except 'main' and current branch '$current_branch'"
  echo "Are you sure? (y/n)"
  read -r response

  if [[ "$response" =~ ^[Yy]$ ]]; then
      # Delete all local branches except main and current branch
      git branch | grep -v "main" | grep -v "$current_branch" | xargs git branch -D
      echo "Branches deleted successfully"
  else
      echo "Operation cancelled"
  fi
}
