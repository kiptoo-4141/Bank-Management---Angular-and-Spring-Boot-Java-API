package com.kiptoo.models;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;


@Entity
@Table(name = "transactions")
public class Transactions {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "transaction_id")
    private Long id;

    @Column(name = "account_id")
    private Long account_id;

    @Enumerated(EnumType.STRING)
    @Column(name="transaction_type")
    private TransactionType transactionType;

    @Enumerated(EnumType.STRING)
    @Column(name="transaction_status")
    private TransactionStatus transactionStatus;

    @Column(name="amount")
    private Long amount;

    @Column(name = "balance_after")
    private Long balanceAfter;

    @Column(name = "description")
    private String description;

    @Column(name = "reference_number" , unique = true)
    private String referenceNumber;

    @Column(name = "transaction_date")
    private Date transactionDate;


    public enum TransactionType{
        deposit, withdrawal, transfer_in, transfer_out, fee, interest
    }
    public enum TransactionStatus{
        pending, completed, failed, cancelled
    }

    public Transactions() {
    }

    public Transactions(Long id, Long account_id, TransactionType transactionType, TransactionStatus transactionStatus, Long amount, Long balanceAfter, String description, String referenceNumber, Date transactionDate) {
        this.id = id;
        this.account_id = account_id;
        this.transactionType = transactionType;
        this.transactionStatus = transactionStatus;
        this.amount = amount;
        this.balanceAfter = balanceAfter;
        this.description = description;
        this.referenceNumber = referenceNumber;
        this.transactionDate = transactionDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getAccount_id() {
        return account_id;
    }

    public void setAccount_id(Long account_id) {
        this.account_id = account_id;
    }

    public TransactionType getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(TransactionType transactionType) {
        this.transactionType = transactionType;
    }

    public TransactionStatus getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(TransactionStatus transactionStatus) {
        this.transactionStatus = transactionStatus;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public Long getBalanceAfter() {
        return balanceAfter;
    }

    public void setBalanceAfter(Long balanceAfter) {
        this.balanceAfter = balanceAfter;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getReferenceNumber() {
        return referenceNumber;
    }

    public void setReferenceNumber(String referenceNumber) {
        this.referenceNumber = referenceNumber;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }
}
