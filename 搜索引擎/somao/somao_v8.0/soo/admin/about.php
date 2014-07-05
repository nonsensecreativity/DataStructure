<?php
require "global.php";
headhtml();
?>
<div class="nav" style="display:;"><a href="?action=addform">添加</a></div>
<script language="javascript">
   function checkform()
   {
         if(document.pageform.title.value==""){alert("标题不能为空!");document.pageform.title.focus();return false;}
		 if(document.pageform.filename.value==""){alert("文件名称不能为空!");document.pageform.filename.focus();return false;}
   }
</script>
<?php
$action=$_GET["action"];
switch ($action)
{
    case "saveform":
    saveform();
    break;

    case "addform":
	addform($action);
	break;
	
	case "modify":
	addform($action);
	break;

	case "del":
	     $about_id=intval($_GET["about_id"]);
		 $db->query("delete from ve123_about where about_id='".$about_id."'");
	break;
}	
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">

  <tr>
    <th width="100">ID</th>
    <th width="100">单页标题</th>
    <th>文件名称</th>
    <th>是否显示</th>
    <th>地址</th>
    <th width="80">操作</th>
  </tr>
  <?php
  $result=$db->query("select * from ve123_about order by about_id desc");
  while ($rs=$db->fetch_array($result))
  {
  ?>
  <tr>
    <td><?php echo $rs["about_id"];?></td>
    <td><?php echo stripslashes($rs["title"]);?></td>
    <td><?php echo $rs["filename"];?></td>
    <td><?php if($rs["is_show"]){echo "√";}else{echo "<font color=\"red\">×</font>";}?></td>
    <td><?php echo "<a target=\"_blank\" href=\"".$site["url"]."/a/".$rs["filename"].".html\" title=\"查看".$rs["title"]."\">".$rs["filename"].".html";?></a></td>
    <td><a href="?action=modify&amp;about_id=<?php echo $rs["about_id"]?>">修改</a>
	<a href="?action=del&about_id=<?php echo $rs["about_id"];?>" onclick="if(!confirm('确认删除码?')) return false;">删除</a>	</td>
  </tr>
  <?php
  }
  ?>
</table>

<?php
function addform($do_action)
{
global $db;
  if ($do_action=="modify")
  {
      $about_id=$_GET["about_id"];
	  $sql="select * from ve123_about where about_id='$about_id'";
	  $rs=$db->get_one($sql);
	  $title=$rs["title"];
	  $content=$rs["content"];
	  $filename=$rs["filename"];
	  $url=$rs["url"];
	  $sortid=$rs["sortid"];
	  $is_show=$rs["is_show"];
	  $btn_txt="确定修改";
  }
  else
  {
     $btn_txt="确定提交";
  }
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
<form id="pageform" name="pageform" method="post" action="?action=saveform" onsubmit="return checkform()">
  <tr>
    <td width="100">单页标题:</td>
    <td>
      <input name="title" type="text" value="<?php echo $title?>" size="80"/>    </td>
  </tr>
  <tr>
    <td>文件名称:</td>
    <td><input type="text" name="filename" value="<?php echo $filename;?>"/></td>
  </tr>
  <tr>
    <td>URL:</td>
    <td><input name="url" type="text" size="80"  value="<?php echo $url;?>"/>
      (如果要跳向URL网址,请输入网址,否则请留空)</td>
  </tr>
  <tr>
    <td>排序:</td>
    <td><input type="text" name="sortid" value="<?php echo $sortid?>"/></td>
  </tr>
  <tr>
    <td>是否显示:</td>
    <td><input name="is_show" type="checkbox" value="1" <?php if($is_show){echo "checked=\"checked\"";}?>/></td>
  </tr>
  <tr>
    <td>单页内容:</td>
    <td><textarea name="content" id="content" cols="50" rows="15" style="width:100%;"><?php echo $content?></textarea></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
	<input type="hidden" name="about_id" value="<?php echo $about_id?>">
	<input type="hidden" name="do_action" value="<?php echo $do_action?>">
	<input type="submit" name="Submit" value="<?php echo $btn_txt?>" />	</td>
  </tr>
  </form>
</table>
<?php
}
?>

<?php
function saveform()
{
global $db,$config;
   $title=addslashes(HtmlReplace(trim($_POST["title"])));
   $content=trim($_POST["content"]);
   $filename=HtmlReplace(trim($_POST["filename"]));
   $url=HtmlReplace(trim($_POST["url"]));
   $sortid=intval($_POST["sortid"]);
   $about_id=intval($_POST["about_id"]);
   $do_action=HtmlReplace($_POST["do_action"]);
   $is_show=$_POST["is_show"];
ob_start();
require "temp/a.php";
$str=ob_get_contents();
ob_end_clean();
$str=stripslashes($str);
file_put_contents("../a/".$filename.".html", $str);
   if ($do_action=="modify")
   {
     $array=array('title'=>$title,'content'=>$content,'url'=>$url,'filename'=>$filename,'sortid'=>$sortid,'is_show'=>$is_show);
	 $db->update("ve123_about",$array,"about_id='$about_id'");
	 jsalert("修改成功");
   }
   else
   {
     $array=array('title'=>$title,'content'=>$content,'url'=>$url,'filename'=>$filename,'sortid'=>$sortid,'is_show'=>$is_show);
	 $db->insert("ve123_about",$array);
     jsalert("提交成功");
   }
}
?>

