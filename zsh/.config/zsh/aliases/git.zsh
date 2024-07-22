# Git

git_current_branch() {
    git rev-parse --abbrev-ref HEAD
}


alias g='git' # rtes

# Git Adding

alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'


# Git Branch

alias gb='git branch -vv'
alias gba='git branch --all'

alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'

# Git Checkout

alias gco='git checkout'
alias gcb='git checkout -b'
alias gcB='git checkout -B'

# Git Cherry-Pick

alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'



# Git Commit

alias gc='git commit --verbose'
alias 'gc!'='git commit --verbose --amend'
alias 'gcm!'='git commit --verbose --amend --message'
alias 'gcn!'='git commit --verbose --amend --no-edit'

alias gcm='git commit --message'

alias gca='git commit --verbose --all'
alias 'gca!'='git commit --verbose --all --amend'
alias 'gcan!'='git commit --verbose --all --amend --no-edit'

alias gcam='git commit --verbose --all --message'


# Git Config

alias gcf='git config'
alias gcfl='git config --list'
alias gcflg='git config --list --global'


# Git Diff

alias gd='git diff'
alias gdc='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'

# Git Fetch

alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'
alias gfo='git fetch origin'

# Git Help

alias ghh='git help'

# Git Log

alias gl='git log --oneline --decorate'
alias gll='git log'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

alias glg='git log --graph'
alias glgda='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'

alias gls='git log --stat'
alias glsp='git log --stat --patch'

# Git Merge

alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'


# Git Push

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease --force-if-includes'
alias 'gpf!'='git push --force'

alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'

alias ggpush='git push origin "$(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'

alias gpu='git push upstream'
alias gpv='git push --verbose'

# Git Pull

alias gpl='git pull'

# Git Rebase

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'


# Git Remote

alias gr='git remote'
alias gra='git remote add'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias grv='git remote --verbose'

# Git Reflog

alias grf='git reflog'

# Git Reset

alias grh='git reset --hard'
alias grk='git reset --keep'
alias grs='git reset --soft'
alias groh='git reset origin/$(git_current_branch) --hard'
alias gru='git reset --'

# Git Remove

alias grm='git rm'
alias grmc='git rm --cached'

# Git Revert

alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'


# Git Stash

alias gst='git stash'
alias gstm='git stash --message'
alias gstum='git stash --include-untracked --message'
alias gsta='git stash --all --message'
alias gstpu='git stash push'
alias gstap='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'

# Git Status

alias gs='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'

# Git Switch

alias gsw='git switch'
alias gswc='git switch --create'
alias gswb='git switch -'
