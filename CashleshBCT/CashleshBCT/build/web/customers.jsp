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
    String usertype=session.getAttribute("usertype").toString();
    AES aes=new AES();
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
                            <h3>Customer Details</h3>
                            <button type="button" class="btn btn-success pull-right" style="margin: 5px" data-toggle="modal" data-target="#productModal">Add Customer</button>
                        </div>
                        <!-- /widget-header -->
                        <div class="widget-content">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th> Sr </th>
                                        <th> Customer Name</th>
                                        <th> Customer Email</th>
                                        <th> Customer Mobile</th>
                                        <th> Address</th>
                                        <th class="td-actions">Edit </th>
                                        <%if(usertype.equals("2")){%>
                                       <th class="td-actions">Add Account </th>
                                        <th class="td-actions">View Account </th>
                                        <%
                                            }
                                        %>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        DBConnection con = new DBConnection();
                                        ResultSet rs = con.select("SELECT * FROM tbl_users WHERE usertype='"+aes.encrypt("3")+"'");
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
                                            <a href="javascript:void(0);" id="<%=rs.getString("sr")%>"  class="edit"><i class="btn-icon-only icon-pencil"> </i></a>
                                        </td>
                                        <%
                                       if (usertype.equals("2")) {%>
                                           <td class="td-actions">
                                               <a href="add_account.jsp?id=<%=aes.decrypt(rs.getString("email"))%>"><i class="btn-icon-only icon-plus-sign"> </i></a>
                                        </td> 
                                         <td class="td-actions">
                                               <a href="javascript:void(0);" id="<%=rs.getString("sr")%>"  class="add_account" ><i class="btn-icon-only icon-eye-open"> </i></a>
                                        </td> 
                                         <%  }
                                        %>
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
                            <h4 class="modal-title" >Customer Details</h4>
                        </div>
                        <form class="form-horizontal" method="POST" name="productForm" id="productForm" action="AddCustomer">
                            <div class="modal-body">

                                <div class="control-group">											
                                    <label class="control-label" for="customer_name">Customer Name</label>
                                    <div class="controls">
                                        <input type="text" class="span4" placeholder="Customer Name" id="customer_name" name="customer_name" required>
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->

                                <div class="control-group">											
                                    <label class="control-label" for="scheme_name">Address</label>
                                    <div class="controls">
                                        <textarea type="text" placeholder="Address" class="span4" id="address" name="address" required></textarea>
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->
                                <div class="control-group">											
                                    <label class="control-label" for="customer_email">Customer Email</label>
                                    <div class="controls">
                                        <input type="email" required class="span4" placeholder="Customer Email" id="customer_email" name="customer_email">
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->
                                <div class="control-group">											
                                    <label class="control-label" for="customer_mobile">Customer Mobile</label>
                                    <div class="controls">
                                        <input type="number" class="span4" placeholder="Customer Mobile" id="customer_mobile" name="customer_mobile" required>
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
            
            <!--Account Modal to show account details of current customer -->
             <div id="accountModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" >Account Details</h4>
                        </div>
                        <form class="form-horizontal" method="POST" name="productForm" id="productForm" action="UpdateAccount">
                            <div class="modal-body">

                                <div class="control-group">											
                                    <label class="control-label" for="bank_name">Bank Name</label>
                                    <div class="controls">
                                        <input type="text" class="span4" placeholder="Bank Name" id="bank_name" name="bank_name" required="" readonly="">
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->

                                <div class="control-group">											
                                    <label class="control-label" for="bank_address">Address</label>
                                    <div class="controls">
                                        <input type="text" placeholder="Address" class="span4" id="bank_address" name="bank_address" required="" readonly="">
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->
                                <div class="control-group">											
                                    <label class="control-label" for="account_no">Account Number</label>
                                    <div class="controls">
                                        <input type="number" required="" class="span4" placeholder="Account Number" id="account_no" name="account_no" readonly="">
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->
                                <div class="control-group">											
                                    <label class="control-label" for="balance">Balance</label>
                                    <div class="controls">
                                        <input type="number" class="span4" placeholder="Balance" id="balance" name="balance" required="" readonly="">
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->
                                <div class="control-group">											
                                    <label class="control-label" for="amount">Add Amount</label>
                                    <div class="controls">
                                        <input type="number" class="span4" placeholder="Add Amount" id="amount" name="amount" required="">
                                    </div> <!-- /controls -->				
                                </div> <!-- /control-group -->
                            </div>
                            <div class="modal-footer">
                                <input type="hidden" name="account_id" id="account_id">
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
