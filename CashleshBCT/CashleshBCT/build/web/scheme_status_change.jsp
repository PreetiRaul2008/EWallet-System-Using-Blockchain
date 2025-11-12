<%-- 
    Document   : scheme_status_change
    Created on : Dec 2, 2019, 12:03:03 PM
    Author     : Dinesh
--%>

<%@page import="pack.DBConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            try {
                DBConnection con = new DBConnection();
                String id = request.getParameter("id");
                String sql = "SELECT * FROM tbl_schemes WHERE sr=" + id + "";
                ResultSet rs = con.select(sql);
                if (rs.next()) {
                    String status = "";
                    if (rs.getString("scheme_status").equalsIgnoreCase("active")) {
                        status = "Deactive";
                    } else {
                        status = "Active";
                    }
                    sql = "UPDATE tbl_schemes set scheme_status='" + status + "' WHERE sr=" + id + "";
                    con.update(sql);
                    con.close();
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Scheme Updated!');");
                    out.println("location='schemes.jsp';");
                    out.println("</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
