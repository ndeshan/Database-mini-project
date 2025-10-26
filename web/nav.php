    <?php
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    $is_admin = !empty($_SESSION['admin_logged_in']) && $_SESSION['admin_logged_in'] === true;
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
        
           <nav class="bg-gray-800 p-4 text-white">
        <ul class="flex space-x-4">
            <li><a href="index.php">Home</a></li>
            
            <?php if ($is_admin): ?>
            <li>
                <select name="attendance" id="attendance" class="bg-gray-700 border border-gray-600 rounded p-2">
                    <option value="" disabled selected>Attendance Options</option>
                    <option value="attendance">Attendance</option>
                    <option value="attendance_eligibility">Attendance Eligibility</option>
                </select>
            </li>
            <li>
                <select name="marks" id="marks" class="marks bg-gray-700 border border-gray-600 rounded p-2">
                    <option value="" disabled selected>Marks Options</option>
                    <option value="marks_view">Marks View</option>
                </select>
            </li>
            <li>
                <input type="submit" value="logout" onclick="window.location.href='logout.php'" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
            </li>
            <?php endif; ?>
        </ul>       
    </nav>

   <script src="script.js"></script> 
    </body>
    </html>
