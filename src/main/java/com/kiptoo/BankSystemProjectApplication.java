package com.kiptoo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.web.bind.annotation.CrossOrigin;

@SpringBootApplication
@ComponentScan(basePackages={"com.kiptoo.models","com.kiptoo.controller","com.kiptoo.config"})
@EntityScan("com.kiptoo.models")
@CrossOrigin(origins = {"http://localhost:8080","http:localhost:4200"})
@EnableJpaRepositories("com.kiptoo.repository")
public class BankSystemProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(BankSystemProjectApplication.class, args);
	}

}
