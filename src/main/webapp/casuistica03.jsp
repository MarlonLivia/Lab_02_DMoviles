<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>CASUÍSTICA 03 — Sueldo a destajo</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<header class="app-header">
    <div class="wrapper">
        <h1>CASUÍSTICA 03</h1>
        <p>Cálculo del sueldo mensual a destajo</p>
    </div>
</header>

<main class="wrapper">
    <!-- Tablas de referencia -->
    <section class="card">
        <h2 class="card-title">Tarifas por tipo de prenda</h2>
        <div class="table-scroll">
            <table class="table">
                <thead>
                <tr><th>TIPO DE PRENDA</th><th>TARIFA (S/)</th></tr>
                </thead>
                <tbody>
                <tr><td>Polo</td><td>0.50</td></tr>
                <tr><td>Camisa</td><td>1.00</td></tr>
                <tr><td>Pantalón</td><td>1.50</td></tr>
                </tbody>
            </table>
        </div>
    </section>

    <section class="card">
        <h2 class="card-title">Bonificación por categoría</h2>
        <div class="table-scroll">
            <table class="table">
                <thead>
                <tr><th>CATEGORÍA</th><th>BONIFICACIÓN (S/)</th></tr>
                </thead>
                <tbody>
                <tr><td>A</td><td>250.00</td></tr>
                <tr><td>B</td><td>150.00</td></tr>
                <tr><td>C</td><td>100.00</td></tr>
                <tr><td>D</td><td>50.00</td></tr>
                </tbody>
            </table>
        </div>
    </section>

    <!-- Formulario -->
    <section class="grid-2 gap card">
        <div>
            <h2 class="card-title">Formulario de cálculo</h2>
            <form method="post" action="" class="form">
                <div class="form-group">
                    <label for="nombre">Nombre del obrero</label>
                    <input type="text" id="nombre" name="nombre" required>
                </div>

                <div class="form-group">
                    <label for="prenda">Tipo de prenda</label>
                    <select id="prenda" name="prenda" required>
                        <option value="">Seleccione</option>
                        <option value="polo">Polo</option>
                        <option value="camisa">Camisa</option>
                        <option value="pantalon">Pantalón</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="unidades">Unidades confeccionadas</label>
                    <input type="number" id="unidades" name="unidades" min="0" required>
                </div>

                <div class="form-group">
                    <label for="categoria">Categoría (si aplica bonificación)</label>
                    <select id="categoria" name="categoria">
                        <option value="">Seleccione</option>
                        <option value="A">A</option>
                        <option value="B">B</option>
                        <option value="C">C</option>
                        <option value="D">D</option>
                    </select>
                </div>

                <div class="actions">
                    <button type="submit" class="btn">Calcular sueldo</button>
                    <button type="reset" class="btn btn-secondary">Limpiar</button>
                </div>
            </form>
        </div>

        <!-- Resultados -->
        <div>
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    try {
                        String nombre = request.getParameter("nombre");
                        String prenda = request.getParameter("prenda");
                        String unidadesStr = request.getParameter("unidades");
                        String categoria = request.getParameter("categoria");

                        if (nombre != null && prenda != null && unidadesStr != null) {
                            int unidades = Integer.parseInt(unidadesStr);
                            double tarifa = 0.0;

                            switch (prenda) {
                                case "polo": tarifa = 0.50; break;
                                case "camisa": tarifa = 1.00; break;
                                case "pantalon": tarifa = 1.50; break;
                            }

                            double ingresoBase = unidades * tarifa;

                            // Bonificación
                            double bonificacion = 0.0;
                            if (unidades > 700 && categoria != null && !categoria.isEmpty()) {
                                switch (categoria) {
                                    case "A": bonificacion = 250.0; break;
                                    case "B": bonificacion = 150.0; break;
                                    case "C": bonificacion = 100.0; break;
                                    case "D": bonificacion = 50.0; break;
                                }
                            }

                            // Descuentos
                            double descImpuesto = ingresoBase * 0.09;
                            double descSeguro = ingresoBase * 0.02;
                            if (descSeguro > 20.0) descSeguro = 20.0;
                            double descSolidaridad = ingresoBase * 0.01;

                            double totalDescuentos = descImpuesto + descSeguro + descSolidaridad;
                            double sueldoNeto = ingresoBase + bonificacion - totalDescuentos;
            %>
            <aside class="result card success">
                <h2 class="card-title">Resultado del cálculo</h2>
                <div class="pill">
                    <strong>Obrero:</strong> <%= nombre %> &nbsp;|&nbsp;
                    <strong>Prenda:</strong> <%= prenda %> &nbsp;|&nbsp;
                    <strong>Unidades:</strong> <%= unidades %>
                </div>
                <ul class="summary">
                    <li><span>Ingreso base</span><strong>S/ <%= String.format("%.2f", ingresoBase) %></strong></li>
                    <li><span>Bonificación</span><strong>S/ <%= String.format("%.2f", bonificacion) %></strong></li>
                    <li><span>Descuento impuestos (9%)</span><strong>S/ <%= String.format("%.2f", descImpuesto) %></strong></li>
                    <li><span>Descuento seguro (2%, máx. 20)</span><strong>S/ <%= String.format("%.2f", descSeguro) %></strong></li>
                    <li><span>Descuento solidaridad (1%)</span><strong>S/ <%= String.format("%.2f", descSolidaridad) %></strong></li>
                    <li class="total"><span>Sueldo neto</span><strong>S/ <%= String.format("%.2f", sueldoNeto) %></strong></li>
                </ul>
            </aside>
            <%
                }
            } catch (Exception e) {
            %>
            <aside class="result card error">
                <h2 class="card-title">Error en el cálculo</h2>
                <p>Verifique los datos ingresados.</p>
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
        <small>© <%= new java.util.GregorianCalendar().get(java.util.Calendar.YEAR) %> — Sueldo a Destajo</small>
    </div>
</footer>
</body>
</html>
