<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>attendance</title>
</head>
<body class="bg-gray-100">
    <?php include 'nav.php' ?>



    <div class="max-w-6xl mx-auto mt-8 grid grid-cols-1 md:grid-cols-2 gap-6 items-start p-6">
    <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="GET" class="flex flex-col max-w-md w-full p-6 border rounded-lg shadow-lg bg-white">
        <label for="reg_no">Registration Number:</label>
        <input type="text" id="reg_no" name="reg_no" required class="mb-4 p-2 border rounded" placeholder="Enter Registration Number">
        <label for="course_code">Course Code:</label>
        <input type="text" id="course_code" name="course_code" class="mb-4 p-2 border rounded" placeholder="Enter Course Code">

        <input type="submit" value="Submit" class="bg-blue-500 text-white p-2 rounded hover:bg-blue-600 cursor-pointer">
    </form>

    <div class="bg-white p-6 border rounded-lg shadow overflow-auto">
        <?php
$reg_no = isset($_GET['reg_no']) ? $_GET['reg_no'] : '';
$course_code = isset($_GET['course_code']) ? $_GET['course_code'] : '';
$conn = mysqli_connect("localhost", "root", "1234", "student_management","3309");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$sql = "SELECT * FROM attendance WHERE ST_Id='$reg_no' AND Course_Code='$course_code'";
$result = mysqli_query($conn, $sql);
$c_name = '';
if (!empty($course_code)) {
    $sql2 = "SELECT Name FROM course_unit WHERE Course_Code='$course_code'";
    $result2 = mysqli_query($conn, $sql2);
    $row2 = $result2 ? mysqli_fetch_assoc($result2) : null;
    if ($row2 && isset($row2['Name'])) {
        $c_name = $row2['Name'];
    }
}

if (mysqli_num_rows($result) > 0) {
    $title = 'ATTENDANCE RECORD';
    if ($c_name !== '') {
        $title .= ' FOR ' . strtoupper($c_name);
    }
    echo "<h1 class='text-2xl font-bold mb-4 mt-10 text-center'>" . htmlspecialchars($title) . "</h1>";

    echo "<table cellspacing='0' cellpadding='10' border='1' class='table-auto w-full mt-6 border border-gray-300 border-collapse bg-white'>
    <thead>
    <tr class='bg-gray-100'>
   
    <th class='border px-4 py-2 border-gray-300'>Session_Date</th>
    <th class='border px-4 py-2 border-gray-300'>Session_Type</th>
    <th class='border px-4 py-2 border-gray-300'>Status</th>
    </tr>
    </thead>
    <tbody>";
    while($row = mysqli_fetch_assoc($result)) {
        echo "<tr>";
        
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Session_Date'])."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Session_Type'])."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Status'])."</td>";
        echo "</tr>";
    }
    echo"</tbody></table>";
} else {
    echo "<p class='text-center mt-6'>0 results</p>";
}
mysqli_close($conn);
?>
    </div>
    </div>
</body>
</html>


