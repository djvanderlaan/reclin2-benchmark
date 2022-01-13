


Dataset is from [ESSnet on Data Integration](https://ec.europa.eu/eurostat/cros/content/essnet-di-fictitious-data-ons-job-training-record-linkage_en)


These totally fictional data sets are supposed to have captured details of
persons up to the date 31 December 2011.  Any years of birth captured as 2012
are therefore in error.  Note that in the fictional Census data set, dates of
birth between 27 March 2011 and 31 December 2011 are not necessarily in error.


|--------------|-----------------------------------------------------------------------------|
| CIS          | Fictional observations from Customer Information System, which is combined 
                 administrative data from the tax and benefit systems                        |
| PRD          | Fictional observations from Patient Register Data of the National Health 
                 Service                                                                     |





CIS
-------------------------------------------------------------------------------

Variable Name	Description	Field Length	Type	Number of rows	Number of rows missing	Number of rows in error

PERSON_ID	A unique number for each person, consisting of postcode, house number and person number	20	Text	24613	0	0
PERNAME1	Forename	17	Text	24613	280	5317
PERNAME2	Surname	17	Text	24613	0	4102
SEX	Gender (M/F)	1	Text	24613	303	303
DOB_DAY	Day of birth	8	Numeric	24613	317	317
DOB_MON	Month of birth	8	Numeric	24613	0	1050
DOB_YEAR	Year of birth	8	Numeric	24613	321	675
ENUMCAP	An address consisting of house number and street name	80	Text	24613	620	2582
ENUMPC	Postcode	8	Text	24613	276	1754
CIS_ID	Person ID with "CIS" added in front	17	Text	24613	0	0

Number of rows in CIS data set: 24,613

Number of rows in common with the Census data set: 24,043

Number of rows in common with the Census data set that are noisy: 15,214

Number of rows in common with the PRD data set: 22,860

Number of rows in common with the PRD data set that are noisy: 14,369


PRD
-------------------------------------------------------------------------------


Variable Name	Description	Field Length	Type	Number of rows	Number of rows missing	Number of rows in error

PERSON_ID	A unique number for each person, consisting of postcode, house number and person number	20	Text	24750	0	0
PERNAME1	Forename	17	Text	24750	288	4381
PERNAME2	Surname	17	Text	24750	0	4006
SEX	Gender (M/F)	1	Text	24750	298	298
DOB_DAY	Day of birth	8	Numeric	24750	316	316
DOB_MON	Month of birth	8	Numeric	24750	0	1006
DOB_YEAR	Year of birth	8	Numeric	24750	264	633
ENUMPC	Postcode	8	Text	24750	1222	2739
PRD_ID	Person ID with "PRD" added in front	17	Text	24750	0	0

Number of rows in PRD data set: 24,750

Number of rows in common with the Census data set: 24,102

Number of rows in common with the Census data set that are noisy: 14,020

Number of rows in common with the CIS data set: 22,860

Number of rows in common with the CIS data set that are noisy: 14,369

