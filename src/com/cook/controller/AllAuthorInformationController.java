package com.cook.controller;

import com.cook.model.Menu;
import com.cook.model.User;
import com.cook.service.CollectService;
import com.cook.service.MenuService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 通过所有菜谱获取个人信息
 */
@WebServlet(name = "allAuthorInformation",urlPatterns = "/allAuthorInformation")
public class AllAuthorInformationController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        HttpSession session = request.getSession();
        int index = Integer.parseInt(request.getParameter("index"));
        List<User> allauthors = (List<User>) session.getAttribute("allauthors");
        User author = allauthors.get(index);
        List<Menu> menus = MenuService.listMenu(author.getId());
        List<Integer> counts = new ArrayList<>();
        for (Menu menu:menus){
            counts.add(CollectService.getCount(menu.getId()));
        }
        session.setAttribute("counts",counts);
        session.setAttribute("author",author);
        session.setAttribute("menus",menus);
        response.sendRedirect(request.getContextPath()+"/authorinformation.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
