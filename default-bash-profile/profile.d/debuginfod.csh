if ("https://debuginfod.fedoraproject.org/" != "") then
	if ($?DEBUGINFOD_URLS) then
		if ($%DEBUGINFOD_URLS) then
			setenv DEBUGINFOD_URLS "$DEBUGINFOD_URLS https://debuginfod.fedoraproject.org/"
		else
			setenv DEBUGINFOD_URLS "https://debuginfod.fedoraproject.org/"
		endif
	else
		setenv DEBUGINFOD_URLS "https://debuginfod.fedoraproject.org/"
	endif
endif
