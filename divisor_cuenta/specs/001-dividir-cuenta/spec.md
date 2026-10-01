# Especificación de funcionalidad: Dividir cuenta con propina y redondeo

**Rama de funcionalidad**: `sdd`

**Creada**: 2026-10-01

**Estado**: Borrador

**Entrada**: Descripción del usuario: "Una app de una sola pantalla para dividir la cuenta de un restaurante entre varias personas. El usuario ingresa el monto total, el número de personas y el porcentaje de propina, y al tocar «Calcular» ve cuánto paga cada persona con dos decimales. Hay dos modos de redondeo que el usuario elige: exacto, o hacia arriba al entero más cercano. La app funciona sin conexión: no hay red ni base de datos."

## Escenarios de usuario y pruebas

### Historia de usuario 1: Calcular el pago por persona (Prioridad: P1)

Como persona que comparte una cuenta de restaurante, quiero ingresar el monto, el número
de personas, la propina y el modo de redondeo para saber cuánto paga cada persona.

**Por qué tiene esta prioridad**: El reparto de la cuenta es la función principal de la app.

**Prueba independiente**: Ingresar datos válidos, seleccionar cada modo disponible y
comprobar que se muestra el pago individual esperado.

**Escenarios de aceptación**:

1. **Dado** un monto de 100.00, 4 personas, 10% de propina y modo exacto, **cuando** se
   calcula la cuenta, **entonces** se muestra 27.50 por persona.
2. **Dado** un monto de 90.00, 3 personas, 0% de propina y modo exacto, **cuando** se
   calcula la cuenta, **entonces** se muestra 30.00 por persona.
3. **Dado** un monto de 10.00, 3 personas, 0% de propina y modo exacto, **cuando** se
   calcula la cuenta, **entonces** se muestra 3.33 por persona.
4. **Dado** un monto de 10.00, 3 personas, 0% de propina y modo hacia arriba, **cuando** se
   calcula la cuenta, **entonces** se muestra 4.00 por persona.

### Historia de usuario 2: Corregir datos no válidos (Prioridad: P2)

Como persona que divide una cuenta, quiero recibir un mensaje cuando falten datos válidos,
para corregirlos sin confundir un error con un resultado.

**Por qué tiene esta prioridad**: La app debe evitar presentar un pago que no se pudo
calcular correctamente.

**Prueba independiente**: Enviar los dos datos inválidos descritos en los escenarios y
comprobar el mensaje especificado y que no se muestra ningún resultado.

**Escenarios de aceptación**:

1. **Dado** un monto de 50.00 y 0 personas, **cuando** se calcula la cuenta, **entonces** se
   muestra «Debe haber al menos una persona» y no se muestra un resultado.
2. **Dado** que el monto ingresado es «abc», **cuando** se calcula la cuenta, **entonces** se
   muestra «Monto inválido» y no se muestra un resultado.

### Casos límite

- Con 0 personas, la app muestra el mensaje indicado y no presenta un pago por persona.
- Si el monto no es numérico, la app muestra el mensaje indicado y no presenta un pago.
- La app debe poder completar el cálculo sin conexión a una red.

## Requisitos

### Requisitos funcionales

- **RF-001**: La app DEBE permitir ingresar el monto total de la cuenta.
- **RF-002**: La app DEBE presentar la experiencia completa para dividir la cuenta en una sola pantalla.
- **RF-003**: La app DEBE permitir ingresar el número de personas.
- **RF-004**: La app DEBE permitir ingresar el porcentaje de propina, incluido 0%.
- **RF-005**: La app DEBE permitir elegir entre los modos de redondeo exacto y hacia arriba.
- **RF-006**: Al tocar «Calcular» con datos válidos, la app DEBE repartir el monto más la
  propina entre el número de personas y mostrar el pago por persona con dos decimales.
- **RF-007**: En modo exacto, la app DEBE mostrar el resultado con dos decimales.
- **RF-008**: En modo hacia arriba, la app DEBE redondear el pago individual hacia arriba al
  entero siguiente y mostrarlo con dos decimales.
- **RF-009**: Si el número de personas es 0, la app DEBE mostrar «Debe haber al menos una
  persona» y NO DEBE mostrar un resultado.
- **RF-010**: Si el monto ingresado no es numérico, la app DEBE mostrar «Monto inválido» y
  NO DEBE mostrar un resultado.
- **RF-011**: La app DEBE funcionar sin conexión a internet y sin una base de datos.

### Entidades principales

- **Cuenta**: el monto total, el número de personas y el porcentaje de propina que ingresa
  quien usa la app.
- **Reparto**: el pago resultante por persona, expresado con dos decimales según el modo
  de redondeo elegido.

## Criterios de éxito

### Resultados medibles

- **CE-001**: Los cuatro escenarios de cálculo válidos muestran exactamente los valores
  esperados: 27.50, 30.00, 3.33 y 4.00.
- **CE-002**: Los dos escenarios inválidos muestran el mensaje esperado y ninguno muestra
  un resultado.
- **CE-003**: Los seis escenarios de aceptación se pueden completar sin conexión y sin
  depender de una base de datos.

## Suposiciones

- El modo exacto presenta el resultado con dos decimales, tal como se indica en la solicitud.
- El modo hacia arriba redondea el pago individual al entero siguiente; esto se desprende
  del resultado 4.00 indicado para 10.00 dividido entre 3.
- La propina se calcula como porcentaje del monto total antes de dividir entre las personas;
  esto coincide con el ejemplo de 100.00, 4 personas y 10% de propina.
