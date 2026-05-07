# bam_wallet_transfers

Aplicacion Flutter para gestion de transferencias de wallet.

## Objetivo

Este README esta orientado al equipo de desarrollo y cubre:

- Configuracion y ejecucion local.
- Estructura y arquitectura del proyecto.
- Flujos funcionales principales.
- Flujo de localizacion con `gen-l10n`.
- Comandos basicos de calidad.

## Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart (incluido con Flutter)
- Emulador o dispositivo fisico

Verifica la instalacion con:

```bash
flutter doctor
```

## Setup rapido

1. Clonar el repositorio.

```bash
git clone https://gitlab.com/walter.ordonez.garcia-group/walter.ordonez.garcia-project
cd bam_wallet_transfers
```

2. Instalar dependencias.

```bash
flutter pub get
```

3. Ejecutar la app.

```bash
flutter run
```

Si necesitas especificar target:

```bash
flutter run -t lib/main.dart
```

## Estructura del proyecto

```text
lib/
   core/
      error/
      extensions/
      network/
      presentation/
   features/
      auth/
      dashboard/
      history/
      home/
      settings/
      transfers/
   l10n/
   main.dart
```

## Arquitectura

El proyecto sigue una separacion por `core` y `features`, con capas por feature (domain/data/presentation).

- `core`: utilidades compartidas (errores, red, extensiones, tema).
- `features`: logica de negocio por modulo.
- `l10n`: recursos de internacionalizacion y archivos generados.

```mermaid
flowchart LR
   UI[Presentation Views] --> UC[Use Cases]
   UC --> REPO[Repository Interface]
   REPO --> REPOIMP[Repository Implementation]
   REPOIMP --> DS[Remote Data Source]
   DS --> API[ApiClient Dio]
   API --> BACKEND[Backend API]
```

## Flujos clave

- Dashboard/Home
- Transfers
- History

## Red y configuracion

- El cliente HTTP usa `dio`.
- El wrapper principal de red esta en `lib/core/network/api_client.dart`.
- Configuracion de backend: por ahora no hay variables de entorno documentadas ni flujo de configuracion externo implementado.

## Localizacion (i18n)

Archivos relevantes:

- `l10n.yaml`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_es.arb`
- `lib/l10n/app_localizations*.dart` (generados)

Flujo para actualizar textos:

1. Editar los archivos `.arb` (`app_en.arb`, `app_es.arb`).
2. Generar localizaciones:

```bash
flutter gen-l10n
```

Nota: si existe `l10n.yaml`, Flutter usa esa configuracion y no toma argumentos CLI personalizados para `gen-l10n`.

## Build

Android APK release:

```bash
flutter build apk --release
```

iOS release (requiere macOS):

```bash
flutter build ios --release
```

## Calidad basica

Analisis estatico:

```bash
flutter analyze
```

Pruebas:

```bash
flutter test
```
