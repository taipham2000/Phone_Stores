package servlet;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import dao.ProductDAO;
import dto.Cart;
import dto.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

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

    }

    /*     if (user == null) {
                        request.getRequestDispatcher("UI_Login.jsp").forward(request, response);
                        if (user != null) {
                            request.getRequestDispatcher("CustomerOrder.jsp").forward(request, response);
                        }
                    }
                    request.getRequestDispatcher("CustomerOrder.jsp").forward(request, response);*/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        HttpSession httpSession = request.getSession();
        httpSession.setMaxInactiveInterval(3000);

        String action = request.getParameter("action");

        if (action == null) {
            displayCart(request, response);
        } else {
            if (action.equalsIgnoreCase("buy")) {
                User user = (User) httpSession.getAttribute("user");
                if (user == null) {
                    request.getRequestDispatcher("UI_Login.jsp").forward(request, response);
                }
                buyItem(request, response);

            } else if (action.equalsIgnoreCase("remove")) {
                removeItem(request, response);
            }
        }
    }

    protected void displayCart(HttpServletRequest request, HttpServletResponse respone) throws ServletException, IOException {
        request.getRequestDispatcher("showcart.jsp").forward(request, respone);
    }

    protected void removeItem(HttpServletRequest request, HttpServletResponse respone) throws IOException {
        HttpSession session = request.getSession();

        List<Cart> cart = (List<Cart>) session.getAttribute("cart");
        int index = isExisting(request.getParameter("productID"), cart);
        cart.remove(index);
        session.setAttribute("cart", cart);
        respone.sendRedirect("CartServlet");
    }

    private int isExisting(String id, List<Cart> cart) {
        for (int i = 0; i < cart.size(); i++) {
            if (cart.get(i).getSanpham().getProductID().equalsIgnoreCase(id)) {
                return i;
            }
        }
        return -1;
    }

    protected void buyItem(HttpServletRequest request, HttpServletResponse respone) throws IOException {
        ProductDAO proDao = new ProductDAO();
        HttpSession session = request.getSession();
        if (session.getAttribute("cart") == null) {
            List<Cart> cart = new ArrayList<Cart>();
            cart.add(new Cart(proDao.find(request.getParameter("productID")), 1));
            System.out.println("Cart : "+cart);
            session.setAttribute("cart", cart);
        } else {
            List<Cart> cart = (List<Cart>) session.getAttribute("cart");
            System.out.println(cart.size());
            int index = isExisting(request.getParameter("productID"), cart);

            if (index == -1) {
                cart.add(new Cart(proDao.find(request.getParameter("productID")), 1));

            } else {
                int quantity = cart.get(index).getQuantities() + 1;
                cart.get(index).setQuantities(quantity);
            }
            session.setAttribute("cart", cart);
        }
        respone.sendRedirect("CartServlet");
    }

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
