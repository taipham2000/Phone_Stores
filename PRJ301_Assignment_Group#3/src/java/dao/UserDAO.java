package dao;

import dto.Product;
import dto.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import ultis.DBUItis;

public class UserDAO {

    DBUItis db = new DBUItis();
    Vector<User> listUser = new Vector<User>();

    public User checkLogin(String name, String password) {
        try {
            getAllUser();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (name == null || password == null) {
            return null;
        }
        for (User user: listUser) {
            if (name.equals(user.getUserName()) && password.equals(user.getPassword())) {
                return user;
            }
        }
        return null;
    }
       public boolean createUser(User user) throws SQLException{
        Connection con= null;
        PreparedStatement ps= null;
        try {
            con= DBUItis.openConnection();
            if(con != null){
                String sql= "Insert Users Values(?,?,?,?,?,?)";
                
                ps= con.prepareStatement(sql);
                ps.setString(1, user.getUserID());
                ps.setString(2, user.getUserName());         
                ps.setString(3, user.getPassword());
                ps.setString(4, user.getAddress());
                ps.setString(5, user.getPhone());
                ps.setString(6, "2");
                ps.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("Error: "+e.getMessage());
            return false;
        }
        finally{
            if(ps != null){
                ps.close();
            }
            if(con != null){
                con.close();
            }
        }
        System.out.println("Add Successful!");
        return true;
    }
    public Vector<User> getAllUser() throws SQLException {
        Connection con = null; // Đối tượng tạo kết nối với CSDL
        PreparedStatement ps = null; // đối tượng tạo câu truy vấn
        ResultSet rs = null; // Đối tượng nhận kết quả truy vấn
        listUser.clear();

        try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "SELECT * FROM Users";

                ps = con.prepareStatement(sql); // tạo đối trượng truy vấn
                rs = ps.executeQuery(); // 

                while (rs.next()) {
                    listUser.add(new User(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        System.out.println("Load Successful!");
        return listUser;
    }

    public User getUserByID(String userID) throws SQLException {
        if (listUser.size() == 0) {
            getAllUser();
        }
        for (int i = 0; i < listUser.size(); i++) {
            if (listUser.get(i).getUserID().equals(userID)) {
                return listUser.get(i);
            }
        }
        return null;
    }
    
    public String getRoleOfUser(User user) throws SQLException{
        Connection con = null; // Đối tượng tạo kết nối với CSDL
        PreparedStatement ps = null; // đối tượng tạo câu truy vấn
        ResultSet rs = null; // Đối tượng nhận kết quả truy vấn
        listUser.clear();
        String role = null;
        try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "SELECT roleName FROM Roles WHERE roleID= (SELECT roleID FROM Users WHERE userID=N'"+user.getUserID()+"')";

                ps = con.prepareStatement(sql); // tạo đối trượng truy vấn
                rs = ps.executeQuery(); // 

                rs.next();
                role = rs.getString(1);
                }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        System.out.println("Load Successful!");
        return role;
    }
}
