package com.kiptoo.models;

import jakarta.persistence.*;

import java.sql.Timestamp;

@Entity
@Table(name = "branches")
public class Branch {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "branch_id")
    private Long branch_id;

    @Column(name = "branch_code")
    private String branch_code;

    @Column(name = "branch_name")
    private  String branch_name;

    @Column(name = "address")
    private String address;

    @Column(name = "city")
    private  String city;

    @Column(name = "state")
    private String state;

    @Column(name = "zip_code")
    private String zip_code;

    @Column(name = "phone")
    private  String phone;

    @Column(name = "manager_name")
    private  String manager_name;

    @Column(name = "opening_hours")
    private String opening_hours;

    public Branch() {
    }

    public Branch(String state, Long branch_id, String branch_code, String branch_name,
                  String address, String city, String zip_code, String phone,
                  String manager_name, String opening_hours) {
        this.state = state;
        this.branch_id = branch_id;
        this.branch_code = branch_code;
        this.branch_name = branch_name;
        this.address = address;
        this.city = city;
        this.zip_code = zip_code;
        this.phone = phone;
        this.manager_name = manager_name;
        this.opening_hours = opening_hours;
    }

    public Long getBranch_id() {
        return branch_id;
    }

    public void setBranch_id(Long branch_id) {
        this.branch_id = branch_id;
    }

    public String getBranch_code() {
        return branch_code;
    }

    public void setBranch_code(String branch_code) {
        this.branch_code = branch_code;
    }

    public String getBranch_name() {
        return branch_name;
    }

    public void setBranch_name(String branch_name) {
        this.branch_name = branch_name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZip_code() {
        return zip_code;
    }

    public void setZip_code(String zip_code) {
        this.zip_code = zip_code;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getManager_name() {
        return manager_name;
    }

    public void setManager_name(String manager_name) {
        this.manager_name = manager_name;
    }

    public String getOpening_hours() {
        return opening_hours;
    }

    public void setOpening_hours(String opening_hours) {
        this.opening_hours = opening_hours;
    }
}
