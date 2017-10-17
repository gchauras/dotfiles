git filter-branch --env-filter '
    if [ "$GIT_AUTHOR_EMAIL"="cgaurav@inf.ethz.ch" ]; then
        GIT_AUTHOR_EMAIL="gaurav.chaurasia@disneyresearch.com";
        GIT_COMMITTER_EMAIL="gaurav.chaurasia@disneyresearch.com";
        GIT_COMMITTER_NAME="Gaurav Chaurasia";
        GIT_AUTHOR_NAME="Gaurav Chaurasia";
    fi' -- --all
