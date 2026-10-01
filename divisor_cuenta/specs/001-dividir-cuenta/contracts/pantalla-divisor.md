# Contrato de pantalla: Divisor de cuenta

## Entradas

La pantalla ofrece una sola experiencia con:

- Monto total de la cuenta.
- Número de personas.
- Porcentaje de propina.
- Selector de modo: exacto o hacia arriba.

## Acción

Al activar «Calcular», el sistema valida las entradas. Si son válidas, divide el monto con
propina entre las personas y aplica el modo seleccionado.

## Salidas observables

- En modo exacto, muestra el pago por persona con dos decimales.
- En modo hacia arriba, redondea el pago individual al entero siguiente y lo muestra con
  dos decimales.
- Con 0 personas, muestra «Debe haber al menos una persona» y no muestra resultado.
- Con monto no numérico, muestra «Monto inválido» y no muestra resultado.

## Alcance del contrato

La interacción ocurre localmente, sin conexión de red ni persistencia en base de datos. Los
valores y mensajes de aceptación están definidos en [spec.md](../spec.md).
