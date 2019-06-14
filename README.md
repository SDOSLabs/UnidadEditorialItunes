## Project generated from Template-VIPER version 1.0.0

- La aplicación debe compilarsre con Xcode 10.2
- Se han subido las dependencias ya que se usan librerías privadas que no están en el repositorio público de cocoapods
- La aplicación está internazionalizada en español e inglés

================================================

- El proyecto sigue la arquitectura VIPER. Se ha optado por la injección de dependencias con `Swinject` para la comunicación de las distintas capas que lo componen.

- SDOSSwinject
- https://github.com/Swinject/Swinject

Para la comunicación entre las capas de más bajo nivel se hará uso de las "Promesas" con el framework `PromiseKit`

- https://github.com/mxcl/PromiseKit

Para llamadas y parseos de servicios web se usa una implementación específica para el proyecto

Para la generación de código usaremos las siguientes dependencias:

- SDOSEnvironment: Generación de variables de entorno en un fichero encriptado en base a un fichero `.plist`
- SDOSSwinject: Generación de dependencias en base a un fichero `.json`
- SwiftGen - https://github.com/SwiftGen/SwiftGen: Generación de constantes de imágenes, strings y fonts en base a plantillas. Las plantillas se pueden añadir al proyecto y modificar en base a las necesidades del proyecto. Para más información revisar la documentación o imprimir la ayuda en la línea de comandos.

Para la carga de imágenes usaremos `Kingfisher`

- Kingfisher - https://github.com/onevcat/Kingfisher

Las funcionalidades que hacen uso de los métodos del AppDelegate serán tratados como servicios. Estos servicios se gestionarán con la librería `SDOSPluggableApplicationDelegate`:

- SDOSPluggableApplicationDelegate

Como herramientas de Debug tenemos `FLEX`.

- SDOSFLEX
- FLEX - https://github.com/Flipboard/FLEX

================================================

El proyecto componen de la siguiente jerarquía:

- scripts: Carpeta que contiene diferentes script que se ejecutan en el *BuildPhases* de los targets
- main: Carpeta que contiene todo el código del proyecto
    - base: Contiene funcionalidades base del proyecto
    - common: Funcionalidades comunes a todos los módulos del proyecto. Aquí se encuentran las constantes, dependencias, colores y fuentes entre otros.
        - interactors: Interactors de la capa VIPER para la agrupación de funcionalidades de la lógica de negocio
        - models: modelos de los objetos y sus mapeadores. Sólo contiene aquellos que son de la parte común (no tiene los modelos visuales VO)
        - repositories: Repositories de la capa de VIPER para el manejo de datos
        - services: Servicios del proyecto. Son aquellos que necesitan hacer uso del ciclo de vida del AppDelegate. Por lo general serán Singleton
        - useCases: Casos de uso de la capa VIPER. Contienen implementaciones unitarias de la lógica de negocio
    - configuration: Contiene parámetros de la configuración del proyecto, como el Info.plist, los .xcconfig o los ficheros por entorno de Firebase.
    - resources: Contiene recursos de la aplicación como estílos, imágenes, fuentes, AppIcon, LaunchScreen
        - generated: Aquí se encuentran todos los ficheros generados por los diferentes scripts
    - ui: Capa visual de la aplicación, con las clases de VIPER correspondientes. El contenido se organizará con carpetas para cada módulo y tipo.
        - vo: Objetos del modelo visual de los diferentes módulos
