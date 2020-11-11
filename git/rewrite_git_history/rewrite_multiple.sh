REPO="repo.git"
DIR="dir"

git clone --bare $REPO $DIR
cd $DIR

git filter-branch --env-filter '

NAME="name"
EMAIL="email"
OLD_EMAILS=("old1" "old2")

for i in "${OLD_EMAILS[@]}"
do
   if [ "$GIT_COMMITTER_EMAIL" == "$i" ]
	then
		export GIT_COMMITTER_NAME="$NAME"
		export GIT_COMMITTER_EMAIL="$EMAIL"
	fi
	if [ "$GIT_AUTHOR_EMAIL" = "$i" ]
	then
		export GIT_AUTHOR_NAME="$NAME"
		export GIT_AUTHOR_EMAIL="$EMAIL"
	fi
done
' -f --tag-name-filter cat -- --branches --tags

git push --force --tags origin 'refs/heads/*'

cd ..
rm -rf $DIR

read -rsp $'Press enter to continue...\n'

