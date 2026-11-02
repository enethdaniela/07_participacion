# Bitácora de comparación: rama vibe vs rama sdd

Estado actual: la Parte 1 está completada y se implementó la primera app en la rama `vibe`. Para esa rama se usó únicamente la solicitud inicial: "Hazme una app en Flutter para dividir la cuenta entre varias personas." En `sdd` se completaron las Partes 3.1–3.3, 4.1–4.3, 5, 6.1–6.2, 7.1–7.4 y 8.

| | rama vibe | rama sdd |
|---|---|---|
| Iteraciones (veces que le tuviste que volver a pedir algo) | 1 | Pendiente |
| Casos de aceptación que cumple (0–6) | 6/6 | 6/6 |
| Pruebas automatizadas que pasan | 6 | 12 |
| Archivos en `lib/` | 1 | 11 |
| Líneas de código en `lib/` | 329 | 485 |
| ¿`domain/` depende de Flutter? | No existe `domain/` | No |
| ¿Existe separación `presentation/domain/data`? | No | Sí |
| ¿El agente agregó algo que nadie pidió? | No; solo reparto básico | No; se implementó lo definido en la especificación |
| ¿Se puede agregar otra estrategia sin modificar el cálculo existente? | No; el cálculo está integrado en la pantalla | Sí |

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
- Parte 7.1: se creó `specs/001-dividir-cuenta/plan.md` junto con investigación, modelo de datos, contrato de pantalla y guía de validación. El plan usa Flutter estable, dependencias actuales, `setState` y las capas/responsabilidades pedidas. Gate de Constitución aprobado; no se identificaron dudas técnicas pendientes.
- Parte 7.2 (opcional): se creó `specs/001-dividir-cuenta/checklists/arquitectura.md` con 9 preguntas de revisión de calidad de requisitos; se dejaron sin marcar para evaluación del estudiante.
- Parte 7.3: se generó `specs/001-dividir-cuenta/tasks.md` con 27 tareas numeradas: 10 para US1, 5 para US2, 5 de preparación/fundamentos y 7 de pulido/validación. Incluye oportunidades paralelas y criterios de prueba independiente. No se implementó código.
- Parte 7.4: el análisis de coherencia detectó una diferencia terminológica entre `Reparto` y `Resultado`, y que no había una tarea explícita para comprobar ausencia de red y base de datos. Con autorización del estudiante, se unificó la entidad como `Resultado`, se aclaró que el modo exacto no eleva al entero siguiente y se añadió T027 con una verificación de arquitectura sin red/base de datos. Los cambios de planificación se confirmaron en `98e53fa`.
- Parte 8: se implementaron las entidades y reglas de dominio sin importar Flutter, las dos estrategias sustituibles, el controlador y la pantalla con entradas para monto, personas y propina. `main.dart` compone las implementaciones concretas.
- Cobertura de aceptación en SDD: los seis escenarios de la especificación están representados en los datos de prueba y las pruebas de dominio; las pruebas de pantalla verifican el cálculo principal y ambos errores sin resultado.
- Verificación SDD: `flutter analyze` sin issues; `flutter test` con 12 pruebas aprobadas; `flutter build apk --debug` exitoso. No se modificó `pubspec.yaml`; la búsqueda de arquitectura confirmó que no hay imports Flutter en `domain/`, las estrategias concretas solo se crean en `main.dart`, el cálculo no inspecciona sus tipos y no se agregaron red, base de datos ni dependencias.
- Métricas de implementación SDD: 11 archivos Dart y 485 líneas en `lib/`. La cantidad de iteraciones y la comparación final de ambas ramas quedan pendientes de la evaluación global.
- La revisión documental de `checklists/arquitectura.md` quedó completa (9/9); las tareas de implementación/validación T001–T027 están completadas.
- Tras la evaluación inicial se hizo una iteración en `vibe` para implementar propina y los dos modos de redondeo, además de los mensajes de error exigidos. Sus seis pruebas de aceptación pasan; `flutter analyze` no reporta issues y `flutter build apk --debug` termina correctamente.
- Al ejecutar temporalmente las pruebas de `sdd` en `vibe`, la compilación falló porque `lib/data/redondeo_exacto.dart` no existe en esa rama. Esto evidencia la diferencia de estructura/testabilidad; no es por sí solo un fallo funcional. Se restauró `test/` a la versión de `vibe` después de la comparación.
