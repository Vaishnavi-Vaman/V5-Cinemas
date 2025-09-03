package com.V5.dao.user;
	import com.V5.dto.user.Guest;
import com.V5.util.ConnectionClass;

	import java.sql.*;

	public class GuestDAO {
	    public static int insertGuest(Guest guest) throws Exception {
	        String sql = "INSERT INTO guests (name, email) VALUES (?, ?)";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
	            ps.setString(1, guest.getName());
	            ps.setString(2, guest.getEmail());
	            ps.executeUpdate();
	            try (ResultSet rs = ps.getGeneratedKeys()) {
	                if (rs.next()) return rs.getInt(1);
	            }
	        }
	        return -1;
	    }
	}



