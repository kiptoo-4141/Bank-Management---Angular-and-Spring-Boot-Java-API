package com.kiptoo.controller;

import com.kiptoo.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/")
@CrossOrigin(origins = "*")
public class AccountController {
    @Autowired
    private AccountRepository accountRepository;

    @GetMapping("/accounts")
    public Iterable<com.kiptoo.models.Account> getAllAccounts(){
        return accountRepository.findAll();
    }
    @GetMapping("/account")
    public com.kiptoo.models.Account getAccountById(Long id){
        return accountRepository.findById(id).get();
    }

}
