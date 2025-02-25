<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Retrieve the task list from session
    ArrayList<String> tasks = (ArrayList<String>) session.getAttribute("tasks");
    if (tasks == null) {
        tasks = new ArrayList<>();
        session.setAttribute("tasks", tasks);
    }

    // Handle task addition
    String newTask = request.getParameter("task");
    if (newTask != null && !newTask.trim().isEmpty()) {
        tasks.add(newTask);
    }

    // Handle task deletion
    String deleteIndexStr = request.getParameter("deleteIndex");
    if (deleteIndexStr != null) {
        int deleteIndex = Integer.parseInt(deleteIndexStr);
        if (deleteIndex >= 0 && deleteIndex < tasks.size()) {
            tasks.remove(deleteIndex);
        }
    }

    // Handle task update
    String updateIndexStr = request.getParameter("updateIndex");
    String updatedTask = request.getParameter("updatedTask");
    if (updateIndexStr != null && updatedTask != null) {
        int updateIndex = Integer.parseInt(updateIndexStr);
        if (updateIndex >= 0 && updateIndex < tasks.size() && !updatedTask.trim().isEmpty()) {
            tasks.set(updateIndex, updatedTask);
        }
    }
%>

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
        .delete-btn {
            background-color: #dc3545;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <h2>To-Do List</h2>
    
    <!-- Form to Add Task -->
    <form method="post">
        <input type="text" name="task" placeholder="Enter a new task" required>
        <button type="submit">Add Task</button>
    </form>
    
    <ul>
        <% for (int i = 0; i < tasks.size(); i++) { %>
            <li>
                <%= tasks.get(i) %>
                
                <!-- Delete Button -->
                <form method="post" style="display:inline;">
                    <input type="hidden" name="deleteIndex" value="<%= i %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
                
                <!-- Update Form -->
                <form method="post" style="display:inline;">
                    <input type="text" name="updatedTask" placeholder="Update task" required>
                    <input type="hidden" name="updateIndex" value="<%= i %>">
                    <button type="submit">Update</button>
                </form>
            </li>
        <% } %>
    </ul>
</body>
</html>
