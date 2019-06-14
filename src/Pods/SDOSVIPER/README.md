- [SDOSVIPER](#sdosviper)
  - [Introducción](#introducci%C3%B3n)
  - [Instalación](#instalaci%C3%B3n)
    - [Cocoapods](#cocoapods)
  - [Cómo se usa](#c%C3%B3mo-se-usa)
    - [Implementación](#implementaci%C3%B3n)
  - [Referencias](#referencias)

# SDOSVIPER

- Enlace confluence: https://kc.sdos.es/x/vgHLAQ

## Introducción

SDOSVIPER proporciona las clases génericas y los protocolos genéricos que implementan funcionalidades comunes para la arquitectura VIPER

## Instalación

### Cocoapods

Usaremos [CocoaPods](https://cocoapods.org). Hay que añadir la dependencia al `Podfile`:

```ruby
pod 'SDOSVIPER', '~>1.0.0' 
```

## Cómo se usa

### Implementación

La librería actualmente sólo contiene las clases genéricas sin implementación. Estás clases podrán contener funcionalidades en el futuro que requiramos para todos los proyectos.

Contiene las siguientes clases genéricas
```js
//Usada por los objetos que implementan VIPER
@objc open class VIPERGenericObject: NSObject {}

//Usada por la vista que implementa VIPER
@objc open class VIPERGenericViewController: UIViewController {}
```

Contiene los siguientes protocolos genéricos
```js
/// Protocolo base para los Use Cases
public protocol GenericUseCaseProtocol {}

/// Protocolo base para los presenter que implementan VIPER
public protocol GenericPresenterActions {}

// Protocolo base para los interactor que implementan VIPER
public protocol GenericInteractorActions {}

// Protocolo base para los datastore que implementan VIPER
public protocol GenericRepositoryActions {}

// Protocolo base para los wireframe que implementan VIPER
public protocol GenericWireframeActions {}

// Protocolo base para los ViewControllers que implementan VIPER
public protocol GenericViewActions {}
```

Todas las clases que implementan VIPER deberán extender o implementar su correspondiente clase o protocolo. En nuestro caso, los proyectos contienen las *clases base* que implementan estos

## Referencias
* https://svrgitpub.sdos.es/iOS/SDOSVIPER