package com.lh.bean;

import java.util.List;
import java.util.Objects;

public class Category {
    private Integer id;

    private String categoryName;

    private String categoryDescripe;

    private Integer categoryStatus;

    private Integer pid;

    private List<ArticleWithBLOBs> articles;

    public String categoryStatusDesc()
    {
        String s = "";
        if (categoryStatus==1)
            s = "显示";
        else if(categoryStatus==2)
            s = "隐藏";
        return s;
    }

    public List<ArticleWithBLOBs> getArticles() {
        return articles;
    }

    public void setArticles(List<ArticleWithBLOBs> articles) {
        this.articles = articles;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName == null ? null : categoryName.trim();
    }

    public String getCategoryDescripe() {
        return categoryDescripe;
    }

    public void setCategoryDescripe(String categoryDescripe) {
        this.categoryDescripe = categoryDescripe == null ? null : categoryDescripe.trim();
    }

    public Integer getCategoryStatus() {
        return categoryStatus;
    }

    public void setCategoryStatus(Integer categoryStatus) {
        this.categoryStatus = categoryStatus;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Category category = (Category) o;
        return Objects.equals(id, category.id) &&
                Objects.equals(categoryName, category.categoryName) &&
                Objects.equals(categoryDescripe, category.categoryDescripe) &&
                Objects.equals(categoryStatus, category.categoryStatus) &&
                Objects.equals(pid, category.pid) &&
                Objects.equals(articles, category.articles);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, categoryName, categoryDescripe, categoryStatus, pid, articles);
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", categoryName='" + categoryName + '\'' +
                ", categoryDescripe='" + categoryDescripe + '\'' +
                ", categoryStatus=" + categoryStatus +
                ", pid=" + pid +
                ", articles=" + articles +
                '}';
    }
}