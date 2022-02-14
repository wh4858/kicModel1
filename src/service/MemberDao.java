package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import model.Member;
import util.JdbcConnection;


public class MemberDao {
	
	public int insertMember(HttpServletRequest request) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "insert into member values(?,?,?,?,?,?,?)";
		
		try {
			ps = con.prepareStatement(sql);
			//  ?,?,?를 채워주는 메서드
			ps.setString(1, request.getParameter("id"));
			ps.setString(2, request.getParameter("pass"));
			ps.setString(3, request.getParameter("name"));
			ps.setInt(4, Integer.parseInt((request.getParameter("gender"))));
			ps.setString(5, request.getParameter("tel"));
			ps.setString(6, request.getParameter("email"));
			ps.setString(7, request.getParameter("picture"));
			// ?를 채운후 전송해주는 메서드 에러가 없으면 ps를 반환
			return ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, null);
		}
		return 0;
	}
	
	public Member selectOne(String id) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from member where id = ?";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			// sql문을이용하여 쿼리문을 실행하여 나온값을 저장
			rs = ps.executeQuery();
			// 지금은 row가 하나여서 if하지만 보통은 데이터가 많아 while로 한다
			if(rs.next()) {
				Member m = new Member(
					rs.getString("id"),
					rs.getString("pass"),
					rs.getString("name"),
					rs.getInt("gender"),
					rs.getString("tel"),
					rs.getString("email"),	
					rs.getString("picture")
						);
				return m;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, rs);
		}
		return null;
	}
	
	public int memberUpdate(Member mem) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "update member set tel = ? , email = ? where id = ?";
		
		try {
			ps = con.prepareStatement(sql);
			//  ?,?,?를 채워주는 메서드
			ps.setString(1, mem.getTel());
			ps.setString(2, mem.getEmail());
			ps.setString(3, mem.getId());
			
			// ?를 채운후 전송해주는 메서드 에러가 없으면 ps를 반환
			return ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, null);
		}
		return 0;
	}
	
	public int deleteMember(String id) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "delete from member where id = ?";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			return ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, ps, null);
		}
		
		return 0;
	}
	
}// end class