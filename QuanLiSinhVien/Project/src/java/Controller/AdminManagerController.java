/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AdminDAO;
import DAL.StudentDAO;
import Model.Building;
import Model.ManagerView;
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
public class AdminManagerController extends HttpServlet {

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
            out.println("<title>Servlet AdminManagerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminManagerController at " + request.getContextPath() + "</h1>");
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
        AdminDAO dao = new AdminDAO();
        List<Building> buildings = dao.getBuilding();
         List<Building> building1 = dao.getBuildings();
        String hoTen = request.getParameter("hoTen");
        List<ManagerView> managers = dao.getManagers(hoTen);
        
        request.setAttribute("building1", building1);
        request.setAttribute("buildings", buildings);
        request.setAttribute("managers", managers);
        request.getRequestDispatcher("/View/admin/managers.jsp").forward(request, response);
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
        AdminDAO dao = new AdminDAO();

        String action = request.getParameter("action");

        String password = request.getParameter("password");
        String hoTen = request.getParameter("hoTen");
        String thongTinLienLac = request.getParameter("thongTinLienLac");

        if (action.equals("update")) {
            int idUser = Integer.parseInt(request.getParameter("idUser"));
            int idToaNha = Integer.parseInt(request.getParameter("idToaNha"));
            dao.updateManager(idUser, password, hoTen, thongTinLienLac, idToaNha);
        } else if (action.equals("createManager")) {
            String username = request.getParameter("username");
            int idToaNha = Integer.parseInt(request.getParameter("idToaNha"));
            dao.createManager(username, password, hoTen, thongTinLienLac, idToaNha);
        } else if (action.equals("createBuilding")) {
            String tenToa = request.getParameter("tenToa");
            dao.createBuilding(tenToa);
        } else if (action.equals("createRoom")) {
            String idPhong = request.getParameter("idPhong");
            int idToaNha = Integer.parseInt(request.getParameter("idToaNha"));
            int maLoaiPhong = Integer.parseInt(request.getParameter("maLoaiPhong"));
            int maCSVC = Integer.parseInt(request.getParameter("maCSVC"));
            dao.createRoom(idPhong, idToaNha, maLoaiPhong, maCSVC);
        } else if (action.equals("updatePrice")) {
            int maLoaiPhong = Integer.parseInt(request.getParameter("maLoaiPhong"));
            int giaPhong = Integer.parseInt(request.getParameter("giaThuePhong"));
            dao.updateRoomPrice(maLoaiPhong, giaPhong);

        }

        List<ManagerView> managers = dao.getManagers("");
        List<Building> buildings = dao.getBuilding();
        request.setAttribute("buildings", buildings);
        request.setAttribute("managers", managers);
        request.getRequestDispatcher("/View/admin/managers.jsp").forward(request, response);

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
