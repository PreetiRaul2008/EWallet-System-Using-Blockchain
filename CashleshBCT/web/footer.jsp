<div class="extra">
    <div class="extra-inner">
        <div class="container">
            <div class="row">
                <div class="span6" >
                    <h4>
                        Links To Connect</h4>
                    <ul>
                        <li><a href="index.jsp">Dashboard</a></li>
                        <li><a href="schemes.jsp">Schemes</a></li>
                        <li><a href="states.jsp">States</a></li>
                        <li><a href="banks.jsp">Banks</a></li>
                        <li><a href="customers.jsp">Customers</a></li>
                    </ul>
                </div>

                <!-- /span3 -->
            </div>
            <!-- /row --> 
        </div>
        <!-- /container --> 
    </div>
    <!-- /extra-inner --> 
</div>
<!-- /extra -->
<div class="footer">
    <div class="footer-inner">
        <div class="container">
            <div class="row">
                <div class="span12"> &copy; 2013 <a href="#">Bootstrap Responsive Admin Template</a>. </div>
                <!-- /span12 --> 
            </div>
            <!-- /row --> 
        </div>
        <!-- /container --> 
    </div>
    <!-- /footer-inner --> 
</div>
<!-- /footer --> 
<!-- Le javascript
================================================== --> 
<!-- Placed at the end of the document so the pages load faster --> 
<script src="js/jquery-1.7.2.min.js"></script> 
<script src="js/excanvas.min.js"></script> 
<script src="js/chart.min.js" type="text/javascript"></script> 
<script src="js/bootstrap.js"></script>
<script language="javascript" type="text/javascript" src="js/full-calendar/fullcalendar.min.js"></script>
<script src="js/base.js"></script> 
<script>

    var lineChartData = {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
            {
                fillColor: "rgba(220,220,220,0.5)",
                strokeColor: "rgba(220,220,220,1)",
                pointColor: "rgba(220,220,220,1)",
                pointStrokeColor: "#fff",
                data: [65, 59, 90, 81, 56, 55, 40]
            },
            {
                fillColor: "rgba(151,187,205,0.5)",
                strokeColor: "rgba(151,187,205,1)",
                pointColor: "rgba(151,187,205,1)",
                pointStrokeColor: "#fff",
                data: [28, 48, 40, 19, 96, 27, 100]
            }
        ]

    }

    var myLine = new Chart(document.getElementById("area-chart").getContext("2d")).Line(lineChartData);


    var barChartData = {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
            {
                fillColor: "rgba(220,220,220,0.5)",
                strokeColor: "rgba(220,220,220,1)",
                data: [65, 59, 90, 81, 56, 55, 40]
            },
            {
                fillColor: "rgba(151,187,205,0.5)",
                strokeColor: "rgba(151,187,205,1)",
                data: [28, 48, 40, 19, 96, 27, 100]
            }
        ]

    }

    $(document).ready(function () {
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var calendar = $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            selectable: true,
            selectHelper: true,
            select: function (start, end, allDay) {
                var title = prompt('Event Title:');
                if (title) {
                    calendar.fullCalendar('renderEvent',
                            {
                                title: title,
                                start: start,
                                end: end,
                                allDay: allDay
                            },
                            true // make the event "stick"
                            );
                }
                calendar.fullCalendar('unselect');
            },
            editable: true,

        });
    });
</script><!-- /Calendar -->

<script type="text/javascript">

    var i = 1;
    $(".edit").click(function (e) {
        e.preventDefault();
        var id = $(this).attr("id");
        $.ajax({
            url: "get_state_info.jsp",
            method: "POST",
            dataType: "json",
            data: {id: id},
            success: function (data) {
                $('#productModal').modal('show');
                $('#customer_name').val(data.state_name);
                $('#customer_email').val(data.state_email);
                $('#customer_mobile').val(data.state_mobile);
                $('#address').val(data.state_address);
                $('#btnsubmit').val("update");
                $('#productId').val(data.sr);
            }
        })
    });
    
     $(".bank_edit").click(function (e) {
        e.preventDefault();
        var id = $(this).attr("id");
        $.ajax({
            url: "get_bank_info.jsp",
            method: "POST",
            dataType: "json",
            data: {id: id},
            success: function (data) {
                $('#bankModal').modal('show');
                $('#bank_name').val(data.bank_name);
                $('#bank_email').val(data.bank_email);
                $('#bank_mobile').val(data.bank_mobile);
                $('#office_address').val(data.bank_address);
                $('#btnsubmit').val("update");
                $('#productId').val(data.sr);
            }
        })
    });
    $(".add_account").click(function (e) {
        e.preventDefault();
        var id = $(this).attr("id");
        $.ajax({
            url: "get_account_info.jsp",
            method: "POST",
            dataType: "json",
            data: {id: id},
            success: function (data) {
                $('#accountModal').modal('show');
                $('#bank_name').val(data.bank_name);
                $('#bank_address').val(data.bank_address);
                $('#account_no').val(data.account_no);
                $('#balance').val(data.balance);
                $('#btnsubmit').val("update");
                $('#account_id').val(data.sr);
            }
        })
    });
    $('#productModal').on('hidden.bs.modal', function () {
        location.reload();
    });
    $('#bankModal').on('hidden.bs.modal', function () {
        location.reload();
    });
</script>
</body>
</html>
