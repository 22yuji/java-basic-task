<%@page import="util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

    //定義
    int totalNum;  //石の数
    int i = 0;  //プレイヤー順番
    int pNum = 0;  //どの数字を押したか
    String[] playername = {"A", "B"};  // プレイヤー用の変数
    String player = null;  //プレイヤー
    String pickNum = request.getParameter("num");  //取る石の数
    String drawStone = null;  //描画する石の変数
    
  	//初期化
    if (session.getAttribute("init") == null){
        session.setAttribute("init", 1);
        session.setAttribute("totalNum", 25);
    	session.setAttribute("turn", 0);
    }
    
    //代入
    i = (int)session.getAttribute("turn");
    totalNum = (int)session.getAttribute("totalNum");
    
    //プレイヤーを切り替える
    if(!Utility.isNullOrEmpty(pickNum)){
    	pNum = Integer.parseInt(pickNum);
    	
    	if(i == 0){
    		i = 1;
    	}else if(i == 1){
    		i = 0;
    	}
    }
    
    //石を引く
    totalNum -= pNum;
    player = playername[i];
    
    drawStone = Utility.getStoneDisplayHtml(totalNum);
    
    //更新
    session.setAttribute("totalNum", totalNum);
    session.setAttribute("turn", i);
    session.setAttribute("player", player);
    
    // 残数が0以下の場合、結果ページへ遷移
    if(totalNum <= 0){
    	session.setAttribute("winner", playername[i]);
    	session.setAttribute("init", null);
    	response.sendRedirect("finish.jsp");
    }
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Java基礎課題</title>
		<link href="css/styles.css" rel="stylesheet">
	</head>
	
	<body>
	  <h1>石取りゲーム</h1>
	
	  <div class="info">
	    <h2>
	      残り：<%= totalNum %>個
	    </h2>
	    <p class="stone">
	      <%=
	          // todo:このprint分は仮の処理。実装が完了したら削除する。
	          // 表示する文字列("●●～")をメソッドを使い取得し、取得した文字列を表示する
	          //out.println("●●●●●●●●●●<br>●●●●●●●●●●<br>●●●●●");
	      	drawStone
	      %>
	    </p>
	  </div>
	  <div class="info">
	    <h2>
	      プレイヤー<%= player %>の番
	    </h2>
	
	    <form action="play.jsp">
	      <p>
	        石を
	        <input type="number" name="num" min="1" max="3">
	        個取る<br> ※1度に3個取れます。
	      </p>
	      <button class="btn" type="submit">決定</button>
	    </form>
	  </div>
	</body>
</html>