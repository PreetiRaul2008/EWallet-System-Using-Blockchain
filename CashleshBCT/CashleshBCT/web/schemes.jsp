<%-- 
    Document   : schemes
    Created on : Nov 28, 2019, 12:47:05 PM
    Author     : Dinesh
--%>
<%
    HttpServletResponse httpResponse = (HttpServletResponse) response;

    httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.addHeader("Cache-Control", "post-check=0, pre-check=0");
    httpResponse.setHeader("Pragma", "no-cache");
    httpResponse.setDateHeader("Expires", 0);
    if (session.getAttribute("usertype") == null || session.getAttribute("email") == null) {
        response.sendRedirect("logout.jsp");
        return;
    }
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="pack.DBConnection"%>
<jsp:include page="header.jsp"/>
<div class="main">
    <div class="main-inner">
        <div class="container">
            <div class="row">

                <div class="span12">

                    <div class="widget widget-table action-table">
                        <div class="widget-header"> <i class="icon-th-list"></i>
                            <h3>Scheme Details</h3>
                            <button type="button" class="btn btn-success pull-right" style="margin: 5px" data-toggle="modal" data-target="#productModal">Add Scheme</button>
                        </div>
                        <!-- /widget-header -->
                        <div class="widget-content">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th> Sr </th>
                                        <th> Scheme Name</th>
                                        <th> Scheme Details</th>
                                        <th class="td-actions"> </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        DBConnection con = new DBConnection();
                                        ResultSet rs = con.select("SELECT * FROM tbl_schemes ORDER BY scheme_status ASC");
                                        int i = 1;
                                        while (rs.next()) {
                                    %>
                                    <tr>
                                        <td> <%=i%> </td>
                                        <td><%=rs.getString("scheme_name")%> </td>
                                        <td><%=rs.getString("scheme_details")%> </td>
                                        <td class="td-actions"><%
                                            if (rs.getString("scheme_status").equalsIgnoreCase("active")) {%>
                                            <a href="scheme_status_change.jsp?id=<%=rs.getString("sr")%>" onclick="return confirm('Do you want to deactivate?');" class="btn btn-success btn-small"><i class="btn-icon-only icon-ok"> </i></a>
                                            <%} else {
                                            %>
                                            <a href="scheme_status_change.jsp?id=<%=rs.getString("sr")%>" onclick="return confirm('Do you want to activate?');" class="btn btn-danger btn-small"><i class="btn-icon-only icon-remove"> </i></a>
                                            <%}%>
                                        </td>
                                    </tr>
                                    <%
                                        i++;
                                        }
                                        con.close();
                                    %>

                                </tbody>
                            </table>
                        </div>
                        <!-- /widget-content --> 
                    </div>
                    <!-- /widget --> 

                    <!-- /widget -->
                </div>
                <!-- /span6 --> 
            </div>
            <!-- /row --> 

            <div id="productModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" >Scheme Details</h4>
                        </div>
                        <form class="form-horizontal" method="POST" name="productForm" id="productForm" action="AddScheme">
                            <div class="modal-body">

                                <div class="control-group">											
                                    <label class="control-label" for="scheme_name">Scheme Name</label>
                                    <div class="controls">
                                        <input type="text" class="span4" placeholder="Scheme Name" id="scheme_name" name="scheme_name">

                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->

                                <div class="control-group">											
                                    <label class="control-label" for="scheme_name">Scheme Details</label>
                                    <div class="controls">
                                        <textarea type="text" placeholder="Scheme Details" class="span4" id="scheme_details" name="scheme_details"></textarea>

                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->

                            </div>
                            <div class="modal-footer">
                                <input type="hidden" name="productId" id="productId">
                                <input type="submit" name="btnsubmit" id="btnsubmit" class="btn btn-success btn-flat" value="Add">
                                <button type="button" class="btn btn-default btn-flat" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- /container --> 
    </div>
    <!-- /main-inner --> 
</div>
<jsp:include page="footer.jsp"/>
