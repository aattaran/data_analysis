#count total number of violations

redirect -var rptstring \
	{report_violation -all_violators -max_delay}
	
set TNV [regexp -all VIOLTED $rptstring]

