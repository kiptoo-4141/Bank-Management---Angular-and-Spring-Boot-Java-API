package com.kiptoo.models;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "bank_accounts")
public class Account {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long account_id;

    @Column(name = "account_number")
    private String accountNumber;

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    private Users user;

    @Column(name = "account_type_id")
    private String accountTypeId;

    @Column(name = "balance")
    private Long balance;

    @Column(name = "available_balance")
    private Long availableBalance;

    @Column(name = "overdraft_limit")
    private Long overdraftLimit;

    @Column(name = "branch_code")
    private String branchCode;

    @Column(name = "open_date")
    private Date openDate;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('active', 'closed', 'frozen') DEFAULT 'active'")
    private Status status = Status.active;

    @Column(name = "created_at")
    private Date createdAt;

    public enum Status{
        active, closed, frozen
    }

    public Account() {
    }

    public Account(Long account_id, String accountNumber, Users user, String accountTypeId, Long balance, Long availableBalance, Long overdraftLimit, String branchCode, Date openDate, Status status, Date createdAt) {
        this.account_id = account_id;
        this.accountNumber = accountNumber;
        this.user = user;
        this.accountTypeId = accountTypeId;
        this.balance = balance;
        this.availableBalance = availableBalance;
        this.overdraftLimit = overdraftLimit;
        this.branchCode = branchCode;
        this.openDate = openDate;
        this.status = status;
        this.createdAt = createdAt;
    }

    public Long getAccount_id() {
        return account_id;
    }

    public void setAccount_id(Long account_id) {
        this.account_id = account_id;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public String getAccountTypeId() {
        return accountTypeId;
    }

    public void setAccountTypeId(String accountTypeId) {
        this.accountTypeId = accountTypeId;
    }

    public Long getBalance() {
        return balance;
    }

    public void setBalance(Long balance) {
        this.balance = balance;
    }

    public Long getAvailableBalance() {
        return availableBalance;
    }

    public void setAvailableBalance(Long availableBalance) {
        this.availableBalance = availableBalance;
    }

    public Long getOverdraftLimit() {
        return overdraftLimit;
    }

    public void setOverdraftLimit(Long overdraftLimit) {
        this.overdraftLimit = overdraftLimit;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public Date getOpenDate() {
        return openDate;
    }

    public void setOpenDate(Date openDate) {
        this.openDate = openDate;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
