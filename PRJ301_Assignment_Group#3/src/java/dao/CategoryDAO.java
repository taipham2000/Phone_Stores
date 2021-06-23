package dao;

import dto.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import ultis.DBUItis;

public class CategoryDAO {
    DBUItis db= new DBUItis();
    Vector<Category> listCategory= new Vector<Category>();
    
    public Vector<Category> getAllCategory() throws SQLException{
        Connection con = null; // Đối tượng tạo kết nối với CSDL
        PreparedStatement ps = null; // đối tượng tạo câu truy vấn
        ResultSet rs = null; // Đối tượng nhận kết quả truy vấn
        listCategory.clear();

        try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "SELECT * FROM Categories";

                ps = con.prepareStatement(sql); // tạo đối trượng truy vấn
                rs = ps.executeQuery(); // 

                while (rs.next()) {
                    listCategory.add(new Category(rs.getString(1), rs.getString(2)));
                }
            }
        } catch (Exception e) {
            System.out.println("Error: "+e.getMessage());
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
        return listCategory;
    }
    
    public Category getCategoryByID(String categoryID) throws SQLException{
        if (listCategory.size()==0) getAllCategory();
        for (int i=0; i<listCategory.size(); i++){
            if(listCategory.get(i).getCategoryID().equals(categoryID)){
                return listCategory.get(i);
            }
        }
        return null;
    }
}
