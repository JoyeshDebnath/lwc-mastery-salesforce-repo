public  class PortfolioController {
    public class ProjectWrapper{
        @AuraEnabled public Id projectId;
        @AuraEnabled public String name;
        @AuraEnabled public String category;
        @AuraEnabled public String  description;
        @AuraEnabled public String techTags;
        @AuraEnabled public String demoUrl;
        @AuraEnabled public String githubUrl;
        @AuraEnabled public Integer stars;
        @AuraEnabled public Integer forks;
        @AuraEnabled public Boolean isFeatured;
        @AuraEnabled public List<String> tagList;
    }

    public class JobWrapper{
        @AuraEnabled public Id jobId;
        @AuraEnabled public String role;
        @AuraEnabled public String company;
        @AuraEnabled public String period;
        @AuraEnabled public String description;
        @AuraEnabled public Boolean isCurrent;
    }

    public class SkillWrapper{
        @AuraEnabled public String name;
        @AuraEnabled public String category;//apex / lwc/sales cloud /cpq/ai/agentforce etc 
    }

    @AuraEnabled (cacheable=true)
    public static List<ProjectWrapper> getProjects(){
        List<ProjectWrapper> projects=new List<ProjectWrapper>();
        //loop and add in project wrapper list     
        for(Portfolio_Project__c proj : [SELECT Id, Title__c, Description__c, Category__c,
                   Tech_Tags__c, Demo_URL__c, GitHub_URL__c,
                   Stars__c, Forks__c, Is_Featured__c
                    FROM Portfolio_Project__c
                    ORDER BY Sort_Order__c ASC NULLS LAST
                    LIMIT 10
            ]){
                    ProjectWrapper project = new ProjectWrapper();
                    project.projectId=proj.Id;
                    project.name=proj.Title__c;
                    project.category=proj.Category__c;
                    project.description=proj.Description__c;
                    project.techTags=proj.Tech_Tags__c;
                    project.demoUrl=proj.Demo_URL__c;
                    project.githubUrl=proj.GitHub_URL__c;
                    project.stars=proj.Stars__c !=null ?Integer.valueOf(proj.Stars__c) : 0;
                    project.forks=proj.Forks__c !=null ?Integer.valueOf(proj.Forks__c) : 0;
                    project.isFeatured=proj.Is_Featured__c;
                    project.tagList=new List<String>();
                    if(String.isNotBlank(proj.Tech_Tags__c)){
                       for (String tag : proj.Tech_Tags__c.split(',')){
                        project.tagList.add(tag);
                       }
                    }
                    projects.add(project);
            }
       return projects;
    }

    @AuraEnabled(cacheable=true)
    public static  List<JobWrapper> getJobs(){
         List<JobWrapper> result = new List<JobWrapper>();
        for (Portfolio_Experience__c e : [
            SELECT Id, Role__c, Company__c, Period__c,
                   Description__c, Is_Current__c
            FROM Portfolio_Experience__c
            ORDER BY Sort_Order__c ASC NULLS LAST
            LIMIT 10
        ]) {
            JobWrapper w  = new JobWrapper();
            w.jobId       = e.Id;
            w.role        = e.Role__c;
            w.company     = e.Company__c;
            w.period      = e.Period__c;
            w.description = e.Description__c;
            w.isCurrent   = e.Is_Current__c;
            result.add(w);
        }
        return result;
       
    }
}