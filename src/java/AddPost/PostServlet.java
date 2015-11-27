/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AddPost;

import database.db_Connection;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import user.user;

/**
 *
 * @author Sayed Mahmud Raihan
 */
@MultipartConfig(maxFileSize = 16177215)
public class PostServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

        String message, messageDetail;
        message = null;
        messageDetail = null;
        String book_name, author, description, number;
        String price, quantity;
        boolean isRegistered = false;

        String messageUrl = "/message.jsp";
        RequestDispatcher dispatchMessage
                = request.getServletContext().getRequestDispatcher(messageUrl);

        book_name = request.getParameter("book");
        author = request.getParameter("author");
        InputStream inputStream = null;
        Part filePart = request.getPart("photo");
        price = request.getParameter("price");
        description = request.getParameter("des");
        number = request.getParameter("num");
        
        if (filePart != null) {

            inputStream = filePart.getInputStream();
        }
        try {
            db_Connection con = new db_Connection();
            Connection c = con.getConnection();

            String sql = "INSERT INTO  shop.post_book (pb_name ,pb_author ,pb_images, pb_price,pb_description,Contact) \n" +
"                    VALUES ( ?, ?,?, ?, ?, ?) ";

            PreparedStatement psmt = c.prepareStatement(sql);

            psmt.setString(1, book_name);

            psmt.setString(2, author);
            if (inputStream != null) {

                psmt.setBlob(3, inputStream);
            }

            psmt.setString(4, price);

            psmt.setString(5, description);
            psmt.setString(6, number);
            int i = psmt.executeUpdate();

            if (i == 1) {
                isRegistered = true;
                out.println("Your book is posted..");

                return;
            } else {
                isRegistered = false;
                out.println("Your book is not posted..");
            }

//            if (isRegistered == false) {
//                request.setAttribute("message", message);
//                request.setAttribute("messageDetail", messageDetail);
//                dispatchMessage.forward(request, response);
//            }
        } catch (SQLIntegrityConstraintViolationException ex) {

            messageDetail = ex.getMessage();
            message = "You have been registered earlier please try your right password again, else change your password...";
            out.print(" nOT Success!!" + ex);
            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            dispatchMessage.forward(request, response);
        } catch (Exception ex) {
            messageDetail = ex.getMessage();
            message = "There was a problem in registering your account please do retry again later...";
            out.print(" nOT Success!!" + ex);
            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            dispatchMessage.forward(request, response);
            response.sendError(404);

        }
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
