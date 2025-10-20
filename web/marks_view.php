<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
   <!--  <style>
    
    @media (min-width: 768px) {
        .grid-1-2 { grid-template-columns: 1fr 2fr; }
    }
    </style> -->
    <title>attendance</title>
</head>
<body class="bg-gray-100">
    <div class="max-w-6xl mx-auto mt-8 grid grid-cols-1 md:[grid-template-columns:1fr_2fr] grid-1-2 gap-6 items-start p-6">
    <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF'] ?? '', ENT_QUOTES, 'UTF-8'); ?>" method="GET" class="flex flex-col max-w-md w-full p-6 border rounded-lg shadow-lg bg-white">
        <label for="reg_no">Registration Number:</label>
        <input type="text" id="reg_no" name="reg_no" required class="mb-4 p-2 border rounded" placeholder="Enter Registration Number">
        

        <input type="submit" value="Submit" class="bg-blue-500 text-white p-2 rounded hover:bg-blue-600 cursor-pointer">
    </form>

    <div class="bg-white p-6 border rounded-lg shadow overflow-auto">
        <?php
$reg_no = isset($_GET['reg_no']) ? $_GET['reg_no'] : '';

$conn = mysqli_connect("localhost", "root", "1234", "student_management","3309");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$sql = "SELECT * FROM mark WHERE ST_Id='$reg_no'";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    $title = 'MARKS RECORD';

    echo "<h1 class='text-2xl font-bold mb-4 mt-10 text-center'>" . htmlspecialchars($title ?? '', ENT_QUOTES, 'UTF-8') . "</h1>";

    echo "<table cellspacing='0' cellpadding='10' border='1' class='table-auto w-full mt-6 border border-gray-300 border-collapse bg-white'>
    <thead>
    <tr class='bg-gray-100'>
   
    <th class='border px-4 py-2 border-gray-300'>Course_code</th>
    <th class='border px-4 py-2 border-gray-300'>Quiz_01</th>
    <th class='border px-4 py-2 border-gray-300'>Quiz_02</th>
    <th class='border px-4 py-2 border-gray-300'>Quiz_03</th>
    <th class='border px-4 py-2 border-gray-300'>Assessment_01</th>
    <th class='border px-4 py-2 border-gray-300'>Assessment_02</th>
    <th class='border px-4 py-2 border-gray-300'>Mid_Practical</th>
    <th class='border px-4 py-2 border-gray-300'>Final_Theory</th>
    <th class='border px-4 py-2 border-gray-300'>Final_Practical</th>
    </tr>
    </thead>
    <tbody>";
    while($row = mysqli_fetch_assoc($result)) {
        echo "<tr>";

    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Course_code'] ?? '', ENT_QUOTES, 'UTF-8')."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Quiz_01'] ?? '', ENT_QUOTES, 'UTF-8')."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Quiz_02'] ?? '', ENT_QUOTES, 'UTF-8')."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Quiz_03'] ?? '', ENT_QUOTES, 'UTF-8')."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Assessment_01'] ?? '', ENT_QUOTES, 'UTF-8')."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Assessment_02'] ?? '', ENT_QUOTES, 'UTF-8')."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Mid_Practical'] ?? '', ENT_QUOTES, 'UTF-8')."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Final_Theory'] ?? '', ENT_QUOTES, 'UTF-8')."</td>";
    echo "<td class='border px-4 py-2 border-gray-300'>".htmlspecialchars($row['Final_Practical'] ?? '', ENT_QUOTES, 'UTF-8')."</td>";

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


