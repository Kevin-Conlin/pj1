# Wikipedia Analytics MapReduce Programs

This project contains Scala files used to perform MapReduce jobs on data provided by Wikipedia.

The InternalLinkCount program is designed to use the Wikipedia clickstream data as input.
This data contains 4 fields: Referrer_Article, Current_Article, Link_Type, Number_of_Occurences.
The program will output a key, value pair that represents Article_Name, Number_of_Internal_Links_Followed.

The PageViewMR program is designed to use the Wikipedia pageviews data as input.
This data contains 4 fields: Domain_Code, Article_Name, Number_of_Views, Total_Response_Size.
The program will output a key, value pair that represents Article_Name, Number_of_Views for only the en and en.m domain codes.
Ultimately, this provides total desktop and mobile views on English Wikipedia articles within a very narrow margin of error.

The MobilePageViews program is similar to the PageViewMR program, but deals only with mobile traffic.
It is designed to use the Wikipedia pageviews data as input.
This data contains 4 fields: Domain_Code, Article_Name, Number_of_Views, Total_Response_Size.
The program will output a key, value pair that represents Article_Name, Number_of_Views for only the en.m domain code.
Ultimately, this provides total mobile views on English Wikipedia articles within a very narrow margin of error.

The Wikipedia analytics information that is used as input to the programs can be found at:
https://dumps.wikimedia.org/other/analytics/