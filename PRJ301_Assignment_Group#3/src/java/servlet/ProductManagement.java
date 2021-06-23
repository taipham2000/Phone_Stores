package servlet;
import dao.CategoryDAO;
import dao.OrderDetailDao;
import dao.ProductDAO;
import dao.UserDAO;
import dto.Category;
import dto.OrderDetails;
import dto.Product;
import dto.User;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)

@WebServlet(name = "ProductManagement", urlPatterns = {"/ProductManagement"})
public class ProductManagement extends HttpServlet {

    private static final String UPLOAD_DIR = "images";
    private String ImageURLAfter = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String pathUI_ListProduct = "UI_ListProduct.jsp";
        String pathUI_InsertProduct = "UI_InsertProduct.jsp";
        String pathUI_UpdateProduct = "UI_UpdateProduct.jsp";
        String pathUI_SearchProduct = "UI_SearchProduct.jsp";
        String pathUI_SearchByPrice = "UI_SearchByPrice.jsp";
        String pathUI_Description = "UI_Description.jsp";
        String pathUI_Login = "UI_Login.jsp";
        String pathUI_Error = "UI_Error.jsp";
        String controlProduct = "ProductManagement";

        String action = request.getParameter("action");
        System.out.println("action :" + action);
        ProductDAO dao = new ProductDAO();
        CategoryDAO daoC = new CategoryDAO();
        UserDAO daoU = new UserDAO();

        HttpSession httpSession = request.getSession();
        httpSession.setMaxInactiveInterval(3000);

        try {
            if (action == null) {
                Vector<Product> listProduct = dao.getAllProducts();
                Vector<Category> listCategory = daoC.getAllCategory();
                request.setAttribute("listProduct", listProduct);
                request.setAttribute("listCategory", listCategory);
                request.setAttribute("categoryName", "Smart Phone");

                User user = (User) httpSession.getAttribute("user");
                request.setAttribute("user", user);
                String role = (String) httpSession.getAttribute("role");
                request.setAttribute("role", role);

                RequestDispatcher rd = request.getRequestDispatcher(pathUI_ListProduct);
                rd.forward(request, response);
            } else if (action.equals("showCategory")) {
                String categoryID = request.getParameter("categoryID");
                Vector<Product> listProduct = dao.getAllProductsOfCategory(categoryID);
                Vector<Category> listCategory = daoC.getAllCategory();
                String categoryName = daoC.getCategoryByID(categoryID).getCategoryName();
                request.setAttribute("categoryName", categoryName);
                request.setAttribute("listProduct", listProduct);
                request.setAttribute("listCategory", listCategory);

                User user = (User) httpSession.getAttribute("user");
                request.setAttribute("user", user);
                String role = (String) httpSession.getAttribute("role");
                request.setAttribute("role", role);

                RequestDispatcher rd = request.getRequestDispatcher(pathUI_ListProduct);
                rd.forward(request, response);
            } else if (action.equals("showDescription")) {
                Vector<Category> listCategory = daoC.getAllCategory();
                String productID = request.getParameter("productID");
                Product product = dao.getProductByID(productID);

                User user = (User) httpSession.getAttribute("user");
                request.setAttribute("user", user);
                String role = (String) httpSession.getAttribute("role");
                request.setAttribute("role", role);

                String description = getDescriptionFromFile(product.getProductDescription());

                request.setAttribute("listCategory", listCategory);
                request.setAttribute("product", product);
                request.setAttribute("description", description);

                RequestDispatcher rd = request.getRequestDispatcher(pathUI_Description);
                rd.forward(request, response);
            }
            else if(action.equals("register")){
                request.getRequestDispatcher("CreateAccount.jsp").forward(request, response);
            }
            else if (action.equals("search")) {
                    String sear = request.getParameter("search");
                    List<Product> list = dao.getProductNameSearch(sear);

                    if (list != null) {
                        request.setAttribute("List_Search", list);
                    }
                    Vector<Category> listCategory = daoC.getAllCategory();
                    request.setAttribute("listCategory", listCategory);
                    request.setAttribute("categoryName", "Smart Phone");
                    request.getRequestDispatcher("search.jsp").forward(request, response);
                }
            else if (action.equals("Order")) {
                    User user = (User) httpSession.getAttribute("user");
                     if (user == null) {
                        request.getRequestDispatcher("UI_Login.jsp").forward(request, response);
                        if (user != null) {
                            request.getRequestDispatcher("CustomerOrder.jsp").forward(request, response);
                        }
                    }
                    request.getRequestDispatcher("CustomerOrder.jsp").forward(request, response);
                } 
            else if (action.equals("login")) {
                Vector<User> listUser = daoU.getAllUser();
                String userName = request.getParameter("userName");
                String password = request.getParameter("password");

                User user = daoU.checkLogin(userName, password);
                if (user != null) {
                    httpSession.setAttribute("user", user);
                    String role = daoU.getRoleOfUser(user);
                    httpSession.setAttribute("role", role);

                    response.sendRedirect(controlProduct);
                } else {
                    String error = "User hoặc password không đúng!";
                    request.setAttribute("error", error);
                    request.setAttribute("userName", userName);
                    request.setAttribute("password", password);

                    RequestDispatcher rd = request.getRequestDispatcher(pathUI_Login);
                    rd.forward(request, response);
                    return;
                }
            } else if (action.equals("logout")) {
                httpSession.invalidate();
                response.sendRedirect(controlProduct);
            } else if (((String) httpSession.getAttribute("role")).equals("admin")) {
                if (action.equals("addFormProduct")) {
                    Product product = new Product("", "", 0, 0, "", "", "", "");
                    request.setAttribute("product", product);
                    Vector<Category> listCategory = daoC.getAllCategory();
                    request.setAttribute("listCategory", listCategory);
                    
                    User user = (User) httpSession.getAttribute("user");
                    request.setAttribute("user", user);
                    String role = (String) httpSession.getAttribute("role");
                    request.setAttribute("role", role);

                    RequestDispatcher rd = request.getRequestDispatcher(pathUI_InsertProduct);
                    rd.forward(request, response);
                } else if (action.equals("insert")) {
                    String productID = request.getParameter("productID").trim();
                    String productName = request.getParameter("productName").trim();
                    String price = request.getParameter("price").trim();
                    String quantity = request.getParameter("quantity").trim();
                    String shortDescription = request.getParameter("shortDescription").trim();
                    String productDescription = request.getParameter("productID").trim() + ".txt";
                    String description = request.getParameter("description").trim();
                    String url = uploadFile(request); // Upload file vào thư mục, return image name 
                    String categoryID = request.getParameter("categoryID").trim();

                    if (dao.getProductByID(productID) == null) {
                        Product product = new Product(productID, productName, Double.parseDouble(price), Integer.parseInt(quantity), shortDescription, productDescription, url, categoryID);
                        dao.createProduct(product);
                        response.sendRedirect(controlProduct);
                    } else {
                        Product product = new Product(productID, productName, Double.parseDouble(price), Integer.parseInt(quantity), shortDescription, description, url, categoryID);
                        String error = "Product ID đã tồn tại!";
                        request.setAttribute("error", error);
                        request.setAttribute("product", product);
                        Vector<Category> listCategory = daoC.getAllCategory();
                        request.setAttribute("listCategory", listCategory);

                        RequestDispatcher rd = request.getRequestDispatcher(pathUI_InsertProduct);
                        rd.forward(request, response);
                        return;
                    }

                    writerDescription(productDescription, description);

                    String path = request.getServletContext().getRealPath("/images/");
                    File f = new File(path + productID);
                    if (!f.exists()) {
                        f.mkdirs();
                    }
                    for (File file : f.listFiles()) {
                        if (!file.isDirectory()) {
                            file.delete();
                        }
                    }

                    //
                    List<String> photos = uploadFile2(UPLOAD_DIR + "/" + productID, request);
                    //
                } else if (action.equals("editFormProduct")) {
                    String productID = request.getParameter("productID");
                    Product product = dao.getProductByID(productID);
                    ImageURLAfter = product.getImageUrl();
                    request.setAttribute("product", product);
                    Vector<Category> listCategory = daoC.getAllCategory();
                    request.setAttribute("listCategory", listCategory);

                    ArrayList<String> listImg = new ArrayList<String>();
                    String path = request.getServletContext().getRealPath("/images/");
                    File f = new File(path + productID);
                    for (File file : f.listFiles()) {
                        if (!file.isDirectory()) {
                            listImg.add(file.getName());
                        }
                    }
                    request.setAttribute("listImg", listImg);

                    String description = getDescriptionFromFile(product.getProductDescription());
                    request.setAttribute("description", description);
                    
                    User user = (User) httpSession.getAttribute("user");
                    request.setAttribute("user", user);
                    String role = (String) httpSession.getAttribute("role");
                    request.setAttribute("role", role);

                    RequestDispatcher rd = request.getRequestDispatcher(pathUI_UpdateProduct);
                    rd.forward(request, response);
                } else if (action.equals("ViewOrder")) {
                    List<OrderDetails> order = new ArrayList<OrderDetails>();
                    System.out.println("Asfvsd");
                    OrderDetailDao orderdetail = new OrderDetailDao();
                    order = orderdetail.getAllOrderDetails();
                    request.setAttribute("View", order);
                    request.getRequestDispatcher("ViewOrder.jsp").forward(request, response);
                } else if (action.equals("update")) {
                    String productID = request.getParameter("productID").trim();
                    String productName = request.getParameter("productName").trim();
                    String price = request.getParameter("price").trim();
                    String quantity = request.getParameter("quantity").trim();
                    String shortDescription = request.getParameter("shortDescription").trim();
                    String productDescription = request.getParameter("productID").trim() + ".txt";
                    String description = request.getParameter("description").trim();
                    String categoryID = request.getParameter("categoryID").trim();

                    writerDescription(productDescription, description);

                    String url = "";
                    Part filePart = request.getPart("photo");
                    if (((String) getFileName(filePart)).equals("")) {
                        url = ImageURLAfter;
                    } else {
                        url = uploadFile(request); // Upload file vào thư mục, return image name
                    }

                    //
                    Part fileParts = request.getPart("photos");
                    if (!((String) getFileName(fileParts)).equals("")) {
                        String path = request.getServletContext().getRealPath("/images/");
                        File f = new File(path + productID);
                        if (!f.exists()) {
                            f.mkdirs();
                        }
                        for (File file : f.listFiles()) {
                            if (!file.isDirectory()) {
                                file.delete();
                            }
                        }

                        List<String> photos = uploadFile2(UPLOAD_DIR + "/" + productID, request);
                    }
                    //

                    Product product = new Product(productID, productName, Double.parseDouble(price), Integer.parseInt(quantity), shortDescription, productDescription, url, categoryID);
                    dao.updateProduct(product);
                    response.sendRedirect(controlProduct);
                }  else if (action.equals("delete")) {
                    String productID = request.getParameter("productID").trim();
                    dao.deleteProduct(productID);
                    response.sendRedirect(controlProduct);
                }

            } else {
                response.sendRedirect(controlProduct);
                return;
            }
        } catch (Exception e) {
            request.setAttribute("messException", e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher(pathUI_Error);
            rd.forward(request, response);
        }
    }

    private String uploadFile(HttpServletRequest request) throws IOException, ServletException {
        String fileName = "";
        try {
            Part filePart = request.getPart("photo");
            fileName = (String) getFileName(filePart);

            String applicationPath = request.getServletContext().getRealPath("");
            String basePath = applicationPath + File.separator + UPLOAD_DIR + File.separator;
            InputStream inputStream = null;
            OutputStream outputStream = null;
            try {
                File outputFilePath = new File(basePath + fileName);
                inputStream = filePart.getInputStream();
                outputStream = new FileOutputStream(outputFilePath);
                int read = 0;
                final byte[] bytes = new byte[1024];
                while ((read = inputStream.read(bytes)) != -1) {
                    outputStream.write(bytes, 0, read);
                }
            } catch (Exception e) {
                e.printStackTrace();
                fileName = "";
            } finally {
                if (inputStream != null) {
                    inputStream.close();
                }
                if (outputStream != null) {
                    outputStream.close();
                }
            }

        } catch (Exception e) {
            fileName = "";
        }
        return fileName;
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }

        return null;
    }

    public List<String> uploadFile2(String UPLOAD_DIR, HttpServletRequest request) {
        List<String> fileNames = new ArrayList<String>();
        try {
            List<Part> parts = (List<Part>) request.getParts();
            for (Part part : parts) {
                if (part.getName().equalsIgnoreCase("photos")) {
                    String fileName = getFileName(part);
                    System.out.println("link hinh: " + fileName);// Link anh
                    fileNames.add(fileName);
                    String applicationPath = request.getServletContext().getRealPath("");
                    String basePath = applicationPath + File.separator + UPLOAD_DIR + File.separator;
                    InputStream inputStream = null;
                    OutputStream outputStream = null;
                    try {
                        File outputFilePath = new File(basePath + fileName);
                        inputStream = part.getInputStream();
                        outputStream = new FileOutputStream(outputFilePath);
                        int read = 0;
                        final byte[] bytes = new byte[1024];
                        while ((read = inputStream.read(bytes)) != -1) {
                            outputStream.write(bytes, 0, read);
                        }
                    } catch (Exception ex) {
                        fileName = null;
                    } finally {
                        if (outputStream != null) {
                            outputStream.close();
                        }
                        if (inputStream != null) {
                            inputStream.close();
                        }
                    }
                }
            }
        } catch (Exception e) {
            fileNames = null;
        }
        return fileNames;
    }

    private String getDescriptionFromFile(String part) throws FileNotFoundException, IOException {
        InputStream csv = ProductManagement.class.getResourceAsStream("Description\\" + part);
        BufferedReader br = new BufferedReader(new InputStreamReader(csv, "UTF-8"));

        int i;
        String s = "";
        while ((i = br.read()) != -1) {
            s += (char) i;
        }
        return s;
    }

    private void writerDescription(String productDescription, String content) throws IOException, URISyntaxException {
        String webInfPath = getServletConfig().getServletContext().getRealPath("WEB-INF\\classes\\servlet\\Description");
        File newFile = new File(webInfPath + "/" + productDescription);
        newFile.createNewFile();

        URL resourceUrl = ProductManagement.class.getResource("Description\\" + productDescription);

        File file = new File(resourceUrl.toURI());

        FileOutputStream fout = new FileOutputStream(file);

        OutputStreamWriter osw = new OutputStreamWriter(fout, StandardCharsets.UTF_8);
        BufferedWriter writer = new BufferedWriter(osw);

        try {
            String s = content;
            writer.write(s);
            writer.close();
            fout.close();
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            writer.close();
            fout.close();
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
