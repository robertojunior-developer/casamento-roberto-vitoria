package br.com.casamento;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
@Configuration public class SecurityConfig {
 @Bean AuthenticationEntryPoint noBrowserPrompt(){return (request,response,authException)->{response.setStatus(401);response.setContentType("application/json");response.getWriter().write("{\"error\":\"unauthorized\"}");};}
 @Bean SecurityFilterChain chain(HttpSecurity http,AuthenticationEntryPoint noBrowserPrompt) throws Exception {return http.csrf(csrf->csrf.disable()).authorizeHttpRequests(auth->auth.requestMatchers(HttpMethod.GET,"/api/gifts","/api/messages","/api/config").permitAll().requestMatchers(HttpMethod.POST,"/api/rsvp","/api/messages","/api/pledges").permitAll().requestMatchers("/api/admin/**").hasRole("ADMIN").anyRequest().denyAll()).httpBasic(basic->basic.authenticationEntryPoint(noBrowserPrompt)).sessionManagement(s->s.sessionCreationPolicy(org.springframework.security.config.http.SessionCreationPolicy.STATELESS)).build();}
 @Bean UserDetailsService users(@Value("${app.admin.user:admin}") String username,@Value("${app.admin.password:admin-2027}") String password){return new InMemoryUserDetailsManager(User.withUsername(username).password("{bcrypt}"+new BCryptPasswordEncoder().encode(password)).roles("ADMIN").build());}
}
