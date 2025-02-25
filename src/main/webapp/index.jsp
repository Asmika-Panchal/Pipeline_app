<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP To-Do List</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            text-align: center;
            background-color: #f0f8ff;
            margin: 0;
            padding: 20px;
        }
        .container {
            background: #ffffff;
            padding: 20px;
            width: 40%;
            margin: auto;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
        }
        input, button {
            padding: 10px;
            margin: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #28a745;
            color: white;
            cursor: pointer;
            border: none;
        }
        button:hover {
            background-color: #218838;
        }
        ul {
            list-style: none;
            padding: 0;
        }
        li {
            background: #e0f7fa;
            padding: 10px;
            margin: 5px;
            display: flex;
            justify-content: space-between;
            border-radius: 5px;
            align-items: center;
        }
        .delete, .update {
            background: #dc3545;
            color: white;
            border: none;
            padding: 5px;
            cursor: pointer;
            border-radius: 5px;
        }
        .delete:hover {
            background: #c82333;
        }
        .update {
            background: #ffc107;
            margin-right: 5px;
        }
        .update:hover {
            background: #e0a800;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>JSP To-Do List</h2>
        <form method="post">
            <input type="text" name="task" placeholder="Enter a task" required>
            <button type="submit">Add Task</button>
        </form>
        
        <% 
            ArrayList<String> tasks = (ArrayList<String>) session.getAttribute("tasks");
            if (tasks == null) {
                tasks = new ArrayList<>();
            }
            String newTask = request.getParameter("task");
            if (newTask != null && !newTask.trim().isEmpty()) {
                tasks.add(newTask);
                session.setAttribute("tasks", tasks);
            }
            String deleteTask = request.getParameter("delete");
            if (deleteTask != null) {
                tasks.remove(deleteTask);
                session.setAttribute("tasks", tasks);
            }
            String updateOldTask = request.getParameter("updateOld");
            String updateNewTask = request.getParameter("updateNew");
            if (updateOldTask != null && updateNewTask != null && !updateNewTask.trim().isEmpty()) {
                int index = tasks.indexOf(updateOldTask);
                if (index != -1) {
                    tasks.set(index, updateNewTask);
                    session.setAttribute("tasks", tasks);
                }
            }
        %>
        
        <ul>
            <% for (String task : tasks) { %>
                <li>
                    <%= task %>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="updateOld" value="<%= task %>">
                        <input type="text" name="updateNew" placeholder="Edit task" required>
                        <button type="submit" class="update">Update</button>
                    </form>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="delete" value="<%= task %>">
                        <button type="submit" class="delete">Delete</button>
                    </form>
                </li>
            <% } %>
        </ul>
    </div>
</body>
</html>
