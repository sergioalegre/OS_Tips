#!/bin/bash
# Ejemplo en BASH de web scrapping. El programa originalmente se llamaba btcAnalyzer.sh
# Basado: https://www.youtube.com/watch?v=_OpD54Q9hZc
# Author: Marcelo Vázquez (aka S4vitar)

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


#Queremos capturar y definir que hacer cuando se pulsa Ctrl+C
trap ctrl_c INT
function ctrl_c(){
	echo -e "\n${redColour}[!] Saliendo...\n${endColour}"

	rm ut.t* money* total_entrada_salida.tmp entradas.tmp salidas.tmp bitcoin_to_dollars 2>/dev/null
	tput cnorm; exit 1 #que vuelva a mostrar el cursor y marcamos que el programa termino anormalmente
}

function dependencies(){
	tput civis; counter=0
	dependencies_array=(html2text bc)

	echo; for program in "${dependencies_array[@]}"; do
		if [ ! "$(command -v $program)" ]; then
			echo -e "${redColour}[X]${endColour}${grayColour} $program${endColour}${yellowColour} no está instalado${endColour}"; sleep 1
			echo -e "\n${yellowColour}[i]${endColour}${grayColour} Instalando...${endColour}"; sleep 1
			apt install $program -y > /dev/null 2>&1
			echo -e "\n${greenColour}[V]${endColour}${grayColour} $program${endColour}${yellowColour} instalado${endColour}\n"; sleep 2
			let counter+=1
		fi
	done
}

#que verá el usuario si entra en la ayuda o ha metido un parametro erroneo
function helpPanel(){
	echo -e "\n${redColour}[!] Uso: ./btcAnalyzer${endColour}"
	for i in $(seq 1 80); do echo -ne "${redColour}-"; done; echo -ne "${endColour}" #dibujar 80 guiones '-'
	echo -e "\n\n\t${grayColour}[-e]${endColour}${yellowColour} Modo exploración${endColour}"
	echo -e "\t\t${purpleColour}unconfirmed_transactions${endColour}${yellowColour}:\t Listar transacciones no confirmadas${endColour}"
	echo -e "\t\t${purpleColour}inspect${endColour}${yellowColour}:\t\t\t Inspeccionar un hash de transacción${endColour}"
	echo -e "\t\t${purpleColour}address${endColour}${yellowColour}:\t\t\t Inspeccionar una transacción de dirección${endColour}"
	echo -e "\n\t${grayColour}[-n]${endColour}${yellowColour} Limitar el número de resultados${endColour}${blueColour} (Ejemplo: -n 10)${endColour}"
	echo -e "\n\t${grayColour}[-i]${endColour}${yellowColour} Proporcionar el identificador de transacción${endColour}${blueColour} (Ejemplo: -i ba76ab9876b98ad5b98ad5b9a8db5ad98b5ad98b5a9d)${endColour}"
	echo -e "\n\t${grayColour}[-a]${endColour}${yellowColour} Proporcionar una dirección de transacción${endColour}${blueColour} (Ejemplo: -a bad876fa876A876f8d6a861b9a8bd9a)${endColour}"
	echo -e "\n\t${grayColour}[-h]${endColour}${yellowColour} Mostrar este panel de ayuda${endColour}\n"
	tput cnorm; exit 1 #que vuelva a mostrar el cursor y marcamos que el programa termino anormalmente
}

# Variables globales
unconfirmed_transactions="https://www.blockchain.com/es/btc/unconfirmed-transactions" #Transacciones sin confirmar
inspect_transaction_url="https://www.blockchain.com/es/btc/tx/"
inspect_address_url="https://www.blockchain.com/es/btc/address/"

function printTable(){

    local -r delimiter="${1}"
    local -r data="$(removeEmptyLines "${2}")"

    if [[ "${delimiter}" != '' && "$(isEmptyString "${data}")" = 'false' ]]
    then
        local -r numberOfLines="$(wc -l <<< "${data}")"

        if [[ "${numberOfLines}" -gt '0' ]]
        then
            local table=''
            local i=1

            for ((i = 1; i <= "${numberOfLines}"; i = i + 1))
            do
                local line=''
                line="$(sed "${i}q;d" <<< "${data}")"

                local numberOfColumns='0'
                numberOfColumns="$(awk -F "${delimiter}" '{print NF}' <<< "${line}")"

                if [[ "${i}" -eq '1' ]]
                then
                    table="${table}$(printf '%s#+' "$(repeatString '#+' "${numberOfColumns}")")"
                fi

                table="${table}\n"

                local j=1

                for ((j = 1; j <= "${numberOfColumns}"; j = j + 1))
                do
                    table="${table}$(printf '#| %s' "$(cut -d "${delimiter}" -f "${j}" <<< "${line}")")"
                done

                table="${table}#|\n"

                if [[ "${i}" -eq '1' ]] || [[ "${numberOfLines}" -gt '1' && "${i}" -eq "${numberOfLines}" ]]
                then
                    table="${table}$(printf '%s#+' "$(repeatString '#+' "${numberOfColumns}")")"
                fi
            done

            if [[ "$(isEmptyString "${table}")" = 'false' ]]
            then
                echo -e "${table}" | column -s '#' -t | awk '/^\+/{gsub(" ", "-", $0)}1'
            fi
        fi
    fi
}

function removeEmptyLines(){

    local -r content="${1}"
    echo -e "${content}" | sed '/^\s*$/d'
}

function repeatString(){

    local -r string="${1}"
    local -r numberToRepeat="${2}"

    if [[ "${string}" != '' && "${numberToRepeat}" =~ ^[1-9][0-9]*$ ]]
    then
        local -r result="$(printf "%${numberToRepeat}s")"
        echo -e "${result// /${string}}"
    fi
}

function isEmptyString(){

    local -r string="${1}"

    if [[ "$(trimString "${string}")" = '' ]]
    then
        echo 'true' && return 0
    fi

    echo 'false' && return 1
}

function trimString(){

    local -r string="${1}"
    sed 's,^[[:blank:]]*,,' <<< "${string}" | sed 's,[[:blank:]]*$,,'
}

#si el usuario quiere ver las transacciones no verificadas
function unconfirmedTransactions(){

	number_output=$1
	echo '' > ut.tmp

	while [ "$(cat ut.tmp | wc -l)" == "1" ]; do
		curl -s "$unconfirmed_transactions" | html2text > ut.tmp #curl -s para que no enseñe la barra de progreso. $unconfirmed_transactions es la url que es una variable global
	done

	hashes=$(cat ut.tmp | grep "Hash" -A 1 | grep -v -E "Hash|\--|Tiempo" | head -n $number_output)  #cada hash que es lo que queremos, vemos que en curl empieza siempre por Hash y luego '--' asi que hay que quitarlo, y quitamos la palabra Tiempo. Con ello, nos quedamos solo con los hashes que es lo que queremos mostrar

	echo "Hash_Cantidad_Bitcoin_Tiempo" > ut.table
	for hash in $hashes; do #explicado minuto 40
		echo "${hash}_$(cat ut.tmp | grep "$hash" -A 6 | tail -n 1)_$(cat ut.tmp | grep "$hash" -A 4 | tail -n 1)_$(cat ut.tmp | grep "$hash" -A 2 | tail -n 1)" >> ut.table
	done

	cat ut.table | tr '_' ' ' | awk '{print $2}' | grep -v "Cantidad" | tr -d '$' | sed 's/\..*//g' | tr -d ',' > money

	money=0; cat money | while read money_in_line; do
		let money+=$money_in_line
		echo $money > money.tmp
	done;

	echo -n "Cantidad total_" > amount.table
	echo "\$$(printf "%'.d\n" $(cat money.tmp))" >> amount.table

	if [ "$(cat ut.table | wc -l)" != "1" ]; then
		echo -ne "${yellowColour}"
		printTable '_' "$(cat ut.table)"
		echo -ne "${endColour}"
		echo -ne "${blueColour}"
		printTable '_' "$(cat amount.table)"
		echo -ne "${endColour}"
		rm ut.* money* amount.table 2>/dev/null
		tput cnorm; exit 0
	else
		rm ut.t* 2>/dev/null
	fi

	rm ut.* money* amount.table
	tput cnorm
}

function inspectTransaction(){
	inspect_transaction_hash=$1

	echo "Entrada Total_Salida Total" > total_entrada_salida.tmp

	while [ "$(cat total_entrada_salida.tmp | wc -l)" == "1" ]; do
		curl -s "${inspect_transaction_url}${inspect_transaction_hash}" | html2text | grep -E "Entrada total|Salida total" -A 1  | grep -v -E "Entrada total|Salida total" | xargs | tr ' ' '_' | sed 's/_BTC/ BTC/g' >> total_entrada_salida.tmp
	done

	echo -ne "${grayColour}"
	printTable '_' "$(cat total_entrada_salida.tmp)"
	echo -ne "${endColour}"
	rm total_entrada_salida.tmp 2>/dev/null

	echo "Dirección (Entradas)_Valor" > entradas.tmp

	while [ "$(cat entradas.tmp | wc -l)" == "1" ]; do
		curl -s "${inspect_transaction_url}${inspect_transaction_hash}" | html2text | grep "Entradas" -A 500 | grep "Salidas" -B 500 | grep "Direcci"  -A 3 | grep -v -E "Direcci|Valor|\--" | awk 'NR%2{printf "%s ",$0;next;}1' | awk '{print $1 "_" $2 " " $3}' >> entradas.tmp
	done

	echo -ne "${greenColour}"
	printTable '_' "$(cat entradas.tmp)"
	echo -ne "${endColour}"
	rm entradas.tmp 2>/dev/null

	echo "Dirección (Salidas)_Valor" > salidas.tmp

	while [ "$(cat salidas.tmp | wc -l)" == "1" ]; do
		curl -s "${inspect_transaction_url}${inspect_transaction_hash}" | html2text | grep "Salidas" -A 500 | grep "Lo has pensado" -B 500 | grep "Direcci"  -A 3 | grep -v -E "Direcci|Valor|\--" | awk 'NR%2{printf "%s ",$0;next;}1' | awk '{print $1 "_" $2 " " $3}' >> salidas.tmp
	done

	echo -ne "${greenColour}"
	printTable '_' "$(cat salidas.tmp)"
	echo -ne "${endColour}"
	rm salidas.tmp 2>/dev/null
	tput cnorm
}

function inspectAddress(){
	address_hash=$1
	echo "Transacciones realizadas_Cantidad total recibida (BTC)_Cantidad total enviada (BTC)_Saldo total en la cuenta (BTC)" > address.information
	curl -s "${inspect_address_url}${address_hash}" | html2text | grep -E "Transacciones|Total Recibidas|Cantidad total enviada|Saldo final" -A 1 | head -n -2 | grep -v -E "Transacciones|Total Recibidas|Cantidad total enviada|Saldo final" | xargs | tr ' ' '_' | sed 's/_BTC/ BTC/g' >> address.information

	echo -ne "${grayColour}"
	printTable '_' "$(cat address.information)"
	echo -ne "${endColour}"
	rm address.information 2>/dev/null

	bitcoin_value=$(curl -s "https://cointelegraph.com/bitcoin-price-index" | html2text | grep "Last Price" | head -n 1 | awk 'NF{print $NF}' | tr -d ',')

	curl -s "${inspect_address_url}${address_hash}" | html2text | grep "Transacciones" -A 1 | head -n -2 | grep -v -E "Transacciones|\--" > address.information
	curl -s "${inspect_address_url}${address_hash}" | html2text | grep -E "Total Recibidas|Cantidad total enviada|Saldo final" -A 1 | grep -v -E "Total Recibidas|Cantidad total enviada|Saldo final|\--" > bitcoin_to_dollars

	cat bitcoin_to_dollars | while read value; do
		echo "\$$(printf "%'.d\n" $(echo "$(echo $value | awk '{print $1}')*$bitcoin_value" | bc) 2>/dev/null)" >> address.information
	done

	line_null=$(cat address.information | grep -n "^\$$" | awk '{print $1}' FS=":")

	if [ "$(echo $line_null | grep -oP '\w')" ]; then
		echo $line_null | tr ' ' '\n' | while read line; do
			sed "${line}s/\$/0.00/" -i address.information
		done
	fi

	cat address.information | xargs | tr ' ' '_' >> address.information2
	rm address.information 2>/dev/null && mv address.information2 address.information
	sed '1iTransacciones realizadas_Cantidad total recibidas (USD)_Cantidad total enviada (USD)_ Saldo actual en la cuenta (USD)' -i address.information

	echo -ne "${grayColour}"
	printTable '_' "$(cat address.information)"
	echo -ne "${endColour}"

	rm address.information bitcoin_to_dollars 2>/dev/null
	tput cnorm
}

#parametros que admitira el programa. Ejemplo BASH-bitcoin -e
dependencies; parameter_counter=0
while getopts "e:n:i:a:h:" arg; do
	case $arg in
		e) exploration_mode=$OPTARG; let parameter_counter+=1;; #OPTARG será lo que haya puesto el usuario despues de -e
		n) number_output=$OPTARG; let parameter_counter+=1;;
		i) inspect_transaction=$OPTARG; let parameter_counter+=1;;
		a) inspect_address=$OPTARG; let parameter_counter+=1;;
		h) helpPanel;; # aqui entrará con -h o con un parametro que no existe. Siempre ha de ser la última opción
	esac
done

tput civis #hace el cursor invisible

# a que funcion irá dependiendo de la opcion del usuario
if [ $parameter_counter -eq 0 ]; then #si el usuaruio no puso parametros que muestre la ayuda del programa
	helpPanel
else
	if [ "$(echo $exploration_mode)" == "unconfirmed_transactions" ]; then # si el usuario ha usado -e vamos a ver transacciones sin confirmar
		if [ ! "$number_output" ]; then
			number_output=100
			unconfirmedTransactions $number_output
		else
			unconfirmedTransactions $number_output
		fi
	elif [ "$(echo $exploration_mode)" == "inspect" ]; then
		inspectTransaction $inspect_transaction
	elif [ "$(echo $exploration_mode)" == "address" ]; then
		inspectAddress $inspect_address
	fi
fi
