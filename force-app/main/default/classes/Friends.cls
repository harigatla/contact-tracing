public class Friends {
	final Integer ONE_SLICE = 8;
    final Integer LESS_THAN_THREE_SLICE = 7;
    final Integer MORE_THAN_THREE_SLICE = 6;
    
    public Integer getBill(Integer numberOfSlices){
        Integer BillAmount = numberOfSlices == 1 ? numberOfSlices*ONE_SLICE : numberOfSlices <= 3 ? numberOfSlices*LESS_THAN_THREE_SLICE
                            : numberOfSlices*MORE_THAN_THREE_SLICE;
        return BillAmount;
    }
    
}