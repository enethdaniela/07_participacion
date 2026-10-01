# Bitácora de comparación: rama vibe vs rama sdd

Estado actual: la Parte 1 está completada y se implementó la primera app en la rama `vibe`. Para esa rama se usó únicamente la solicitud inicial: "Hazme una app en Flutter para dividir la cuenta entre varias personas." En `sdd` se completaron las Partes 3.1–3.3, 4.1–4.3, 5 y 6.1; falta Clarify, planificar e implementar.

| | rama vibe | rama sdd |
|---|---|---|
| Iteraciones (veces que le tuviste que volver a pedir algo) | 0 | Pendiente |
| Casos de aceptación que cumple (0–6) | Pendiente de evaluar | Pendiente |
| Pruebas automatizadas que pasan | 1 widget test | Pendiente |
| Archivos en `lib/` | 1 | Pendiente |
| Líneas de código en `lib/` | 288 | Pendiente |
| ¿`domain/` depende de Flutter? | No existe `domain/` | Pendiente |
| ¿Existe separación `presentation/domain/data`? | No | Pendiente |
| ¿El agente agregó algo que nadie pidió? | No; solo reparto básico | Pendiente |
| ¿Se puede agregar otra estrategia sin modificar el cálculo existente? | No; el cálculo está integrado en la pantalla | Pendiente |

| Métrica secundaria opcional | rama vibe | rama sdd |
|---|---:|---:|
| Tiempo aproximado hasta cumplir los 6 escenarios | Pendiente de evaluar | Pendiente |

Nota de la Parte 1:
- Caso de Git detectado: Caso C. Se eligió la alternativa de trabajar en el repositorio padre existente, porque toda la carpeta `07_participacion` es exclusiva de este proyecto.
- Se creó el proyecto Flutter dentro de `divisor_cuenta/`. El repositorio conectado está en `07_participacion`; allí se confirmaron las ramas `main`, `vibe` y `sdd` desde el commit inicial `df95632`.
- El repositorio Git accidentalmente anidado en `divisor_cuenta/` se retiró de esa carpeta y se conservó como respaldo fuera del proyecto.
- Rama `vibe`: interfaz de una pantalla para ingresar el monto y cantidad de personas, calcular el reparto y mostrar el pago por persona. La prueba de contador que venía con la plantilla Flutter se sustituyó por una prueba del cálculo de reparto.
- Verificación de `vibe`: `flutter analyze` sin issues, `flutter test` con 1 prueba aprobada y `flutter build apk --debug` exitoso.
- Parte 3.1: cambié a la rama `sdd`. Los comandos `claude`, `codex`, `gemini` y `copilot` no están instalados como CLI; se está usando GitHub Copilot integrado en VS Code.
- Modelo reportado en esta conversación: `gpt-6-luna`. La configuración/nivel de razonamiento no está disponible para verificar, así que queda pendiente anotarlo desde la interfaz del agente.
- Parte 3.2: no se creó un archivo de instrucciones general en la carpeta superior; se usan solo las instrucciones del proyecto Flutter.
- Parte 3.3: se creó `divisor_cuenta/AGENTS.md` para GitHub Copilot. No se añadieron archivos a `lib/`; el código de la app no se modificó en estas subsecciones.
- Parte 4.1: se instaló `uv` mediante WinGet y se verificó directamente la versión `0.12.21`. WinGet modificó `PATH`; es necesario abrir una terminal nueva para que `uv --version` funcione por nombre.
- Parte 4.2: se instaló `specify-cli` `1.0.13` con `uv tool install specify-cli`. El ejecutable instalado se llama `specify`; `C:\Users\Eneth\.local\bin` aún no está en el `PATH` de esta terminal.
- Parte 4.3: se inicializó Spec Kit en `divisor_cuenta/` con integración GitHub Copilot y scripts PowerShell. Los archivos de Spec Kit se confirmaron en `7ed7d9c` (`uv y spec kit instalados`).
- Parte 5: se creó y revisó `.specify/memory/constitution.md` con los cinco principios SOLID, arquitectura, seguridad, pruebas y regla de la materia. La constitución está en versión `1.0.0`; no se añadieron reglas SOLID distintas de las indicadas en la guía.
- Parte 6.1: se creó `specs/001-dividir-cuenta/spec.md` con los seis escenarios de aceptación y una lista de calidad revisada. Interpretaciones explicitadas como suposiciones: la propina se aplica al total antes de dividir; el modo exacto presenta dos decimales; el modo hacia arriba redondea el pago individual al entero siguiente. No se agregó funcionalidad fuera del alcance descrito.
- Parte 6.2: Clarify no encontró ambigüedades críticas que ameriten preguntas. La especificación ya fija los datos, los seis resultados, los errores y los dos modos; los ejemplos determinan cómo se aplica la propina y qué significa redondear hacia arriba. No se pidió ninguna respuesta al usuario ni se modificó la especificación.
