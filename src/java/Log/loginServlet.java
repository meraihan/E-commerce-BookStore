/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Log;

import database.db_Connection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Sayed Mahmud Raihan
 */
public class loginServlet extends HttpServlet {

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
            out.println("<title>Servlet loginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginServlet at " + request.getContextPath() + "</h1>");
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

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String message, messageDetail;
        message = "";
        messageDetail = "";
        
        boolean isLoggedIn=false;
        HttpSession userSession=request.getSession();
        message = null;
        String dbuser;
        String dbpass;
        
        PrintWriter out=response.getWriter();
        response.setContentType("text/html");
        String userId=request.getParameter("email");
        String userPassword=request.getParameter("pass");
        
        String messageUrl = "/message.jsp";
        RequestDispatcher rd = 
                 request.getServletContext().getRequestDispatcher(messageUrl);
        
        try {
            db_Connection db = new db_Connection();
            Connection con=db.getConnection();
            out.println("email " + userId + " pass " + userPassword);
            String sql = "select email, password from user";
            PreparedStatement st=con.prepareStatement(sql);
            ResultSet rs=st.executeQuery();
            while(rs.next()){
                dbuser=rs.getString("email");
                dbpass=rs.getString("password");
                if(dbuser.equals(userId)){
                    if(dbpass.equals(userPassword)){
                    isLoggedIn=true;
                    userSession.setAttribute("userName", userId);
                    //response.sendRedirect("index.jsp");
                    response.sendRedirect(request.getContextPath()+"/index.jsp");
                }
                else{
                    isLoggedIn=false;
                    message="wrong password";
                    messageDetail = "Password does not match with the password during registeration... Please re-login with correct password";
                        out.println("wrong password Change the password now <a href = 'changeMyPassword.jsp'>Change</a>");
                    break;
                }
            }
            else{
                isLoggedIn=false;
                message="wrong username";
               }
            }
            if(isLoggedIn==false){
                out.print("wrong login again");
                rd.include(request, response);
            }
        } catch (Exception e) {
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
