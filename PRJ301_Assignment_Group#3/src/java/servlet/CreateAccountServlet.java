package servlet;

import dao.UserDAO;
import dto.User;
import dto.UserError;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        try {
            if (action.equals("Register")) {
                String name = request.getParameter("userName");
                String password = request.getParameter("password");
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                Random generator = new Random();

                String id = "";
                UserDAO daoU = new UserDAO();
                Vector<User> listUser = daoU.getAllUser();
                do {
                    id = "U" + generator.nextInt(999) + 1;
                } while (id.equals(listUser.get(0).getUserID()));
                int role = 2;
                boolean valid = true;
                UserError error = new UserError();

                if (!password.trim().isEmpty() && !password.matches("[a-zA-Z0-9]{8}")) {
                    error.setPasswordError("Password 8 digits");
                    valid = false;
                }
                if (!phone.trim().isEmpty() && !phone.matches("[0-9]{10}")) {
                    error.setPhone("Phone must have 10 numbers");
                    valid = false;
                }

                User user = new User(id, name, password, address, phone, role);
                UserDAO dao = new UserDAO();
                System.out.println("user: " + user);
                if (valid) {
                    if (dao.createUser(user)) {

                        request.getRequestDispatcher("UI_Login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("INVALID", error);
                    System.out.println("tyhgj");
                    request.getRequestDispatcher("CreateAccount.jsp").forward(request, response);
                }

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
