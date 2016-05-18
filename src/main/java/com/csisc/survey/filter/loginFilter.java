package com.csisc.survey.filter;

import com.csisc.survey.model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by KingLf on 2016/5/18.
 */
public class loginFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest hsq= (HttpServletRequest) servletRequest;
        User user = (User) hsq.getSession().getAttribute("loginUser");
        if(user==null){
            ((HttpServletResponse)servletResponse).sendRedirect(hsq.getContextPath()+"/index.jsp");
        }
        filterChain.doFilter(servletRequest,servletResponse);
    }

    public void destroy() {

    }
}
