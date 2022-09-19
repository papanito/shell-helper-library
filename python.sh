# @file python.sh
# @description helper functions for working with python

# @description Activating python virtual environments
# Keep python virtual environments in a central place in ~/.venv. To activate one of the environments,this function can be used
activate-venv() {
  local selected_env
  selected_env=$(ls ~/.venv/ | fzf)

  if [ -n "$selected_env" ]; then
    source "$HOME/.venv/$selected_env/bin/activate"
  fi
}