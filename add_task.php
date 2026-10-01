<?php

header("Content-Type: application/json");

$con = mysqli_connect(
    "localhost",
    "root",
    "",
    "task_manager"
);

if (!$con) {
    echo json_encode([
        "success" => false,
        "error" => mysqli_connect_error()
    ]);
    exit;
}

$title = $_POST["title"] ?? "";
$description = $_POST["description"] ?? "";

$sql = "INSERT INTO tasks (title, description, is_complated)
        VALUES ('$title', '$description', 0)";

$result = mysqli_query($con, $sql);

if ($result) {
    echo json_encode([
        "success" => true,
        "message" => "Task berhasil ditambahkan",
        "id" => mysqli_insert_id($con)
    ]);
} else {
    echo json_encode([
        "success" => false,
        "error" => mysqli_error($con)
    ]);
}

mysqli_close($con);
?>