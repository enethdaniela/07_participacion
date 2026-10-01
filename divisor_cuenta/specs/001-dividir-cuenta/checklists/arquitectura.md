# Revisión de requisitos de arquitectura: Dividir cuenta con propina y redondeo

**Propósito**: Revisar que los requisitos y el plan describan límites de arquitectura y
validación antes de implementar.
**Creada**: 2026-10-01
**Funcionalidad**: [spec.md](../spec.md) y [plan.md](../plan.md)

**Nota**: Esta checklist personalizada valida la calidad de los requisitos, no la
implementación.
**Responsable de revisión**: La persona revisora decide si cada requisito está claro y
completo antes de marcarlo `[x]`.
**Significado de los marcadores**: `[x]` indica revisión y aprobación de la calidad del
requisito; no indica que el código esté implementado.

## Separación y dependencias

- [ ] CHK001 ¿El plan asigna responsabilidades distintas a validación, cálculo, redondeo, formato y presentación? [Completitud, plan.md §Verificación de la constitución]
- [ ] CHK002 ¿Queda claro que `presentation` depende de abstracciones de `domain` y no de implementaciones concretas de `data`? [Claridad, spec.md §Requisitos]
- [ ] CHK003 ¿Se establece que una estrategia de redondeo nueva puede añadirse sin editar el cálculo existente? [Trazabilidad, constitution.md §II]
- [ ] CHK004 ¿Se define la interfaz de redondeo como un contrato pequeño que permite sustituir sus implementaciones? [Completitud, constitution.md §III–IV]
- [ ] CHK005 ¿El límite que mantiene `lib/domain/` libre de dependencias de Flutter está expresado de forma verificable? [Claridad, constitution.md §Arquitectura y seguridad]
- [ ] CHK006 ¿Está inequívocamente indicado que la composición de implementaciones concretas ocurre solo en `main.dart`? [Consistencia, constitution.md §Arquitectura y seguridad]

## Cobertura y validación

- [ ] CHK007 ¿El plan vincula los seis escenarios de aceptación con pruebas de dominio y de pantalla identificables? [Cobertura, spec.md §Escenarios de usuario y pruebas; plan.md §Contexto técnico]
- [ ] CHK008 ¿La guía de validación identifica comandos y resultados esperados para pruebas, análisis y compilación Android? [Completitud, quickstart.md]
- [ ] CHK009 ¿Los contratos documentados cubren los dos errores requeridos y especifican que no se presenta resultado cuando hay error? [Consistencia, contracts/pantalla-divisor.md; spec.md §Requisitos funcionales]

## Notas

- Mantener todos los ítems sin marcar hasta que una persona revisora evalúe su claridad.
- No marcar un ítem como aprobado por el mero hecho de que exista una implementación.
- La lista automática de calidad de la especificación está en [requirements.md](requirements.md).
