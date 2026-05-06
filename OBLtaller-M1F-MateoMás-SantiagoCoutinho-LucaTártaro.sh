#!/bin/bash

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
    echo "|         3. Registrar equipo                  |"
    echo "|         4. Registrar partido                 |"
    echo "|         5. Ver historial de partidos         |"
    echo "|         6. Buscar equipo                     |"
    echo "|         7. Cantidad de partidos jugados      |"
    echo "|         8. Salir                             |"
    echo "|______________________________________________|"
    read opcion;
    case $opcion in
        1) listar_equipos ;;
        2) mostrar_campeon_actual ;;
        3) registrar_equipo ;;
        4) registrar_partido ;;
        5) ver_historial_partidos ;;
        6) buscar_equipo ;;
        7) cantidad_partidos_jugados ;;
        8) continuar=false ;;
        *) echo "Opción inválida. Por favor, elija una opción del menú." ;;
    esac
    sleep 2;
}

function listar_equipos(){
    echo "Equipos registrados:"
    cat equipos.txt
}

function mostrar_campeon_actual(){
    echo "El campeón actual es: $(grep "Campeon" equipos.txt)"
}

function registrar_equipo(){
    echo "Ingrese el nombre del equipo:"
    read nombre_equipo
    if grep -q "$nombre_equipo" equipos.txt; then
        echo "El equipo ya está registrado."
        return
    fi
    if [ -z "$nombre_equipo" ]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi
    if [[ "$nombre_equipo" =~ Campeon ]]; then
        echo "El nombre del equipo no puede contener la palabra 'Campeon'."
        return
    fi
    echo "$nombre_equipo" >> equipos.txt
    echo "Equipo registrado exitosamente."
}

function registrar_partido() {
    echo "Ingrese el nombre de un equipo:"
    read equipo_1
    if [[ -z "$equipo_1" ]]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi
    if ! grep -qx "$equipo_1" equipos.txt; then
        echo "El equipo no está registrado."
        return
    fi

    echo "Ingrese la cantidad de goles del equipo 1:"
    read goles_1

    if [[ ! "$goles_1" =~ ^[0-9]+$ ]]; then
        echo "La cantidad de goles debe ser un número entero."
        return
    fi

    echo "Ingrese el nombre del otro equipo:"
    read equipo_2

    if [[ -z "$equipo_2" ]]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi

    if ! grep -qx "$equipo_2" equipos.txt; then
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

    echo "$equipo_1 ($goles_1) vs $equipo_2 ($goles_2)" >> partidos.txt
    echo "Partido registrado exitosamente."
}

function ver_historial_partidos() {
    if [ ! -f partidos.txt ]; then
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
    if grep -q "$equipo_buscar" equipos.txt; then
        echo "El equipo '$equipo_buscar' está registrado."
    else
        echo "El equipo '$equipo_buscar' no está registrado."
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