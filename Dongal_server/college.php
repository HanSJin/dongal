
<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
		$uuid = $_GET[uuid];
		
		$result = sql_query("select * from dongal_boards where board_type='college'");
		$cnt = 0;
		while ($row=sql_fetch_array($result)) {
			$results[$cnt++] = array(
				"board_id"=>$row[board_id],
				"board_name"=>$row[board_name],
				"board_title"=>$row[board_title]
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
