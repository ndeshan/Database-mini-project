        document.getElementById("attendance").addEventListener("change", function () {
            if (this.value === "attendance") {
                window.location.href = "attendance.php";
            } else if (this.value === "attendance_eligibility") {
                window.location.href = "attendance_eligibility.php";
            }
        });

        document.getElementById("marks").addEventListener("change", function () {
            if (this.value === "marks_view") {
                window.location.href = "marks_view.php";
            }
        });