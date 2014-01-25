{
	file = 24;
	min = (file-1) * 500000;
	max = file * 500000;
	#min = 1500000;
	#max = 2000000;
	
	s = "";
	if(NR >=min && NR < max)
		s = s "" $0;
	else
		next;
		print s > "eco"file".csv";
}
