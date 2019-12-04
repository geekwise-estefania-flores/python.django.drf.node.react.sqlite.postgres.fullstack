function helpku() {
    local command="${1}"
    local subcommand="${2}"
    local appname="${2}"
    local error_message='Example: --appurl app-name-on-heroku'

	case "${command}" in
	'appurl' | '--appurl')
        if [ ! -z "${appname}" ]; then
            heroku apps:info -s ${appname}| grep web_url | cut -d= -f2
        else
            echo 'error: missing app name'
            echo 'try running: heroku apps -A'
            printf '\n'
        fi
	;;
	* ) echo "${error_message}"
	;;

	esac

}