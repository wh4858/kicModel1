package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcConnection {

	public static Connection getConnection() {
//		Connection : oracle server에 연결해서 sql에 전달해주는 객체
//		jdbc:oracle:thin:@localhost:1521:xe   ==>   오라클 연결 url
//		username = userid  ,  password = 6998
		Connection con = null;
		String url ="jdbc:oracle:thin:@localhost:1521:xe";
		String userId = "kic";
		String pwd = "6998";
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			con = DriverManager.
					getConnection(url,userId,pwd);
			System.out.println("ok db");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("error db");
		}
		return con;
	}
	
	public static void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if(con != null) {
				con.commit();
				con.close();
			}
			
			if(ps != null)
				ps.close();
			
			if(rs != null)
				rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

