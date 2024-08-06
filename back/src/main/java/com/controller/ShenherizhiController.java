








package com.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import com.alibaba.fastjson.JSONObject;
import java.util.*;
import org.springframework.beans.BeanUtils;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.ContextLoader;
import javax.servlet.ServletContext;
import com.service.TokenService;
import com.utils.StringUtil;
import java.lang.reflect.InvocationTargetException;

import com.service.DictionaryService;
import org.apache.commons.lang3.StringUtils;
import com.annotation.IgnoreAuth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.entity.*;
import com.entity.view.*;
import com.service.*;
import com.utils.PageUtils;
import com.utils.R;
import com.alibaba.fastjson.*;

/**
 * 审核日志
 * 后端接口
 * @author
 * @email
*/
@RestController
@Controller
@RequestMapping("/shenherizhi")
public class ShenherizhiController {
    private static final Logger logger = LoggerFactory.getLogger(ShenherizhiController.class);

    @Autowired
    private ShenherizhiService shenherizhiService;


    @Autowired
    private TokenService tokenService;
    @Autowired
    private DictionaryService dictionaryService;

    //级联表service

    @Autowired
    private YonghuService yonghuService;
    @Autowired
    private XiangmuguanliyuanService xiangmuguanliyuanService;
    @Autowired
    private ZhuanjiaService zhuanjiaService;


    /**
    * 后端列表
    */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params, HttpServletRequest request){
        logger.debug("page方法:,,Controller:{},,params:{}",this.getClass().getName(),JSONObject.toJSONString(params));
        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(StringUtil.isEmpty(role))
            return R.error(511,"权限为空");
        else if("用户".equals(role))
            params.put("yonghuId",request.getSession().getAttribute("userId"));
        else if("项目管理员".equals(role))
            params.put("xiangmuguanliyuanId",request.getSession().getAttribute("userId"));
        else if("专家账户".equals(role))
            params.put("zhuanjiaId",request.getSession().getAttribute("userId"));
        if(params.get("orderBy")==null || params.get("orderBy")==""){
            params.put("orderBy","id");
        }
        PageUtils page = shenherizhiService.queryPage(params);

        //字典表数据转换
        List<ShenherizhiView> list =(List<ShenherizhiView>)page.getList();
        for(ShenherizhiView c:list){
            //修改对应字典表字段
            dictionaryService.dictionaryConvert(c, request);
        }
        return R.ok().put("data", page);
    }

    /**
    * 后端详情
    */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id, HttpServletRequest request){
        logger.debug("info方法:,,Controller:{},,id:{}",this.getClass().getName(),id);
        ShenherizhiEntity shenherizhi = shenherizhiService.selectById(id);
        if(shenherizhi !=null){
            //entity转view
            ShenherizhiView view = new ShenherizhiView();
            BeanUtils.copyProperties( shenherizhi , view );//把实体数据重构到view中

            //修改对应字典表字段
            dictionaryService.dictionaryConvert(view, request);
            return R.ok().put("data", view);
        }else {
            return R.error(511,"查不到数据");
        }

    }

    /**
    * 后端保存
    */
    @RequestMapping("/save")
    public R save(@RequestBody ShenherizhiEntity shenherizhi, HttpServletRequest request){
        logger.debug("save方法:,,Controller:{},,shenherizhi:{}",this.getClass().getName(),shenherizhi.toString());

        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(StringUtil.isEmpty(role))
            return R.error(511,"权限为空");
        Wrapper<ShenherizhiEntity> queryWrapper = new EntityWrapper<ShenherizhiEntity>()
            .eq("shenherizhi_table", shenherizhi.getShenherizhiTable())
            .eq("shenherizhi_name", shenherizhi.getShenherizhiName())
            .eq("shenherizhi_phone", shenherizhi.getShenherizhiPhone())
            .eq("shenherizhi_id_number", shenherizhi.getShenherizhiIdNumber())
            .eq("shenherizhi_jieguo", shenherizhi.getShenherizhiJieguo())
            ;


        ShenherizhiEntity shenherizhiEntity = shenherizhiService.selectOne(queryWrapper);
        if(shenherizhiEntity==null){
            shenherizhi.setCreateTime(new Date());
            shenherizhiService.insert(shenherizhi);
            return R.ok();
        }else {
            return R.error(511,"表中有相同数据");
        }
    }

    /**
    * 后端修改
    */
    @RequestMapping("/update")
    public R update(@RequestBody ShenherizhiEntity shenherizhi, HttpServletRequest request){
        logger.debug("update方法:,,Controller:{},,shenherizhi:{}",this.getClass().getName(),shenherizhi.toString());

        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(StringUtil.isEmpty(role))
            return R.error(511,"权限为空");
        //根据字段查询是否有相同数据
        Wrapper<ShenherizhiEntity> queryWrapper = new EntityWrapper<ShenherizhiEntity>()
            .notIn("id",shenherizhi.getId())
            .andNew()
            .eq("shenherizhi_table", shenherizhi.getShenherizhiTable())
            .eq("shenherizhi_name", shenherizhi.getShenherizhiName())
            .eq("shenherizhi_phone", shenherizhi.getShenherizhiPhone())
            .eq("shenherizhi_id_number", shenherizhi.getShenherizhiIdNumber())
            .eq("shenherizhi_jieguo", shenherizhi.getShenherizhiJieguo())
            ;


        ShenherizhiEntity shenherizhiEntity = shenherizhiService.selectOne(queryWrapper);
        if(shenherizhiEntity==null){
            //  String role = String.valueOf(request.getSession().getAttribute("role"));
            //  if("".equals(role)){
            //      shenherizhi.set
            //  }
            shenherizhiService.updateById(shenherizhi);//根据id更新
            return R.ok();
        }else {
            return R.error(511,"表中有相同数据");
        }
    }

    /**
    * 删除
    */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
        logger.debug("delete:,,Controller:{},,ids:{}",this.getClass().getName(),ids.toString());
        shenherizhiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }





}
