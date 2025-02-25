<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>To-Do List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 20px;
        }
        h2 {
            color: #333;
        }
        form {
            margin-bottom: 15px;
        }
        input[type="text"] {
            padding: 10px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #28a745;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            background: white;
            margin: 10px auto;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        form[style="display:inline;"] button {
            background-color: #dc3545;
        }
        form[style="display:inline;"] button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <h2>To-Do List</h2>
    
    <form action="TodoServlet" method="post">
        <input type="text" name="task" placeholder="Enter a new task" required>
        <input type="hidden" name="action" value="add">
        <button type="submit">Add Task</button>
    </form>
    
    <ul>
        <%@ page import="java.util.List" %>
        <%@ page import="javax.servlet.http.HttpSession" %>
        <% List<String> tasks = (List<String>) session.getAttribute("tasks"); %>
        <% if (tasks != null) { %>
            <% for (int i = 0; i < tasks.size(); i++) { %>
                <li>
                    <%= tasks.get(i) %> 
                    <form action="TodoServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="index" value="<%= i %>">
                        <button type="submit">Delete</button>
                    </form>
                    
                    <form action="TodoServlet" method="post" style="display:inline;">
                        <input type="text" name="updatedTask" placeholder="Update task" required>
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="index" value="<%= i %>">
                        <button type="submit">Update</button>
                    </form>
                </li>
            <% } %>
        <% } %>
    </ul>
</body>
</html>
