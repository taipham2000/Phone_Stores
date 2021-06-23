/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.OrderDAO;
import dao.OrderDetailDao;
import dao.ProductDAO;
import dto.Cart;
import dto.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author phamv
 */
@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String totalPrice = request.getParameter("totalPrice");
        System.out.println("totalPrice:" + totalPrice);
        User user = (User) session.getAttribute("user");
        System.out.println("user:" + user);
        OrderDAO oD = new OrderDAO();
        OrderDetailDao oDl = new OrderDetailDao();
        ProductDAO dao = new ProductDAO();
        try {
            int oID = oD.getLastOrder();
            int orderID = oID + 1;
            int oDID = oDl.getLastRecordOrderDetail();
            int orderDetailID = oDID + 1;
            List<Cart> listCart = (List<Cart>) session.getAttribute("cart");

            if (action.equals("checkout")) {
                if (user != null) {
                    int insertOrder = oD.insertOrder(orderID, user.getUserID(), Float.parseFloat(totalPrice));
                    if (insertOrder > 0) {
                        int orderIDs = oD.getLastOrder();
                        int insertOrderDetail = 0;
                        for (Cart cart : listCart) {
                            insertOrderDetail = 0;
                            if (cart.getSanpham().getQuantity() < cart.getQuantities()) {
                                request.setAttribute("ERROR", "The number of Phones is not enough");
                                request.getRequestDispatcher("CustomerOrder.jsp").forward(request, response);
                            } else {
                                insertOrderDetail = oDl.insertDetail(orderDetailID, orderID, cart.getSanpham().getProductID(), Float.parseFloat(totalPrice), cart.getQuantities());
                                System.out.println("liscart1:" + listCart);
                                dao.setQuantityBook(cart.getSanpham().getProductID(), cart.getQuantities());
                            }
                            orderDetailID++;
                            System.out.println("OrderIDDetail 2:" + orderDetailID);
                            System.out.println("liscart2:" + listCart);
                        }
                        if (insertOrderDetail > 0) {
                            request.setAttribute("SUCCESS", "Checkout Success!");
                            request.getRequestDispatcher("CustomerOrder.jsp").forward(request, response);

                        }
                    }

                }
                listCart.clear();
            }
        } catch (Exception e) {

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
