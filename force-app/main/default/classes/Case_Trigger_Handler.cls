public without sharing  class  Case_Trigger_Handler extends TriggerHandler 
{
    @TestVisible
    private Map<Id, Case> newCaseMap;
    private Map<Id, Case> oldCaseMap;
    private List<Case> newCaseLst;
    private List<Case> oldCaseLst;
    
    public static boolean isAfterInsert=true;
    public static boolean isBeforeInsert = true;
    public static boolean isBeforeUpdate = true;
    public static boolean isAfterUpdate = true;
    public Case_Trigger_Handler() 
    {
        this.newCaseMap = (Map<Id, Case>) Trigger.newMap; 
        this.oldCaseMap = (Map<Id, Case>) Trigger.oldMap;       
        this.newCaseLst = (List<Case>) Trigger.new;   
        this.oldCaseLst = (List<Case>) Trigger.old;   
    }    
    
    @TestVisible
    protected override void beforeInsert() 
    {
        try
        {            
            if(isBeforeInsert){
                isBeforeInsert = false;                
            }
        }
        catch(BaseApplicationException baseEx) 
        {   
            throw new BaseApplicationException('Case_Trigger_Handler', 'beforeInsert', baseEx); 
        }
        
    }       
    
    @TestVisible
    protected override void afterInsert() 
    {
        try
        {
            if(isAfterInsert){                
                for(case cseObj: newCaseLst)
                {
                    EinsteinAPIClass.GetIntent(cseObj.subject, cseObj.id);
                    system.debug('Case Id'+cseObj.id);
                    system.debug('Case Subject'+cseObj.subject);
                }                
                isAfterInsert = false;
            }
        }
        catch(BaseApplicationException baseEx)  
        {   
            throw new BaseApplicationException('Case_Trigger_Handler', 'afterinsert', baseEx);  
        }
    }
    
    
    @TestVisible
    protected override void beforeUpdate() 
    {
        // trigger handler to update the account from billing code in case for registration
        try
        {
            if(isBeforeUpdate){
                isBeforeUpdate = false;
                
            }
            
        }
        catch(BaseApplicationException baseEx)  
        {   
            throw new BaseApplicationException('Case_Trigger_Handler', 'beforeUpdate', baseEx); 
        }
        
    }
    
    @TestVisible
    protected override void afterUpdate() 
    {
        try
        {
            if(isAfterUpdate){
                
                isAfterUpdate = false;
                
            }
        }
        catch(BaseApplicationException baseEx) 
        {    
            throw new BaseApplicationException('Case_Trigger_Handler', 'afterUpdate', baseEx);  
        }
        
    } 
    
    
}