$path = "training/"
$statsPath = "stats/"
$testsPath = "test/"

$extension = ".txt"

$methods = [
	 "euclidean", 
	 "manhattan", 
	 "maximum",
	 "cosine"]

$files = [
	 "english1",
         "english2",
         "english3",
         "english4",
	 "finnish1",
         "finnish2",
         "german1",
         "german2",
         "german3",
         "german4",
         "italian1",
         "italian2",
         "polish1",
         "polish2",
         "polish3",
         "spanish1",
         "spanish2"]

$encodings = {
	 "english1" => "us-ascii",
         "english2" => "us-ascii",
         "english3" => "us-ascii",
         "english4" => "iso-8859-1",
	 "finnish1" => "iso-8859-1",
         "finnish2" => "iso-8859-1",
         "german1"  => "iso-8859-1",
         "german2"  => "iso-8859-1",
         "german3"  => "iso-8859-1",
         "german4"  => "iso-8859-1",
         "italian1" => "utf-8",
         "italian2" => "utf-8",
         "polish1"  => "ISO-8859-2",
         "polish2"  => "ISO-8859-2",
         "polish3"  => "ISO-8859-2",
         "spanish1" => "iso-8859-1",
         "spanish2" => "iso-8859-1"}