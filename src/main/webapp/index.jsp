<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management System</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            text-align: center;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            background: #ffffff;
            padding: 20px;
            width: 50%;
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
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border: none;
        }
        button:hover {
            background-color: #0056b3;
        }
        ul {
            list-style: none;
            padding: 0;
        }
        li {
            background: #e9ecef;
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
        <h2>Library Management System</h2>
        <form method="post">
            <input type="text" name="bookTitle" placeholder="Enter Book Title" required>
            <input type="text" name="author" placeholder="Enter Author" required>
            <button type="submit">Add Book</button>
        </form>
        
        <% 
            class Book {
                String title;
                String author;
                Book(String title, String author) {
                    this.title = title;
                    this.author = author;
                }
            }
            
            ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("books");
            if (books == null) {
                books = new ArrayList<>();
            }
            String newTitle = request.getParameter("bookTitle");
            String newAuthor = request.getParameter("author");
            if (newTitle != null && newAuthor != null && !newTitle.trim().isEmpty() && !newAuthor.trim().isEmpty()) {
                books.add(new Book(newTitle, newAuthor));
                session.setAttribute("books", books);
            }
            String deleteTitle = request.getParameter("delete");
            if (deleteTitle != null) {
                books.removeIf(book -> book.title.equals(deleteTitle));
                session.setAttribute("books", books);
            }
            String updateOldTitle = request.getParameter("updateOld");
            String updateNewTitle = request.getParameter("updateNew");
            String updateNewAuthor = request.getParameter("updateNewAuthor");
            if (updateOldTitle != null && updateNewTitle != null && updateNewAuthor != null) {
                for (Book book : books) {
                    if (book.title.equals(updateOldTitle)) {
                        book.title = updateNewTitle;
                        book.author = updateNewAuthor;
                        session.setAttribute("books", books);
                        break;
                    }
                }
            }
        %>
        
        <ul>
            <% for (Book book : books) { %>
                <li>
                    <%= book.title %> by <%= book.author %>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="updateOld" value="<%= book.title %>">
                        <input type="text" name="updateNew" placeholder="New Title" required>
                        <input type="text" name="updateNewAuthor" placeholder="New Author" required>
                        <button type="submit" class="update">Update</button>
                    </form>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="delete" value="<%= book.title %>">
                        <button type="submit" class="delete">Delete</button>
                    </form>
                </li>
            <% } %>
        </ul>
    </div>
</body>
</html>
