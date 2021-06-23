package dao;

import dto.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Vector;
import javax.swing.JOptionPane;
import static jdk.nashorn.internal.runtime.Debug.id;
import ultis.DBUItis;

public class ProductDAO {
    Connection con=null;
    PreparedStatement ps=null;
    ResultSet rs=null;
    DBUItis db= new DBUItis();
    Vector<Product> listProduct= new Vector<Product>();
    List<Product> products;
    private void closeconnected() throws SQLException{
        if(rs!=null){
                rs.close();
            }
        if(ps!=null){
                ps.close();
            }
        if(con!=null){
                con.close();
            }
    }
    
    public ProductDAO()  {
        try{
        this.products=getAllProducts();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
        public int setQuantityBook(String bookID, int quantity) throws SQLException, ClassNotFoundException {
        try {
            con = DBUItis.openConnection();

            if (con != null) {
                String sql = "update Products\n"
                        + "set quantity = quantity - ?\n"
                        + "where productID = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, quantity);
                ps.setString(2, bookID);
                int result = ps.executeUpdate();
                if (result > 0) {
                    return result;
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
    public Vector<Product> getAllProducts() throws SQLException{
        Connection con = null; // Đối tượng tạo kết nối với CSDL
        PreparedStatement ps = null; // đối tượng tạo câu truy vấn
        ResultSet rs = null; // Đối tượng nhận kết quả truy vấn
        listProduct.clear();

        try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "SELECT * FROM Products";

                ps = con.prepareStatement(sql); // tạo đối trượng truy vấn
                rs = ps.executeQuery(); // 

                while (rs.next()) {
                    listProduct.add(new Product(rs.getString(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
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
        return listProduct;
    }

   public List<Product>findAll(){
    return this.products;
}
   
public Product find(String id){
    for(Product product : this.listProduct){
        if(product.getProductID().equalsIgnoreCase(id)){
            return product;
        }
    }
    return null;
} 
    public Product getProductByID(String productID) throws SQLException{
        getAllProducts();
        for (int i=0; i<listProduct.size(); i++){
            if(listProduct.get(i).getProductID().equals(productID)){
                return listProduct.get(i);
            }
        }
        return null;
    }
        public List<Product> getProductNameSearch(String search) throws SQLException{
        List<Product> list =null;
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
       
            con=DBUItis.openConnection();
            if(con!=null){
                String sql="Select productID,productName,quantity,price,shortDescription,productDescription,imageUrl,categoryID \n"+
                        "from Products\n"+
                        "Where productName like ?";
                ps=con.prepareStatement(sql);
                ps.setString(1, "%"+search+"%");
                rs=ps.executeQuery();
                while(rs.next()){
                     String ProductId= rs.getString("productID");
                    String Productname = rs.getString("productname");
                    int Quantity = rs.getInt("quantity");
                    float Price = rs.getFloat("price");
                    String shortDescription=rs.getString("shortDescription");
                    String productDescription=rs.getString("productDescription");
                    String imageUrl=rs.getString("imageUrl");
                    String categoryId = rs.getString("categoryID");//"******";
                    if(list == null){
                        list = new ArrayList<>();
                    }
                    list.add(new Product(ProductId, Productname, Price, Quantity, shortDescription, productDescription, imageUrl, categoryId));
                }
              
            }
        
        return list;
    }
    public boolean createProduct(Product product) throws SQLException{
        Connection con= null;
        PreparedStatement ps= null;
        try {
            con= DBUItis.openConnection();
            if(con != null){
                String sql= "Insert Products Values(?,?,?,?,?,?,?,?)";
                
                ps= con.prepareStatement(sql);
                ps.setString(1, product.getProductID());
                ps.setString(2, product.getProductName());         
                ps.setDouble(3, product.getPrice());
                ps.setInt(4, product.getQuantity());
                ps.setString(5, product.getShortDescription());
                ps.setString(6, product.getProductDescription());
                ps.setString(7, product.getImageUrl());
                ps.setString(8, product.getCategoryID());
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
    
     public boolean updateProduct(Product product) throws SQLException{
        Connection con= null;
        PreparedStatement ps= null;
        try {
            con= DBUItis.openConnection();
            if(con != null){
                String sql= "UPDATE Products SET productName=?, price=?, quantity=?, shortDescription=?, productDescription=?, imageUrl=?, categoryID=? WHERE productID=?";
                ps= con.prepareStatement(sql);
                ps.setString(1, product.getProductName());
                ps.setDouble(2, product.getPrice());
                ps.setInt(3, product.getQuantity());
                ps.setString(4, product.getShortDescription());
                ps.setString(5, product.getProductDescription());
                ps.setString(6, product.getImageUrl());
                ps.setString(7, product.getCategoryID());
                ps.setString(8, product.getProductID());
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
        System.out.println("Update Successful!");
        return true;
    }
     
     public boolean deleteProduct(String productID) throws SQLException{
        Connection con= null;
        PreparedStatement ps= null;
        try {
            con= DBUItis.openConnection();
            if(con != null){
                String sql= "DELETE FROM Products WHERE productID=?";
                ps= con.prepareStatement(sql);
                ps.setString(1, productID);
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
        System.out.println("Delete Successful!");
        return true;
    }
     
    public Vector<Product> getListSearchProducts(String nameProduct) throws SQLException{
        Connection con = null; // Đối tượng tạo kết nối với CSDL
        PreparedStatement ps = null; // đối tượng tạo câu truy vấn
        ResultSet rs = null; // Đối tượng nhận kết quả truy vấn
        listProduct.clear();

        try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "SELECT * FROM Products WHERE CHARINDEX(N'"+nameProduct+"', productName)>0;";

                ps = con.prepareStatement(sql); // tạo đối trượng truy vấn
                rs = ps.executeQuery(); // 

                while (rs.next()) {
                    listProduct.add(new Product(rs.getString(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
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
        return listProduct;
    }
     
    public Vector<Product> getProductByPrice(double price1, double price2) throws SQLException{
        Connection con = null; // Đối tượng tạo kết nối với CSDL
        PreparedStatement ps = null; // đối tượng tạo câu truy vấn
        ResultSet rs = null; // Đối tượng nhận kết quả truy vấn
        listProduct.clear();

        try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "SELECT * FROM Products WHERE (price>="+price1+" and price<="+price2+");";

                ps = con.prepareStatement(sql); // tạo đối trượng truy vấn
                rs = ps.executeQuery(); // 

                while (rs.next()) {
                    listProduct.add(new Product(rs.getString(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
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
        return listProduct;
    }
    
    public Vector<Product> getAllProductsOfCategory(String categoryID) throws SQLException{
        Connection con = null; // Đối tượng tạo kết nối với CSDL
        PreparedStatement ps = null; // đối tượng tạo câu truy vấn
        ResultSet rs = null; // Đối tượng nhận kết quả truy vấn
        listProduct.clear();

        try {
            con = DBUItis.openConnection();
            if (con != null) {
                String sql = "SELECT * FROM Products WHERE categoryID=N'"+categoryID+"'";

                ps = con.prepareStatement(sql); // tạo đối trượng truy vấn
                rs = ps.executeQuery(); // 

                while (rs.next()) {
                    listProduct.add(new Product(rs.getString(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
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
        return listProduct;
    }
}
