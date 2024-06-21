#!/bin/bash
testdir=test.tmp
out=main.txt
rm -rf $testdir && mkdir $testdir && cd $testdir
git init
git branch -m master main
git config core.autocrlf false
echo "=== init" > $out

commit(){
	echo "commit id: \"$1\"" >> $out
	git add $out
	git commit -m "$*"
}
branch(){
	git switch -c "$1"
	out="$1.txt"
	echo "branch $1" >> $out
}
checkout(){
	git switch $1
	out="$1.txt"
	echo "checkout $1" >> $out
}

commit M1
commit M2
branch featX
commit F1
commit F2
branch current
commit C1
commit C2
checkout featX
commit F3
checkout main
commit M3
	git tag tag3
commit M4
git tag -f save
git switch current
git branch -c detached
echo === logs
git log --oneline --branches --graph
echo === rebase main
git rebase -v main
echo === logs
git log --oneline --branches --graph
