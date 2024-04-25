public class Fitness {

    
    public static decimal calculateBMI(decimal bodyWeight, decimal bodyHeight){
        if(bodyHeight <= 0 || bodyWeight<0 ){
            return(-1);
        }
        decimal bmiNumber = bodyWeight/(bodyHeight*bodyHeight);
        return bmiNumber;
    }
    
    public static decimal paceCalculate(decimal distance, decimal minutes){
        decimal hr = minutes/60;
        if(minutes <= 0 || distance<=0){
            return(-1);
        }
        decimal pace = distance/hr;
        return pace;
    }

}