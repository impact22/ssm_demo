package com.bo.pojo;

public class Department {
    private Integer dpId;

    private String dpName;

    public Department() {
    }

    public Department(Integer dpId, String dpName) {
        this.dpId = dpId;
        this.dpName = dpName;
    }

    public Integer getDpId() {
        return dpId;
    }

    public void setDpId(Integer dpId) {
        this.dpId = dpId;
    }

    public String getDpName() {
        return dpName;
    }

    public void setDpName(String dpName) {
        this.dpName = dpName == null ? null : dpName.trim();
    }

    @Override
    public String toString() {
        return "Department{" +
                "dpId=" + dpId +
                ", dpName='" + dpName + '\'' +
                '}';
    }
}