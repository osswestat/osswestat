# CODEGOV README
Rahul Shrivastava

## Introduction

This README provides a step by step guide to the analysis process of
data from the code.gov platform from initial data collection to final
results.

The analysis was a component of a larger study performed for the
following project:

> EAGER: Measuring the Impact and Diffusion of Open Source Software
> Innovation on Contributor and Project Networks
>
> [NSF AWARD \#
> 2306160](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2306160&HistoricalAwards=false "NSF Award Abstract")

Further information and complete documentation along with results of the
project can be found on:

<https://oss.quarto.pub/oss/about.html>

Researchers can reproduce the results of the code.gov component of the
study using this README. Complete documentation is provided for each
script used along with the data dictionaries and metadata for input and
output data files. Visual diagrams of data and script directories are
provided.

## Requirements

To run all the scripts of this analysis you will need the following
software installed:

- Python 3.9.7

- R-4.3.0

- RStudio 2023.12.0+369

- MySQL 8.0.33

- MySQL Workbench 8.0

### Package Versions

The package versions required for each programming language are provided
below.

#### Python

## Reproducing

To reproduce the work from beginning to end the following scripts must
be run in order:

### **Data Collection**

The following scripts are to be run in order.

<table style="width:99%;">
<colgroup>
<col style="width: 1%" />
<col style="width: 9%" />
<col style="width: 64%" />
<col style="width: 8%" />
<col style="width: 15%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>Script</th>
<th>Purpose</th>
<th>Input</th>
<th>Output</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1.</td>
<td>01_Extract_Repo_Names_From_JSON</td>
<td>Collect repo names from JSON input files of data captured from
Code.gov website on all projects on 06/01/2022. These files include
project names and GitHub links of projects be various Agencies available
on the Code.gov platform.</td>
<td>Input_Files_JSON_06_01_2022</td>
<td><p>Codegov_Slugs.csv</p>
<p>Push to database as table <code>codegov_slugs</code></p></td>
</tr>
<tr class="even">
<td>2.</td>
<td>02_Collect_Codegov_Repos</td>
<td>Collect data on each repo from GitHub using the GitRipper
package.</td>
<td>Codegov_Slugs.csv</td>
<td><p>Codegov_GH_Data_Repos.csv</p>
<p>Push to database as table <code>codegov_gh_data_repos</code></p></td>
</tr>
<tr class="odd">
<td>3.</td>
<td>03_Collect_Codegov_Commits</td>
<td>Collect data on each commit for each repo from GitHub using the
GitRipper package.</td>
<td>Codegov_Slugs.csv</td>
<td><p>Codegov_GH_Data_Commits.csv</p>
<p>Push to database as table
<code>codegov_gh_data_commits</code></p></td>
</tr>
</tbody>
</table>

The two output files `Codegov_GH_Data_Repos.csv` and
`Codegov_GH_Data_Commits.csv` can then be pushed to a SQL database as
individual tables. These tables will be used in the Data Cleaning
section to create other tables for analysis.

### Data Cleaning

The scripts below are used for cleaning data and creating new tables and
adding new variables. The scripts make calls to the database and use the
original tables created form the Data Collection process.

<table style="width:99%;">
<colgroup>
<col style="width: 2%" />
<col style="width: 20%" />
<col style="width: 52%" />
<col style="width: 10%" />
<col style="width: 11%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>Script</th>
<th>Purpose</th>
<th>Input</th>
<th>Output</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1.</td>
<td>01_creating_users/01_codegov_create_users</td>
<td>Creates table <code>codegov_users</code> in the database -
containing information on all users</td>
<td><code>codegov_gh_data_commits</code></td>
<td><code>codegov_users</code></td>
</tr>
<tr class="even">
<td>2.</td>
<td>02_adding_slugs/01_codegov_add_slugs_to_commits</td>
<td>Alter table <code>codegov_gh_data_commits</code> by adding a new
column <code>slug</code></td>
<td><code>codegov_gh_data_commits</code></td>
<td><code>codegov_gh_data_commits</code></td>
</tr>
<tr class="odd">
<td>3.</td>
<td>03_creating_agency_counts/01_codegov_gh_agency_counts</td>
<td>Creates table <code>codegov_gh_agency_count</code> in the database -
containing counts of projects by agency</td>
<td><code>codegov_slugs</code></td>
<td><code>codegov_gh_agency_count</code></td>
</tr>
<tr class="even">
<td>4.</td>
<td>04_adding_sectors/01_sectoring_codegov</td>
<td>Creates table <code>codegov_users_sectored</code> in the database by
applying package <code>tidyorgs</code> to categorize users into
sectors</td>
<td><code>codegov_users</code></td>
<td><code>codegov_users_sectored</code></td>
</tr>
<tr class="odd">
<td>5.</td>
<td>04_adding_sectors/02_codegov_sectors_from_sectored</td>
<td>Creates table <code>codegov_users_sectors</code> in the database by
converting dummy variables for sectors into a single categorical
variable for <code>sector</code></td>
<td><code>codegov_users_sectored</code></td>
<td><code>codegov_users_sectors</code></td>
</tr>
<tr class="even">
<td>6.</td>
<td><p>05_adding_countries/01_identify_countries</p>
<p><sub><strong>Contains code for CRAN</strong></sub></p></td>
<td>Alters table <code>codegov_users_sectors</code> in the database by
applying package <code>diverstidy</code> to categorize users into
countries</td>
<td><code>codegov_users_sectors</code></td>
<td><code>codegov_users_sectors</code></td>
</tr>
<tr class="odd">
<td>7.</td>
<td>06_creating_cost_tables/01_codegov_gh_commits_by_login</td>
<td>Creates view <code>codegov_gh_commits_by_login</code> in the
database - contains aggregate commits information by login</td>
<td><code>codegov_gh_data_commits</code></td>
<td><code>codegov_gh_commits_by_login</code></td>
</tr>
<tr class="even">
<td>8.</td>
<td>06_creating_cost_tables/02_codegov_gh_commits_by_repo</td>
<td>Creates view <code>codegov_gh_commits_by_repo</code> in the database
- contains aggregate commits information by repo</td>
<td><code>codegov_gh_data_commits</code></td>
<td><code>codegov_gh_commits_by_repo</code></td>
</tr>
<tr class="odd">
<td>9.</td>
<td>06_creating_cost_tables/03_codegov_gh_commits_by_sector</td>
<td>Creates view <code>codegov_gh_commits_by_sector</code> in the
database - contains aggregate commits information by sector</td>
<td><p><code>codegov_gh_data_commits</code> ,</p>
<p><code>codegov_users_sectors</code></p></td>
<td><code>codegov_gh_commits_by_sector</code></td>
</tr>
<tr class="even">
<td>10.</td>
<td>06_creating_cost_tables/04_codegov_gh_commits_by_year</td>
<td>Creates view <code>codegov_gh_commits_by_year</code> in the database
- contains aggregate commits information by year</td>
<td><code>codegov_gh_data_commits</code></td>
<td><code>codegov_gh_commits_by_year</code></td>
</tr>
</tbody>
</table>

All the tables created and altered in the Data Cleaning section above
exist in the SQL database. Scripts used in the section above load in
original tables the database and perform data manipulation to create
output tables which are then saved/pushed to the same database.

### Analysis

The analysis has two components - Exploratory Data Analysis (EDA) and
Network Analysis. This section is divided into these two sub-components:

#### Exploratory Data Analysis

|     | Script                         | Purpose                                                                                                                                                     | Input                      | Output             |
|-----|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|--------------------|
| 1\. | 01_EDA/01_EDA_GASP_Publication | Includes all data manipulations and calculations to produce analyses and graphs used for the GASP Special Issue (Journal of Data Science) paper submission. | `All Tables from Database` | `Graphs and Paper` |

#### Network Analysis

<table style="width:99%;">
<colgroup>
<col style="width: 2%" />
<col style="width: 19%" />
<col style="width: 41%" />
<col style="width: 15%" />
<col style="width: 20%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>Script</th>
<th>Purpose</th>
<th>Input</th>
<th>Output</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1.</td>
<td>02_Network/01_codegov_edge_combos</td>
<td>Creates view <code>codegov_edge_combos</code> to be used in creation
of network edge list.</td>
<td><code>codegov_gh_commits_by_login</code></td>
<td><code>codegov_edge_combos</code></td>
</tr>
<tr class="even">
<td>2.</td>
<td>02_Network/02_codegov_edge_creation</td>
<td>Creates table <code>codegov_edgelist_users</code> to be used in
creation of contributor network.</td>
<td><p><code>codegov_edge_combos</code> ,</p>
<p><code>codegov_slugs</code></p></td>
<td><code>codegov_edgelist_users</code></td>
</tr>
<tr class="odd">
<td>3.</td>
<td>02_Network/03_codegov_network_analysis</td>
<td>Creates multiple tables used for network analysis and calculating
network metrics.</td>
<td><code>codegov_edgelist_users</code></td>
<td><p><code>codegov_network_degree_centrality</code> ,</p>
<p><code>codegov_network_eigen_centrality</code> ,</p>
<p><code>codegov_network_closeness_centrality</code> ,</p>
<p><code>codegov_network_betweeness_centrality</code></p></td>
</tr>
</tbody>
</table>

### Dissemination

More information to be added.
