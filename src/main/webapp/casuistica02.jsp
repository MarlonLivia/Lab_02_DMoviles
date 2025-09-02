<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>CASUÍSTICA 02 — Neto a Cobrar</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<header class="app-header">
    <div class="wrapper">
        <h1>CASUÍSTICA 02</h1>
        <p>Cálculo del neto a cobrar según estado civil e hijos</p>
    </div>
</header>

<main class="wrapper">
    <!-- Tabla de referencia -->
    <section class="card">
        <h2 class="card-title">Tabla de Bonificaciones</h2>
        <div class="table-scroll">
            <table class="table">
                <thead>
                <tr>
                    <th>ESTADO CIVIL</th>
                    <th>PORCENTAJE</th>
                </tr>
                </thead>
                <tbody>
                <tr><td>Casado</td><td>13%</td></tr>
                <tr><td>Viudo</td><td>15%</td></tr>
                <tr><td>Soltero</td><td>5%</td></tr>
                </tbody>
            </table>
        </div>
        <p class="note">Adicionalmente se abonará el <strong>1.5% por cada hijo</strong>, con un máximo de <strong>6%</strong>.</p>
    </section>

    <!-- Formulario -->
    <section class="grid-2 gap card">
        <div>
            <h2 class="card-title">Formulario de cálculo</h2>
            <form method="post" action="" class="form">
                <div class="form-group">
                    <label for="nombre">Nombre del trabajador</label>
                    <input type="text" id="nombre" name="nombre" placeholder="Ej. Luis Pérez" required>
                </div>

                <div class="form-group">
                    <label for="sueldo">Sueldo base (S/)</label>
                    <input type="number" id="sueldo" name="sueldo" min="0" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="estado">Estado civil</label>
                    <select id="estado" name="estado" required>
                        <option value="">Seleccione</option>
                        <option value="casado">Casado</option>
                        <option value="viudo">Viudo</option>
                        <option value="soltero">Soltero</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="hijos">Número de hijos</label>
                    <input type="number" id="hijos" name="hijos" min="0" max="10" required>
                </div>

                <div class="actions">
                    <button type="submit" class="btn">Calcular</button>
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
                        String estado = request.getParameter("estado");
                        String sueldoStr = request.getParameter("sueldo");
                        String hijosStr = request.getParameter("hijos");

                        if (nombre != null && estado != null && sueldoStr != null && hijosStr != null) {
                            double sueldo = Double.parseDouble(sueldoStr);
                            int hijos = Integer.parseInt(hijosStr);

                            double bonificacionEstado = 0.0;
                            switch (estado) {
                                case "casado": bonificacionEstado = 13.0; break;
                                case "viudo": bonificacionEstado = 15.0; break;
                                case "soltero": bonificacionEstado = 5.0; break;
                            }

                            double bonifHijos = hijos * 1.5;
                            if (bonifHijos > 6.0) {
                                bonifHijos = 6.0;
                            }

                            double totalBonif = bonificacionEstado + bonifHijos;
                            double montoBonif = sueldo * (totalBonif / 100.0);
                            double neto = sueldo + montoBonif;
            %>
            <aside class="result card success">
                <h2 class="card-title">Resultado del cálculo</h2>
                <div class="pill">
                    <strong>Trabajador:</strong> <%= nombre %> &nbsp;|&nbsp;
                    <strong>Estado civil:</strong> <%= estado %> &nbsp;|&nbsp;
                    <strong>Hijos:</strong> <%= hijos %>
                </div>
                <ul class="summary">
                    <li><span>Sueldo base</span><strong>S/ <%= String.format("%.2f", sueldo) %></strong></li>
                    <li><span>Bonificación por estado civil</span><strong><%= bonificacionEstado %>%</strong></li>
                    <li><span>Bonificación por hijos</span><strong><%= String.format("%.1f", bonifHijos) %>%</strong></li>
                    <li><span>Total de bonificación</span><strong><%= String.format("%.1f", totalBonif) %>%</strong></li>
                    <li class="total"><span>Neto a cobrar</span><strong>S/ <%= String.format("%.2f", neto) %></strong></li>
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
        <small>© <%= new java.util.GregorianCalendar().get(java.util.Calendar.YEAR) %> — Cálculo Neto</small>
    </div>
</footer>
</body>
</html>
