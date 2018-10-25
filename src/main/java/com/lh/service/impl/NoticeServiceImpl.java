package com.lh.service.impl;

import com.lh.bean.Notice;
import com.lh.bean.NoticeExample;
import com.lh.bean.NoticeWithBLOBs;
import com.lh.mapper.NoticeMapper;
import com.lh.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@CacheConfig(cacheNames = "notice")
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    NoticeMapper noticeMapper;

    @Override
    public void add(NoticeWithBLOBs notice) {
        noticeMapper.insertSelective(notice);
    }

    @Override
    public void delete(int id) {
        noticeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(NoticeWithBLOBs notice) {
        noticeMapper.updateByPrimaryKeyWithBLOBs(notice);
    }

    @Override
    public Notice get(int id) {
        return noticeMapper.selectByPrimaryKey(id);
    }

    @Override
    @Cacheable(key = "'notices:'+#p0")
    public NoticeWithBLOBs getBLOB(int id) {
        return noticeMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Notice> list() {
        NoticeExample example = new NoticeExample();
        example.setOrderByClause("id desc");
        return noticeMapper.selectByExample(example);
    }

    @Override
    public List<Notice> listByStatus(int status) {
        NoticeExample example = new NoticeExample();
        example.setOrderByClause("id desc");
        example.createCriteria().andStatusEqualTo(status);
        return noticeMapper.selectByExample(example);
    }

    @Override
    @Cacheable(key = "'notices'")
    public List<NoticeWithBLOBs> listBLOB() {
        NoticeExample example = new NoticeExample();
        example.setOrderByClause("id desc");
        return noticeMapper.selectByExampleWithBLOBs(example);
    }
}
