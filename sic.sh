# Script Name: sic.sh
# Version: 0.1.0
# Author: Marcelo Canales
# Contact: https://www.linkedin.com/in/marcelo-canales			
# Repository: https://github.com/marcelocanales/sic
# Description: Enhances the search experience by providing context lines around search hits using 'ag', 'fzf', and 'bat'.
# License: MIT License

	function check_dependencies() {
  local missing_deps=()
  local dep
  for dep in ag fzf bat; do
    if ! command -v "$dep" &> /dev/null; then
      missing_deps+=("$dep")
    fi
  done

  if [ ${#missing_deps[@]} -ne 0 ]; then
    echo "Error: Missing dependencies:" >&2
    printf ' - %s\n' "${missing_deps[@]}" >&2
    return 1
  fi
}

function sic() {

  if ! check_dependencies; then
    return 1
  fi	

  if [ -z "$1" ]; then
    echo "Usage: sic <search-term>"
    return 1
  fi

  local query="$1"
  local result selected_file selected_line

  # Perform the search and allow the user to select a line with a colored preview with context.
  result=$(ag --nobreak --noheading "$query" | fzf --delimiter=':' \
    --preview "echo 'File: {1}'; echo 'Line: {2}'; line=\$(echo {2}); bat --style=numbers --color=always --line-range \$((line > 5 ? line - 5 : 1)):\$((line + 5)) --highlight-line \$line {1}" \
    --preview-window=up:60%:wrap --bind '?:toggle-preview')

  # Extract the file name and line number from the selection
  selected_file=$(echo "$result" | cut -d':' -f1)
  selected_line=$(echo "$result" | cut -d':' -f2)

  # Verify if a file and line were selected
  if [[ -n "$selected_file" && -n "$selected_line" ]]; then
    # Use bat to display the file with context and highlight the selected line
    local context_range=$((selected_line - 5))
    bat --style=numbers --color=always --line-range "$((selected_line > 5 ? selected_line - 5 : 1)):$((selected_line + 5))" --highlight-line "$selected_line" "$selected_file"
  else
    echo "No file was selected."
  fi
}
