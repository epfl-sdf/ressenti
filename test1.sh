#Petit script pour tester juste la durée d'une page
#zf181219.1536

#time stamp du test
#ztime=`date +%Y%m%d.%H%M%S-%N`

#mkdir -p ./poubelle/$ztime
#cd ./poubelle/$ztime


zt1=`date +%s.%N`

docker exec -it docker-firefox /bin/bash /root/work/test1.sh

zt2=`date +%s.%N`

zduree=`jq -n $zt2-$zt1`

#rm -Rf test*

echo -e $ztime" "$zduree
# > duree.txt

