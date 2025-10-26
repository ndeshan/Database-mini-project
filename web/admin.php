<?php
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = isset($_POST['name']) ? trim($_POST['name']) : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';

    if ($name === 'admins_stdb' && $password === '123') {

        $conn = mysqli_connect("localhost","admins_stdb","123","student_management","3309");

        if (!$conn) {//check connection
            die("Connection failed: " . mysqli_connect_error());
        }

        
        session_regenerate_id(true);
        $_SESSION['admin_logged_in'] = true;
        $_SESSION['admin_name'] = $name;

        
        mysqli_close($conn);

        
        header('Location: index.php');
        exit();
    } else {
        echo "<script>alert('Invalid credentials. Please try again.');</script>";
    }
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <script src="https://cdn.tailwindcss.com"></script>
    <title>Document</title>
</head>
<body>
    <div class="max-w-md mx-auto mt-20 p-6 border rounded-lg shadow-lg bg-white">
        <h1 class="text-2xl font-bold text-center">Admin Login</h1>
        <form action="<?PHP echo $_SERVER['PHP_SELF']; ?>" method="POST">
            <input type="text" name = "name" class="border border-gray-300 p-2 rounded w-full mt-4" placeholder="Enter Name">
            <input type="password" name = "password" class="border border-gray-300 p-2 rounded w-full mt-4" placeholder="Enter Password">
            <input type="submit" value="Login" class="bg-blue-500 text-white p-2 rounded hover:bg-blue-600 cursor-pointer mt-4 justify-center w-full">
        </form>
</body>
</html>