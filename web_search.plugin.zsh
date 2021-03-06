## depending of xdg-utils
## https://github.com/theskumar/dotfiles/blob/master/.zsh/plugins/web_search/web_search.plugin.zsh

function web_search() {
  # get the open command
  local open_cmd
  [[ "$OSTYPE" = linux* ]] && open_cmd='xdg-open'

  pattern='(google|duckduckgo|bing|yahoo)'

  # check whether the search engine is supported
  if [[ $1 =~ pattern ]];
  then
    echo "Search engine $1 not supported."
    return 1
  fi

  local url="http://www.$1.com"

  # no keyword provided, simply open the search engine homepage
  if [[ $# -le 1 ]]; then
    $open_cmd "$url"
    return
  fi
  if [[ $1 == 'duckduckgo' ]]; then
  # slightly different search syntax for DDG
    url="${url}/?q="
  else
    url="${url}/search?q="
  fi
  shift   # shift out $1

  while [[ $# -gt 0 ]]; do
    url="${url}$1+"
    shift
  done

  url="${url%?}" # remove the last '+'
  nohup $open_cmd "$url" &> /dev/null
}

alias bing='web_search bing'
alias google='web_search google'
alias yahoo='web_search yahoo'
alias ddg='web_search duckduckgo'

#add your own !bang searches here
alias wiki='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias youtube='web_search duckduckgo \!yt'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'
alias ducky='web_search duckduckgo \!'
