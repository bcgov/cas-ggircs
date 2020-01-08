# Derivation Notes
## GGIRCS Obfuscated XML Test Files
M. Wenzowski &nbsp; / &nbsp; Button, Inc.  
07 January 2020

### Background
The XML test files included in this repository were randomly selected from submissions received in previous years. Their formatting has not been disturbed, and the data they contain has been left largely untouched. However, certain fields have been intentionally obfuscated in order to protect both personal and corporate identities. The methodology used to perform this obfuscation is described below.
### Methodology
The obfuscation of corporate, personal and any other confidential data was effected using text strings and numbers that were created using randomized functions. For this reason, text strings representing company, facility, personal and place-name information now appear as nonsense "words." Similarly, numeric identifiers now appear as randomly-generated numbers.

It is important to note that the formatting of certain fields conforms with the nature of the data in those fields – in order to generate values that remain faithful to the application’s data consistency requirements. As a result, some of the generated values could lead the reader to falsely attribute the data’s origins to the identification data associated with it.

Any conclusions or correlations based on the above assumption would be entirely false, since each of the test files have had all of their identification data completely obfuscated. So even though some of the data in a particular file will be valid (because of its compliance with formulation conventions), it is not in any way associated with any the data appearing in the same file.

The following offers further details of how these obfuscations were effected.

### Field Transformations
- ***Business, Company, Facility and Operating Names*** appear as randomized strings that may have “Ltd.” or “Inc.” appended.
- ***CRA Business Numbers*** appear as a random number, conforming to the CRA BN format.
- ***DUNS Numbers*** appear as a random number, conforming to the DUNS Number format.
- ***Post Office Box Number*** appears as a 2 to 4 digit random number.
- ***Unit and Street Numbers*** appear as a 3 to 4 digit random number.
- ***Latitude & Longitude*** are randomized, but appear as a valid location within the province of British Columbia.
- ***Street Number Suffix and Direction:*** The eight (cardinal and inter-cardinal) compass rose directions have been randomized to one of the other seven directions.
- ***Street Names:*** Numeric street names appear as a 1 to 3 digit random number, and text-based names appear as randomized strings.
- ***Street Types:*** The original values of “street”, “road”, etc. have been replaced with randomly selected street types.
- ***Municipality Names*** appear as randomized strings.
- ***Postal Codes:*** With the exception of the initial character (which is always “V”) the letters and digits of the generated postal codes have been randomly selected. The result is that all generated postal codes appear as valid codes for British Columbia.
- ***Administrative Identifiers:*** Values for BC Greenhouse, National Polluters and Permit identifiers have been randomized, but remain conformant with the respective rules for their formulation.
- ***Latitude / Longitude Pairs*** appear as valid British Columbia location identifiers, but have been fully obfuscated.
- ***Personal Identifiers:*** Given and family names appear as randomized strings.
- ***Email Addresses*** appear as firstname.lastname@domain2.domain1, such that first and last names are the obfuscated values for given and family names, domain2 is a randomized string, and domain1 is always the string: “xxx”.
- ***Telephone Numbers*** appear as randomized 7 digit numbers prepended with “250”. The result is that all generated 10-digit telephone numbers appear as British Columbia numbers.
- ***Uploaded File Names*** appear as randomized strings, all of which terminate in “.pdf”.
- ***Report & Facility Identifier Numbers, and Organization & Program Identifiers*** appear as randomized numbers.
- ***NPRI Identifiers*** appear as randomized numbers.
- ***Web Site Identifiers*** appear as randomized strings with “www.” prepended, and terminating with “.com”.