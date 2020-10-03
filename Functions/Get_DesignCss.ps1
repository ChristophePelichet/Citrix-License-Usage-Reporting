# Creating head style
$Head = @"

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  
<style>
  body {
    font-family: "Arial";
    font-size: 8pt;
    color: #4C607B;
    }
  th, td { 
    border: 1px solid #e57300;
    border-collapse: collapse;
    padding: 5px;
    }
  th {
    font-size: 1.2em;
    text-align: left;
    background-color: #003366;
    color: #ffffff;
    }
  td {
    color: #000000;
    }
.blank_line { 
    border: 1px solid #ffffff;
    border-collapse: collapse;
    padding: 5px;
    }
.green_answer {
    background-color: #89D995;
    font-weight:bold;
    text-align: center;
}
.red_answer {
    background-color: #D67A7C;
    font-weight: bold;
    text-align: center;

}
.orange_answer {
    background-color: #D9A33F;
    font-weight: bold;
    text-align: center;

}

  .even { background-color: #ffffff; }
  .odd { background-color: #bfbfbf; }
</style>
</head>
<body>
  
"@