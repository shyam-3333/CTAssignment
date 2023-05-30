public class EnglishNumberToWords 
    {
        private static final String[] tensNames = new String[]{'',' TEN',' TWENTY',' THIRTY',' FORTY',' FIFTY',' SIXTY',' SEVENTY',' EIGHTY',' NINETY'};

        private static final String[] numNames = new String[]{'',' ONE',' TWO',' THREE',' FOUR',' FIVE',' SIX',' SEVEN',' EIGHT',' NINE',' TEN',
        'ELEVEN',' TWELVE',' THIRTEEN',' FOURTEEN',' FIFTEEN',' SIXTEEN',' SEVENTEEN',' EIGHTEEN',' NINETEEN'};

        public static String convertLessThanOneThousand(Integer num) 
            {
                String soFar;
                if (math.mod(num,100) < 20)
                {
                    soFar = numNames[math.mod(num,100)];
                    num /= 100;
                }
                else 
                {
                    soFar = numNames[math.mod(num,10)];
                    num /= 10;

                    soFar = tensNames[math.mod(num,10)] + soFar;
                    num /= 10;
                }
                if (num == 0) return soFar;
                    return numNames[num] + ' HUNDRED ' + soFar;
            }

        public static String convert(Decimal num) 
            {
                System.debug('num********'+num);
                // 0 to 999 999 999 999
                if (num == 0) 
                    {
                        return 'zero';
                    }
                String snumber;
                 String snumber1;
                snumber=String.valueof(num);
                System.debug('SL*********'+snumber.length());
                if(snumber.length()< 14) //99,999,999.12   99 99999999.12
                    {
                        Decimal dd=1000000000000.0;
                        Decimal ddnum=dd + num;
                        snumber1 = String.valueof(ddnum);
                        System.debug('SL&&&&&&&snumber1 '+snumber1 );
                        snumber = snumber1.substring(1,snumber1.length());
                        System.debug('SL&&&&&&&&&&&&&&&'+snumber.length());
                    }
                System.debug('llllllllllllllllll'+snumber);
                Integer billions = Integer.valueof(snumber.substring(0,3));
                System.debug('bbbbbbbbbbb'+billions );
                // nnnXXXnnnnnn
                integer millions  = Integer.valueof(snumber.substring(3,6)); 
                System.debug('mmmmmmmm'+millions  );
                // nnnnnnXXXnnn
                integer hundredThousands = Integer.valueof(snumber.substring(6,9)); 
                System.debug('hhhhhhhhh'+hundredThousands );
                // nnnnnnnnnXXX
                integer thousands = Integer.valueof(snumber.substring(9,12));    //9,999,999,999.99
                System.debug('tttttttttt'+thousands );

                String tradBillions;
                    if(billions==0)
                    {
                        tradBillions = '';
                    }
                else  
                    {
                        tradBillions = convertLessThanOneThousand(billions) 
                        + ' BILLION ';
                    }
                System.debug('billions>>>>>>>>>>>>'+tradBillions );
                String result =  tradBillions;
                System.debug('billions'+result );
                String tradMillions;
                if(millions==0)
                    {
                        tradMillions = '';
                    }
                else
                    {
                        tradMillions = convertLessThanOneThousand(millions) 
                        + ' MILLION ';
                    }
           
                result =  result + tradMillions;
                System.debug('millions>>>>>>>>>>>>'+result );
                String tradHundredThousands;
                if(hundredThousands==0) 
                    {
                        tradHundredThousands = '';
                    }
                else
                    {
                        tradHundredThousands = convertLessThanOneThousand(hundredThousands) 
                        + ' THOUSAND ';
                    }
                result =  result + tradHundredThousands;
                String tradThousand;
                tradThousand = convertLessThanOneThousand(thousands);
                //String temp=snumber1.right(2);
                //integer i=Integer.valueof(temp);
                String cen= convertLessThanOneThousand(Integer.valueof(snumber1.right(2)));
                if(cen== ''){
                    result =  result + tradThousand + ' ONLY';}
                else if(cen!= ''){
                     result =  result + tradThousand + cen+ ' CENTS ONLY';
                }
                System.debug('tradThousand>>>>>>>>>>>>'+result );
                // remove extra spaces!
                return result.replaceAll('^\\s+', ' ').replaceAll('\\b\\s{2,}\\b', ' ');
            }
      
      }