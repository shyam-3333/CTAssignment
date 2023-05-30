@isTest

private class TestConvertRupees{

   public static testMethod void ConvertRupeesTest1() {
       ConvertRupees cr = new ConvertRupees();
       cr.ConvertRup('USD');
       ConvertRupees.ConvertFun(1.23);
  }
  public static testMethod void ConvertRupeesTest2() {
       ConvertRupees cr = new ConvertRupees();
       cr.ConvertRup('INR');
       ConvertRupees.ConvertFun(99.283);
  }
  public static testMethod void ConvertRupeesTest3() {
       ConvertRupees cr = new ConvertRupees();
       cr.ConvertRup('GBP');
       ConvertRupees.ConvertFun(567.2783);
  }
   public static testMethod void ConvertRupeesTest4() {
       ConvertRupees cr = new ConvertRupees();
       cr.ConvertRup('EURO');
       ConvertRupees.ConvertFun(4567.2546573);
  }
   public static testMethod void ConvertRupeesTest5() {
       ConvertRupees cr = new ConvertRupees();
       cr.ConvertRup('JPY');
       ConvertRupees.ConvertFun(23455.24676563);
  }
  public static testMethod void ConvertRupeesTest6() {
       ConvertRupees cr = new ConvertRupees();
       cr.ConvertRup('CHF');
       ConvertRupees.ConvertFun(456789.246575673);
  }
  public static testMethod void ConvertRupeesTest7() {
       ConvertRupees cr = new ConvertRupees();
       cr.ConvertRup('SGD');
       ConvertRupees.ConvertFun(3454678.2354677783);
  }
 public static testMethod void ConvertRupeesTest8() {
       ConvertRupees cr = new ConvertRupees();
       cr.ConvertRup('SGD');
       ConvertRupees.ConvertFun(3345657545.2);
  }
  public static testMethod void ConvertRupeesTest9() {
       ConvertRupees cr = new ConvertRupees();
       cr.ConvertRup('INR');
       ConvertRupees.ConvertFun(3345657545.2);
  }
 }