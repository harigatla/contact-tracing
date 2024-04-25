@isTest
public class FitnessTest {
    
    @isTest
    public static void calculateBMITest(){
        decimal bodyWeight = 60;
        decimal bodyHeight = 1.2;
        decimal result = Fitness.calculateBMI(bodyWeight, bodyHeight);
        result = result.setScale(2);
        System.assertEquals(41.67, result, 'BMI is wrong');
        
    }
    
    @isTest
    public static void calculateBMITest1(){
        decimal bodyWeight = 0;
        decimal bodyHeight = 1.2;
        decimal result = Fitness.calculateBMI(bodyWeight, bodyHeight);
        System.assertEquals(0, result, 'BMI is wrong');    
    }
    
        @isTest
    	public static void calculateBMITest2(){
        decimal bodyWeight = 60;
        decimal bodyHeight = 0;
        decimal result = Fitness.calculateBMI(bodyWeight, bodyHeight);
        System.assertEquals(-1, result, 'BMI is wrong');    
    }
    
        @isTest
    	public static void calculateBMITest3(){
        decimal bodyWeight = -60;
        decimal bodyHeight = 1.2;
        decimal result = Fitness.calculateBMI(bodyWeight, bodyHeight);
        System.assertEquals(-1, result, 'BMI is wrong');    
    }
    
        @isTest
    	public static void calculateBMITest4(){
        decimal bodyWeight = 60;
        decimal bodyHeight = -1.2;
        decimal result = Fitness.calculateBMI(bodyWeight, bodyHeight);
        System.assertEquals(-1, result, 'BMI is wrong');    
    }
    
        @isTest
    	public static void paceCalculateTest1(){
        decimal distance = 10;
        decimal minutes = 60;
        decimal result = Fitness.paceCalculate(distance, minutes);
        System.assertEquals(10, result, 'BMI is wrong');    
    }
    
        @isTest
    	public static void paceCalculateTest2(){
        decimal distance = 10;
        decimal minutes = 0;
        decimal result = Fitness.paceCalculate(distance, minutes);
        System.assertEquals(-1, result, 'BMI is wrong');    
    }
    
        @isTest
    	public static void paceCalculateTest3(){
        decimal distance = 0;
        decimal minutes = 60;
        decimal result = Fitness.paceCalculate(distance, minutes);
        System.assertEquals(-1, result, 'BMI is wrong');    
    }
    
        @isTest
    	public static void paceCalculateTest4(){
        decimal distance = -10;
        decimal minutes = 60;
        decimal result = Fitness.paceCalculate(distance, minutes);
        System.assertEquals(-1, result, 'BMI is wrong');    
    }
    
        @isTest
    	public static void paceCalculateTest5(){
        decimal distance = 60;
        decimal minutes = -10;
        decimal result = Fitness.paceCalculate(distance, minutes);
        System.assertEquals(-1, result, 'BMI is wrong');    
    }


}