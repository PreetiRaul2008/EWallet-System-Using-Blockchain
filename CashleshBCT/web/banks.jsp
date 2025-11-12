<%-- 
    Document   : schemes
    Created on : Nov 28, 2019, 12:47:05 PM
    Author     : Dinesh
--%>
<%@page import="cryptography.AES"%>
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
                            <h3>Bank Details</h3>
                            <button type="button" class="btn btn-success pull-right" style="margin: 5px" data-toggle="modal" data-target="#bankModal">Add Bank</button>
                        </div>
                        <!-- /widget-header -->
                        <div class="widget-content">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th> Sr </th>
                                        <th> Bank Name</th>
                                        <th> Bank Email</th>
                                        <th> Bank Mobile</th>
                                        <th> Office Address</th>
                                        <th class="td-actions"> </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        DBConnection con = new DBConnection();
                                        AES aes=new AES();
                                        ResultSet rs = con.select("SELECT * FROM tbl_users WHERE usertype='"+aes.encrypt("2")+"'");
                                        int i = 1;
                                        while (rs.next()) {
                                    %>
                                    <tr>
                                        <td> <%=i%> </td>
                                        <td><%=aes.decrypt(rs.getString("name"))%> </td>
                                        <td><%=aes.decrypt(rs.getString("email"))%> </td>
                                        <td><%=aes.decrypt(rs.getString("mobile"))%> </td>
                                        <td><%=aes.decrypt(rs.getString("address"))%> </td>
                                        <td class="td-actions">
                                            <a href="javascript:void(0);" id="<%=rs.getString("sr")%>"  class="bank_edit"><i class="btn-icon-only icon-pencil"> </i></a>
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

            <div id="bankModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" >Bank Details</h4>
                        </div>
                        <form class="form-horizontal" method="POST" name="productForm" id="productForm" action="AddBank">
                            <div class="modal-body">

                                <div class="control-group">											
                                    <label class="control-label" for="state_name">Select State</label>
                                    <div class="controls">
                                        <select class="span4" required id="state_name" name="state_name">
                                            <option value="1">Nationalize Bank</option>
                                          
                                        </select>

                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->
                                <div class="control-group">											
                                    <label class="control-label" for="bank_name">Bank Name</label>
                                    <div class="controls">
                                        <input type="text" class="span4" placeholder="Bank Name" id="bank_name" name="bank_name" required>
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->

                                <div class="control-group">											
                                    <label class="control-label" for="office_address">Office Address</label>
                                    <div class="controls">
                                        <textarea type="text" placeholder="Office Address" class="span4" id="office_address" name="office_address" required></textarea>
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->
                                <div class="control-group">											
                                    <label class="control-label" for="bank_email">Bank Email</label>
                                    <div class="controls">
                                        <input type="email" required class="span4" placeholder="Bank Email" id="bank_email" name="bank_email">
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->
                                <div class="control-group">											
                                    <label class="control-label" for="bank_mobile">Bank Mobile</label>
                                    <div class="controls">
                                        <input type="number" class="span4" placeholder="Bank Mobile" id="bank_mobile" name="bank_mobile" required>
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
