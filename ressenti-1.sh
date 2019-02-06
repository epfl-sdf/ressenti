#Petit script pour lancer une mesure de temps sur une liste de site
#ATTENTION: faire tourner ce script DANS le container docker-ressenti!

#zf190206.1256

prometheus_ip="172.22.0.1"




triger_state() {
    triger_val=$1

    c=$(echo "$RANDOM % 2" | bc)                        #juster pour tester la prochaine fonctionalite
    cat <<__EOF | curl --data-binary @- http://$prometheus_ip:9091/metrics/job/zuzuresenti/instance/triger
        # TYPE zuzu_resenti_load_time gauge
        zuzu_resenti_load_time {location="berlin"} $triger_val
        # TYPE zuzu_resenti_page_changed gauge
        zuzu_resenti_page_changed $c
__EOF

    cat <<__EOF | curl --data-binary @- http://10.0.2.15:9991/metrics/job/zuzuresenti/instance/triger
        # TYPE zuzu_resenti_load_time gauge
        zuzu_resenti_load_time {location="berlin"} $triger_val
        # TYPE zuzu_resenti_page_changed gauge
        zuzu_resenti_page_changed $c
__EOF
}



time_page() {
    label=$1
    url=$2
    img=$3

    ztime=`date +%Y%m%d.%H%M%S`
    zduree=`/root/work/screenshot.sh $url $img`

    echo -e $ztime" "$zduree

    t=${zduree::-1}				                        #supprime le dernier car
    c=$(echo "$RANDOM % 2" | bc)		                #juster pour tester la prochaine fonctionalite
    cat <<__EOF | curl --data-binary @- http://$prometheus_ip:9091/metrics/job/zuzuresenti/instance/$label
        # TYPE zuzu_resenti_load_time gauge
        zuzu_resenti_load_time {location="berlin"} $t
        # TYPE zuzu_resenti_page_changed gauge
        zuzu_resenti_page_changed $c
__EOF

    cat <<__EOF | curl --data-binary @- http://10.0.2.15:9991/metrics/job/zuzuresenti/instance/$label
        # TYPE zuzu_resenti_load_time gauge
        zuzu_resenti_load_time {location="berlin"} $t
        # TYPE zuzu_resenti_page_changed gauge
        zuzu_resenti_page_changed $c
__EOF

}




echo -e "triger 10"
triger_state "10"



echo -e "z.zufferey.com"
time_page "z.zufferey.com" "http://z.zufferey.com" "z.zufferey.com"

echo -e "www.epfl.ch"
time_page "www.epfl.ch" "https://www.epfl.ch" "www.epfl.ch"

echo -e "www.epfl.ch/wp-admin"
time_page "www.epfl.ch-wp-admin" "https://www.epfl.ch/wp-admin" "www.epfl.ch-wp-admin"

echo -e "actu.epfl.ch"
time_page "actu.epfl.ch" "https://actu.epfl.ch" "actu.epfl.ch"

echo -e "memento.epfl.ch"
time_page "memento.epfl.ch" "https://memento.epfl.ch" "memento.epfl.ch"

echo -e "people.epfl.ch"
time_page "people.epfl.ch" "https://people.epfl.ch/christian.zufferey" "people.epfl.ch"

echo -e "gel.epfl.ch"
time_page "gel.epfl.ch" "https://gel.epfl.ch" "gel.epfl.ch"

echo -e "jahia.epfl.ch"
time_page "jahia.epfl.ch" "https://jahia.epfl.ch" "jahia.epfl.ch"

echo -e "www.abcm.ch"
time_page "www.abcm.ch" "https://www.abcm.ch" "www.abcm.ch"

echo -e "www.abcm.ch_wp"
time_page "www.abcm.ch-wp" "http://www.abcm.ch/wp" "www.abcm.ch-wp"

echo -e "www.makerspace-lausanne.ch"
time_page "www.makerspace-lausanne.ch" "http://www.makerspace-lausanne.ch" "www.makerspace-lausanne.ch"




echo -e "triger 1"
triger_state "1"
