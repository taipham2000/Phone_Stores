package dto;

import java.util.Date;
public class Orders {
    private String orderID;
    private String userName;
    private String address;
    private Date date;
    private double total;
    private Product product;
    public Orders() {
    }

    public Orders(String orderID, String userName, String address, Date date, double total, Product product) {
        this.orderID = orderID;
        this.userName = userName;
        this.address = address;
        this.date = date;
        this.total = total;
        this.product = product;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
    public Orders(String orderID, String userID, String address, Date date, double total) {
        this.orderID = orderID;
        this.userName = userID;
        this.address = address;
        this.date = date;
        this.total = total;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    
    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getUserID() {
        return userName;
    }

    public void setUserID(String userID) {
        this.userName = userID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "Orders{" + "orderID=" + orderID + ", userID=" + userName + ", date=" + date + ", total=" + total + '}';
    }
    
}
