package com.V5.dao;

import com.V5.dto.User;
import com.V5.util.ConnectionClass;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Register a new user and return the generated user_id
	public static int registerUser(User user) throws SQLException {
	    try (Connection con = ConnectionClass.getConnect()) {
	        // Check if email already exists
	        PreparedStatement check = con.prepareStatement("SELECT 1 FROM users WHERE email = ?");
	        check.setString(1, user.getEmail());
	        ResultSet rs = check.executeQuery();
	        if (rs.next()) {
	            return -2; // email exists
	        }

	        String sql = "INSERT INTO users (name, email, password, role, license_path) VALUES (?, ?, ?, ?, ?)";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, user.getName());
	        ps.setString(2, user.getEmail());
	        ps.setString(3, user.getPassword());
	        ps.setString(4, user.getRole());
	        ps.setString(5, user.getLicensePath());
	        return ps.executeUpdate();
	    }
	}


    // Login user using email and password
	  public static User loginUser(String email, String password) throws Exception {
	        try (Connection con = ConnectionClass.getConnect()) {
	            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, email);
	            ps.setString(2, password);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                User user = new User();
	                user.setUserId(rs.getInt("user_id"));
	                user.setName(rs.getString("name"));
	                user.setEmail(rs.getString("email"));
	                user.setPassword(rs.getString("password"));
	                user.setRole(rs.getString("role"));
	                user.setLicensePath(rs.getString("license_path"));
	                return user;
	            }
	            return null;
	        }
	    }
	// pending request
	  public static List<User> getPendingAdmins() throws Exception {
	        List<User> pendingList = new ArrayList<>();
	        try (Connection con = ConnectionClass.getConnect()) {
	            // Match EXACT value stored in DB
	            String sql = "SELECT user_id, name, email, role, license_path FROM users WHERE role = ?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, "pending_admin");
	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {
	                User u = new User();
	                u.setUserId(rs.getInt("user_id"));
	                u.setName(rs.getString("name"));
	                u.setEmail(rs.getString("email"));
	                u.setRole(rs.getString("role"));
	                u.setLicensePath(rs.getString("license_path"));
	                pendingList.add(u);

	                System.out.println("[DEBUG] Found: " + u.getName() + " | " + u.getEmail());
	            }
	        }
	        return pendingList;
	    }

	    public static void updateUserRole(int userId, String newRole, boolean clearLicense) throws Exception {
	        try (Connection con = ConnectionClass.getConnect()) {
	            String sql;
	            if (clearLicense) {
	                sql = "UPDATE users SET role = ?, license_path = NULL WHERE user_id = ?";
	            } else {
	                sql = "UPDATE users SET role = ? WHERE user_id = ?";
	            }
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, newRole);
	            ps.setInt(2, userId);
	            ps.executeUpdate();
	        }
	    }
	 // Delete user by ID
	    public static void deleteUser(int userId) throws Exception {
	        try (Connection con = ConnectionClass.getConnect()) {
	            String sql = "DELETE FROM users WHERE user_id = ?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setInt(1, userId);
	            ps.executeUpdate();
	        }
	    }

	}