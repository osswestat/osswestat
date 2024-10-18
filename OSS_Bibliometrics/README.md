# Bibliometrics README
Nick Askew

## Introduction

This README provides a summary guide to the analysis process of
data from R and Python programming languages from initial data collection to final
results. The analysis was primarily centered around bibliometrics, with the main goal
being to attribute package credit to countries and institutions. We also wanted to 
analyze how these entities collaborated with one another through network analysis methods. 

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

Researchers can reproduce the results of the bibliometrics component of the
study using this README. Descriptions for each script are provided in the Data 
Collection and Analysis tabs below, along with input files needed to run each one.

## Requirements

To run all the scripts of this analysis you will need the following
software installed:

- R-4.3.0

- RStudio 2023.12.0+369

- MySQL 8.0.33

- MySQL Workbench 8.0

### **Data Collection**

Data collection of R/Python GitHub users and repositories was done through the use of the GitHub API after identifying a registry of GitHub URLs for both package managers

### **Data Cleaning**

There was initial data cleaning done for each programming language to get the data ready for analysis. Here's a short description of each provided in the table below:

|     | Script                         | Purpose                                                                                                                                                     | Input                      | Output             |
|-----|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|--------------------|
| 1\. | PyPi_Cleaning.qmd | Clean and join Python database tables to create a final full dataset for analysis. Includes extracting country and sector data, and joining wih commits data | `Tables "python_dependencies", "python_repos", "python_github", and "python_commits" from Database` | `"python_final - A cleaned final version of all python data`|
| 2\. | CRAN_Cleaning.qmd | Fetching most recent CRAN Database available publicly (September 2023 for our analysis), and extracting sector data for an EDA on full CRAN Database | `CRAN Database` | `"cran" - a cleaned version of the full Database uploaded to our Database from Sep. 2023` |


### **Analysis**

There is analysis for both programming languages along with an EDA for CRAN on the full package database (those packages that are not also on GitHub), as this is available for R, but not for Python

|     | Script                         | Purpose                                                                                                                                                     | Input                      | Output             |
|-----|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|--------------------|
| 1\. | CRAN_EDA.qmd | An exploratory analysis of CRAN Database and Cran GitHub repositories including download, author, dependency counts and more | `Tables "cran" and "cran_repos" from Database` | `HTML of Tables and Graphs`|
| 2\. | CRAN_Analysis.qmd | Analyze programming language with bibliometric methods to attribute credit to sectors, countries, and institutions as well as generate a network analysis to see how these entities collaborate | `CRAN Database` | `HTML of Tables and Graphs` |
| 3\. | PyPi_Analysis.qmd | Analyze programming language with bibliometric methods to attribute credit to sectors, countries, and institutions as well as generate a network analysis to see how these entities collaborate | `Table "python_final" from Database and python_revdep - a reformatted version of "python_dependencies" to get reverse dependency information`| `HTML of Tables and Graphs` |