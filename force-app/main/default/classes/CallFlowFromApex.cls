public class CallFlowFromApex {
    public static void callFlow(){
    Map < String, Object > flowParams = new Map < String, Object >();
        //this recordId variable is created as input type in flow which will accepting input from the apex
   flowParams.put( 'recordId', '0012w000028utw8AAA' );
   Flow.Interview.Call_Flow_From_Apex myFlow = new Flow.Interview.Call_Flow_From_Apex( flowParams );
   myFlow.start();
        //this AccName variable is type of output which get data from flow and store the value in it.
   String accName = ( String ) myFlow.getvariableValue( 'AccName' );
   System.debug( 'Account Name is ' + accName );
    }
}