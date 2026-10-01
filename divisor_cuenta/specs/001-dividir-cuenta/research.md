# Investigación: Dividir cuenta con propina y redondeo

## Decisiones

### Plataforma y dependencias

- **Decisión**: Usar el Flutter SDK estable disponible. No agregar dependencias externas.
- **Razón**: Es una restricción explícita del plan de la práctica; el proyecto ya incluye
  Flutter SDK y herramientas de prueba.
- **Alternativas consideradas**: Paquetes externos para presentación, cálculos o estado.
  Se descartan porque no son necesarios para una sola pantalla y contravienen el alcance.

### Estado de la interfaz

- **Decisión**: Mantener el estado de la pantalla con `setState`.
- **Razón**: La práctica especifica una sola pantalla y solicita estado local.
- **Alternativas consideradas**: Gestores de estado de terceros. No se incorporan.

### Capas y estrategias

- **Decisión**: Separar presentación, dominio y datos; declarar `EstrategiaRedondeo` en
  dominio y colocar ambas implementaciones concretas en data.
- **Razón**: Lo requieren la Constitución y el plan de la práctica; permite sustituir e
  incorporar estrategias sin acoplar el cálculo a tipos concretos.
- **Alternativas consideradas**: Un condicional de redondeo dentro del cálculo. Se descarta
  porque viola OCP y LSP.

### Contratos de interacción

- **Decisión**: Considerar la pantalla local como el único contrato externo del producto y
  documentar sus campos, acciones, estados y mensajes.
- **Razón**: La app no expone API ni usa servicios externos, pero sí tiene una interfaz
  observable cubierta por requisitos de aceptación.
- **Alternativas consideradas**: Contratos de red o persistencia. No aplican al alcance sin
  conexión y sin base de datos.

## Incertidumbres

No quedan decisiones técnicas pendientes para iniciar el diseño. Los detalles de exactitud
del redondeo y cálculo de propina se toman de los ejemplos y supuestos explícitos de la
especificación.
