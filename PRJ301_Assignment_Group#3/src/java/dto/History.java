/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author phamv
 */
public class History {
    private String productName;
    private float price;
    private int quantity;
    private String date;
    private String imageUrl;

    public History() {
    }

    public History(String productName, float price, int quantity, String date, String imageUrl) {
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.date = date;
        this.imageUrl = imageUrl;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "History{" + "productName=" + productName + ", price=" + price + ", quantity=" + quantity + ", date=" + date + ", imageUrl=" + imageUrl + '}';
    }
    
}
