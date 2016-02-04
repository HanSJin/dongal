<meta charset="UTF-8">

<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
	
		$result = sql_query("select * from g4_dongal_board_arts"); //질의.
		
		$cnt = 0;
		while ($row=sql_fetch_array($result)) {			
			$results[$cnt++] = array(
				"id"=>$row[id],
				"wr_title"=>$row[wr_title],
				"wr_link"=>$row[wr_link],
				"wr_writer"=>$row[wr_writer],
				"wr_created_on"=>$row[wr_created_on]
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
