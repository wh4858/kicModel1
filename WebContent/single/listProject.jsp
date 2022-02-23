<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
.pagination {
  margin-top:50px;
  display: flex;
  justify-content: center;
}

.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
}
</style>
</head>
<body>

<h1 style="text-align: center;">게시판 리스트</h1>
<p style="text-align: right;">글개수 : 16</p>
<table id="customers">
  <tr id="head">
    <th style="width:10%;">번호</th>
    <th style="width:40%;">제목</th>
    <th style="width:12.5%;">작성자</th>
    <th style="width:12.5%;">등록일</th>
    <th style="width:12.5%;">파일</th>
    <th style="width:12.5%;">조회수</th>
  </tr>
  <tr>
    <td>1</td>
    <td>Oracle</td>
    <td>Maria Anders</td>
    <td>2022/02/12</td>
    <td>test.txt</td>
    <td>35</td>
  </tr>
  <tr>
    <td>2</td>
    <td>SQL</td>
    <td>Christina Berglund</td>
    <td>2022/01/15</td>
    <td>down.jpg</td>
    <td>74</td>
  </tr>
  <tr>
    <td>3</td>
    <td>Java</td>
    <td>Francisco Chang</td>
    <td>2021/12/27</td>
    <td>null</td>
    <td>65</td>
  </tr>
  <tr>
    <td>4</td>
    <td>Jsp</td>
    <td>Roland Mendel</td>
    <td>2021/12/07</td>
    <td>null</td>
    <td>105</td>
  </tr>
</table>
<div class="pagination">
  <a href="#">&laquo;</a>
  <a href="#">1</a>
  <a href="#">2</a>
  <a href="#">3</a>
  <a href="#">4</a>
  <a href="#">&raquo;</a>
</div>
</body>
</html>


