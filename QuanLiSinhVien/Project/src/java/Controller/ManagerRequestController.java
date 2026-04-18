/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.ManagerDAO;
import Model.BillView;
import Model.Request;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ManagerRequestController extends HttpServlet {

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
            out.println("<title>Servlet ManagerRequestController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerRequestController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        ManagerDAO dao = new ManagerDAO();
        String MSSV = request.getParameter("MSSV");
        String status = request.getParameter("status");
        String offsetRaw = request.getParameter("offset");
        int offset = 0;
        if (offsetRaw != null) {
            offset = Integer.parseInt(offsetRaw);
        }
        List<Request> requests = dao.getRequests(MSSV, status, user.getId(), offset);
        boolean hasMore = false;
        if (requests.size() > 2) {
            hasMore = true;
            requests.remove(2); // chỉ giữ lại 2 cái đầu
        }
        request.setAttribute("offset", offset);
        request.setAttribute("hasMore", hasMore);
        request.setAttribute("requests", requests);
        request.getRequestDispatcher("/View/manager/requests.jsp").forward(request, response);

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        ManagerDAO dao = new ManagerDAO();

        int idYeuCau = Integer.parseInt(request.getParameter("idYeuCau"));
        String ghiChu = request.getParameter("ghiChu");
        String action = request.getParameter("action");

        dao.updateRequest(ghiChu, action, idYeuCau);

        String MSSV = request.getParameter("MSSV");
        
        String offsetRaw = request.getParameter("offset");
        int offset = 0;
        if (offsetRaw != null) {
            offset = Integer.parseInt(offsetRaw);
        }
        List<Request> requests = dao.getRequests(MSSV, "", user.getId(), offset);
        boolean hasMore = false;
        if (requests.size() > 2) {
            hasMore = true;
            requests.remove(2); // chỉ giữ lại 2 cái đầu
        }
        request.setAttribute("offset", offset);
        request.setAttribute("hasMore", hasMore);
        request.setAttribute("requests", requests);

        request.getRequestDispatcher("/View/manager/requests.jsp").forward(request, response);

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
