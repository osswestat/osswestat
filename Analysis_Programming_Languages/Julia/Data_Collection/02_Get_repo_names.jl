using CSV
using DataFrames
using PackageAnalyzer
using ProgressBars


# Reading the output file from '01_Extract_package_name.ipynb'
df = CSV.read("/home/sreenath_a/Projects/OSS/Julia_Packages_List.csv", DataFrame)
packages_vector = df.Pkg_Name


# Function to get repository name and URL
function GetInfo(pname)
    p = analyze(pname)
    row =[p.name, p.repo]
    return row
end

# Creating a dataframe to store the name and URL of a repository
dfrepo =DataFrame(PackageName=String[], RepoURL=String[])

# Iterating over each package to information and store it into the dataframe
packages_num = length(packages_vector)
packages_list = packages_vector[1:packages_num]
for pname in ProgressBar(packages_list)
    row = GetInfo(pname)
    push!(dfrepo, (PackageName=row[1], RepoURL=row[2]))
end

# Saving the dataframe in a .csv format
dfrepo
CSV.write("Julia_Packages_List_Repo.csv", dfrepo)