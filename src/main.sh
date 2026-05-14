#!/usr/bin/env bash

source "$PR_SIZE_LABELER_HOME/src/ensure.sh"
source "$PR_SIZE_LABELER_HOME/src/github.sh"
source "$PR_SIZE_LABELER_HOME/src/github_actions.sh"
source "$PR_SIZE_LABELER_HOME/src/labeler.sh"
source "$PR_SIZE_LABELER_HOME/src/misc.sh"

##? Adds a size label to a GitHub Pull Request
##?
##? Usage:
##?   main.sh --github_token=<token> --xs_label=<label> --xs_max_size=<size> --s_label=<label> --s_max_size=<size> --m_label=<label> --m_max_size=<size> --l_label=<label> --l_max_size=<size> --xl_label=<label> --fail_if_xl=<false> --message_if_xl=<message> --github_api_url=<url> --files_to_ignore=<files> --ignore_line_deletions=<false> --ignore_file_deletions=<false>
main() {
  # Parse --key=value arguments directly without eval to avoid code injection risk
  local github_token="" xs_label="" xs_max_size="" s_label="" s_max_size=""
  local m_label="" m_max_size="" l_label="" l_max_size="" xl_label=""
  local fail_if_xl="" message_if_xl="" github_api_url="" files_to_ignore=""
  local ignore_line_deletions="" ignore_file_deletions=""
  for arg in "$@"; do
    case "$arg" in
      --github_token=*)       github_token="${arg#--github_token=}" ;;
      --xs_label=*)           xs_label="${arg#--xs_label=}" ;;
      --xs_max_size=*)        xs_max_size="${arg#--xs_max_size=}" ;;
      --s_label=*)            s_label="${arg#--s_label=}" ;;
      --s_max_size=*)         s_max_size="${arg#--s_max_size=}" ;;
      --m_label=*)            m_label="${arg#--m_label=}" ;;
      --m_max_size=*)         m_max_size="${arg#--m_max_size=}" ;;
      --l_label=*)            l_label="${arg#--l_label=}" ;;
      --l_max_size=*)         l_max_size="${arg#--l_max_size=}" ;;
      --xl_label=*)           xl_label="${arg#--xl_label=}" ;;
      --fail_if_xl=*)         fail_if_xl="${arg#--fail_if_xl=}" ;;
      --message_if_xl=*)      message_if_xl="${arg#--message_if_xl=}" ;;
      --github_api_url=*)     github_api_url="${arg#--github_api_url=}" ;;
      --files_to_ignore=*)    files_to_ignore="${arg#--files_to_ignore=}" ;;
      --ignore_line_deletions=*)  ignore_line_deletions="${arg#--ignore_line_deletions=}" ;;
      --ignore_file_deletions=*)  ignore_file_deletions="${arg#--ignore_file_deletions=}" ;;
    esac
  done

  ensure::env_variable_exist "GITHUB_REPOSITORY"
  ensure::env_variable_exist "GITHUB_EVENT_PATH"

  export GITHUB_TOKEN="$github_token"
  export GITHUB_API_URL="$github_api_url"

  labeler::label \
    "$xs_label" \
    "$xs_max_size" \
    "$s_label" \
    "$s_max_size" \
    "$m_label" \
    "$m_max_size" \
    "$l_label" \
    "$l_max_size" \
    "$xl_label" \
    "$fail_if_xl" \
    "$message_if_xl" \
    "$files_to_ignore" \
    "$ignore_line_deletions" \
    "$ignore_file_deletions"

  exit $?
}
