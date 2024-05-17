Public class AutoConvertLeads
{
    @InvocableMethod
    public static void LeadAssign(List<Id> LeadIds)
    {
        LeadStatus CLeadStatus = [SELECT Id, ApiName FROM LeadStatus WHERE IsConverted=true Limit 1];
        List<Database.LeadConvert> MassLeadconvert = new List<Database.LeadConvert>();
        for(Id currentLead: LeadIds)
        {
            Database.LeadConvert Leadconvert = new Database.LeadConvert();
            Leadconvert.setLeadId(currentLead);
            Leadconvert.setConvertedStatus(CLeadStatus.ApiName);
            // Leadconvert.setDoNotCreateOpportunity(TRUE);
            MassLeadconvert.add(Leadconvert);
        }
        if (!MassLeadconvert.isEmpty())
        {
            List<Database.LeadConvertResult> lcr = Database.convertLead(MassLeadconvert);
        }
    }
}