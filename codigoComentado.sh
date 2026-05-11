#!/bin/bash

# Inicialización de archivos necesarios para el sistema
if [ ! -f equipos.txt ]; then
    touch equipos.txt
    echo "Arsenal" >> equipos.txt
    echo "Liverpool" >> equipos.txt
    echo "Chelsea" >> equipos.txt
    echo "Manchester City" >> equipos.txt
    echo "Manchester United" >> equipos.txt
    echo "Tottenham Hotspur" >> equipos.txt
fi
if [ ! -f partidos.txt ]; then
    touch partidos.txt
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
    echo "|         9. Salir                             |"
    echo "|______________________________________________|"
    read opcion;
    # En case se define un comportamiento según el número en $opcion. 
    # Es una alternativa a usar muchos if y maneja mejor los recursos[cite: 12].
    case $opcion in
        1) listar_equipos ;;
        2) mostrar_campeon_actual ;;
        3) definir_nuevo_campeon ;;
        4) registrar_equipo ;;
        5) registrar_partido ;;
        6) ver_historial_partidos ;;
        7) buscar_equipo ;;
        8) cantidad_partidos_jugados ;;
        9) continuar=false ;;
        *) echo "Opción inválida. Por favor, elija una opción del menú." ;;
        # El '*' funciona como el 'default' en un switch de JS para opciones no contempladas[cite: 15].
    esac
    sleep 1; # Espera 1 segundo antes de volver a mostrar el menú[cite: 16].
}

function definir_nuevo_campeon() {
    echo "Ingrese el nombre del nuevo campeón:"
    read nuevo_campeon
    # -i busca ignorando mayúsculas, -x busca la línea exacta para evitar errores con nombres similares.
    if ! grep -iqx "$nuevo_campeon" equipos.txt; then
        echo "El equipo '$nuevo_campeon' no está registrado."
        return
    fi
    # sed -i '/^Campeon:/d' elimina la línea previa del campeón para que solo haya uno.
    sed -i '/^Campeon:/d' equipos.txt
    echo "" >> equipos.txt
    # Buscamos el nombre exacto como está guardado y le agregamos el prefijo 'Campeon:'.
    echo "Campeon: $(grep -ix "$nuevo_campeon" equipos.txt)" >> equipos.txt
    echo "Nuevo campeón registrado exitosamente."
    sed -i '/^$/d' equipos.txt # Limpia líneas vacías sobrantes.
}

function listar_equipos(){
    if [ ! -s equipos.txt ]; then
        echo "No hay equipos registrados."
        return
    fi
    echo "Equipos registrados:"
    # Muestra todo excepto la línea que contiene la palabra 'Campeon'[cite: 17].
    grep -v '^Campeon:' equipos.txt
}

function mostrar_campeon_actual(){
    # -q (quiet) verifica si existe la palabra sin mostrar el resultado por pantalla[cite: 20].
    if ! grep -q "Campeon" equipos.txt; then
        echo "No hay campeón registrado actualmente."
        return
    fi
    # Extrae la línea del campeón y usa sed para quitar el texto 'Campeon: ' y mostrar solo el nombre.
    campeon=$(grep "Campeon" equipos.txt | tail -n 1 | sed 's/Campeon: //')
    echo "El campeón actual es: $campeon"
}

function registrar_equipo(){
    # wc -l cuenta las líneas para advertir sobre el rendimiento si hay muchos equipos.
    if [ $(grep -v '^$' equipos.txt | wc -l) -gt 15 ]; then
        echo "Tenga cuidado, hay más de 15 equipos registrados. Esto puede afectar el rendimiento de la búsqueda."
    fi
    echo "Ingrese el nombre del equipo:"
    read nombre_equipo
    # -z comprueba que la variable no esté vacía[cite: 23].
    if [ -z "$nombre_equipo" ]; then
        echo "El nombre del equipo no puede estar vacío."
        return # Freno de mano necesario para no seguir con la ejecución[cite: 22].
    fi
    # Verificamos si ya existe para evitar duplicados.
    if grep -iFxq "$nombre_equipo" equipos.txt; then
        echo "El equipo ya está registrado."
        return
    fi
    # =~ permite usar expresiones regulares. Aquí evita que el usuario use la palabra reservada 'Campeon'[cite: 25].
    if [[ "$nombre_equipo" =~ Campeon ]]; then
        echo "El nombre del equipo no puede contener la palabra 'Campeon'."
        return
    fi
    echo "" >> equipos.txt
    echo "$nombre_equipo" >> equipos.txt # El símbolo '>>' añade el contenido al final del archivo[cite: 26].
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

    # Comprueba que el dato ingresado sea un número entero positivo[cite: 32].
    if [[ ! "$goles_1" =~ ^[0-9]+$ ]]; then
        echo "La cantidad de goles debe ser un número entero."
        return
    fi
    # Validaciones extras de rango para evitar errores de carga.
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

    # Evita que un equipo juegue contra sí mismo[cite: 38].
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

    # Registra el resultado formateado en el archivo de historial[cite: 41].
    echo "$(grep -ix "$equipo_1" equipos.txt) ($goles_1) vs $(grep -ix "$equipo_2" equipos.txt) ($goles_2)" >> partidos.txt
    echo "Partido registrado exitosamente."
}

function ver_historial_partidos() {
    sed -i '/^$/d' partidos.txt
    # -s comprueba si el archivo existe y NO está vacío.
    if [ ! -s partidos.txt ]; then
        echo "No hay partidos registrados."
        return
    fi
    echo "Historial de partidos:"
    cat partidos.txt # Muestra todo el contenido del historial[cite: 17].
}

function buscar_equipo() {
    echo "Ingrese el nombre del equipo a buscar:"
    read equipo_buscar
    if [[ -z "$equipo_buscar" ]]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi
    # Busca el equipo e informa si está en la lista[cite: 47].
    if grep -iqx "$equipo_buscar" equipos.txt; then
        echo "El equipo '$(grep -ix "$equipo_buscar" equipos.txt)' está registrado."
    else
        echo "El equipo '$equipo_buscar' no está registrado."
    fi
}

function cantidad_partidos_jugados() {
    if [ ! -f partidos.txt ]; then
        echo "No hay partidos registrados."
        return
    fi  
    # Filtra líneas vacías y cuenta las líneas restantes para dar el total de partidos[cite: 51].
    echo "Cantidad de partidos jugados: $(grep -v '^$' partidos.txt | wc -l)"
}

# Bucle principal que mantiene el programa corriendo hasta que 'continuar' sea false[cite: 52].
while [ "$continuar" = true ]; do
    menu
done