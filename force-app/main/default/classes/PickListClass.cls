public class PickListClass {
    @AuraEnabled
    public String label;
    @AuraEnabled
    public String value;
    public PickListClass(string label,string value){
        this.label=label;
        this.value=value;
    }
}