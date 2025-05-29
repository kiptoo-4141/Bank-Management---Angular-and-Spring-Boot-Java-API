package com.kiptoo.controller;

import com.kiptoo.models.Branch;
import com.kiptoo.repository.BranchRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/")
@CrossOrigin("*")
public class BranchController {
    @Autowired
    private BranchRepository branchRepository;

    @GetMapping("/branches")
    public List<Branch> getBranches(){
        return branchRepository.findAll();
    }
}
