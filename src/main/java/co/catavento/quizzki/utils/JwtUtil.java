package co.catavento.quizzki.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtUtil {

    private final String SECRET_KEY = "popoutcrushkpopevilj0rdanmojojojophillyradarratherliefineshitbackd00rtoxicmunyuncrankchargedem" +
            "hoesafeegoodcreditiseeeeeeyoubabyboiwakeupf1lthyjumpintrimcocainenoseweneedalldavibesolympianopmbabitwintrimlikeweezydis" +
            "1gotitwalkhbaoverlysouthatlantababy";
    private final long EXPIRATION_TIME = 1000 * 60 * 60; // 1 hora

    // Generate the token
    public String generateToken(String username) {
        Map<String, Object> claims = new HashMap<>();
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(username)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 10)) // Token válido por 10 horas
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    // Validate the token
    public boolean validateToken(String token) {
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey(SECRET_KEY) // Make sure the secretKey is correct
                    .parseClaimsJws(token)
                    .getBody();

            // Verificates the expiration date
            return !claims.getExpiration().before(new Date());
        } catch (Exception e) {
            return false;
        }
    }

    // Obtain the user form the token
    public String getUsernameFromToken(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody();
        return claims.getSubject();
    }
}
