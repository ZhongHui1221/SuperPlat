package com.zheling.base.entity;

public class BdDept {
    private String rwid;

    private String objname;

    private String objcode;

    private String parents;

    private String parentid;

    private String objnamepy;

    private String creater;

    private Object createtime;

    private Short isleaf;

    private Double sortorder;

    private Short lev;

    private String orgid;

    public String getRwid() {
        return rwid;
    }

    public void setRwid(String rwid) {
        this.rwid = rwid;
    }

    public String getObjname() {
        return objname;
    }

    public void setObjname(String objname) {
        this.objname = objname;
    }

    public String getObjcode() {
        return objcode;
    }

    public void setObjcode(String objcode) {
        this.objcode = objcode;
    }

    public String getParents() {
        return parents;
    }

    public void setParents(String parents) {
        this.parents = parents;
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid;
    }

    public String getObjnamepy() {
        return objnamepy;
    }

    public void setObjnamepy(String objnamepy) {
        this.objnamepy = objnamepy;
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    public Object getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Object createtime) {
        this.createtime = createtime;
    }

    public Short getIsleaf() {
        return isleaf;
    }

    public void setIsleaf(Short isleaf) {
        this.isleaf = isleaf;
    }

    public Double getSortorder() {
        return sortorder;
    }

    public void setSortorder(Double sortorder) {
        this.sortorder = sortorder;
    }

    public Short getLev() {
        return lev;
    }

    public void setLev(Short lev) {
        this.lev = lev;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }
}