<?php
$conn = mysqli_connect("localhost", "root", "1234", "student_management","3309");

/* if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}else{
    echo "connected database successfully";
} */

$sql = "SELECT * FROM student";
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
    echo"<h1>STUDEBT TABLE</h2>";
    echo "<table border='1' cellspacing='0' cellpadding='10'>
    <tr>
    <th>Registration_No</th>
    <th>Fname</th>
    <th>Lname</th>
    <th>Year</th>
    <th>Department</th>
    <th>Batch</th>
    <th>Status</th>

    </tr>";
    while($row = mysqli_fetch_assoc($result)) {
        echo "<tr>";
        echo "<td>".$row['Registration_No']."</td>";
        echo "<td>".$row['Fname']."</td>";
        echo "<td>".$row['Lname']."</td>";
        echo "<td>".$row['Year']."</td>";
        echo "<td>".$row['Department']."</td>";
        echo "<td>".$row['Batch']."</td>";
        echo "<td>".$row['Status']."</td>";
        echo "</tr>";
    }
    echo"</table>";
} else {
    echo "0 results";
}
mysqli_close($conn);
?>