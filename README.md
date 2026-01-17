# Chef Inteligente - De tu despensa a la mesa

**Chef Inteligente** es una aplicación de Flutter diseñada para transformar los ingredientes que ya tienes en platos deliciosos utilizando Inteligencia Artificial (Google Gemini).

## 🚀 Requisitos Finales
- **Flutter SDK**: >=3.0.0
- **Dart SDK**: >=3.0.0
- **API Key de Gemini**: Configurada en `lib/core/constants/api_keys.dart` (Simulada para esta entrega).

## 📂 Estructura del Proyecto
El proyecto sigue los principios de **Clean Architecture**:
- `core/`: Estilos (Apple/Airbnb), temas y constantes globales.
- `features/`:
  - `onboarding/`: Flujo inicial de bienvenida.
  - `inventory/`: Gestión de despensa y lista de compras.
  - `recipes/`: Base de datos de 50+ platos y lógica de porciones.
  - `profile/`: Diario gastonómico y logros personal.
  - `scan/`: Integración con cámara y galería (IA).

## 🛠️ Cómo Iniciar el Proyecto
1. Clona o descarga este repositorio.
2. Ejecuta `flutter pub get` en la terminal.
3. Conecta un dispositivo o emulador.
4. Ejecuta `flutter run`.

## 📦 Generación de APK / AppBundle (Android)
Para generar el instalador para tu teléfono:
```bash
flutter build apk --split-per-abi
```
El archivo resultante estará en `build/app/outputs/flutter-apk/app-release.apk`.

## 🍏 Generación para iOS
Requiere macOS y Xcode:
1. `cd ios`
2. `pod install`
3. Abre `Runner.xcworkspace` en Xcode y realiza el Archive.

## ✨ Créditos
Diseñado con un enfoque en la experiencia de usuario (UX) premium y minimalista.
