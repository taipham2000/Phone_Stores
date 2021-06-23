package dao;

import dto.OrderDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import static org.apache.coyote.ContainerThreadMarker.clear;
import ultis.DBUItis;
public class OrderDetailDao {
        Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public void Closefinally() throws SQLException {
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
        public int getLastRecordOrderDetail() throws NamingException, SQLException {

        try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "SELECT OrderDetailID FROM OrderDetail ORDER BY orderDetailID DESC";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getInt("orderDetailID");
                }
            }
        } finally {
            Closefinally();
        }
        return -1;
    }
                   public int insertDetail(int orderDetailID,int oderID,  String productID,float price , int detailQuantity) throws SQLException, ClassNotFoundException {
        
               clear();
                       try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "insert OrderDetail (OrderDetailID,OrderID,productID,price,quantity)\n"
                        + "values (?,?,?,?,?)";
                ps = con.prepareStatement(sql);
                ps.setInt(1, orderDetailID);
                ps.setInt(2, oderID);
                ps.setString(3, productID);
                ps.setFloat(4, price);
                ps.setInt(5, detailQuantity);

                int rs = ps.executeUpdate();
                if (rs > 0) {
                    return rs;
                }
            }
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return 0;
    }
    public List<OrderDetails> getAllOrderDetails(){
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
       List<OrderDetails> list=new ArrayList<>();
        try{
            con=DBUItis.openConnection();
            if(con!=null){
                String sql="Select * From OrderDetail";
                ps=con.prepareStatement(sql);
                rs=ps.executeQuery();
                while(rs.next()){
                OrderDetails orderdetail=new OrderDetails(rs.getString(1), rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getInt(5));
                list.add(orderdetail);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
}
