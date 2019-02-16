/* Fully discriminating TypeOfAssistance criteria */
select TypesOfAssistance_060 from Program p 
	where 
		TypesOfAssistance_060 not like 'Formula Grants%' and
			/*--> Extra*/TypesOfAssistance_060 not like 'Cooperative Agreements%'  and
		TypesOfAssistance_060 not like 'Project Grants%' and
		/*modified*/TypesOfAssistance_060 not like 'Direct Payments for%Specified Use%' and
		TypesOfAssistance_060 not like 'Direct Payments with Unrestricted Use%' and
		TypesOfAssistance_060 not like 'Direct Loans%' and
		TypesOfAssistance_060 not like 'Guaranteed/Insured Loans%' and
			/*--> Extra*/TypesOfAssistance_060 not like 'Loan Guarantees/Grants%' and
		TypesOfAssistance_060 not like 'Insurance%' and
		/*modified*/TypesOfAssistance_060 not like 'Sale, Exchange, or Donation of Property%Goods%' and
		TypesOfAssistance_060 not like 'Use of Property, Facilities, and Equipment%' and
		TypesOfAssistance_060 not like 'Provision of Specialized Services%' and
		TypesOfAssistance_060 not like 'Advisory Services and Counseling%' and
		TypesOfAssistance_060 not like 'Dissemination of Technical Information%' and
			/*--> Extra*/TypesOfAssistance_060 not like 'Information%' and
		TypesOfAssistance_060 not like 'Training%' and
		TypesOfAssistance_060 not like 'Investigation of Complaints%' and
		TypesOfAssistance_060 not like 'Federal Employment%'