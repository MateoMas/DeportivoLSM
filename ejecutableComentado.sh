#!/bin/bash

# Comprueba si los archivos necesarios existen, si no, los crea y los llena con datos predefinidos.

# Este archivo contiene los equipos registrados en el campeonato. El mismo se genera con algunos equipos predefinidos.
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

# En este archivo se registran los partidos jugados, con el formato "Equipo 1 (Goles) vs Equipo 2 (Goles)". El mismo se genera vacío.
if [ ! -f partidos.txt ]; then
    touch partidos.txt
fi

# Este archivo contiene una lista de equipos predefinidos que pueden ser registrados.
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

# Variable de control para el bucle del menú principal. Se inicializa en true para que el menú se muestre al menos una vez.
continuar=true

# Función que muestra el menú principal y maneja la selección de opciones por parte del usuario.
# Cada opción llama a una función específica para realizar la tarea correspondiente.
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
        10) continuar=false ;; # Al seleccionar esta opción, se cambia la variable de control a false, lo que hará que el bucle del menú principal termine y el programa finalice.
        *) echo "Opción inválida. Por favor, elija una opción del menú." ;; # En caso de que el usuario ingrese una opción no válida, se muestra un mensaje de error y se vuelve a mostrar el menú.
    esac
    sleep 1; # Pausa de 1 segundo para que el usuario pueda leer el resultado de la opción seleccionada antes de que se muestre el menú nuevamente.
}

# Función que muestra los créditos del programa, incluyendo los nombres de los desarrolladores.
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

# Función que permite definir un nuevo campeón. 
# El usuario ingresa el nombre del equipo que desea establecer como campeón, y el programa verifica si ese equipo está registrado en el archivo de equipos.
# Si el equipo existe, se actualiza el archivo para reflejar el nuevo campeón.
function definir_nuevo_campeon() {
    echo "Ingrese el nombre del nuevo campeón:"
    read nuevo_campeon
    # Se verifica que el nombre del nuevo campeón no esté vacío y que el equipo exista en el archivo de equipos registrados.
    # Si alguna de estas condiciones no se cumple, se muestra un mensaje de error y se termina la función.
    if ! grep -iqx "$nuevo_campeon" equipos.txt; then
        echo "El equipo '$nuevo_campeon' no está registrado."
        return
    fi
    # Si el equipo existe, se elimina cualquier línea que comience con "Campeon:" en el archivo de equipos para asegurarse de que solo haya un campeón registrado.
    # Después, se agrega una nueva línea al final del archivo con el formato "Campeon: [Nombre del equipo]", indicando el nuevo campeón.
    sed -i '/^Campeon:/d' equipos.txt
    echo "" >> equipos.txt
    echo "Campeon: $(grep -ix "$nuevo_campeon" equipos.txt)" >> equipos.txt
    echo "Nuevo campeón registrado exitosamente."
    sed -i '/^$/d' equipos.txt
}

# Función que lista los equipos registrados en el archivo de equipos.
# Si no hay equipos registrados, se muestra un mensaje indicando que no hay equipos.
function listar_equipos(){
    if [ ! -s equipos.txt ]; then
        echo "No hay equipos registrados."
        return
    fi
    echo "Equipos registrados:"
    grep -v '^Campeon:' equipos.txt
}
    
# Función que muestra el campeón actual.
function mostrar_campeon_actual(){
    # Se verifica si hay un campeón registrado en el archivo de equipos.
    # Si no hay ningún campeón, se muestra un mensaje indicando que no hay campeón registrado actualmente.
    if ! grep -q "Campeon" equipos.txt; then
        echo "No hay campeón registrado actualmente."
        return
    fi
    campeon=$(grep "Campeon" equipos.txt | tail -n 1 | sed 's/Campeon: //')
    echo "El campeón actual es: $campeon"
}

# Función que permite registrar un nuevo equipo en el archivo de equipos.
# El usuario ingresa el nombre del equipo que desea registrar, y el programa realiza varias validaciones para asegurarse de que el equipo pueda ser registrado correctamente.
function registrar_equipo(){
    # Antes de registrar un nuevo equipo, se verifica la cantidad de equipos registrados actualmente.
    # Si hay más de 15 equipos, se muestra una advertencia al usuario indicando que esto puede afectar el rendimiento de la búsqueda.
    if [ $(grep -v '^$' equipos.txt | wc -l) -gt 15 ]; then
        echo "Tenga cuidado, hay más de 15 equipos registrados. Esto puede afectar el rendimiento de la búsqueda."
    fi
    echo "Ingrese el nombre del equipo:"
    read nombre_equipo
    # Se realizan varias validaciones para asegurarse de que el nombre del equipo sea válido:
    # 1. El nombre del equipo no puede estar vacío.
    if [ -z "$nombre_equipo" ]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi
    # 2. El equipo no puede estar registrado previamente en el archivo de equipos.
    if grep -iFxq "$nombre_equipo" equipos.txt; then
        echo "El equipo ya está registrado."
        return
    fi
    # 3. El equipo debe estar en la lista de equipos predefinidos en el archivo predefinidos.txt para ser registrado.
    if ! grep -iFxq "$nombre_equipo" predefinidos.txt; then
        echo "El equipo '$nombre_equipo' no está en el mundial."
        return
    fi
    # Si todas las validaciones se pasan, se agrega el nuevo equipo al archivo de equipos, asegurándose de eliminar cualquier línea vacía para mantener el formato del archivo limpio.
    echo "" >> equipos.txt
    echo "$(grep -ix "$nombre_equipo" predefinidos.txt)" >> equipos.txt
    echo "Equipo registrado exitosamente."
    sed -i '/^$/d' equipos.txt
}

# Función que permite registrar un partido entre dos equipos, incluyendo la cantidad de goles anotados por cada equipo.
# El usuario ingresa el nombre de los dos equipos y la cantidad de goles anotados por cada uno, y el programa realiza varias validaciones para asegurarse de que el partido pueda ser registrado correctamente.
function registrar_partido() {
    echo "Ingrese el nombre de un equipo:"
    read equipo_1
    # Se realizan varias validaciones para asegurarse de que el nombre del equipo sea válido:
    # 1. El nombre del equipo no puede estar vacío.
    if [[ -z "$equipo_1" ]]; then
        echo "El nombre del equipo no puede estar vacío."
        return
    fi
    # 2. El equipo debe estar registrado en el archivo de equipos para poder registrar un partido con ese equipo.
    if ! grep -iqx "$equipo_1" equipos.txt; then
        echo "El equipo no está registrado."
        return
    fi

    echo "Ingrese la cantidad de goles del equipo 1:"
    read goles_1

    # Se realizan varias validaciones para asegurarse de que la cantidad de goles ingresada sea válida:
    # 1. La cantidad de goles debe ser un número entero.
    if [[ ! "$goles_1" =~ ^[0-9]+$ ]]; then
        echo "La cantidad de goles debe ser un número entero."
        return
    fi
    # 2. La cantidad de goles no puede ser negativa.
    if [[ "$goles_1" -lt 0 ]]; then
        echo "La cantidad de goles no puede ser negativa."
        return
    fi
    # 3. La cantidad de goles no puede ser mayor a 20.
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

    # Si todas las validaciones se pasan, se registra el partido en el archivo de partidos con el formato "Equipo 1 (Goles) vs Equipo 2 (Goles)", asegurándose de eliminar cualquier línea vacía para mantener el formato del archivo limpio.
    echo "$(grep -ix "$equipo_1" equipos.txt) ($goles_1) vs $(grep -ix "$equipo_2" equipos.txt) ($goles_2)" >> partidos.txt
    echo "Partido registrado exitosamente."
}

# Función que muestra el historial de partidos registrados en el archivo de partidos.
# Si no hay partidos registrados, se muestra un mensaje indicando que no hay partidos registrados.
function ver_historial_partidos() {
    sed -i '/^$/d' partidos.txt
    if [ ! -s partidos.txt ]; then
        echo "No hay partidos registrados."
        return
    fi
    echo "Historial de partidos:"
    cat partidos.txt
}

# Función que permite buscar un equipo específico en el archivo de equipos.
# El usuario ingresa el nombre del equipo que desea buscar, y el programa verifica si ese equipo está registrado en el archivo de equipos.
# Si el equipo existe, se muestra un mensaje indicando que el equipo está registrado; de lo contrario, se muestra un mensaje indicando que el equipo no está registrado.
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

# Función que cuenta la cantidad de partidos registrados en el archivo de partidos.
# Si no hay partidos registrados, se muestra un mensaje indicando que no hay partidos registrados.
function cantidad_partidos_jugados() {
    if [ ! -f partidos.txt ]; then
        echo "No hay partidos registrados."
        return
    fi  
    echo "Cantidad de partidos jugados: $(grep -v '^$' partidos.txt | wc -l)"
}

# Bucle principal del programa que muestra el menú principal y permite al usuario seleccionar opciones hasta que decida salir.
while [ "$continuar" = true ]; do
    menu
done

