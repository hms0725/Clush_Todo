package com.example.Clush;

import java.util.Collections;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;

@OpenAPIDefinition(
	    info = @Info(
	        title = "Todo API",
	        version = "1.0.0",
	        description = "Todo 관리 API 명세서",
	        contact = @Contact(name = "홍미숙", email = "hms910725@naver.com", url = "https://blog.naver.com/hms0725-"),
	        license = @License(name = "Apache 2.0", url = "https://www.apache.org/licenses/LICENSE-2.0")
	    )
	)
@SpringBootApplication
//@MapperScan(basePackages = "com.example.Clush.mapper")
public class ClushApplication {

    public static void main(String[] args) {
    	SpringApplication.run(ClushApplication.class, args);
    }

}
