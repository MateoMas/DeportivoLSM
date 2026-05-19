#!/bin/bash

# Comprueba si los archivos necesarios existen, si no, los crea y los llena con datos predefinidos.

# Este archivo contiene los equipos registrados en el campeonato. El mismo se genera con algunos equipos predefinidos.
if [ ! -f equipos.txt ]; then
    touch equipos.txt
    echo "Espana" >> equipos.txt
    echo "Inglaterra" >> equipos.txt
    echo "Alemania" >> equipos.txt
    echo "Brasil" >> equipos.txt
    echo "Argentina" >> equipos.txt
    echo "Uruguay" >> equipos.txt
    echo "Francia" >> equipos.txt
fi

# En este archivo se registran los partidos jugados, con el formato "Equipo 1 (Goles) vs Equipo 2 (Goles)". El mismo se genera vacio.
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
    echo "Espana" >> predefinidos.txt
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

# Variable de control para el bucle del menu principal. Se inicializa en true para que el menu se muestre al menos una vez.
continuar=true

# Funcion que muestra el menu principal y maneja la seleccion de opciones por parte del usuario.
# Cada opcion llama a una funcion especifica para realizar la tarea correspondiente.
function menu(){ 
    echo ""
    echo "________________________________________________"
    echo "|                                              |"
    echo "|                Menu Principal                |"
    echo "|______________________________________________|"
    echo "|                                              |"
    echo "|         1. Listar equipos                    |"
    echo "|         2. Mostrar Campeon actual            |"
    echo "|         3. Definir nuevo campeon             |"
    echo "|         4. Registrar equipo                  |"
    echo "|         5. Registrar partido                 |"
    echo "|         6. Ver historial de partidos         |"
    echo "|         7. Buscar equipo                     |"
    echo "|         8. Cantidad de partidos jugados      |"
    echo "|         9. Creditos                          |"
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
        10) continuar=false ;; # Al seleccionar esta opcion, se cambia la variable de control a false, lo que hara que el bucle del menu principal termine y el programa finalice.
        *) echo "Opcion invalida. Por favor, elija una opcion del menu." ;; # En caso de que el usuario ingrese una opcion no valida, se muestra un mensaje de error y se vuelve a mostrar el menu.
    esac
    sleep 1; # Pausa de 1 segundo para que el usuario pueda leer el resultado de la opcion seleccionada antes de que se muestre el menu nuevamente.
}

# Funcion que muestra los creditos del programa, incluyendo los nombres de los desarrolladores.
function creditos () {
    echo ""
    echo "________________________________________________"
    echo "|                                              |"
    echo "|                   Creditos                   |"
    echo "|______________________________________________|"
    echo "|                                              |"
    echo "|            Desarrollado por:                 |"
    echo "|                                              |"
    echo "|            Santiago Coutinho (378832)        |"
    echo "|            Mateo Mas Lukinskas (375845)      |"
    echo "|            Luca Tartaro (354973)             |"
    echo "|______________________________________________|"
    echo ""
}

# Funcion que permite definir un nuevo campeon. 
# El usuario ingresa el nombre del equipo que desea establecer como campeon, y el programa verifica si ese equipo esta registrado en el archivo de equipos.
# Si el equipo existe, se actualiza el archivo para reflejar el nuevo campeon.
function definir_nuevo_campeon() {
    echo "Ingrese el nombre del nuevo campeon:"
    read nuevo_campeon
    # Se verifica que el nombre del nuevo campeon no este vacio y que el equipo exista en el archivo de equipos registrados.
    # Si alguna de estas condiciones no se cumple, se muestra un mensaje de error y se termina la funcion.
    if ! grep -iqx "$nuevo_campeon" equipos.txt; then
        echo "El equipo '$nuevo_campeon' no esta registrado."
        return
    fi
    # Si el equipo existe, se elimina cualquier linea que comience con "Campeon:" en el archivo de equipos para asegurarse de que solo haya un campeon registrado.
    # Despues, se agrega una nueva linea al final del archivo con el formato "Campeon: [Nombre del equipo]", indicando el nuevo campeon.
    sed -i '/^Campeon:/d' equipos.txt
    echo "" >> equipos.txt
    echo "Campeon: $(grep -ix "$nuevo_campeon" equipos.txt)" >> equipos.txt
    echo "Nuevo campeon registrado exitosamente."
    sed -i '/^$/d' equipos.txt
}

# Funcion que lista los equipos registrados en el archivo de equipos.
# Si no hay equipos registrados, se muestra un mensaje indicando que no hay equipos.
function listar_equipos(){
    if [ ! -s equipos.txt ]; then
        echo "No hay equipos registrados."
        return
    fi
    echo "Equipos registrados:"
    grep -v '^Campeon:' equipos.txt
}
    
# Funcion que muestra el campeon actual.
function mostrar_campeon_actual(){
    # Se verifica si hay un campeon registrado en el archivo de equipos.
    # Si no hay ningun campeon, se muestra un mensaje indicando que no hay campeon registrado actualmente.
    if ! grep -q "Campeon" equipos.txt; then
        echo "No hay campeon registrado actualmente."
        return
    fi
    campeon=$(grep "Campeon" equipos.txt | tail -n 1 | sed 's/Campeon: //')
    echo "El campeon actual es: $campeon"
}

# Funcion que permite registrar un nuevo equipo en el archivo de equipos.
# El usuario ingresa el nombre del equipo que desea registrar, y el programa realiza varias validaciones para asegurarse de que el equipo pueda ser registrado correctamente.
function registrar_equipo(){
    # Antes de registrar un nuevo equipo, se verifica la cantidad de equipos registrados actualmente.
    # Si hay mas de 15 equipos, se muestra una advertencia al usuario indicando que esto puede afectar el rendimiento de la busqueda.
    if [ $(grep -v '^$' equipos.txt | wc -l) -gt 15 ]; then
        echo "Tenga cuidado, hay mas de 15 equipos registrados. Esto puede afectar el rendimiento de la busqueda."
    fi
    echo "Ingrese el nombre del equipo:"
    read nombre_equipo
    # Se realizan varias validaciones para asegurarse de que el nombre del equipo sea valido:
    # 1. El nombre del equipo no puede estar vacio.
    if [ -z "$nombre_equipo" ]; then
        echo "El nombre del equipo no puede estar vacio."
        return
    fi
    # 2. El equipo no puede estar registrado previamente en el archivo de equipos.
    if grep -iFxq "$nombre_equipo" equipos.txt; then
        echo "El equipo ya esta registrado."
        return
    fi
    # 3. El equipo debe estar en la lista de equipos predefinidos en el archivo predefinidos.txt para ser registrado.
    if ! grep -iFxq "$nombre_equipo" predefinidos.txt; then
        echo "El equipo '$nombre_equipo' no esta en el mundial."
        return
    fi
    # Si todas las validaciones se pasan, se agrega el nuevo equipo al archivo de equipos, asegurandose de eliminar cualquier linea vacia para mantener el formato del archivo limpio.
    echo "" >> equipos.txt
    echo "$(grep -ix "$nombre_equipo" predefinidos.txt)" >> equipos.txt
    echo "Equipo registrado exitosamente."
    sed -i '/^$/d' equipos.txt
}

# Funcion que permite registrar un partido entre dos equipos, incluyendo la cantidad de goles anotados por cada equipo.
# El usuario ingresa el nombre de los dos equipos y la cantidad de goles anotados por cada uno, y el programa realiza varias validaciones para asegurarse de que el partido pueda ser registrado correctamente.
function registrar_partido() {
    echo "Ingrese el nombre de un equipo:"
    read equipo_1
    # Se realizan varias validaciones para asegurarse de que el nombre del equipo sea valido:
    # 1. El nombre del equipo no puede estar vacio.
    if [[ -z "$equipo_1" ]]; then
        echo "El nombre del equipo no puede estar vacio."
        return
    fi
    # 2. El equipo debe estar registrado en el archivo de equipos para poder registrar un partido con ese equipo.
    if ! grep -iqx "$equipo_1" equipos.txt; then
        echo "El equipo no esta registrado."
        return
    fi

    echo "Ingrese la cantidad de goles del equipo 1:"
    read goles_1

    # Se realizan varias validaciones para asegurarse de que la cantidad de goles ingresada sea valida:
    # 1. La cantidad de goles debe ser un numero entero.
    if [[ ! "$goles_1" =~ ^[0-9]+$ ]]; then
        echo "La cantidad de goles debe ser un numero entero."
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
        echo "El nombre del equipo no puede estar vacio."
        return
    fi

    if ! grep -iqx "$equipo_2" equipos.txt; then
        echo "El equipo no esta registrado."
        return
    fi

    if [[ "$equipo_1" == "$equipo_2" ]]; then
        echo "No se puede registrar un partido entre el mismo equipo."
        return
    fi

    echo "Ingrese la cantidad de goles del equipo 2:"
    read goles_2

    if [[ ! "$goles_2" =~ ^[0-9]+$ ]]; then
        echo "La cantidad de goles debe ser un numero entero."
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

    # Si todas las validaciones se pasan, se registra el partido en el archivo de partidos con el formato "Equipo 1 (Goles) vs Equipo 2 (Goles)", asegurandose de eliminar cualquier linea vacia para mantener el formato del archivo limpio.
    echo "$(grep -ix "$equipo_1" equipos.txt) ($goles_1) vs $(grep -ix "$equipo_2" equipos.txt) ($goles_2)" >> partidos.txt
    echo "Partido registrado exitosamente."
}

# Funcion que muestra el historial de partidos registrados en el archivo de partidos.
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

# Funcion que permite buscar un equipo especifico en el archivo de equipos.
# El usuario ingresa el nombre del equipo que desea buscar, y el programa verifica si ese equipo esta registrado en el archivo de equipos.
# Si el equipo existe, se muestra un mensaje indicando que el equipo esta registrado; de lo contrario, se muestra un mensaje indicando que el equipo no esta registrado.
function buscar_equipo() {
    echo "Ingrese el nombre del equipo a buscar:"
    read equipo_buscar
    if [[ -z "$equipo_buscar" ]]; then
        echo "El nombre del equipo no puede estar vacio."
        return
    fi
    if grep -iqx "$equipo_buscar" equipos.txt; then
        echo "El equipo '$(grep -ix "$equipo_buscar" equipos.txt)' esta registrado."
    else
        echo "El equipo '$(grep -ix "$equipo_buscar" equipos.txt)' no esta registrado."
    fi
}

# Funcion que cuenta la cantidad de partidos registrados en el archivo de partidos.
# Si no hay partidos registrados, se muestra un mensaje indicando que no hay partidos registrados.
function cantidad_partidos_jugados() {
    if [ ! -f partidos.txt ]; then
        echo "No hay partidos registrados."
        return
    fi  
    echo "Cantidad de partidos jugados: $(grep -v '^$' partidos.txt | wc -l)"
}

# Bucle principal del programa que muestra el menu principal y permite al usuario seleccionar opciones hasta que decida salir.
while [ "$continuar" = true ]; do
    menu
done

# A continuacion se incluyen algunos comentarios adicionales sobre comandos y conceptos utilizados en el programa:

# GREP - Buscar texto dentro de archivos
# Comando fundamental para encontrar líneas que coincidan con un patrón.

# Parámetros clave:
#   -i : Iguala mayúsculas y minúsculas (case-insensitive).
#        Ideal si no sabés exactamente cómo está escrita la palabra.
#   -q : Modo "Quiet" (silencioso). No muestra salida en pantalla.
#        Devuelve un booleano (0 si encontró, 1 si no). Muy usado en 'if'.
#   -x : Coincidencia exacta. La línea entera debe coincidir carácter por 
#        carácter con la búsqueda. Si coincide solo una parte, no devuelve nada.
#   -v : Invierte el filtro. Muestra todas las líneas que NO coinciden.
#   -r : Búsqueda recursiva. Busca dentro de todos los archivos y subcarpetas.

# CAT - Concatenar y mostrar archivos

# Sirve principalmente para desplegar el contenido de archivos en la terminal.
# Parámetros clave:
#   -n : Numera todas las líneas al mostrarlas (ideal para depurar errores).
#   -b : Similar a -n, pero solo numera las líneas que NO están vacías.


# SED - Stream Editor (Modificador de texto)

# Permite transformar, borrar o reemplazar texto de forma automática y directa.
# Parámetros y comandos internos clave:
#   s/viejo/nuevo/g : El comando de sustitución. Reemplaza 'viejo' por 'nuevo'.
#                     La 'g' (global) asegura que cambie todas las apariciones.
#   -i              : Modificación "in-place". Aplica y guarda los cambios 
#                     directamente en el archivo original. Sin -i, solo lo
#                     muestra modificado por pantalla.
#   '3d'            : Borra (delete) la línea número 3 del archivo.


# Un pipe es un operador representado por el símbolo vertical |.
# Su función principal es conectar comandos: toma la salida de un comando 
# (lo que normalmente verías en pantalla) y la pasa directamente como entrada
# al siguiente comando, permitiendo encadenar acciones sin necesidad de guardar archivos intermedios.