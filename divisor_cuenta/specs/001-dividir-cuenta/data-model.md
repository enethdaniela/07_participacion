# Modelo de datos: Dividir cuenta con propina y redondeo

## Cuenta

Representa los datos validados de la cuenta que se va a dividir.

| Campo | Tipo conceptual | Regla |
|---|---|---|
| `monto` | número decimal | Se obtiene del monto ingresado y participa en el cálculo. |
| `personas` | entero | Debe ser al menos 1. |
| `propina` | número decimal porcentual | Se aplica al monto antes de dividirlo; 0 es válido. |

La lectura y validación de los datos escritos ocurre antes de calcular. Un monto que no sea
numérico produce «Monto inválido»; 0 personas produce «Debe haber al menos una persona».

## Resultado

Representa el pago calculado por persona.

| Campo | Tipo conceptual | Regla |
|---|---|---|
| `montoPorPersona` | número decimal | Resultado de aplicar el modo de redondeo solicitado al reparto. |

La presentación del resultado muestra exactamente dos decimales. Los errores de validación
se presentan como mensajes y no como resultados.

## EstrategiaRedondeo

Abstracción de un único comportamiento: recibe el pago calculado sin redondear y devuelve
el valor redondeado.

- `RedondeoExacto`: conserva el valor calculado; la vista lo presenta con dos decimales.
- `RedondeoHaciaArriba`: lleva el pago individual al entero siguiente; la vista lo presenta
  con dos decimales.

## Flujo y relaciones

1. `ValidarEntrada` interpreta los campos escritos y produce una `Cuenta` válida o un error.
2. `CalcularDivision` recibe la `Cuenta` y una `EstrategiaRedondeo`, y produce un
   `Resultado`.
3. `DivisorController` coordina los casos de uso; `FormateadorMoneda` presenta el valor.
4. `PantallaDivisor` lee los datos y presenta resultado o mensaje de validación.
