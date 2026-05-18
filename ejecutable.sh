#!/bin/bash

if [ ! -f equipos.txt ]; then
    touch equipos.txt
    echo "España" >> equipos.txt
    echo "Inglaterra" >> equipos.txt
    echo "Alemania" >> equipos.txt
    echo "Brasil" >> equipos.txt
    echo "Argentina" >> equipos.txt
    echo "Uruguay" >> equipos.txt
    echo "Francia" >> equipos.txt
fi
if [ ! -f partidos.txt ]; then
    touch partidos.txt
fi
if [ ! -f predefinidos.txt ]; then
    touch predefinidos.txt
    echo "Mexico" >> predefinidos.txt
    echo "Sudafrica" >> predefinidos.txt
    echo "Corea" >> predefinidos.txt
    echo "Chequia" >> predefinidos.txt
    echo "Canada" >> predefinidos.txt
    echo "Bosnia" >> predefinidos.txt
    echo "Qatar" >> predefinidos.txt
    echo "Suiza" >> predefinidos.txt
    echo "Brasil" >> predefinidos.txt
    echo "Marruecos" >> predefinidos.txt
    echo "Haiti" >> predefinidos.txt
    echo "Escocia" >> predefinidos.txt
    echo "Estados Unidos" >> predefinidos.txt
    echo "Paraguay" >> predefinidos.txt
    echo "Australia" >> predefinidos.txt
    echo "Turquia" >> predefinidos.txt
    echo "Alemania" >> predefinidos.txt
    echo "Curazao" >> predefinidos.txt
    echo "Costa de Marfil" >> predefinidos.txt
    echo "Ecuador" >> predefinidos.txt
    echo "Paises Bajos" >> predefinidos.txt
    echo "Japon" >> predefinidos.txt
    echo "Suecia" >> predefinidos.txt
    echo "Tunez" >> predefinidos.txt
    echo "Belgica" >> predefinidos.txt
    echo "Egipto" >> predefinidos.txt
    echo "Iran" >> predefinidos.txt
    echo "Nueva Zelanda" >> predefinidos.txt
    echo "España" >> predefinidos.txt
    echo "Cabo Verde" >> predefinidos.txt
    echo "Arabia Saudita" >> predefinidos.txt
    echo "Uruguay" >> predefinidos.txt
    echo "Francia" >> predefinidos.txt
    echo "Senegal" >> predefinidos.txt
    echo "Irak" >> predefinidos.txt
    echo "Noruega" >> predefinidos.txt
    echo "Argentina" >> predefinidos.txt
    echo "Argelia" >> predefinidos.txt
    echo "Austria" >> predefinidos.txt
    echo "Jordania" >> predefinidos.txt
    echo "Portugal" >> predefinidos.txt
    echo "Republica Democratica del Congo" >> predefinidos.txt
    echo "Uzbekistan" >> predefinidos.txt
    echo "Colombia" >> predefinidos.txt
    echo "Inglaterra" >> predefinidos.txt
    echo "Croacia" >> predefinidos.txt
    echo "Ghana" >> predefinidos.txt
    echo "Panama" >> predefinidos.txt
fi


continuar=true

function menu(){ 
    echo ""
    echo "________________________________________________"
    echo "|                                              |"
    echo "|                Menú Principal                |"
    echo "|______________________________________________|"
    echo "|                                              |"
    echo "|         1. Listar equipos                    |"
    echo "|         2. Mostrar Campeón actual            |"
    echo "|         3. Definir nuevo campeón             |"
    echo "|         4. Registrar equipo                  |"
    echo "|         5. Registrar partido                 |"
    echo "|         6. Ver historial de partidos         |"
    echo "|         7. Buscar equipo                     |"
    echo "|         8. Cantidad de partidos jugados      |"
    echo "|         9. Créditos                          |"
    echo "|         10. Salir                            |"
    echo "|______________________________________________|"
    read opcion;
    case $opcion in
        1) listar_equipos ;;
        2) mostrar_campeon_actual ;;
        3) definir_nuevo_campeon ;;
        4) registrar_equipo ;;
        5) registrar_partido ;;
        6) ver_historial_partidos ;;
        7) buscar_equipo ;;
        8) cantidad_partidos_jugados ;;
        9) creditos ;;
        10) continuar=false ;;
        *) echo "Opción inválida. Por favor, elija una opción del menú." ;;
    esac
    sleep 1;
}

function creditos () {
    echo ""
    echo "________________________________________________"
    echo "|                                              |"
    echo "|                   Créditos                   |"
    echo "|______________________________________________|"
    echo "|                                              |"
    echo "|            Desarrollado por:                 |"
    echo "|                                              |"
    echo "|            Santiago Coutinho (378832)        |"
    echo "|            Mateo Más Lukinskas (375845)      |"
    echo "|            Luca Tártaro (354973)             |"
    echo "|______________________________________________|"
    echo ""
}

function definir_nuevo_campeon() {
    echo "Ingrese el nombre del nuevo campeón:"
    read nuevo_campeon
    if ! grep -iqx "$nuevo_campeon" equipos.txt; then
        echo "El equipo '$nuevo_campeon' no está registrado."
        return
    fi
    sed -i '/^Campeon:/d' equipos.txt
    echo "" >> equipos.txt
    echo "Campeon: $(grep -ix "$nuevo_campeon" equipos.txt)" >> equipos.txt
    echo "Nuevo campeón registrado exitosamente."
    sed -i '/^$/d' equipos.txt
}

function listar_equipos(){
    if [ ! -s equipos.txt ]; then
        echo "No hay equipos registrados."
        return
    fi
    echo "Equipos registrados:"
    grep -v '^Campeon:' equipos.txt
}

function mostrar_campeon_actual(){
    if ! grep -q "Campeon" equipos.txt; then
        echo "No hay campeón registrado actualmente."
        return
    fi
    campeon=$(grep "Campeon" equipos.txt | tail -n 1 | sed 's/Campeon: //')
    echo "El campeón actual es: $campeon"
}

function registrar_equipo(){
    if [ $(grep -v '^$' equipos.txt | wc -l) -gt 15 ]; then
        echo "Tenga cuidado, hay más de 15 equipos registrados. Esto puede afectar el rendimiento de la búsqueda."
    fi
    echo "Ingrese el nombre del equipo:"
    read nombre_equipo
    if [ -z "$nombre_equipo" ]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi
    if grep -iFxq "$nombre_equipo" equipos.txt; then
        echo "El equipo ya está registrado."
        return
    fi
    if [[ "$nombre_equipo" =~ Campeon ]]; then
        echo "El nombre del equipo no puede contener la palabra 'Campeon'."
        return
    fi
    if ! grep -iFxq "$nombre_equipo" predefinidos.txt; then
        echo "El equipo '$nombre_equipo' no está en el mundial."
        return
    fi
    echo "" >> equipos.txt
    echo "$(grep -ix "$nombre_equipo" predefinidos.txt)" >> equipos.txt
    echo "Equipo registrado exitosamente."
    sed -i '/^$/d' equipos.txt
}

function registrar_partido() {
    echo "Ingrese el nombre de un equipo:"
    read equipo_1
    if [[ -z "$equipo_1" ]]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi
    if ! grep -iqx "$equipo_1" equipos.txt; then
        echo "El equipo no está registrado."
        return
    fi

    echo "Ingrese la cantidad de goles del equipo 1:"
    read goles_1

    if [[ ! "$goles_1" =~ ^[0-9]+$ ]]; then
        echo "La cantidad de goles debe ser un número entero."
        return
    fi
    if [[ "$goles_1" -lt 0 ]]; then
        echo "La cantidad de goles no puede ser negativa."
        return
    fi
    if [[ "$goles_1" -gt 20 ]]; then
        echo "La cantidad de goles no puede ser mayor a 20."
        return
    fi

    echo "Ingrese el nombre del otro equipo:"
    read equipo_2

    if [[ -z "$equipo_2" ]]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi

    if ! grep -iqx "$equipo_2" equipos.txt; then
        echo "El equipo no está registrado."
        return
    fi

    if [[ "$equipo_1" == "$equipo_2" ]]; then
        echo "No se puede registrar un partido entre el mismo equipo."
        return
    fi

    echo "Ingrese la cantidad de goles del equipo 2:"
    read goles_2

    if [[ ! "$goles_2" =~ ^[0-9]+$ ]]; then
        echo "La cantidad de goles debe ser un número entero."
        return
    fi

    if [[ "$goles_2" -lt 0 ]]; then
        echo "La cantidad de goles no puede ser negativa."
        return
    fi
    if [[ "$goles_2" -gt 20 ]]; then
        echo "La cantidad de goles no puede ser mayor a 20."
        return
    fi

    echo "$(grep -ix "$equipo_1" equipos.txt) ($goles_1) vs $(grep -ix "$equipo_2" equipos.txt) ($goles_2)" >> partidos.txt
    echo "Partido registrado exitosamente."
}

function ver_historial_partidos() {
    sed -i '/^$/d' partidos.txt
    if [ ! -s partidos.txt ]; then
        echo "No hay partidos registrados."
        return
    fi
    echo "Historial de partidos:"
    cat partidos.txt
}

function buscar_equipo() {
    echo "Ingrese el nombre del equipo a buscar:"
    read equipo_buscar
    if [[ -z "$equipo_buscar" ]]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi
    if grep -iqx "$equipo_buscar" equipos.txt; then
        echo "El equipo '$(grep -ix "$equipo_buscar" equipos.txt)' está registrado."
    else
        echo "El equipo '$(grep -ix "$equipo_buscar" equipos.txt)' no está registrado."
    fi
}

function cantidad_partidos_jugados() {
    if [ ! -f partidos.txt ]; then
        echo "No hay partidos registrados."
        return
    fi  
    echo "Cantidad de partidos jugados: $(grep -v '^$' partidos.txt | wc -l)"
}

while [ "$continuar" = true ]; do
    menu
done