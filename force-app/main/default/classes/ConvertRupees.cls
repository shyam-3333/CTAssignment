public class ConvertRupees
{
    public static String Ctp;
    
    public ConvertRupees()
    {
    }
    
    public String ConvertRup(String Ctype){
        Ctp=Ctype;
        return Ctp;
    }
    
    public static String ConvertFun(Decimal data)
    {
        // return data+'hi';
        String crores1='';
        String thousands1='';
        Integer lakhs=0,lakhs2=0;
        Integer hcrore;
        String hcr1='';
        String hcr2='';
        String hcr='';
        String outputcr='';
        String outputhd='';
        Integer hundreds;
        Integer hundreds2;
        String hundreds1;
        Integer rupees2;
        String rupees1;  
        Integer hundredcr;
        Integer hundredcr1;
        integer thcrorc=0;
        Integer lkcrorc=0;
        
        
        
        Integer crores=0,crores2=0,thousands2=0;
        String lakhs1='';
        String t='';
        String temp='';
        String temp2='';
        String temp3='';
        String temp4='';
        integer c=0;
        Decimal input=(data);
        system.debug('---'+input);
        if (input!=null)
        {
            Decimal rupees= (Math.floor(input));
            
            Decimal paise=Math.round((input *100-rupees*100));
            
            Integer paise2;
            String paise1;
            c=(Math.Mod(paise.intValue(),100000))/10;
            System.debug(paise+'aa ' +c);
            t=getNumberone(c*10);
            System.debug(t);
            paise2=Math.Mod(paise.intvalue(),10);
            paise1=t+' '+getNumberone(paise2);
            c=0;
            t='';
            
            Integer x=rupees.intValue();
            //system.assertEquals(x, 0);
            Integer thousands=((rupees-(math.mod(x,1000)))/1000).intValue();
            System.debug(thousands+'****** ');
            c=(Math.Mod(thousands,100))/10;
            Integer c1=(Math.Mod(thousands,100));
            System.debug(thousands+'******************** ' +c1);
            if(c1<=20)
            {
                c=(Math.Mod(thousands,100));
                t=getNumberone(c);
                System.debug(t+'ttttttttttttttt' +c);
                thousands1=t;
            }
            else
            {
                t=getNumberone(c*10);
                System.debug('&&&&&&&&&&'+t);
                thousands2=Math.Mod(thousands,10);
                System.debug(thousands2+'*&*&*&*&* ' +c);
                thousands1=t+' '+getNumberone(thousands2);
            }
            c=0;
            t='';
            
            rupees-=thousands*1000;
            if(thousands>99)
            {
                lakhs=((Math.floor(thousands/100))).intValue();
                System.debug('LLLLLLLLLLLLLL'+lakhs);
                c=(Math.Mod(lakhs,100))/10;
                Integer c2=(Math.Mod(lakhs,100));
                System.debug(lakhs+'66666666666 ' +c2);
                if(c2<=20)
                {
                    c=(Math.Mod(lakhs,100));
                    t=getNumberone(lakhs);
                    lakhs1=t;
                    if(lakhs>=20)
                    {
                        c=(Math.Mod(lakhs,100));
                        t=getNumberone(c);
                        lakhs1=t;
                    }
                    System.debug('iiiiiiiiiii='+lakhs1);
                }
                else
                {
                    t=getNumberone(c*10);
                    System.debug(t);
                    lakhs2=Math.Mod(lakhs,10);
                    lakhs1=t+' '+getNumberone(lakhs2);
                    System.debug('eeeeeeeee='+lakhs1);
                }
                thousands=thousands-lakhs*100;
                System.debug('eee111111111='+thousands);
                
                t='';
                c=0;
            }
            if(lakhs>99)
            {
                System.debug('33333333333 ' +lakhs);
                crores=((Math.floor(lakhs/100))).intValue();
                System.debug('33333333333 ' +crores);
                Integer c3=(Math.Mod(crores,100));
                System.debug(crores+'--33333333333 --' +c3);
                if(c3<=20)
                {
                    t=getNumberone(crores);
                    crores1=t;
                    System.debug(t+'CRORE' +c);
                    System.debug('33333333333 ' +crores1);
                }
                else
                {
                    c=(crores/10);
                    System.debug('454 ' +c);
                    t=getNumberone(c*10);
                    System.debug('ttttt ' +t);
                    crores2=Math.Mod(crores,10);
                    System.debug('5458-----cr2 ' +crores2);
                    
                    crores1=t+' '+getNumberone(crores2);
                    lakhs=lakhs-crores*100;
                    System.debug('33333333333 lakhs ' +lakhs);
                }
                t='';
                c=0;
                
                
            }
            //---------------only for 99cr-999cr completely--
            if(crores>99){
                
                c=(crores/100);
                System.debug('Lcro 140--  ' +c);
                t=getNumberone(c);
                
                
                hcr=String.valueof(input) ;   // 000,00,00,000
                System.debug('33333333333 lcro ' +hcr);
                hcrore=Integer.valueof(hcr.substring(1,3));  
                
                
                
                
                if(hcrore<=20)
                {
                    temp=getNumberone(hcrore);
                    // crores1=t;
                    System.debug('--HCRORE--' +hcrore);
                    System.debug('--temp-- ' +temp);
                }
                else
                {
                    Integer c4=0;
                    Integer c5=0;
                    String tp='';
                    c4=(hcrore/10);
                    System.debug('454 ' +c4);
                    tp=getNumberone(c4*10);
                    System.debug('ttttt ' +t);
                    c5=Math.Mod(hcrore,10);
                    temp2=getNumberone(c5);
                    System.debug(c5+'--c5--5458-----cr2 --temp2' +temp2);
                    temp=tp+' '+temp2;                    //temp= crores in words
                    
                  
                }
                System.debug('33333333333 lcrore ' +hcrore);  
                if(hcrore==0){
                    outputcr=t+' '+'HUNDRED CRORE';
                }else if(hcrore!=0){
                    outputcr=t+' HUNDRED AND '+temp +' CRORE';
                }
               
                System.debug('33333333333 get number ' +outputcr);
                t='';
                c=0;
                temp='';
                temp2='';
                //-------------lakhs
                
                lkcrorc=Integer.valueof(hcr.substring(3,5)); 
                
                if(lkcrorc<=20)
                {
                    temp3=getNumberone(lkcrorc);
                    // crores1=t;
                    System.debug('--HCRORE--' +lkcrorc);
                    System.debug('--temp-- ' +temp3);
                }
                else
                {
                    Integer c4=0;
                    Integer c5=0;
                    String tp='';
                    
                    String tp1='';
                    //String tp1='';
                    c4=(lkcrorc/10);
                    System.debug('454 ' +c4);
                    tp=getNumberone(c4*10);
                    System.debug('ttttt ' +t);
                    c5=Math.Mod(lkcrorc,10);
                    tp1=getNumberone(c5);
                    System.debug(c5+'--c5--5458-----cr2 --temp2' +tp1);
                    temp3=tp+' '+tp1;    // temp3 lakshs
                    // crores1=t+' '+getNumberone(crores2);
                    // lakhs=lakhs-crores*100;
                    // System.debug('33333333333 lakhs ' +lakhs);
                }
                // --------thousands
                
                thcrorc=Integer.valueof(hcr.substring(5,7)); 
                
                
                if(thcrorc<=20)
                {
                    temp4=getNumberone(thcrorc);
                    // crores1=t;
                    System.debug('--HCRORE--' +thcrorc);
                    System.debug('--temp-- ' +temp4);
                }
                else
                {
                    Integer c4=0;
                    Integer c5=0;
                    String tp='';
                    String tp1='';
                    c4=(thcrorc/10);
                    System.debug('454 ' +c4);
                    tp=getNumberone(c4*10);
                    System.debug('ttttt ' +t);
                    c5=Math.Mod(thcrorc,10);
                    tp1=getNumberone(c5);
                    System.debug(c5+'--c5--5458-----cr2 --temp2' +tp1);
                    temp4=tp+' '+tp1;      // temp4= thousand
                    // crores1=t+' '+getNumberone(crores2);
                    // lakhs=lakhs-crores*100;
                    // System.debug('33333333333 lakhs ' +lakhs);
                }
                
                
                
                
                
                
                
                hundredcr=Integer.valueof(hcr.substring(7,10));
                System.debug('33333333333 get number ' +hundredcr);
                integer h1= (hundredcr/100);
                t=getNumberone(h1);
                hundredcr1=Integer.valueof(hcr.substring(8,10));
                if(hundredcr1<=20){
                    temp=getNumberone(hundredcr1);//one
                }else{
                    c=(hundredcr1/10);
                    String temp5=getNumberone(c*10);//twenty
                    Integer c6=Math.Mod(hundredcr1,10);
                    String temp6=getNumberone(c6);//one,two,three
                    temp=temp5+' '+temp6;
                }
                if(hundredcr1==0  ){
                    outputhd=t+' '+'HUNDRED';
                }else if(hundredcr1!=0 ){
                    outputhd=t+' HUNDRED AND '+temp;//+' RUPEES';
                }
                System.debug('-- get number ----' +outputhd);
            }
            
            //out of >99cr loop--hundred and twelve rupees for less than 100cr---------
            
            if((lakhs>0  || thousands>0 || hundreds>0 || rupees>0 || paise>0)&& crores<100)  {
                hundreds=((rupees-math.mod((rupees.intValue()),100))/100).intValue();
                System.debug(hundreds+'aa ' +hundreds);
                // Integer hundreds2;
                //String hundreds1;
                c=(Math.Mod(hundreds,10000))/10;
                System.debug(hundreds+'aa ' +c);
                t=getNumberone(c*10);
                System.debug(t);
                hundreds2=Math.Mod(hundreds,10);
                hundreds1=t+' '+getNumberone(hundreds2);
                System.debug(hundreds1+'-----hundre1--hudrd2-- ' +hundreds2);
                c=0;
                t='';
                
                rupees-=hundreds*100;
                //  Integer rupees2;
                //  String rupees1;
                c=(Math.Mod(rupees.intValue(),100000))/10;
                System.debug(rupees+'aa ' +c);
                Integer pp=Integer.valueof(rupees);
                System.debug('--pp-- ' +pp);
                if(pp<=20)
                {
                    t=getNumberone(pp);
                    rupees1=t;
                }
                else
                {
                    t=getNumberone(c*10);
                    System.debug(t);
                    rupees2=Math.Mod(rupees.intvalue(),10);
                    rupees1=t+' '+getNumberone(rupees2);
                }
                System.debug(rupees1+'--a--a ' +rupees2);
                c=0;
                t='';
                
                
            }
            if(crores>999)
                            {
                                return  'Amount Too Long';
                            }
            
            
            String output='';
            
            if(crores<100)
            {
                if(Ctp == 'USD' )
                {
                    
                    if(crores>0 )
                    {
                        output+=crores1+' CRORE ' ;
                    }
                    if((lakhs>0  || thousands>0 || hundreds>0 || rupees>0 || paise>0)&& crores>0)
                    {
                        output+='';
                    }
                    if(lakhs>0 && lakhs1!='')
                    {
                        output+=lakhs1 + ' LAKH ' ;
                    }
                    if(thousands>0)
                    {
                        output+=thousands1 + ' THOUSAND ' ;
                    }
                    if(hundreds>0 && crores < 100)
                    {
                        output+=hundreds1 + ' HUNDRED ' ;
                    }
                    
                    if(rupees>0 && crores < 100)
                    {
                        output+=rupees1 + ' DOLLAR' ;
                    }
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' CENTS' ;
                    }
                    
                    
                }
                if(Ctp == 'INR' ){   //output += outputcr + ' CRORE ' +temp3+' LAKHS' 
                    
                    if(crores>0 )
                    {
                        output+=crores1+' CRORE ' ;
                        System.debug('output' +output);
                    }
                    if((lakhs>0  || thousands>0 || hundreds>0 || rupees>0 || paise>0)&& crores>0)
                    {
                        output+='';
                    }
                    if(lakhs>0 && lakhs1!='')
                    {
                        output+=lakhs1 + ' LAKH ' ;
                    }
                    if(thousands>0)
                    {
                        output+=thousands1 + ' THOUSAND ' ;
                    }
                    if(hundreds>0  )
                    {
                        output+=hundreds1 + ' HUNDRED ' ;
                    } 
                    
                    if(rupees>0 )
                    {
                        output+=rupees1 + ' RUPEE' ;
                    }
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' PAISE' ;
                    }
                    
                    
                }if(Ctp == 'GBP'){
                    
                    if(crores>0 )
                    {
                        output+=crores1+' CRORE ' ;
                    }
                    if((lakhs>0  || thousands>0 || hundreds>0 || rupees>0 || paise>0)&& crores>0)
                    {
                        output+='';
                    }
                    if(lakhs>0 && lakhs1!='')
                    {
                        output+=lakhs1 + ' LAKH ' ;
                    }
                    if(thousands>0)
                    {
                        output+=thousands1 + ' THOUSAND ' ;
                    }
                    if(hundreds>0 )
                    {
                        output+=hundreds1 + ' HUNDRED ' ;
                    }
                    
                    if(rupees>0 && crores < 100)
                    {
                        output+=rupees1 + ' POUNDS' ;
                    }
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' PENCE' ;
                    }
                    
                    
                }if(Ctp == 'EURO'){
                    
                    if(crores>0 )
                    {
                        output+=crores1+' CRORE ' ;
                    }
                    if((lakhs>0  || thousands>0 || hundreds>0 || rupees>0 || paise>0)&& crores>0)
                    {
                        output+='';
                    }
                    if(lakhs>0 && lakhs1!='')
                    {
                        output+=lakhs1 + ' LAKH ' ;
                    }
                    if(thousands>0)
                    {
                        output+=thousands1 + ' THOUSAND ' ;
                    }
                    if(hundreds>0 && crores < 100)
                    {
                        output+=hundreds1 + ' HUNDRED ' ;
                    }
                    
                    if(rupees>0 && crores < 100)
                    {
                        output+=rupees1 + ' EUROS' ;
                    }
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' CENTS' ;
                    }
                    
                    
                }
                if(Ctp == 'JPY'){
                    
                    if(crores>0)
                    {
                        output+=crores1+' CRORE ' ;
                    }
                    if((lakhs>0  || thousands>0 || hundreds>0 || rupees>0 || paise>0)&& crores>0)
                    {
                        output+='';
                    }
                    if(lakhs>0 && lakhs1!='')
                    {
                        output+=lakhs1 + ' LAKH ' ;
                    }
                    if(thousands>0)
                    {
                        output+=thousands1 + ' THOUSAND ' ;
                    }
                    if(hundreds>0 && crores < 100)
                    {
                        output+=hundreds1 + ' HUNDRED ' ;
                    }
                    
                    if(rupees>0 && crores < 100)
                    {
                        output+=rupees1 + ' YENS' ;
                    }
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' SENS' ;
                    }
                    
                    
                }if(Ctp == 'CHF'){
                    if(crores>0)
                    {
                        output+=crores1+' CRORE ' ;
                    }
                    if((lakhs>0  || thousands>0 || hundreds>0 || rupees>0 || paise>0)&& crores>0)
                    {
                        output+='';
                    }
                    if(lakhs>0 && lakhs1!='')
                    {
                        output+=lakhs1 + ' LAKH ' ;
                    }
                    if(thousands>0)
                    {
                        output+=thousands1 + ' THOUSAND ' ;
                    }
                    if(hundreds>0 && crores < 100)
                    {
                        output+=hundreds1 + ' HUNDRED ' ;
                    }
                    
                    if(rupees>0 && crores < 100)
                    {
                        output+=rupees1 + ' FRANCS' ;
                    }
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' CENTIMES' ;
                    }
                    
                    
                }if(Ctp == 'SGD'){
                    
                    if(crores>0 )
                    {
                        output+=crores1+' CRORE ' ;
                    }
                    if((lakhs>0  || thousands>0 || hundreds>0 || rupees>0 || paise>0)&& crores>0)
                    {
                        output+='';
                    }
                    if(lakhs>0 && lakhs1!='')
                    {
                        output+=lakhs1 + ' LAKH ' ;
                    }
                    if(thousands>0)
                    {
                        output+=thousands1 + ' THOUSAND ' ;
                    }
                    if(hundreds>0 && crores < 100)
                    {
                        output+=hundreds1 + ' HUNDRED ' ;
                    }
                    
                    if(rupees>0 && crores < 100)
                    {
                        output+=rupees1 + ' DOLLARS' ;
                    }
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' CENTS' ;
                    }
                }
            }
            
            
            
          //----greater than 99 cr---result in words  
            else if(crores > 99)
            {
                //output += outputcr + ' CRORE ' +temp3+' LAKHS' 
                
                
                output+=outputcr;
                System.debug('output' +output);
                
                if(lkcrorc>0  || thcrorc>0 || hundredcr>0 || paise>0)
                {
                    output+=' ';
                }
                if(lkcrorc > 0 && temp3!='')
                {
                    output+=temp3 + ' LAKH ' ;
                }
                if(thcrorc>0)
                {
                    output+=temp4 + ' THOUSAND ' ;
                }
                if(Ctp == 'USD' || Ctp == 'SGD'){ 
                    if(hundredcr >0  )
                    {
                        output+=outputhd + ' DOLLAR';
                    } 
                    
                    
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' CENTS' ;
                    }
                }    
                if(Ctp == 'INR'){ 
                    if(hundredcr >0  )
                    {
                        output+=outputhd + ' RUPEE';
                    } 
                    
                    
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' PAISE' ;
                    }
                }    
                if(Ctp == 'GBP'){ 
                    if(hundredcr >0  )
                    {
                        output+=outputhd + ' PONDS';
                    } 
                    
                    
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' PENCE' ;
                    }
                }    
                if(Ctp == 'EURO'){ 
                    if(hundredcr >0  )
                    {
                        output+=outputhd + ' EURO';
                    } 
                    
                    
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' CENTS' ;
                    }
                }    
                if(Ctp == 'JPY'){ 
                    if(hundredcr >0  )
                    {
                        output+=outputhd + ' YENS';
                    } 
                    
                    
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' SENS' ;
                    }
                }    
                if(Ctp == 'CHF'){ 
                    if(hundredcr >0  )
                    {
                        output+=outputhd + ' FRANCS';
                    } 
                    
                    
                    if(paise>0)
                    {
                        output+=' AND ' + paise1 + ' CENTIMES' ;
                    }
                }    
                
                
            }
            
            
            
            return output +' ONLY' ;
            
        }
        else
        {
            return '';
        }
    }
    public static String getNumberone(integer num)
    {
        if(num==1)
        {
            return 'ONE';
        }
        if(num==2)
        {
            return 'TWO';
        }
        if(num==3)
        {
            return 'THREE';
        }
        if(num==4)
        {
            return 'FOUR';
        }
        if(num==5)
        {
            return 'FIVE';
        }
        if(num==6)
        {
            return 'SIX';
        }
        if(num==7)
        {
            return 'SEVEN';
        }
        if(num==8)
        {
            return 'EIGHT';
        }
        if(num==9)
        {
            return 'NINE';
        }
        if(num==10)
        {
            return 'TEN';
        }
        if(num==11)
        {
            return 'ELEVEN';
        }
        if(num==12)
        {
            return 'TWELVE';
        }
        if(num==13)
        {
            return 'THIRTEEN';
        }
        if(num==14)
        {
            return 'FORTEEN';
        }
        if(num==15)
        {
            return 'FIFTEEN';
        }
        if(num==16)
        {
            return 'SIXTEEN';
        }
        if(num==17)
        {
            return 'SEVENTEEN';
        }
        if(num==18)
        {
            return 'EIGHTEEN';
        }
        if(num==19)
        {
            return 'NINTEEN';
        }
        if(num==20)
        {
            return 'TWENTY';
        }
        if(num==30)
        {
            return 'THIRTY';
        }
        if(num==40)
        {
            return 'FORTY';
        }
        if(num==50)
        {
            return 'FIFTY';
        }
        if(num==60)
        {
            return 'SIXTY';
        }
        if(num==70)
        {
            return 'SEVENTY';
        }
        if(num==80)
        {
            return 'EIGHTY';
        }
        if(num==90)
        {
            return 'NINTY';
        }
        else
        {
            return '';
        }
    }
    
    
}