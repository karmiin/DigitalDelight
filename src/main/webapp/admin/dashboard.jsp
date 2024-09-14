<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <form id="searchOrdersForm" method="get" action="${pageContext.request.contextPath}/adminPanel" class="card p-4 shadow-sm">
                <div class="form-group mb-3">
                    <label for="searchUser" class="form-label">Cerca ordini per utente:</label>
                    <input type="text" class="form-control" id="searchUser" name="searchUser" placeholder="Inserisci nome utente">
                </div>

                <div class="row mb-3">
                    <div class="col">
                        <label for="startDate" class="form-label">Data Inizio</label>
                        <input type="date" class="form-control" id="startDate" name="startDate" placeholder="Start Date">
                    </div>
                    <div class="col">
                        <label for="endDate" class="form-label">Data Fine</label>
                        <input type="date" class="form-control" id="endDate" name="endDate" placeholder="End Date">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100">Cerca</button>
            </form>

            <div id="ordersList" class="mt-4">
                <c:forEach var="order" items="${orders}">
                    <!-- Card di Material Design per ogni ordine -->
                    <div class="card mb-3 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Ordine ID: ${order.id}</h5>
                            <p class="card-text">Utente ID: ${order.userId}</p>
                            <p class="card-text">Nome Utente: ${order.username}</p>
                            <p class="card-text">Data Ordine: ${order.orderDate}</p>
                            <p class="card-text">Totale: €${order.totalAmount}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
