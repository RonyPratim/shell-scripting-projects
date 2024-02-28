#!/bin/bash
##########
# About : This script tells about the list of collaborators for a particular organization 
# e.g. devops-pratice-pratim for a particular repository e.g. shell-scripting
# this script also tells about that which user has the permission to pull request
# GitHub API URL
# Owner : RonyPratim
# Input : Input should be taken from user as a command line argument while executing the script
# user should provide the repoowner and reponame as an input
# notes : before execute user should export the username and token of the github account
##########

helper()
# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

function helper{
command_line_arguments=2
if [ $# -ne $command_line_arguments]; then
echo " Please execute the script with required cmd arguments"
echo "asd"
fi

}
# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
