# Welcome to Business Incentives!

Business Incentives is a search tool for entrepreneurs that aggregates data from multiple entities and displays results for grants, loans, tax incentives, enterprise and opportunity zones as well as other types of resources and funding. 

## Demo Web & Mobile Site

https://coloradoincentives.com/

![Screenshot of Business Incentives](https://github.com/juliras/Business-Incentives/blob/master/docs/BI%20Home%20Page.png)

## Features

### Data Search, Consolidation and Display

Using a simple form, users can search through our aggregated data sets to access city, county, state, region or federal assistance information. Users can access a map of Enterprise and Opportunity Zones in the area by simply typing in a colorado business name, or address.

### Keyword Curation

The filtering logic is built around keyword curation (removal of punctuation, conjunctions, prepositions, pronouns and irrelevant keywords) and quality validation to exclude opportunities that don't match or are expired.

### Generic Criteria Mapping

A list of generic criteria has been compiled for users to search with, for example Assistance Types like "Grant" and "Tax Credit", and we maintain a map linking these generic criteria to coded values that are "origin" specific. 

### Search Form

![Business Incentives Search Form](https://github.com/juliras/Business-Incentives/blob/master/docs/Search%20Form.png)

### Search Result

![Business Incentives Search Result](https://github.com/juliras/Business-Incentives/blob/master/docs/Search%20Result.png)

## Solution

![Flow Chart](https://github.com/juliras/Business-Incentives/blob/master/docs/FlowChart.png)

### Data Aggregation & Processing

Custom tools aggregate data from disparate sources, including:
* Secretary of State 
* data.colorado.gov API
* grants.gov
* cfda.gov a.k.a sam.gov since 05/25/2018

Data formats processed:
* CSV files
* XML file database dump
* JSON from APIs
* Custom inputs on our site are stored into the Business Incentives data model

The various data sets are then linked when possible by creating foreign key relationships.
(e.g. using the CFDA numbers to link grants.gov with sam.gov data).

The data is pre-filtered using indexed views.
(e.g. to filter out only the grants or programs currently available and convert/analyze deadline related fields)

### Datasets Used

Three datasets were used from the Colorado Information Marketplace, two federal sources and custom data fields in the Business Incentives database:

* Enterprise Zones - https://data.colorado.gov/Economic-Growth/Enterprise-Zones-05-04-2018/k6js-8yuk
* Opportunity Zones - https://data.colorado.gov/dataset/OEDIT-Opportunity-Zoning-KMZ/7f2s-r574
* Business Entities in Colorado - https://data.colorado.gov/Business/Business-Entities-in-Colorado/4ykn-tg5h
* cfda.gov - https://beta.sam.gov/
* grants.gov - https://www.grants.gov/
* Custom data tables in the Business Incentives database

### Data Model Diagram with Annotations

![Data Model](https://github.com/juliras/Business-Incentives/blob/master/docs/BusinessIncentives_DataModel.png)

### Security

Notes about security:
* Authentication with one way encryption hash + salt for user passwords
* Leverage input validation from ASP.NET MVC and Angular JS
* Leverage Session management from ASP.NET
* No sensitive resources exposed via the use of simple/guessable URL parameters
* Valid SSL Certificate and forced HTTPS connection
* Use of well supported, reliable frameworks and tools: Angular JS, ASP.NET MVC, .NET Framework, SQL Server 2017

## Code Walk-through

### Our solution contains 4 main projects
![Business Incentives Solution Overview](https://github.com/juliras/Business-Incentives/blob/master/docs/Code_Walkthrough1.png)

* **BusinessIncentives.Web** is the web layer containing our responsive website. It is an ASP.NET MVC application with Web API and hosting an Angular JS v1.7 application.

![Business Incentives Website Project](https://github.com/juliras/Business-Incentives/blob/master/docs/Code_Walkthrough2.png)
![Web API](https://github.com/juliras/Business-Incentives/blob/master/docs/Code_Walkthrough7.png)

Client side the Angular JS application calls API actions on the server side to retrieve data or perform business logic. 
Server side, we created repositories in charge of fetching the data using Entity Framework, and using the `IQueryable` interface so we could construct queries step by step before the resulting SQL code is sent to the database.

* **BusinessIncentives.DataTools** is a C# console application processing and loading and linking data from the disparate datasets

![Business Incentives DataTools Project](https://github.com/juliras/Business-Incentives/blob/master/docs/Code_Walkthrough3.png)

* **BusinessIncentives.Common** is a C# library project containing entities and tools used by other projects, for example, our Entity Framework model (ORM tool from Microsoft), our keyword curator, etc. 

![Business Incentives DataTools Project](https://github.com/juliras/Business-Incentives/blob/master/docs/Code_Walkthrough4.png)

* **BusinessIncentives.Tests** is a C# Unit Test project containing unit tests

* **A word about criteria mapping:** as mentioned above, we maintain a map of generic criteria matched with origin specific codes (often referred to as "coded field values"). For this we use two database tables: one containing the possible origins, and another one containing the mapping:

![Criteria Mapping Tables](https://github.com/juliras/Business-Incentives/blob/master/docs/Code_Walkthrough5.png)

The logic then uses this mapping to find what coded field value to use depending on the origin of the data:

![Coded Field Mapping Logic](https://github.com/juliras/Business-Incentives/blob/master/docs/Code_Walkthrough6.png)

## After compiling the Solution

Create the databases in SQL:
1) Run the DB Creation Scripts located in DataTools->SQL Scripts
  a) Run them in order 1,2,3,...

2) Run the DataTool application to import available datasets from flat-sources

3) Run the Website
  a) First time users will have to create a login account to access all pages.

## Use Case

* Head to https://coloradoincentives.com/ 
* Click "Find Opportunities" from the top menu
* Enter a few keywords like "women grant"
* Answer "What type of business is this?" by selecting "Existing"
* Start filling out a business name in the text box below, and you should see a choice of existing business names to choose from. Type "Zoe" and select "Zoe's Coffee LLC"
* You should see the address fields prepopulated for you as we retrieved the info from the Colorado Busisnesses dataset
* Select an industry or more
* Then select the type of assistance "Grant"
* Click Search

