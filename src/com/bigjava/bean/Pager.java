package com.bigjava.bean;

import java.util.List;

public class Pager<T> {
    private static final long seriaVersionUID = -8741766802354222579L;

    //当前页
    private int indexPage;
    //总记录数
    private int totalRecord;
    //总页数
    private int totalPage;
    //要显示的数据
    private List<T> dataList;
    //一页显示多少条信息
    private int pageSize;

    private String URL;

    public int getIndexPage() {
        return indexPage;
    }

    public void setIndexPage(int indexPage) {
        this.indexPage = indexPage;
    }

    public int getTotalRecord() {
        return totalRecord;
    }

    public void setTotalRecord(int totalRecord) {
        this.totalRecord = totalRecord;
    }

    //计算总页数
    public int getTotalPage() {
        int totalPage = totalRecord / pageSize;

        return totalRecord % pageSize != 0 ? totalPage + 1 : totalPage;
    }

    public int getTotalPage(int totalRecord, int pageSize) {
         totalPage = totalRecord / pageSize;
        return totalRecord % pageSize != 0 ? totalPage + 1 : totalPage;
    }

    /*public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
          */
    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String getURL() {
        return URL;
    }

    public void setURL(String URL) {
        this.URL = URL;
    }

    @Override
    public String toString() {
        return "Pager{" +
                "indexPage=" + indexPage +
                ", totalRecord=" + totalRecord +
                ", totalPage=" + totalPage +
                ", dataList=" + dataList +
                ", pageSize=" + pageSize +
                ", URL='" + URL + '\'' +
                '}';
    }
}
