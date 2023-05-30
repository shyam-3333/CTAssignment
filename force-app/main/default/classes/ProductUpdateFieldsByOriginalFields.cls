public class ProductUpdateFieldsByOriginalFields {

    public void updateFields(list<product__c> proList){
        for(product__c pro :proList){
            pro.Collection_Update__c = pro.Collection__c;
          pro.Body_Pattern_Update__c = pro.Body_Pattern__c;
            pro.Body_Des_Element_Update__c = pro.Body_Des_Element__c;
            pro.Body_Des_Material_Update__c = pro.Body_Des_Material__c;
            pro.Body_Des_Density_Update__c = pro.Body_Des_Density__c;
            pro.Border_Pattern_Update__c = pro.Border_Pattern__c;
            pro.Border_Des_Element_Update__c = pro.Border_Des_Element__c;
            pro.Border_Des_Material_Update__c = pro.Border_Des_Material__c;
            pro.Border_Size_Update__c = pro.Border_Size__c;
            pro.Pallu_Pattern_Update__c = pro.Pallu_Pattern__c;
            pro.Pallu_Design_Update__c = pro.Pallu_Design__c;
            pro.Pallu_Des_Material_Update__c = pro.Pallu_Des_Material__c;
            pro.Pallu_Des_Density_Update__c = pro.Pallu_Des_Density__c;
            pro.Pallu_Size_Update__c = pro.Pallu_Size__c;
        }
    }
}