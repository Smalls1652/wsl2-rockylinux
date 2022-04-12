if [ -n "https://debuginfod.fedoraproject.org/" ]; then
	DEBUGINFOD_URLS="${DEBUGINFOD_URLS-}${DEBUGINFOD_URLS:+ }https://debuginfod.fedoraproject.org/"
	export DEBUGINFOD_URLS
fi
