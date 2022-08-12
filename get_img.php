<?php

$link = mysqli_connect('103.212.181.59', 'adminkaiser', 'a4521050001', "agriser_data","3888");


    if (!$link) {
    echo "Database connection faild";
}

    $getpic = $link->query("SELECT * FROM tb_user");
    $list = array();

    while ($rowdata = $getpic->fetch_assoc()) {
        $list[] = $rowdata;
    }

    return json_encode($list);
    
?>