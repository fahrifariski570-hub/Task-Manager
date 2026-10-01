<?php

$con = mysqli_connect(
    "localhost",
    "root",
    "",
    "task_manager"
);

$sql = "SELECT * FROM tasks";
$result = mysqli_query($con, $sql);
$data = mysqli_fetch_all($result, MYSQLI_ASSOC);
echo(json_encode($data));
?>