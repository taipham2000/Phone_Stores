
package dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.TreeMap;
public class Cart implements Serializable {
    private String customerName;
   Product sanpham;
  private int quantities;
  List<Product> list;
	
   
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public List<Product> getList() {
        return list;
    }

    public void setList(List<Product> list) {
        this.list = list;
    }
  
    public Cart(String customerName) {
		this.customerName = customerName;
	}
    public Cart(String customerName, HashMap<String, Product> cart) {
		this.customerName = customerName;
	}

    public Cart(Product sanpham, int quantities) {
        this.sanpham = sanpham;
        this.quantities = quantities;
    }

    public Product getSanpham() {
        return sanpham;
    }

    public void setSanpham(Product sanpham) {
        this.sanpham = sanpham;
    }

    public int getQuantities() {
        return quantities;
    }

    public void setQuantities(int quantities) {
        this.quantities = quantities;
    }

    @Override
    public String toString() {
        return "Cart{" + "customerName=" + customerName + ", sanpham=" + sanpham + ", quantities=" + quantities + ", list=" + list + '}';
    }
   
    
}
