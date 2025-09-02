<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Casuística 01 — Cálculo de Descuentos</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Ajusta la ruta si pones el CSS en otro lugar -->
    <link rel="stylesheet" href="assets/styles.css" />
</head>
<body>
<header class="app-header">
    <div class="wrapper">
        <h1>CASUÍSTICA 01</h1>
        <p>Cálculo de descuentos por colegio y categoría</p>
    </div>
</header>

<main class="wrapper">
    <section class="card">
        <h2 class="card-title">Tabla de Descuentos</h2>
        <div class="table-scroll">
            <table class="table">
                <thead>
                <tr>
                    <th>COLEGIO</th>
                    <th>CATEGORÍA A</th>
                    <th>CATEGORÍA B</th>
                    <th>CATEGORÍA C</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><strong>Nacional</strong></td>
                    <td>50%</td>
                    <td>40%</td>
                    <td>30%</td>
                </tr>
                <tr>
                    <td><strong>Particular</strong></td>
                    <td>25%</td>
                    <td>20%</td>
                    <td>15%</td>
                </tr>
                </tbody>
            </table>
        </div>
    </section>

    <section class="grid-2 gap card">
        <div>
            <h2 class="card-title">Calculadora de Descuentos</h2>
            <form method="post" action="" class="form">
                <div class="form-group">
                    <label for="nombre">Nombre del alumno</label>
                    <input type="text" id="nombre" name="nombre" placeholder="Ej. Ana Torres" required />
                </div>

                <div class="form-group">
                    <label for="colegio">Colegio de procedencia</label>
                    <select id="colegio" name="colegio" required>
                        <option value="">Seleccione el colegio</option>
                        <option value="nacional">Nacional</option>
                        <option value="particular">Particular</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="categoria">Categoría</label>
                    <select id="categoria" name="categoria" required>
                        <option value="">Seleccione la categoría</option>
                        <option value="A">Categoría A</option>
                        <option value="B">Categoría B</option>
                        <option value="C">Categoría C</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="cuota">Cuota base (S/)</label>
                    <input type="number" id="cuota" name="cuota" placeholder="Ej. 250.00" min="0" step="0.01" required />
                </div>

                <div class="actions">
                    <button type="submit" class="btn">Calcular descuento</button>
                    <button type="reset" class="btn btn-secondary">Limpiar</button>
                </div>
            </form>
        </div>

        <div>
            <%
                // --- Procesamiento del formulario ---
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    try {
                        String nombre = request.getParameter("nombre");
                        String colegio = request.getParameter("colegio");
                        String categoria = request.getParameter("categoria");
                        String cuotaStr = request.getParameter("cuota");

                        if (nombre != null && colegio != null && categoria != null && cuotaStr != null && !cuotaStr.trim().isEmpty()) {
                            double cuota = Double.parseDouble(cuotaStr);
                            double descuento = 0.0;

                            if ("nacional".equals(colegio)) {
                                switch (categoria) {
                                    case "A": descuento = 50.0; break;
                                    case "B": descuento = 40.0; break;
                                    case "C": descuento = 30.0; break;
                                }
                            } else if ("particular".equals(colegio)) {
                                switch (categoria) {
                                    case "A": descuento = 25.0; break;
                                    case "B": descuento = 20.0; break;
                                    case "C": descuento = 15.0; break;
                                }
                            }

                            double montoDescuento = cuota * (descuento / 100.0);
                            double importeFinal = cuota - montoDescuento;

                            String colegioCap = colegio.substring(0,1).toUpperCase() + colegio.substring(1);
                            String descripcionDescuento = colegioCap + " — Categoría " + categoria;
            %>
            <aside class="result card success">
                <h2 class="card-title">Resultado del cálculo</h2>
                <div class="pill">
                    <strong>Alumno:</strong> <%= nombre %> &nbsp;|&nbsp;
                    <strong>Colegio y Categoría:</strong> <%= descripcionDescuento %>
                </div>

                <ul class="summary">
                    <li><span>Cuota base</span><strong>S/ <%= String.format("%.2f", cuota) %></strong></li>
                    <li><span>Descuento aplicado</span><strong><%= String.format("%.1f", descuento) %>%</strong></li>
                    <li><span>Monto del descuento</span><strong>S/ <%= String.format("%.2f", montoDescuento) %></strong></li>
                    <li class="total"><span>Importe final a pagar</span><strong>S/ <%= String.format("%.2f", importeFinal) %></strong></li>
                </ul>
            </aside>
            <%
                }
            } catch (NumberFormatException e) {
            %>
            <aside class="result card error">
                <h2 class="card-title">Error en el cálculo</h2>
                <p>Por favor, ingrese un monto válido para la cuota.</p>
            </aside>
            <%
                    }
                }
            %>
        </div>
    </section>

    <nav class="center mt">
        <a class="link" href="index.jsp">Inicio</a>
    </nav>

</main>

<footer class="app-footer">
    <div class="wrapper">
        <small>© <%= new java.util.GregorianCalendar().get(java.util.Calendar.YEAR) %> — Cálculo de Descuentos</small>
    </div>
</footer>
</body>
</html>
