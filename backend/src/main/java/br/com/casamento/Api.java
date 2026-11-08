package br.com.casamento;
import java.math.BigDecimal;
import java.util.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.jdbc.core.namedparam.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
@RestController @RequestMapping("/api") public class Api {
 private final NamedParameterJdbcTemplate db;
 Api(NamedParameterJdbcTemplate db){this.db=db;}
 record Rsvp(@NotBlank @Size(min=3,max=160) String name,@Size(max=40) String phone,@Email @Size(max=200) String email,@Pattern(regexp="yes|no") String attending,@Min(0) @Max(20) int adults,@Min(0) @Max(20) int children,@Size(max=500) String note){}
 record Message(@NotBlank @Size(max=160) String name,@NotBlank @Size(max=1000) String text){}
 record Pledge(@NotNull UUID giftId,@NotBlank @Size(max=160) String name,@Size(max=300) String message,@NotNull @DecimalMin("1.00") @DecimalMax("100000.00") BigDecimal amount){}
 record Gift(@NotBlank @Size(max=160) String name,@NotNull @DecimalMin("1.00") BigDecimal price,@NotBlank @Size(max=80) String category,@Size(max=1000) String image){}
 private MapSqlParameterSource p(Object... pairs){MapSqlParameterSource s=new MapSqlParameterSource();for(int i=0;i<pairs.length;i+=2)s.addValue((String)pairs[i],pairs[i+1]);return s;}
 private List<Map<String,Object>> list(String sql){return db.queryForList(sql,new MapSqlParameterSource());}
 @GetMapping("/config") Map<String,String> config(@Value("${app.pix.key}") String key,@Value("${app.pix.name}") String name,@Value("${app.pix.bank}") String bank){return Map.of("pixKey",key,"pixName",name,"pixBank",bank);}
 @GetMapping("/gifts") List<Map<String,Object>> gifts(){return list("select id,name,price,category,image from gifts order by name");}
 @GetMapping("/messages") List<Map<String,Object>> messages(){return list("select id,name,text,approved,created_at as \"createdAt\" from messages where approved=true order by created_at desc limit 100");}
 @PostMapping("/rsvp") ResponseEntity<Map<String,Object>> rsvp(@Valid @RequestBody Rsvp r){if(r.attending()==null||r.attending().equals("yes")&&(r.adults()<1||r.adults()+r.children()>30)||r.attending().equals("no")&&(r.adults()!=0||r.children()!=0))throw new ResponseStatusException(HttpStatus.BAD_REQUEST,"Quantidade inválida");UUID id=UUID.randomUUID();db.update("insert into guests(id,name,phone,email,attending,adults,children,note) values(:id,:name,:phone,:email,:attending,:adults,:children,:note)",p("id",id,"name",r.name().trim(),"phone",r.phone(),"email",r.email(),"attending",r.attending(),"adults",r.adults(),"children",r.children(),"note",r.note()));return ResponseEntity.status(201).body(Map.of("id",id,"saved",true));}
 @PostMapping("/messages") ResponseEntity<Map<String,Object>> message(@Valid @RequestBody Message m){UUID id=UUID.randomUUID();db.update("insert into messages(id,name,text) values(:id,:name,:text)",p("id",id,"name",m.name().trim(),"text",m.text().trim()));return ResponseEntity.status(201).body(Map.of("id",id,"saved",true));}
 @PostMapping("/pledges") ResponseEntity<Map<String,Object>> pledge(@Valid @RequestBody Pledge r){List<Map<String,Object>> found=db.queryForList("select name from gifts where id=:id",p("id",r.giftId()));if(found.isEmpty())throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Presente não encontrado");UUID id=UUID.randomUUID();db.update("insert into pledges(id,gift_id,gift,amount,name,message) values(:id,:giftId,:gift,:amount,:name,:message)",p("id",id,"giftId",r.giftId(),"gift",found.get(0).get("name"),"amount",r.amount(),"name",r.name().trim(),"message",r.message()));return ResponseEntity.status(201).body(Map.of("id",id,"status","pending"));}
 @GetMapping("/admin/check") Map<String,Boolean> check(){return Map.of("ok",true);}
 @GetMapping("/admin/guests") List<Map<String,Object>> guests(){return list("select id,name,phone,email,attending,adults,children,note,created_at as \"createdAt\" from guests order by created_at desc");}
 @GetMapping("/admin/messages") List<Map<String,Object>> allMessages(){return list("select id,name,text,approved,created_at as \"createdAt\" from messages order by created_at desc");}
 @GetMapping("/admin/pledges") List<Map<String,Object>> pledges(){return list("select id,gift_id as \"giftId\",gift,amount,name,message,status,created_at as \"createdAt\" from pledges order by created_at desc");}
 @PostMapping("/admin/gifts") ResponseEntity<Map<String,Object>> addGift(@Valid @RequestBody Gift g){UUID id=UUID.randomUUID();db.update("insert into gifts(id,name,price,category,image) values(:id,:name,:price,:category,:image)",p("id",id,"name",g.name(),"price",g.price(),"category",g.category(),"image",g.image()));return ResponseEntity.status(201).body(Map.of("id",id));}
 @PatchMapping("/admin/gifts/{id}") void updateGift(@PathVariable UUID id,@Valid @RequestBody Gift g){db.update("update gifts set name=:name,price=:price,category=:category,image=:image where id=:id",p("id",id,"name",g.name(),"price",g.price(),"category",g.category(),"image",g.image()));}
 @PatchMapping("/admin/messages/{id}/approval") void approve(@PathVariable UUID id,@RequestBody Map<String,Boolean> body){db.update("update messages set approved=:approved where id=:id",p("approved",Boolean.TRUE.equals(body.get("approved")),"id",id));}
 @PatchMapping("/admin/pledges/{id}/status") void status(@PathVariable UUID id,@RequestBody Map<String,String> body){String status=body.get("status");if(!List.of("pending","confirmed").contains(status))throw new ResponseStatusException(HttpStatus.BAD_REQUEST);db.update("update pledges set status=:status where id=:id",p("status",status,"id",id));}
 @DeleteMapping("/admin/{type}/{id}") void delete(@PathVariable String type,@PathVariable UUID id){String table=switch(type){case "guests"->"guests";case "messages"->"messages";case "pledges"->"pledges";case "gifts"->"gifts";default->throw new ResponseStatusException(HttpStatus.NOT_FOUND);};db.update("delete from "+table+" where id=:id",p("id",id));}
}
