
<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
		$uuid = $_GET[uuid];
		$limit = $_GET[limit];
		if (!$limit)
			$limit = 30;
		$offset = $_GET[offset];
		if (!$offset) 
			$offset = 0;
		
		
		$result = sql_query("select * from dongal_like where mb_uuid = '$uuid' ORDER BY update_time desc LIMIT $offset, $limit");
		
		
		$cnt = 0;
		while ($row=sql_fetch_array($result)) {
			$row2 = sql_fetch("select * from g4_dongal_board_$row[bo_table] where id = '$row[wr_id]'");
			$row3 = sql_fetch("select * from dongal_boards where board_name = '$row[bo_table]'");
			$is_like = "0";
			$row4 = sql_fetch("select like_no from dongal_like where mb_uuid='$uuid' and wr_id='$row[wr_id]' and  bo_table='$row[bo_table]'");
			if ($row4) 
				$is_like = "1";
				
			$results[$cnt++] = array(
				"id"=>$row2[id],
				"wr_title"=>$row2[wr_title],
				"wr_link"=>$row2[wr_link],
				"wr_writer"=>$row2[wr_writer],
				"wr_hit"=>$row2[wr_hit],
				"wr_created_on"=>$row2[wr_created_on],
				"board_title"=>$row3[board_title],
				"board_name"=>$row3[board_name],
				"board_color"=>$row3[board_color],
				"is_like"=>$is_like
			);
		}
		
		

	} else if($_SERVER['REQUEST_METHOD'] == "POST"){	
		$results = array("results","error");
	} else{
		$results = array("results","error");
	}
		
		
	
	
	$results = json_encode($results); 	
	echo $results;
	
?>
