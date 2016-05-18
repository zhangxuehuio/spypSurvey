package com.csisc.survey.model;

/**
 * Created by KingLf on 2016/5/18.
 */
public class User {
    private int id;
    private String username;
    private String password;
    private String address_province;//省
    private String address_city;//市
    private String address_county;//县
    private String address_other;//其他详细信息街号
    private int QHDM;//行政区域代码
    private String legalName;//法人姓名
    private int postalCode;//邮政编码
    private String tel;//电话号码
    private String faxNumber;//传真号码
    private int level;

    public User() {
    }

    public User(int id, String username, String password, String address_province, String address_city, String address_county, String address_other, int QHDM, String legalName, int postalCode, String tel, String faxNumber, int level) {

        this.id = id;
        this.username = username;
        this.password = password;
        this.address_province = address_province;
        this.address_city = address_city;
        this.address_county = address_county;
        this.address_other = address_other;
        this.QHDM = QHDM;
        this.legalName = legalName;
        this.postalCode = postalCode;
        this.tel = tel;
        this.faxNumber = faxNumber;
        this.level = level;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress_province() {
        return address_province;
    }

    public void setAddress_province(String address_province) {
        this.address_province = address_province;
    }

    public String getAddress_city() {
        return address_city;
    }

    public void setAddress_city(String address_city) {
        this.address_city = address_city;
    }

    public String getAddress_county() {
        return address_county;
    }

    public void setAddress_county(String address_county) {
        this.address_county = address_county;
    }

    public String getAddress_other() {
        return address_other;
    }

    public void setAddress_other(String address_other) {
        this.address_other = address_other;
    }

    public int getQHDM() {
        return QHDM;
    }

    public void setQHDM(int QHDM) {
        this.QHDM = QHDM;
    }

    public String getLegalName() {
        return legalName;
    }

    public void setLegalName(String legalName) {
        this.legalName = legalName;
    }

    public int getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(int postalCode) {
        this.postalCode = postalCode;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getFaxNumber() {
        return faxNumber;
    }

    public void setFaxNumber(String faxNumber) {
        this.faxNumber = faxNumber;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }
}

