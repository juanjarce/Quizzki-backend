package co.catavento.quizzki.utils.filters;

import co.catavento.quizzki.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class JwtRequestFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {

        // Get the authorization header
        String authorizationHeader = request.getHeader("Authorization");

        String username = null;
        String jwt = null;

        // Verificar si el encabezado contiene un JWT
        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            jwt = authorizationHeader.substring(7); // Get the token after 'Bearer'
            username = jwtUtil.getUsernameFromToken(jwt); // Get the username from the token
        }

        // If the user is valid and not already authenticated, we authenticate them.
        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            if (jwtUtil.validateToken(jwt)) {
                UsernamePasswordAuthenticationToken authentication =
                        new UsernamePasswordAuthenticationToken(username, null, null); // Here we are not using password
                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                // Set authentication in context
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        }

        // Continue with the next filter in the chain
        chain.doFilter(request, response);
    }
}
