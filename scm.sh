# @file scm.sh
# @brief source control helper functions
# @description helper functions to work with source control like git, svn, etc.

# @section git
# @description helper functions for git

# @description Creates a .gitignore file from toptal's service.
# @arg $@ string comma separated list of languages
function gi()
{
   curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ > .gitignore
}

# @description checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr()
{
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# @description checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco()
{
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# @description delete git branches, with log preview
function fdb()
{
  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview="git log {} --" |
    xargs --no-run-if-empty git branch --delete --force
}