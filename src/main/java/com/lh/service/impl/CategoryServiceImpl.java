package com.lh.service.impl;

import com.lh.bean.Article;
import com.lh.bean.ArticleWithBLOBs;
import com.lh.bean.Category;
import com.lh.bean.CategoryExample;
import com.lh.mapper.CategoryMapper;
import com.lh.service.ArticleService;
import com.lh.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@CacheConfig(cacheNames = "category")
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    CategoryMapper categoryMapper;
    @Autowired
    ArticleService articleService;

    @Override
    @CacheEvict(allEntries = true)
    public void add(Category category) {
        categoryMapper.insertSelective(category);
    }

    @Override
    @CacheEvict(allEntries = true)
    public void delete(int id) {
        categoryMapper.deleteByPrimaryKey(id);
    }

    @Override
    @CacheEvict(allEntries = true)
    public void update(Category category) {
        categoryMapper.updateByPrimaryKeySelective(category);
    }

    @Override
    @Cacheable(key = "'categories:'+#p0")
    public Category get(int id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    @Override
    @Cacheable(key = "'categories'")
    public List<Category> list() {
        CategoryExample example = new CategoryExample();
        example.setOrderByClause("id desc");
        return categoryMapper.selectByExample(example);
    }

    @Override
    public List<Category> listByStatus(int status) {
        CategoryExample example = new CategoryExample();
        example.setOrderByClause("id desc");
        example.createCriteria().andCategoryStatusEqualTo(status);
        return categoryMapper.selectByExample(example);
    }

    @Override
    public Boolean hasParent(Category category) {
        int pid = category.getPid();
        int status = category.getCategoryStatus();
        return pid!=0&&status==1;
    }

    @Override
    public Boolean hasChild(Category category) {
        int pid = category.getId();
        int status = category.getCategoryStatus();
        return listByParent(pid).size()!=0;
    }

    @Override
    @Cacheable(key = "'categories-parent:'+#p0")
    public List<Category> listByParent(int pid) {
        CategoryExample example = new CategoryExample();
        example.createCriteria().andPidEqualTo(pid).andCategoryStatusEqualTo(1);
        return categoryMapper.selectByExample(example);
    }

    @Override
    @Cacheable(key = "'categories-child:'+#p0")
    public List<Category> listChild() {
        List<Category> list = new ArrayList<>();
        for (Category category:
             list()) {
            if (hasParent(category))
                list.add(category);
        }
        return list;
    }

    @Override
    public void fillCategory(Category category) {
        List<ArticleWithBLOBs> articles= articleService.listBOLOByCategory(category.getId());
        articleService.fillArticleBLOB(articles);
        category.setArticles(articles);
    }

    @Override
    public void fillCategory(List<Category> categories) {
        for (Category category:
             categories) {
            fillCategory(category);
        }
    }
}
