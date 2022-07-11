package com.group.mayo.common;


import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

@Component
@Aspect
public class AdviceLog {
	
	private static final Logger logger = LoggerFactory.getLogger(AdviceLog.class);
	
	@Pointcut("execution(public * com.group.mayo..*Dao.*(..))")
	public void commonDaoPointCut() {}
	@Pointcut("execution(public * com.group.mayo..*Service.*(..))")
	public void commonServicePointCut() {}
	@Pointcut("execution(public * com.group.mayo..*Controller.*(..))")
	public void commonControllerPointCut() {}
	
	@Around("commonDaoPointCut()")
	public Object aroundDaoLogMethod(ProceedingJoinPoint pjp) throws Throwable {
		Object ro=null;
		logger.info("▶▶▶[" + pjp.getThis() + " : " + pjp.getSignature().getName() + "]");
		Object[] args = pjp.getArgs();
		for(int i = 0; i < args.length; i++) {
			logger.info("\t▶▶args["+i+"]" + args[i]);
		}
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		
		//타겟메소드 실행
		ro = pjp.proceed();
		
		stopWatch.stop();
		
		logger.info("▶▶▶ Dao return ro : [" + stopWatch.getTotalTimeMillis() +"] " + ro);
		
		
		return ro;
	}
	
	@Around("commonServicePointCut()")
	public Object aroundServiceLogMethod(ProceedingJoinPoint pjp) throws Throwable {
		Object ro=null;
		logger.info("▶▶▶[" + pjp.getThis() + " : " + pjp.getSignature().getName() + "]");
		
		Object[] args = pjp.getArgs();
		for(int i = 0; i < args.length; i++) {
			logger.info("\t▶▶args["+i+"]" + args[i]);
		}
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		
		//타겟메소드 실행
		ro = pjp.proceed();
		
		stopWatch.stop();
		
		logger.info("\t▶▶▶ Service return ro : [" + stopWatch.getTotalTimeMillis() +"] " + ro);
		return ro;
	}
	
	@Around("commonControllerPointCut()")
	public Object aroundControllerLogMethod(ProceedingJoinPoint pjp) throws Throwable {
		Object ro=null;
		logger.info("▶▶▶[" + pjp.getThis() + " : " + pjp.getSignature().getName() + "]");
		
		Object[] args = pjp.getArgs();
		for(int i = 0; i < args.length; i++) {
			logger.info("\t▶▶args["+i+"]" + args[i]);
		}
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		
		//타겟메소드 실행
		ro = pjp.proceed();
		
		stopWatch.stop();
		
		logger.info("▶▶▶ Ctrl return ro : [" + stopWatch.getTotalTimeMillis() +"] " + ro);
		
		return ro;
	}
}
