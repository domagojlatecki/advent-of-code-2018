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
seconds=-1

while [[ $allClose -eq 0 ]]; do
    if [[ ${posX[0]} -gt 10000 ]] || [[ ${posX[0]} -lt -10000 ]]; then
        factor=1000
    elif [[ ${posX[0]} -gt 1000 ]] || [[ ${posX[0]} -lt -1000 ]]; then
        factor=100
    else
        factor=1
    fi

    seconds=$(($seconds + $factor))
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

echo $seconds
