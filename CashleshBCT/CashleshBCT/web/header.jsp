<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.min.css" rel="stylesheet">
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600"
              rel="stylesheet">
        <link href="css/font-awesome.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/pages/dashboard.css" rel="stylesheet">
        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
              <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
            <![endif]-->
    </head>
    <body>
        <%

            String email = session.getAttribute("email").toString();
        %>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                            class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span> </a><a class="brand" href="dashboard.jsp">Secure Digital Economy Using BCT</a>
                    <div class="nav-collapse">
                        <ul class="nav pull-right">

                            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i
                                        class="icon-user"></i><%=email%> <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="profile.jsp">Profile</a></li>
                                    <li><a href="logout.jsp">Logout</a></li>
                                </ul>
                            </li>
                        </ul>
                        <form class="navbar-search pull-right">
                            <input type="text" class="search-query" placeholder="Search">
                        </form>
                    </div>
                    <!--/.nav-collapse --> 
                </div>
                <!-- /container --> 
            </div>
            <!-- /navbar-inner --> 
        </div>
        <!-- /navbar -->
        <div class="subnavbar">
            <div class="subnavbar-inner">
                <div class="container">
                    <ul class="mainnav">
                        <%
                            String uri = request.getRequestURI();
                            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
                            String usertype = session.getAttribute("usertype").toString();
                        %>
                        <li <%if (pageName.equals("dashboard.jsp")) {%>class="active"<%}%> ><a href="dashboard.jsp"><i class="icon-dashboard"></i><span>Dashboard</span> </a> </li>
                                    <%if (usertype.equals("1")) {%>
                        <li <%if (pageName.equals("banks.jsp")) {%>class="active"<%}%>><a href="banks.jsp"><i class="icon-rupee"></i><span>Banks</span> </a> </li>

                        <%
                            }
                        %>
                        <li <%if (pageName.equals("customers.jsp")) {%>class="active"<%}%>><a href="customers.jsp"><i class="icon-user"></i><span>Customers</span> </a> </li>
                       

                    </ul>
                </div>
                <!-- /container --> 
            </div>
            <!-- /subnavbar-inner --> 
        </div>