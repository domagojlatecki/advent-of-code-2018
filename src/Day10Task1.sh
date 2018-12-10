input=$(cat "$1" | sed -r "s/ //g" | sed -r "s/position=<(-?[0-9]+),(-?[0-9]+)>velocity=<(-?[0-9]+),(-?[0-9]+)>/\1,\2,\3,\4/")

posX=()
posY=()
velX=()
velY=()

for line in $input; do
    posX+=($(echo $line | sed -r "s/(-?[0-9]+),(-?[0-9]+),(-?[0-9]+),(-?[0-9]+)/\1/"))
    posY+=($(echo $line | sed -r "s/(-?[0-9]+),(-?[0-9]+),(-?[0-9]+),(-?[0-9]+)/\2/"))
    velX+=($(echo $line | sed -r "s/(-?[0-9]+),(-?[0-9]+),(-?[0-9]+),(-?[0-9]+)/\3/"))
    velY+=($(echo $line | sed -r "s/(-?[0-9]+),(-?[0-9]+),(-?[0-9]+),(-?[0-9]+)/\4/"))
done

allClose=0
count=${#posX[@]}

while [[ $allClose -eq 0 ]]; do
    if [[ ${posX[0]} -gt 10000 ]] || [[ ${posX[0]} -lt -10000 ]]; then
        factor=1000
    elif [[ ${posX[0]} -gt 1000 ]] || [[ ${posX[0]} -lt -1000 ]]; then
        factor=100
    else
        factor=1
    fi

    allClose=1

    for i in ${!posX[@]}; do
        closest=0

        for j in ${!posX[@]}; do
            distanceX=$((${posX[$i]} - ${posX[$j]}))
            distanceY=$((${posY[$i]} - ${posY[$j]}))

            if [[ $distanceX -lt 0 ]]; then
                distanceX=$((-$distanceX))
            fi

            if [[ $distanceY -lt 0 ]]; then
                distanceY=$((-$distanceY))
            fi

            distance=$(($distanceX + $distanceY))

            if [[ $distance -eq 0 ]]; then
                continue
            fi

            if [[ $closest -eq 0 ]]; then
                closest=$distance
            elif [[ $distance -lt closest ]]; then
                closest=$distance
            fi
        done

        if [[ $closest -gt 2 ]]; then
            allClose=0
            break
        fi
    done

    if [[ $allClose -eq 1 ]]; then
        break
    fi

    for i in ${!posX[@]}; do
        posX[$i]=$((${posX[$i]} + ${velX[$i]} * $factor))
        posY[$i]=$((${posY[$i]} + ${velY[$i]} * $factor))
    done
done

minX=${posX[0]}
minY=${posY[0]}
maxX=${posX[0]}
maxY=${posY[0]}

for i in ${!posX[@]}; do
    if [[ ${posX[$i]} -gt $maxX ]]; then
        maxX=${posX[$i]}
    fi

    if [[ ${posX[$i]} -lt $minX ]]; then
        minX=${posX[$i]}
    fi

    if [[ ${posY[$i]} -gt $maxY ]]; then
        maxY=${posY[$i]}
    fi

    if [[ ${posY[$i]} -lt $minY ]]; then
        minY=${posY[$i]}
    fi

    declare "marked_${posX[$i]}_${posY[$i]}=1"
done

for y in $(seq $minY $maxY); do
    for x in $(seq $minX $maxX); do
        k="marked_${x}_$y"
        if [[ "${!k}" -eq 1 ]]; then
            echo -n "#"
        else
            echo -n " "
        fi
    done
    echo
done
