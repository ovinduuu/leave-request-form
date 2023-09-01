<%@page import="app.cor.LeaveRequest"%>
<%@page import="org.apache.jasper.tagplugins.jstl.ForEach"%>
<%@page import="app.model.DBConnector"%>
<%@page import="app.cor.LeaveRequest"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="app.model.Employee"%>

<%
    // Check if the user is logged in by verifying the session
    Employee user = (Employee) session.getAttribute("user");
    if (user == null) {
        // If the user is not logged in, redirect to the login page
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- font-awesome CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- DataTables CSS -->
        <link href="https://cdn.datatables.net/1.11.0/css/dataTables.bootstrap5.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <style>

            /* Change the color of the active pill's text */
            .nav-pills .nav-link.active {
                background-color: #e3ebff;
                color: #2851ac;
            }
            textarea {
                resize: none;
            }
            textarea.ta10em {
                height: 10em;
            }
            .divider:after,
            .divider:before {
                content: "";
                flex: 1;
                height: 1px;
                background: #eee;
            }
            .h-custom {
                height: calc(100% - 73px);
            }
            @media (max-width: 450px) {
                .h-custom {
                    height: 100%;
                }
            }
        </style>
        <title>Dashboard</title>
        <!-- Your CSS and other header content goes here -->
    </head>
    <body>

        <% if (request.getParameter("leaveSuccess") != null) {
                int leaveSuccess = Integer.parseInt(request.getParameter("leaveSuccess"));
                String title = (leaveSuccess == 1) ? "Leave Request Sent!" : "Leave Request Failed!";
                String message = (leaveSuccess == 1) ? "Your leave request has been sent for review. We will process your request and inform you once it is approved. Thank you!" : "Oops! Something went wrong while processing your leave request. Please try again later or contact the HR department for assistance. We apologize for the inconvenience.";
                String type = (leaveSuccess == 1) ? "success" : "danger";
        %>
        <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="messageModalLabel"><p class="text-<%= type%>"><%= title%></p></h5>
                    </div>
                    <div class="modal-body"><%= message%></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-<%= type%>" data-bs-dismiss="modal" onclick="closeModalAndRedirect()">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>        

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <a class="navbar-brand" href="dashboard.jsp"><%= user.getEmployee_type()%> Dashboard</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>


                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="#"><i class="fa fa-user-circle fa-lg" aria-hidden="true"></i> <%= user.getFirstname()%> <%= user.getLastname()%> <span class="visually-hidden">(current)</span></a>
                        </li>
                    </ul>
                    <form class="d-flex" action="LogoutController" method="GET">
                        <button class="btn btn-outline-danger" type="submit">Logout</button>
                    </form>
                </div>
            </div>
        </nav>

        <!-- Your dashboard content goes here -->
        <%
            List<LeaveRequest> LeaveRequests = null;
            List<LeaveRequest> MyLeaveRequests = null;

            try {
                MyLeaveRequests = LeaveRequest.viewOwnLeaveRequests(user.getUsername(), user.getEmployee_type(), (DBConnector) session.getAttribute("dbCon"));
                LeaveRequests = LeaveRequest.viewLeaveRequests(user.getUsername(), user.getEmployee_type(), (DBConnector) session.getAttribute("dbCon"));
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            String userType = user.getEmployee_type();
        %>

        <div class="container">
            <% if (!"Manager".equals(userType)) { %>
            <!-- Pills navs -->
            <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="tab-login" data-bs-toggle="pill" href="#pills-login" role="tab" aria-controls="pills-login" aria-selected="true">Leave Requests</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="tab-register" data-bs-toggle="pill" href="#pills-register" role="tab" aria-controls="pills-register" aria-selected="false">Leave Request Form</a>
                </li>
            </ul>
            <!-- Pills navs -->
            <% } %>

            <!-- Pills content -->
            <div class="tab-content">
                <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login">
                    <div class="card mt-5">
                        <div class="card-body">
                            <h5 class="card-title">
                                <% if ("Employee".equals(userType)) { %>My<% } else { %>Received<% } %> Leave Requests
                            </h5>
                            <table id="leaveRequests" class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Username</th>
                                        <th>Reason</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Status</th>
                                            <% if (!"Employee".equals(userType)) { %>
                                        <th class="th-sm">Actions</th>
                                            <% } %>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (LeaveRequest leaveRequest : LeaveRequests) {%>
                                    <tr>
                                        <td><%= leaveRequest.getEmployee()%></td>
                                        <td><%= leaveRequest.getReason()%></td>
                                        <td><%= leaveRequest.getStartDate()%></td>
                                        <td><%= leaveRequest.getEndDate()%></td>
                                        <td><%= leaveRequest.getStatus()%></td>
                                        <% if ("Supervisor".equals(userType) || "Manager".equals(userType)) {%>
                                        <td>
                                            <form action="<%= userType%>Controller" method="POST" onsubmit="return confirm('Are you sure you want to proceed?');">
                                                <input type="hidden" name="id" value="<%= leaveRequest.getId()%>"/>
                                                <button type="submit" name="action" value="Accept" class="btn btn-success btn-sm" onclick="return confirm('Are you sure you want to accept this request?');">Accept</button>
                                                <button type="submit" name="action" value="Decline" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to decline this request?');">Decline</button>
                                            </form>

                                        </td>
                                        <% } %>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% if ("Supervisor".equals(userType)) { %>
                    <div class="card mt-5">
                        <div class="card-body">
                            <h5 class="card-title">
                                My Leave Requests
                            </h5>
                            <table id="myLeaveRequests" class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Username</th>
                                        <th>Reason</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (LeaveRequest myLeaveRequest : MyLeaveRequests) {%>
                                    <tr>
                                        <td><%= myLeaveRequest.getEmployee()%></td>
                                        <td><%= myLeaveRequest.getReason()%></td>
                                        <td><%= myLeaveRequest.getStartDate()%></td>
                                        <td><%= myLeaveRequest.getEndDate()%></td>
                                        <td><%= myLeaveRequest.getStatus()%></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% }%>
                </div>
                <div class="tab-pane fade" id="pills-register" role="tabpanel" aria-labelledby="tab-register">
                    <div class="card mt-5">
                        <div class="card-body">
                            <h5 class="card-title">Leave Request Form</h5>
                            <p class="card-text">Please enter correct details to request your leave...</p>
                            <form action="leaveRequestController" method="POST">
                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label for="username">Username</label>
                                        <input type="text" class="form-control" name="username" placeholder="Username" value="<%= user.getUsername()%>" readonly>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="startDate">Start Date</label>
                                        <input type="date" class="form-control" name="startDate" placeholder="Start Date" required>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="endDate">End Date</label>
                                        <input type="date" class="form-control" name="endDate" placeholder="End Date" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="reason">Reason</label>
                                    <textarea class="form-control" name="reason" rows="5" placeholder="Simply describe the reason..."></textarea>
                                </div>
                                <input type="hidden" name="usertype" value="<%= user.getEmployee_type()%>">
                                <button type="submit" class="btn btn-outline-primary btn-md mb-4" onclick="openModal()">Submit Leave Request</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS (requires jQuery) -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- DataTables JS -->
        <script src="https://cdn.datatables.net/1.11.0/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.0/js/dataTables.bootstrap5.min.js"></script>

        <script>
            // Function to initialize DataTable
            function initializeDataTable() {
                $('#leaveRequests').DataTable({
                    searching: true // Enable the search functionality
                });
            }
            function initializeMyLeaveRequestsTable() {
                $('#myLeaveRequests').DataTable({
                    searching: true // Enable the search functionality
                });
            }

            // Function to open the modal
            function openModal() {
                var myModal = new bootstrap.Modal(document.getElementById('messageModal'));

                // Add event listener to the modal backdrop click
                myModal._element.addEventListener('click', function (event) {
                    if (event.target === myModal._element) {
                        closeModalAndRedirect();
                    }
                });
                myModal.show();
            }

            // Function to close the modal
            function closeModalAndRedirect() {
                var myModal = new bootstrap.Modal(document.getElementById('messageModal'));
                myModal.hide();
                window.location.href = "dashboard.jsp";
            }

            $(document).ready(function () {
                initializeDataTable(); // Initialize DataTable when the document is ready
            });

            $(document).ready(function () {
                initializeMyLeaveRequestsTable(); // Initialize DataTable when the document is ready
            });

            window.onload = function () {
                openModal();
            };
        </script>

    </body>
</html>
