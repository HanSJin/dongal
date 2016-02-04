
<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
		$uuid = $_GET[uuid];
		$result = sql_query("select * from dongal_keyword where mb_uuid='$uuid'");
		$cnt = 0;

		while ($row=sql_fetch_array($result)) {
			$results[$cnt++] = array(
				"keyword_no"=>$row[keyword_no],
				"keyword_txt"=>$row[keyword_txt]
			);
		}
		
	} else if($_SERVER['REQUEST_METHOD'] == "POST"){
		$uuid = $_POST[uuid];	
		$keyword = $_POST[keyword];	

		$result = sql_query("insert into dongal_keyword (keyword_txt, mb_uuid) values ('$keyword', '$uuid')");
		$results = array("results","success");
		
	} else{
		$results = array("results","error");
	}
		
		
	
	

	$results = json_encode($results); 	
	echo $results;
	
?>
