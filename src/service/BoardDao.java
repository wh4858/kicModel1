package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Board;
import util.JdbcConnection;

public class BoardDao {

	public int nextNum() {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select boardseq.nextval from dual";
		
		// column name을 생략하면 create table column순으로 입력한다.
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, rs);
		}
		
		return 0;
	}
	
	public int insertBoard(Board board) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "insert into board "
				+ "values(?, ?, ?, ?, ?, ?, ?, sysdate, ?, 0, ?, ?, ?)";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, board.getNum());
			ps.setString(2, board.getWriter());
			ps.setString(3, board.getPass());
			ps.setString(4, board.getSubject());
			ps.setString(5, board.getContent());
			ps.setString(6, board.getFile1());
			ps.setString(7, board.getBoardid());
			
			ps.setString(8, board.getIp());
			
			ps.setInt(9, board.getRef());
			ps.setInt(10, board.getReflevel());
			ps.setInt(11, board.getRefstep());
			
			return ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, null);
		}
		return 0;
	}
	
	public int boardCount(String id) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "select count(*) from board where boardid = ?";
		ResultSet rs = null;
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			rs.next();
			
			return rs.getInt(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, rs);
		}
		return 0;
	}
	
	public List<Board> boardList(int pageInt, int limit, int count, String id){
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "select * from("
						+ " select rownum rnum, a.* from( "
						+ " select * from board where boardid = ? "
						+ " order by ref desc, refstep asc) a) " 
						+ " where rnum between ? and ?";
		/* 
		-- 1, 4, 7, 10
		-- start : (pageInt-1)*limit + 1;
		-- end : start + limit - 1;
		-- 1 p --> 1 ~ 3
		-- 2 p --> 4
		-- 3 p --> 7 
		*/

		ResultSet rs = null;
		List<Board> list = new ArrayList<Board>();
		
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setInt(2, (pageInt-1)*limit + 1);
			ps.setInt(3, (pageInt-1)*limit + limit);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Board b = new Board();
				b.setNum(rs.getInt("num"));
				b.setWriter(rs.getString("writer"));
				b.setPass(rs.getString("pass"));
				b.setSubject(rs.getString("subject"));
				b.setContent(rs.getString("content"));
				b.setFile1(rs.getString("file1"));
				b.setRef(rs.getInt("ref"));
				b.setRefstep(rs.getInt("refstep"));
				b.setReflevel(rs.getInt("reflevel"));
				b.setReadcnt(rs.getInt("readcnt"));
				b.setRegdate(rs.getDate("regdate"));
				
				list.add(b);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, rs);
		}
		return list;
		}
	
	public Board boardOne(int num) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "select * from board where num = ?";
		ResultSet rs = null;
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			while(rs.next()) {
				Board b = new Board();
				b.setNum(rs.getInt("num"));
				b.setWriter(rs.getString("writer"));
				b.setPass(rs.getString("pass"));
				b.setSubject(rs.getString("subject"));
				b.setContent(rs.getString("content"));
				b.setFile1(rs.getString("file1"));
				b.setRef(rs.getInt("ref"));
				b.setRefstep(rs.getInt("refstep"));
				b.setReflevel(rs.getInt("reflevel"));
				b.setReadcnt(rs.getInt("readcnt"));
				b.setRegdate(rs.getDate("regdate"));
				return b;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, rs);
		}
		return null;
	}
	
	public int boardUpdate(Board board) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "update board set subject = ? , content = ? , file1 = ? where num = ?";
		
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setString(1, board.getSubject());
			ps.setString(2, board.getContent());
			ps.setString(3, board.getFile1());
			ps.setInt(4, board.getNum());
			
			return ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, null);
		}
		
		return 0;
	}
	
	public void readCountUp(int num) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "update board set readcnt = readcnt + 1 where num = ?";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, null);
		}
	}
	
	
	public int boardDelete(int num) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "delete from board where num = ?";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			
			return ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, null);
		}
		
		return 0;
	}
	
	public void refStepAdd(int ref, int refstep) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement ps = null;
		String sql = "update board set refstep = refstep + 1 where ref = ? and refstep > ?";
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, ref);
			ps.setInt(2, refstep);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con, ps, null);
		}
		
	}
}