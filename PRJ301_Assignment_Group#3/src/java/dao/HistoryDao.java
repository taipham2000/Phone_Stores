/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.History;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import ultis.DBUItis;

/**
 *
 * @author phamv
 */
public class HistoryDao {
    Connection con=null;
    PreparedStatement ps=null;
    ResultSet rs=null;
    public List<History> loadHistory(String userID) throws SQLException, ClassNotFoundException {
        List<History> list = new ArrayList<>();
        try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "select o.date, d.price, d.quantity, b.imageUrl , b.productName\n"
                        + "from Orders o inner join OrderDetail d on o.OrderID = d.OrderID, Products b\n"
                        + "where b.productID = d.productID and UserID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, userID);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String date = rs.getString("date");
                    String bookName = rs.getString("productName");
                    int quantity = rs.getInt("quantity");
                    float price = rs.getFloat("Price");
                    String images = rs.getString("imageUrl");

                    list.add(new History(bookName,price , quantity, date, images));
                }

            }
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
        return list;
    }
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        HistoryDao dao=new HistoryDao();
        System.out.println(dao.loadHistory("U04"));
    }
}
